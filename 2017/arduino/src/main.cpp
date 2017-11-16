/*
 * Copyright (C) 2017 Nizar Abak-Kali, Pierre Lamot
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
#include <Arduino.h>

#define MOTOR 8
#define ARUINO_LED 13
#define PIN_READ 2

void setup() {
	//Setup all the Arduino Pins
	pinMode(MOTOR, OUTPUT);
	pinMode(ARUINO_LED, OUTPUT);
	digitalWrite(MOTOR, LOW);
	Serial.begin(9600);
}

void loop() {
	delay(500);
	float position = analogRead(PIN_READ);
	Serial.print(position);
	Serial.write('\n');

	while (Serial.available() > 0){
		int v = Serial.read();
		if(v == '1'){
			digitalWrite(MOTOR, HIGH);
			digitalWrite(ARUINO_LED, HIGH);
		}
		else if(v == '0'){
			digitalWrite(MOTOR, LOW);
			digitalWrite(ARUINO_LED, LOW);
		}
	}
}
