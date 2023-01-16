#!/bin/sh

# This file is part of WiFi101 Updater Arduino-IDE Plugin.
# Copyright 2016 Arduino LLC (http://www.arduino.cc/)
#
# Arduino is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
# As a special exception, you may use this file as part of a free software
# library without restriction.  Specifically, if other files instantiate
# templates or use macros or inline functions from this file, or you compile
# this file and link it with other files to produce an executable, this
# file does not by itself cause the resulting executable to be covered by
# the GNU General Public License.  This exception does not however
# invalidate any other reasons why the executable file might be covered by
# the GNU General Public License.

IDE_FOLDER=/Applications/Arduino.app/Contents
REV=0.12.0
ZIP_FILENAME=WINCTool-ArduinoIDE-Plugin-$REV
# REQUIRED_JARS="pde.jar arduino-core.jar jssc-2.8.0-arduino4.jar bcpg-jdk15on-152.jar bcprov-jdk15on-152.jar commons-lang3-3.8.1.jar commons-codec-1.7.jar commons-io-2.6.jar"
REQUIRED_JARS="apple.jar arduino-core.jar batik-1.8.jar batik-anim-1.8.jar batik-awt-util-1.8.jar batik-bridge-1.8.jar batik-codec-1.8.jar batik-css-1.8.jar batik-dom-1.8.jar batik-ext-1.8.jar batik-gvt-1.8.jar batik-parser-1.8.jar batik-rasterizer-1.8.jar batik-script-1.8.jar batik-squiggle-1.8.jar batik-svg-dom-1.8.jar batik-svgpp-1.8.jar batik-transcoder-1.8.jar batik-util-1.8.jar batik-xml-1.8.jar bcpg-jdk15on-152.jar bcprov-jdk15on-152.jar commons-codec-1.7.jar commons-compress-1.8.jar commons-exec-1.1.jar commons-httpclient-3.1.jar commons-io-2.6.jar commons-lang3-3.8.1.jar commons-logging-1.0.4.jar commons-net-3.3.jar jackson-annotations-2.9.5.jar jackson-core-2.9.5.jar jackson-databind-2.9.5.jar java-semver-0.8.0.jar jmdns-3.5.5.jar jna-4.2.2.jar jna-platform-4.2.2.jar jsch-0.1.50.jar jssc-2.8.0-arduino4.jar jtouchbar-1.0.0.jar log4j-api-2.12.0.jar log4j-core-2.12.0.jar pde.jar rsyntaxtextarea-3.0.3-SNAPSHOT.jar slf4j-api-1.7.22.jar slf4j-simple-1.7.22.jar xml-apis-1.3.04.jar xml-apis-ext-1.3.04.jar xmlgraphics-commons-2.0.jar"

# Check existence of the IDE folder
if [ -z "$IDE_FOLDER" ]; then
	echo ""
	echo "Please set variable IDE_FOLDER to the path of the installed Arduino IDE"
	echo "For example:"
	echo ""
	echo "IDE_FOLDER=/home/user/ArduinoIDE/ ./build.sh"
	echo ""
	exit 1
fi

# Check needed libraries
CLASSPATH="src"
for JAR in $REQUIRED_JARS; do
	case "$OSTYPE" in
		darwin*)  JARFILE="$IDE_FOLDER/Java/$JAR" ;;
		*)        JARFILE="$IDE_FOLDER/lib/$JAR" ;;
	esac
	if [ -z "$JARFILE" ]; then
		echo "Could not find $JARFILE library in you IDE folder."
		exit 1
	fi
	CLASSPATH="$CLASSPATH:$JARFILE"
	# echo $JAR
done

# echo $CLASSPATH
java -cp "$CLASSPATH:dist/WINCTool/tool/WINCTool.jar" cc.arduino.plugins.winctool.UpdaterJFrame
