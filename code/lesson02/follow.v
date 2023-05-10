module top(input clk_i, input port_i, output led_o);
   reg  led_reg;
   wire baseclk;

   clkdiv #(.DIV(200000)) slowclk (clk_i, baseclk);
   ring_buffer  buffer (baseclk, port_i, led_o);
endmodule


module ring_buffer (
  input wire clk,
  input wire data_in,
  output wire data_out
);
  reg [255:0] buffer;
  reg [7:0]   write_pointer;
  reg [7:0]   read_pointer;

  initial begin
    buffer = 256'b0000000000000000000000000000000000000000000011111111000000001111111100000000111111110000000011111111111111110000000011111111111111110000000011111111111111110000000011111111000000001111111100000000111111110000000000000000000000000000000000000000000000000000;
  end

  always @(posedge clk) begin
    buffer[write_pointer] <= data_in;
    write_pointer <= write_pointer + 1;
    read_pointer  <= read_pointer + 1;
  end

  assign data_out = buffer[read_pointer];

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
