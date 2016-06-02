#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#
ghdl -a $FLAG  ../vhdl/pwmclock.vhd
ghdl -a $FLAG  ../vhdl/pwmunit.vhd
ghdl -a $FLAG  ../vhdl/pwm4.vhd
ghdl -a $FLAG  ../demo/i2cslave.vhd
ghdl -a $FLAG  ../demo/i2cpwm4.vhd

ghdl -e $FLAG i2cpwm4

