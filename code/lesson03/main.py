#!/usr/bin/env python3

#
# This file is based on Colorlite (https://github.com/enjoy-digital/colorlite)
#
# Copyright (c) 2020-2022 Florent Kermarrec <florent@enjoy-digital.fr>
# Copyright (c) 2023 Jonathan Bisson <bjonnh-github@bjonnh.net>
# SPDX-License-Identifier: BSD-2-Clause

from liteeth.phy.ecp5rgmii import LiteEthPHYRGMII
from litescope import LiteScopeAnalyzer
from litex.build.generic_platform import *
from litex.soc.cores.clock import *
from litex.soc.cores.gpio import GPIOOut
from litex.soc.cores.led import LedChaser
from litex.soc.cores.spi_flash import ECP5SPIFlash
from litex.soc.integration.builder import *
from litex.soc.integration.soc_core import *
from litex_boards.platforms import colorlight_i5
from migen import *
from migen.genlib.misc import WaitTimer

# IOs ----------------------------------------------------------------------------------------------

#_gpios = [
#    # GPIOs.
#    ("gpio", 0, Pins("j4:0"), IOStandard("LVCMOS33")),
#    ("gpio", 1, Pins("j4:1"), IOStandard("LVCMOS33")),
#]


# CRG ----------------------------------------------------------------------------------------------

class _CRG(Module):
    def __init__(self, platform, sys_clk_freq):
        self.clock_domains.cd_sys = ClockDomain()
        # # #

        # Clk / Rst.
        clk25 = platform.request("clk25")
        #rst_n = platform.request("user_btn_n", 0)

        # PLL.
        self.submodules.pll = pll = ECP5PLL()
        #self.comb += pll.reset.eq(~rst_n)
        pll.register_clkin(clk25, 25e6)
        pll.create_clkout(self.cd_sys, sys_clk_freq)


# ColorLite ----------------------------------------------------------------------------------------

class ColorLite(SoCMini):
    def __init__(self, sys_clk_freq=int(50e6), with_etherbone=True, ip_address=None, mac_address=None):
        platform = colorlight_i5.Platform(revision="7.0")
        platform.add_source("./blinker.v")

        # CRG --------------------------------------------------------------------------------------
        self.submodules.crg = _CRG(platform, sys_clk_freq)

        # SoCMini ----------------------------------------------------------------------------------
        SoCMini.__init__(self, platform, clk_freq=sys_clk_freq)

        # Etherbone --------------------------------------------------------------------------------
        if with_etherbone:
            self.submodules.ethphy = LiteEthPHYRGMII(
                clock_pads=self.platform.request("eth_clocks"),
                pads=self.platform.request("eth"),
                tx_delay=0e-9)
            self.add_etherbone(
                phy=self.ethphy,
                ip_address=ip_address,
                mac_address=mac_address,
                data_width=32,
            )

        # artificial signal
        count = Signal(8)
        blinky = Signal(1)
        #rst_n = platform.request("user_btn_n", 0)
        self.sync += count.eq(count + 1)
        self.specials += Instance("blinker", i_clk_i=count[0], o_led_o=blinky)
        analyzer_signals = [
            count,
            blinky,
        #    rst_n
        ]
        self.submodules.analyzer = LiteScopeAnalyzer(analyzer_signals,
            depth=1024,
            clock_domain="sys",
            samplerate=self.sys_clk_freq,
            csr_csv="analyzer.csv"
        )
        self.add_csr("analyzer")

        # GPIOs ------------------------------------------------------------------------------------
        #platform.add_extension(_gpios)

        # Power switch
        #power_sw_pads = platform.request("gpio", 0)
        #power_sw_gpio = Signal()
        #power_sw_timer = WaitTimer(2 * sys_clk_freq)  # Set Power switch high after power up for 2s.
        #self.comb += power_sw_timer.wait.eq(1)
        #self.submodules += power_sw_timer
        ##self.submodules.gpio0 = GPIOOut(power_sw_gpio)
        #self.comb += power_sw_pads.eq(power_sw_gpio | ~power_sw_timer.done)

        # Reset Switch
        #reset_sw_pads = platform.request("gpio", 1)
        #self.submodules.gpio1 = GPIOOut(reset_sw_pads)


# Build --------------------------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Take control of your ColorLight FPGA board with LiteX/LiteEth :)")
    parser.add_argument("--build", action="store_true", help="Build bitstream")
    parser.add_argument("--load", action="store_true", help="Load bitstream")
    parser.add_argument("--ip-address", default="10.0.0.42",
                        help="Ethernet IP address of the board (default: 10.0.0.42).")
    parser.add_argument("--mac-address", default="0x726b895bc2e2",
                        help="Ethernet MAC address of the board (defaullt: 0x726b895bc2e2).")
    args = parser.parse_args()

    soc = ColorLite(ip_address=args.ip_address, mac_address=int(args.mac_address, 0))
    builder = Builder(soc, output_dir="build", csr_csv="csr.csv")
    builder.build(build_name="colorlite", run=args.build)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(os.path.join(builder.gateware_dir, soc.build_name + ".svf"))

if __name__ == "__main__":
    main()
