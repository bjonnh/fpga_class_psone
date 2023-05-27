+++
title = "Verilog assignments"
weight = 2
+++

We have various kinds of assignment in Verilog:
- In clocked blocks (always @(posedge clk ) for example)
    - Blocking assignment (led_reg = clk_i)
    - Non blocking assignments (led_reg <= clk_i)
- Continuous assignments (assign led_o = clk_i)


Things have to be scheduled by whatever interprets the HDL description of your system.

This is just a simplified view but this is more or less the order of operations in a given module:

- Run all the blocking assignments
- Run the right-hand side(RHS) of non-blocking assignments and schedule the updates of the left hand side
- Update the left-hand-side
- Run the continuous assignments 
- Update inputs and outputs
- …

There is an additional mode which is not present on every FPGA but is on the ECP5 that allows you to initialize registers to specific values. Some FPGA don't have that and will either assign at 0, or even have values random.

You have to think that non-blocking statements may take more cycles to happen than you think (because things have to propagate). 
Whereas blocking ones will happen instantly.

Avoid mixing both if you don't need to (and the result may not be exactly portable from different kinds of FPGA).

