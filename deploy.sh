#!/bin/sh

mkdir -p /Users/me/Documents/Arduino/tools
rm -Rf /Users/me/Documents/Arduino/tools/WINCTool

unzip -q dist/WINCTool-ArduinoIDE-Plugin-0.12.0.zip -d /Users/me/Documents/Arduino/tools

echo "Deployed!"