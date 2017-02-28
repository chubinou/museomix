/*
 * Copyright (c) 2016 Pierre Lamot
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Lesser Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Ce programme se contente de lire les valeurs d'un potentiommetre et
 * de les transmettre vers la raspberrypi via port serie
 *
 * Il est evidement excessif d'utiliser un arduino pour lire un simple
 * potentiometre, il serait plus judicieux de s'interfacer directement
 * avec un ADC
 */

#include <Arduino.h>

#define PIN_READ 2

void setup()
{
	Serial.begin(9600);
}

void loop()
{
	while (true) {
		float position = analogRead(PIN_READ);
		Serial.print(position);
		Serial.write('\n');
		delayMicroseconds(1000000); //10ms
	}
}
