# Arduino AVR Boards 

[![Check Arduino status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/check-arduino.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/check-arduino.yml)
[![Compile Examples status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/compile-platform-examples.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/compile-platform-examples.yml)
[![Spell Check status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/spell-check.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/spell-check.yml)

This is a fork of the source code and configuration files of the Arduino AVR Boards
[platform](https://arduino.github.io/arduino-cli/latest/platform-specification/). The files platform.txt, boards.txt, and programmers.txt have been extended to enable debugging in the Arduino IDE 2 (and elsewhere) by utilizing [PyAvrOCD](https://pyavrocd.io). In addition, we have upgraded to avrdude 8.0. Starting with version 1.10.0-gcc15a, the AVR-GCC 15.1 toolchain from Microchip's website is added. If you run into problems, you can always easily downgrade using the board manager. You can install this fork by entering the following `Additional boards manager URL` in the `Preferences` dialog and then upgrading the `Arduino AVR Boards` version:

```
https://felias-fogg.github.io/ArduinoCore-avr/package_GCC15_ArduinoCore-avr_index.json
```

There has also been a PR submitted to the Arduino repo ...