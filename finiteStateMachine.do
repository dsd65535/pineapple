vlog -reportprogress 300 -work work finiteStateMachine.v
vsim -voptargs="+acc" testStateMachine

add wave -position insertpoint \
sim:/testStateMachine/clk \
sim:/testStateMachine/sclkPosEdge \
sim:/testStateMachine/cs \
sim:/testStateMachine/dc \
sim:/testStateMachine/pcEn \
sim:/testStateMachine/parallelData 

run 5000
wave zoom full