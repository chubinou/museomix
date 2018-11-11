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

#include <QObject>
#include <QSerialPort>

class Controler : public QObject
{
	Q_OBJECT

	Q_PROPERTY(bool capteur1 READ capteur1 NOTIFY capteur1Changed)
	Q_PROPERTY(bool capteur2 READ capteur2 NOTIFY capteur2Changed)
	Q_PROPERTY(bool capteur3 READ capteur3 NOTIFY capteur3Changed)

	Q_PROPERTY(int light READ light WRITE setLight NOTIFY lightChanged)

public:
	Controler(QSerialPort *serialPort, QObject* parent = nullptr);

private:
	inline bool capteur1() { return m_capteur1; }
	inline bool capteur2() { return m_capteur2; }
	inline bool capteur3() { return m_capteur3; }

	inline bool light() { return m_light; }

public slots:
	void setLight(int num);

private slots:
	void onReadAvailable();
	void onHandleError(QSerialPort::SerialPortError serialPortError);


signals:
	void capteur1Changed();
	void capteur2Changed();
	void capteur3Changed();

	void button1Pressed();
	void button2Pressed();
	void button3Pressed();

	void lightChanged();

private:
	bool m_capteur1 = false;
	bool m_capteur2 = false;
	bool m_capteur3 = false;

	int m_light = 0;

	QSerialPort *m_serialPort;
};

