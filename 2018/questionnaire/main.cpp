/**
 ** This file is part of the questionnaire project.
 ** Copyright 2018 copyright_user <copyright_email>.
 **
 ** This program is free software: you can redistribute it and/or modify
 ** it under the terms of the GNU General Public License as published by
 ** the Free Software Foundation, either version 3 of the License, or
 ** (at your option) any later version.
 **
 ** This program is distributed in the hope that it will be useful,
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 **
 ** You should have received a copy of the GNU General Public License
 ** along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Controler.hpp>
#include <QSerialPort>


int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;


	QSerialPort serialport;
	serialport.setPortName("/dev/ttyUSB0");
	serialport.setBaudRate(QSerialPort::Baud9600);
	serialport.open(QIODevice::ReadWrite);

	Controler* controler = new Controler(&serialport, &engine);

	QQmlContext* ctx = engine.rootContext();
	ctx->setContextProperty("controler", controler);

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	if (engine.rootObjects().isEmpty())
		return -1;
	return app.exec();
}
