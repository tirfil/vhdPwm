#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#
ghdl -a $FLAG  ../vhdl/pwmclock.vhd
ghdl -a $FLAG  ../vhdl/pwmunit.vhd
ghdl -a $FLAG  ../vhdl/pwm.vhd
ghdl -a $FLAG ../test/tb_pwm.vhd
ghdl -e $FLAG tb_pwm
ghdl -r $FLAG tb_pwm --vcd=core.vcd
