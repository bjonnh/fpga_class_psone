.PHONY: build flash all
all: build flash

flash: blink_zed.svf
	make -C .. flash FILE=$(PWD)/blink_zed.svf
blink_zed.json: blink_zed.v
	yosys -p "synth_ecp5 -top top -json blink_zed.json" blink_zed.v
blink_out_zed.config: blink_zed.json blink_zed.lpf
	nextpnr-ecp5 --json blink_zed.json --textcfg blink_out_zed.config --25k --package CABGA381 --lpf blink_zed.lpf
blink_zed.svf: blink_out_zed.config
	ecppack --svf blink_zed.svf blink_out_zed.config blink_zed.bit
build: blink_zed.svf 

clean:
	rm blink_zed.json blink_out_zed.config blink_zed.bit blink_zed.svf
