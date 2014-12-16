vlog -reportprogress 300 -work work toplevel.v
vsim -voptargs="+acc" testTopLevel

add wave -position insertpoint \
sim:/testTopLevel/gpioBank1 \
sim:/testTopLevel/led \
sim:/testTopLevel/clk 

run 20480
wave zoom full