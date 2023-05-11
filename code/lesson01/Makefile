.PHONY: build flash all
all: build flash

flash: blink.svf
	make -C .. flash FILE=$(PWD)/blink.svf
blink.json: blink.v
	yosys -p "synth_ecp5 -top top -json blink.json" blink.v
blink_out.config: blink.json blink.lpf
	nextpnr-ecp5 --json blink.json --textcfg blink_out.config --25k --package CABGA381 --lpf blink.lpf
blink.svf: blink_out.config
	ecppack --svf blink.svf blink_out.config blink.bit
build: blink.svf 

clean:
	rm blink.json blink_out.config blink.bit blink.svf
