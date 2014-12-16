vlog -reportprogress 300 -work work toplevel.v
vsim -voptargs="+acc" testTopLevel

add wave -position insertpoint \
sim:/testTopLevel/gpioBank1 \
sim:/testTopLevel/clk 

run 100
wave zoom full