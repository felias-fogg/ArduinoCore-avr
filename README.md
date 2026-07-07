# Arduino AVR Boards 

[![Check Arduino status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/check-arduino.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/check-arduino.yml)
[![Compile Examples status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/compile-platform-examples.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/compile-platform-examples.yml)
[![Spell Check status](https://github.com/arduino/ArduinoCore-avr/actions/workflows/spell-check.yml/badge.svg)](https://github.com/arduino/ArduinoCore-avr/actions/workflows/spell-check.yml)

This is a fork of the source code and configuration files of the Arduino AVR Boards
[platform](https://arduino.github.io/arduino-cli/latest/platform-specification/). The files platform.txt, boards.txt, and programmers.txt have been extended to enable debugging in the Arduino IDE 2 (and elsewhere) by utilizing [PyAvrOCD](https://pyavrocd.io). In addition, we have upgraded to avrdude 8.0. <s>Starting with version 1.10.0-gcc15a, the AVR-GCC 15.1 toolchain from Microchip's website is added.</s> After a short, unsuccessful episode of using GCC15, we are back to GCC7 (because GCC15 fails do generate correct debugging information for local variables). Instead, the core has been extended so that debugging using *[Cortex-Debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)* in the VS Code extension [*Arduino Maker Workshop*](https://marketplace.visualstudio.com/items?itemName=TheLastOutpostWorkshop.arduino-maker-workshop) became possible.

You can install this fork by entering the following `Additional boards manager URL` in the `Preferences` dialog and then upgrading the `Arduino AVR Boards` version:

```
https://felias-fogg.github.io/ArduinoCore-avr/package_felias-fogg_ArduinoCore-avr_index.json
```

There has also been a PR submitted to the Arduino repo ...