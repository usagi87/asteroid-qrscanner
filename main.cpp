/*
 * Copyright (C) 2019 - Florent Revest <revestflo@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
#include <QQmlEngine>
#include <QQmlApplicationEngine>
#include "QZXing.h"
#include <qrcode.h>
#include <asteroidapp.h>

int main(int argc, char *argv[])
{	
	QQmlApplicationEngine engine;

	QZXing::registerQMLTypes();
	QZXing::registerQMLImageProvider(engine);
    qmlRegisterType<QRCode>("QRCode", 1, 0, "QRCode");
    return AsteroidApp::main(argc, argv);
}
