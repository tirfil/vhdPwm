#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#
ghdl -a $FLAG  ../vhdl/pwmclock.vhd
ghdl -a $FLAG ../test/tb_pwmclock.vhd
ghdl -e $FLAG tb_pwmclock
ghdl -r $FLAG tb_pwmclock --vcd=core.vcd
