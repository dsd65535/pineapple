vlog -reportprogress 300 -work work shiftregister.v
vsim -voptargs="+acc" testShiftRegister

add wave -position insertpoint \
sim:/testShiftRegister/clk \
sim:/testShiftRegister/peripheralClkEdge \
sim:/testShiftRegister/parallelLoad \
sim:/testShiftRegister/parallelDataIn \
sim:/testShiftRegister/serialDataIn \
sim:/testShiftRegister/parallelDataOut \
sim:/testShiftRegister/serialDataOut

run 2000
wave zoom full