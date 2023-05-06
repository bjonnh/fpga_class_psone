+++
title = "Assignments"
weight = 1
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

