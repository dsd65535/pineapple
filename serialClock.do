vlog -reportprogress 300 -work work serialClock.v
vsim -voptargs="+acc" testSclk

add wave -position insertpoint \
sim:/testSclk/clk \
sim:/testSclk/sclk \
sim:/testSclk/sclkEdge

run 2000
wave zoom full