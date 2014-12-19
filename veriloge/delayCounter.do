vlog -reportprogress 300 -work work delayCounter.v
vsim -voptargs="+acc" testDelayCounter

add wave -position insertpoint \
sim:/testDelayCounter/pcEn \
sim:/testDelayCounter/delayEn \
sim:/testDelayCounter/clk 

run 2000
wave zoom full