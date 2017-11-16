#! /usr/bin/env python2
# -*- coding: utf-8 -*-

# Copyright (C) 2017 Pierre Lamot
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

import os
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.websocket
import tornado.gen
from tornado.options import define, options

import requests

import time
import functools
import serial
import time
import subprocess
import threading

PATH=os.path.realpath(__file__)


"""
/!\ VLC doit etre lancé avec les options suivantes /!\

    vlc \
     --fullscreen \
     --no-video-title-show \
     --extraintf lua \
     --lua-intf web \
     --http-port 5921 \
     --http-password xxx \
     --play-and-pause
"""

PLAY_VIDEO="http://:xxx@127.0.0.1:5921/requests/status.xml?command=in_play&input=/home/pierre/Videos/mars.mov"
PLAY_VIDEO_ERR="http://:xxx@127.0.0.1:5921/requests/status.xml?command=in_play&input=/home/pierre/Videos/erreur.mp4"

VAL_OK=250
VAL_THRESH = 20

#ici on definie des options qui seront modifiable en ligne de commande au
#lancement de l'application
define("port", default=4242, help="run on the given port", type=int)
define("arduino", default="/dev/ttyACM0", help="arduino tty", type=str)

settings = {
	'debug': True,
	'static_path': os.path.join(PATH, 'static')
}


TOTAL_DURATION = 300
VIDEO_DURATION = 243
START_DURATION = 5
END_DURATION = 5

ERR_DURATION = 10

#cette variable contient l'ensemble des clients connectés au serveur
clients = set()

class WebSocketHandler(tornado.websocket.WebSocketHandler):
	def open(self):
		print 'new connection'
		clients.add(self)

	def on_close(self):
		print 'connection closed'
		clients.remove(self)

	def check_origin(self, origin):
		return True


class ArduinoCtx:
	def __init__(self, arduino, ioloop):
		self.arduino = arduino
		self.ioloop = ioloop
		self.is_playing = False

	def arduino_callback(self, fd, events):
		"""
		cette fonction est appelée lorsqu'il y a des données à
		lire depuis l'arduino
		"""
		#on lit une ligne
		value = float(self.arduino.readline().strip())

		print value
		if self.is_playing:
			return

		now = time.time()
		if value < VAL_THRESH:
			return

		elif VAL_OK - VAL_THRESH <  value < VAL_OK + VAL_THRESH:
			print "start playing"
			self.is_playing = True

			self.vibrate(now, 0, START_DURATION)
			self.vibrate(now, VIDEO_DURATION - END_DURATION, VIDEO_DURATION)

			self.set_atmosphere(now, "0")
			self.set_atmosphere(now + 40, "1")
			self.set_atmosphere(now + 75, "3")
			self.set_atmosphere(now + 96, "4")
			self.set_atmosphere(now + END_DURATION, "0")

			#demarrage de la lecture
			requests.get(PLAY_VIDEO)

			#on envoie à chaque client le nouvel etat des pieces
			self.ioloop.add_timeout(now + TOTAL_DURATION, self.terminate )

		else:
			print "error playing"
			self.is_playing = True
			requests.get(PLAY_VIDEO_ERR)
			self.ioloop.add_timeout(now + ERR_DURATION, self.terminate )

	def set_atmosphere(self, start, msg):
		def _do():
			for c in clients:
				c.write_message("go")
		self.ioloop.add_timeout(start, _do )


	def terminate(self):
		self.is_playing = False


	def vibrate(self, now, start, stop):
		def _start():
			self.arduino.write("1")
			self.arduino.flush()

		def _stop():
			self.arduino.write("0")
			self.arduino.flush()

		self.ioloop.add_timeout(now +  start, _start )
		self.ioloop.add_timeout(now +  stop, _stop )


def main():
	"""
	C'est la fonction principale, on va :
	 - creer le serveur
	 - enregistrer les points d'accès
	 - ouvrir la communication avec l'arduino
	"""

	tornado.options.parse_command_line()
	app = tornado.web.Application(
		handlers=[
			(r"/ws", WebSocketHandler)
		],
		**settings
	)

	httpServer = tornado.httpserver.HTTPServer(app)
	httpServer.listen(options.port)

	io_loop = tornado.ioloop.IOLoop.current()

	arduino = serial.Serial(options.arduino, timeout=None)
	ctx= ArduinoCtx(arduino, io_loop)

	io_loop.add_handler(arduino.fileno(), ctx.arduino_callback, io_loop.READ)

	print "Listening on port:", options.port
	io_loop.start()

if __name__ == "__main__":
	main()
