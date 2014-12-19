vlog -reportprogress 300 -work work programCounter.v
vsim -voptargs="+acc" testProgramCounter

add wave -position insertpoint \
sim:/testProgramCounter/clk \
sim:/testProgramCounter/sclkPosEdge \
sim:/testProgramCounter/memAddr \
sim:/testProgramCounter/next

run 15000
wave zoom full