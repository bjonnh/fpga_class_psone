+++
title = "Resources"
weight = 100
+++

## About the FPGA chip
The Lattice ECP5 is a resonably powerful FPGA which has had its bitstream fully reversed by [Project Trellis](https://prjtrellis.readthedocs.io/en/latest/index.html). This enables it be to fully supported by [the open source tools](https://github.com/YosysHQ/oss-cad-suite-build), requiring no vendor tools.
 - [ECP5 Family Datasheet](https://www.latticesemi.com/-/media/LatticeSemi/Documents/DataSheets/ECP5/FPGA-DS-02012-2-8-ECP5-ECP5G-Family-Data-Sheet.ashx?document_id=50461)

## About the boards
The Colorlite i5 is technically part of a videowall product, but is used by us as a developmenet board because it meets an excellent balance of cost, availability, powerful features and practicality. The community has reversed this board, and additionally, created an "extension board" that is a carrier which breaks out the SO-DIMM to easier to use connectors and also serves as a USB programming interface. Here's some details specs and links:
 - The Colorlite i5 provides the ECP5 and two gigabit PHYs on a SO-DIMM form factor. Commercially sold here: https://www.aliexpress.com/item/1005001686186007.html
 - A very generous amount of IO is available and broken out in a generic way. Additionally, an extension board means you don't have to solder an SO-DIMM socket yourself: https://github.com/wuxx/Colorlight-FPGA-Projects
- Pin mapping of the extension board : https://tomverbeure.github.io/2021/01/30/Colorlight-i5-Extension-Board-Pin-Mapping.html
- Extension board official page: 
- https://www.colorlight-led.com/product/colorlight-i5-led-display-receiver-card.html
- https://tomverbeure.github.io/2021/01/22/The-Colorlight-i5-as-FPGA-development-board.html

## About the OSS FPGA eco-system

- Yosys - Synthesis: https://yosyshq.net/yosys/
- Litex - building hardware easily on FPGA with Python code: https://github.com/enjoy-digital/litex
- VexRiscv - RISC-V CPU: https://github.com/SpinalHDL/VexRiscv
- NextPNR - Place and route tool : https://github.com/YosysHQ/nextpnr
- Project Trellis - PNR for ECP5: https://github.com/YosysHQ/prjtrellis
