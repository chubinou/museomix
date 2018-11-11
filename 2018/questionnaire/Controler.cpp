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


#include "Controler.hpp"
#include <QDebug>

Controler::Controler(QSerialPort* serialPort, QObject* parent)
	: QObject(parent)
	, m_serialPort(serialPort)
{
	connect(m_serialPort, &QSerialPort::readyRead,
		this, &Controler::onReadAvailable);
	connect(m_serialPort, &QSerialPort::errorOccurred,
		this, &Controler::onHandleError);
}

void Controler::setLight(int num)
{
	qWarning() << "set light to" << num;
	switch (num) {
	case 0:
		m_serialPort->write("L0\n");
		break;
	case 1:
		m_serialPort->write("L1\n");
		break;
	case 2:
		m_serialPort->write("L2\n");
		break;
	case 3:
		m_serialPort->write("L3\n");
		break;
	default:
		break;
	}
}

void Controler::onReadAvailable()
{
	while (m_serialPort->canReadLine())
	{
		QByteArray line = m_serialPort->readLine();
		line.chop(2); //\r\n
		qDebug() << "got message" << line;
		if (line == "B1") {
			emit button1Pressed();
		} else if (line == "B2") {
			emit button2Pressed();
		} else if (line == "B3"){
			emit button3Pressed();
		} else if (line == "c1"){
			m_capteur1 = false;
			emit capteur1Changed();
		} else if (line == "c2"){
			m_capteur2 = false;
			emit capteur2Changed();
		} else if (line == "c3"){
			m_capteur3 = true;
			emit capteur3Changed();
		} else if (line == "C1"){
			m_capteur1 = true;
			emit capteur1Changed();
		} else if (line == "C2"){
			m_capteur2 = true;
			emit capteur2Changed();
		} else if (line == "C3"){
			m_capteur3 = true;
			emit capteur3Changed();
		}
	}
}

void Controler::onHandleError(QSerialPort::SerialPortError serialPortError)
{
	qWarning() << "meh";
}
