.PHONY: build flash all
all: build flash

flash: build/gateware/colorlite.svf
	make -C .. flash FILE=$(PWD)/build/gateware/colorlite.svf

build/gateware/colorlite.svf: main.py
	python3 main.py --build
