module top(input clk_i, output led_o);
   reg  led_reg;
   wire baseclk;

   clkdiv #(.DIV(1000000)) slowclk (clk_i, baseclk);

   always @(posedge baseclk) begin;
      led_reg <= ~led_reg;
   end

   assign led_o = led_reg;
endmodule


module clkdiv #(parameter DIV = 24'd5000)(
    input wire clk_i,
    output wire clk_o
    );

    reg [24:0] count = 25'b0;
    reg clk_o_internal = 1;
    //on this board we have a 25MHz clock

    always @(posedge clk_i) begin
        count <= count + 25'b1;
        if(count == DIV) begin
            count <= 25'b0;
            clk_o_internal <= ~clk_o_internal;
        end
    end
    assign clk_o = clk_o_internal;
endmodule
