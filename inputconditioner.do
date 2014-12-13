vlog -reportprogress 300 -work work inputconditioner.v
vsim -voptargs="+acc" testConditioner

add wave -position insertpoint \
sim:/testConditioner/pin \
sim:/testConditioner/conditioned \
sim:/testConditioner/rising \
sim:/testConditioner/falling \
sim:/testConditioner/clk

run 5000
wave zoom full