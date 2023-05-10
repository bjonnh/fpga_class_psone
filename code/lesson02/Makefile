.PHONY: build flash all
all: build flash

flash: follow.svf
	make -C .. flash FILE=$(PWD)/follow.svf
follow.json: follow.v
	yosys -p "synth_ecp5 -top top -json follow.json" follow.v
follow_out.config: follow.json follow.lpf
	nextpnr-ecp5 --json follow.json --textcfg follow_out.config --25k --package CABGA256 --lpf follow.lpf
follow.svf: follow_out.config
	ecppack --svf follow.svf follow_out.config follow.bit
build: follow.svf 

clean:
	rm follow.json follow_out.config follow.bit follow.svf
