+++
title = "Flashing and programming the ECP5"
weight = 1
+++

## Programming

### Faster upload
Programing the ECP5 can be horribly slow with the integrated circuit. 

I recommend something like: https://github.com/phdussud/pico-dirtyJtag with a RP2040 that can program it at high speed. You would have to remove the pogo pins or insulate them and connect the circuit to it.

### Flash, or how to get persistent programs

The colorlight i5 board also contains an SPI EEPROM. This allows you to set a bitstream that will be loaded everytime the board starts instead of having to load it yourself. But it is unfortunately locked when you get it.

There is a program, included in oss-cad that allows to unlock it. Unfortunately, at least on Linux, I had to compile my own with `cargo` the build system for rust. You just have to run

```shell
cargo install ecpdap
~/.cargo/bin/ecpdap scan
```
 
This should reply with something like
```text
Detected JTAG chain, closest to TDO first:
 - 0: 0x41111043 (Lattice Semi.) [IR length: 8] [LFE5U-25]
```

You can then unprotect the flash with:

```shell
~/.cargo/bin/ecpdap flash unprotect
```
