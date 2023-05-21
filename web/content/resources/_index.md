+++
title = "Resources"
weight = 100
+++

## About the FPGA chip
The Lattice ECP5 is a reasonably powerful FPGA which has had its bitstream fully reversed by [Project Trellis](https://prjtrellis.readthedocs.io/en/latest/index.html). This enables it be to fully supported by [the open source tools](https://github.com/YosysHQ/oss-cad-suite-build), requiring no vendor tools.
 - [ECP5 Family Datasheet](https://www.latticesemi.com/-/media/LatticeSemi/Documents/DataSheets/ECP5/FPGA-DS-02012-2-8-ECP5-ECP5G-Family-Data-Sheet.ashx?document_id=50461)

## About the boards
An [in-depth overview](https://tomverbeure.github.io/2021/01/22/The-Colorlight-i5-as-FPGA-development-board.html) of the boards we are using is on Tom Verbeure's blog.




The TLDR is:
The Colorlite i5 is technically part of a commercial [videowall product](https://www.colorlight-led.com/product/colorlight-i5-led-display-receiver-card.html), but is used by us as a dev board because it meets an excellent balance of cost, availability, powerful features and practicality. The community has reversed this board, and additionally, created an "extension board" that is a carrier which breaks out the SO-DIMM with easier to use connectors and also provides a USB-JTAG programming interface. Here's some detailed specs and links:
 - The Colorlite i5 itself provides the ECP5, two gigabit PHYs, and a generous amount of GPIO on a SO-DIMM form factor. Sold here: https://www.aliexpress.com/item/1005001686186007.html
 - A third-party "extension board" (it's a breakout board) means you don't have to solder an SO-DIMM socket yourself and have lots of PMOD-like connectors and a ready-to-go USB-JTAG Programmer: https://github.com/wuxx/Colorlight-FPGA-Projects
- Schematic for the i5 Ext board: https://github.com/wuxx/Colorlight-FPGA-Projects/blob/master/schematic/i5_v6.0-extboard.pdf
- Pin mapping of the extension board: https://tomverbeure.github.io/2021/01/30/Colorlight-i5-Extension-Board-Pin-Mapping.html
- Finaly, another add-on to the extension board provides ethernet: https://github.com/kazkojima/colorlight-i5-tips

## About the OSS FPGA eco-system

- OSS Cad Suite - Packages many of the components necessary: https://github.com/YosysHQ/oss-cad-suite-build
- Yosys - OSS FPGA Synthesis: https://yosyshq.net/yosys/
- Litex - building hardware easily on FPGA with Python code: https://github.com/enjoy-digital/litex
- VexRiscv - RISC-V CPU: https://github.com/SpinalHDL/VexRiscv
- NextPNR - Place and route tool : https://github.com/YosysHQ/nextpnr
- Project Trellis - PNR / Bitstream for ECP5: https://github.com/YosysHQ/prjtrellis

## Terminology
- FPGA - Field Programmable Gate Array. A programmable device, which consists of arbitrarily configurable logic.
- IP Core - Blocks of logic used to perform specific functions
- JTAG - A serial programming and testing interface used to program our FPGA boards.
- LUT - Lookup table: A piece of logic that allows mappings of a series of inputs states to specific output. An FPGA largely consists of a programmable/configurable matrix  of LUTs, and the "size" of an FPGA is often specified in LUTs.
- OSS - Open Source Software
- PMOD - A connector laid out using standard 0.1" headers. Usually provides a byte worth of IO and power/ground in a [standard layout](https://digilent.com/blog/how-to-use-the-pmod-ports-on-the-arty/)
- Python - A general purpose high-level programming lanugage
- Verilog - A programming language used specifically with FPGAs
