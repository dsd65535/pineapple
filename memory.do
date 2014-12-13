vlog -reportprogress 300 -work work memory.v
vsim -voptargs="+acc" testMemory

add wave -position insertpoint \
sim:/testMemory/addr \
sim:/testMemory/dataOut \
sim:/testMemory/clk 

run 100
wave zoom full