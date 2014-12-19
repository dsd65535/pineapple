vlog -reportprogress 300 -work work serialClock.v
vsim -voptargs="+acc" testSclk

add wave -position insertpoint \
sim:/testSclk/clk \
sim:/testSclk/sclk \
sim:/testSclk/sclkPosEdge \
sim:/testSclk/sclk8PosEdge \
sim:/testSclk/sclkNegEdge

run 20000
wave zoom full