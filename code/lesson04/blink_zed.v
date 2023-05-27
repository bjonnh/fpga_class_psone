module top(input wire clk, output wire led_pin);
	wire baseclk;
	reg led;
	reg enable;
	
	// set up state names and initialize the state
	localparam state_off = 2'b00;
	localparam state_dim = 2'b01;
	localparam state_brite = 2'b10;
	reg [1:0] led_state = state_off;
	
	// divide input 25MHz clock to get a period of 100ms (10Hz)
	clkdiv #(.DIV(2500000)) slowclk(
			.clk_i(clk), 
			.clk_o(baseclk));
	
	// set up delay counter for the state machine
	// each clock period is 100ms so total wait time is 500ms
	localparam state_time = 5;
	reg [7:0] counter = state_time;
	
	// the actual state machine
	always @(posedge baseclk) begin
	case (led_state)
		state_off: begin
			enable = 1'b1;
			led <= 1'b1;
			counter <= counter - 1;
			if (counter == 0) begin
				counter <= state_time;
				led_state <= state_dim;
			end
		end
		state_dim: begin
			enable = 1'b0;
			led <= 1'b1;
			counter <= counter - 1;
			if (counter == 0) begin
				counter <= state_time;
				led_state <= state_brite;
			end
		end
		state_brite: begin
			enable = 1'b1;
			led <= 1'b0;
			counter <= counter - 1;
			if (counter == 0) begin
				counter <= state_time;
				led_state <= state_off;
			end
		end
		default: begin
			enable = 1'b1;
			led <= 1'b1;
			counter <= counter - 1;
			if (counter == 0) begin
				counter <= state_time;
				led_state <= state_dim;
			end
		end
	endcase
	end
	
	// primitive for bi-directional buffer which allows tri-stating
	BB tristate_out (.I(led), .T(~enable), .B(led_pin));
	
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
