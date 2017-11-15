#! /usr/bin/env python
# Copyright (c) 2016 Pierre Lamot
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Lesser Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses>

import serial
import pygame as pg
import sys

PLAYING = 1
STOPPED = 0
WEIGHT= 0.8
SCHMITT = 20
FADEOUT_MS = 500

def main():
        """
        Ce programme lit la position d'un potentiometre voltage-> angle
        et declanche des sons lorsque la lunette reliee au potentiometre
        est en face d'un element a observer
        """
	ser = serial.Serial(sys.argv[1])
	pg.mixer.init()
	pg.init()
	sounds = [{
		"name" : "fontaine",
		"start": 0,
		"stop" : 100,
		"sound": pg.mixer.Sound("/home/pi/fontaine.wav"),
		"state" : STOPPED
	},{
		"name" : "singe",
		"start": 200,
		"stop" : 300,
		"sound": pg.mixer.Sound("/home/pi/singe-goutte.wav"),
		"state" : STOPPED
	},{
		"name" : "faisan",
		"start": 500,
		"stop" : 700,
		"sound": pg.mixer.Sound("/home/pi/faisant.wav"),
		"state" : STOPPED
	}, {
		"name" : "licorne",
		"start": 500,
		"stop" : 700,
		"sound": pg.mixer.Sound("/home/pi/licorne.wav"),
		"state" : STOPPED
	}, {
		"name" : "oiseaux",
		"start": 750,
		"stop" : 800,
		"sound": pg.mixer.Sound("/home/pi/oiseaux-fontaine.wav"),
		"state" : STOPPED
	}]

	pos = 0.0
	while True:
		try:
			pos = pos * (1 - WEIGHT)  + (WEIGHT) *  float(ser.readline().strip())
		except:
			print "OOOSSSP"
			continue
		print pos
		for s in sounds:
			if s["start"] < pos < s["stop"] and s["state"] == STOPPED:
				print "play {}".format(s["name"])
				s["sound"].play(loops=1)
				s["state"] = PLAYING
			if not ((s["start"] - SCHMITT) < pos < (s["stop"] + SCHMITT)) \
			   and s["state"] == PLAYING:
				print "stop {}".format(s["name"])
				s["sound"].fadeout(FADEOUT_MS)
				s["state"] = STOPPED

if __name__ == "__main__":
	main()
