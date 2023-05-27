+++
title = "PS1's FPGA class"
+++
<!--: .wrap .size-70 ..aligncenter bgimage=images/ecp5_blinky_div2led.png -->


## **PS1's FPGA class**

Learning stuff about FPGA
{ .text-intro }

**[Class web site](https://bjonnh.github.io/fpga_class_psone)**

**[https://bjonnh.github.com/fpga_class_psone/presentation](https://bjonnh.github.com/fpga_class_psone/presentation)**

**[bjonnh-fpga@bjonnh.net](mailto:bjonnh-fpga@bjonnh.net)**

---

<!--: .wrap -->

## **Who's behind it**

**(alphabetical order no jealous)**

### The main team

- Carl Karsten (boards-master/testing/writing)
- Jonathan Bisson (bottle-washing/conception/testing/writing)
- Peter Zieba (testing/writing)
- Stephen Kulov (soldering/testing/writing)


### Other thanks

- The people behind [OSS-CAD](https://github.com/YosysHQ/oss-cad-suite-build), [LiteX](https://github.com/enjoy-digital/litex) and the hundreds of other tools we don't see
- Bonnie King (testing on Mac)

---

<!--: .wrap -->

## **Ground-rules**

- Respect each other we all come from different backgrounds
- Don't touch someone's else material without asking
- If you act like a dick you're out

---

<!--: .wrap -->

## **Purpose**

- Learn by doing
- Reduce roadblocks in learning

---

<!--: .wrap -->

## **What you'll get**

{{< gallery title="Colorlight i5" href="https://tomverbeure.github.io/2021/01/22/The-Colorlight-i5-as-FPGA-development-board.html" src="https://tomverbeure.github.io/assets/colorlight_i5/colorlight_i5.jpg">}}Colorlight i5{{< /gallery >}}

The board with the FPGA on it, in a SODIMM (DDR-2) format (don't try to put it in a computer you'll be really unhappy)
Originally made to control LEDs on giant panels.

---

<!--: .wrap -->

## **What you'll get**

{{< gallery title="Support board" href="https://tomverbeure.github.io/2021/01/22/The-Colorlight-i5-as-FPGA-development-board.html" src="https://tomverbeure.github.io/assets/colorlight_i5/development_board.jpg">}}Muse lab's dev board{{< /gallery >}}

A support board with a USB-C port for powering, programming and talking to the device. An "HDMI" port. It also exposes most of the GPIOs to the outside as well as the ethernet.

The SODIMM will be already mounted on it, we do not recommend that you remove it. Those ports support 25-ish insertion cycles.

We already mounted the 45 degree pins on the left and right of your board and we will give you the other ones. Careful with the ones next to the HDMI if you mount them, they can block some cables from beeing connected.

---

<!--: .wrap -->

## **What you'll get**

{{< gallery title="Ethernet board" href="https://github.com/kazkojima/colorlight-i5-tips#ethernet" src="https://tomverbeure.github.io/assets/colorlight_i5/ethernet_expansion_board.jpg">}}Kazumoto Kojima's ethernet board{{< /gallery >}}

The pulse transformers and RJ45 board.

---

<!--: .wrap -->

## **Setup**

Who had issues setting up?

---

<!--: .wrap -->

## **Lesson 1**

Blinky

---

<!--: .wrap -->

## **Lesson 2**

Blinky but with purpose

---

<!--: .wrap -->

## **Lesson 3**

SoC with LiteX


---

<!--: .wrap -->

## **Lesson 4 (only for Linux and Mac users sorry)**

SoC with a RiscV cpu



