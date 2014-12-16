vlog -reportprogress 300 -work work mosiFF.v
vsim -voptargs="+acc" testMosiFF

add wave -position insertpoint \
sim:/testMosiFF/clk \
sim:/testMosiFF/sclkNegEdge \
sim:/testMosiFF/d \
sim:/testMosiFF/q

run 2000
wave zoom full