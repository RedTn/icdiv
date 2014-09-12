//
// EECE 479: Project Verilog File: divider.v
//
// This is the stub for your top-level block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Redmond, Kirat
// Number:  70949094, 39208103 
//


module divider(
         remainder,
         quotient,
	 valid,
         divisorin,
         dividendin,
         start,
         clk,
         reset);

output [6:0] remainder;
output [7:0] quotient;
output valid;  
input [6:0] divisorin;
input [7:0] dividendin;
input start;
input clk;
input reset;

wire load;
wire add;
wire shift;
wire inbit;
wire [1:0] sel;
wire valid;
wire sign;
wire [6:0] remainder;
wire [7:0] quotient;

controller controller0(.load(load),
				.add(add),
				.shift(shift),
				.inbit(inbit),
				.sel(sel),
				.valid(valid),
				.start(start),
				.sign(sign),
				.clk(clk),
				.reset(reset));

datapath datapath0(.remainder(remainder),
				.quotient(quotient),
				.sign(sign),
				.divisorin(divisorin),
				.dividendin(dividendin),
				.load(load),
				.add(add),
				.shift(shift),
				.inbit(inbit),
				.sel(sel),
				.clk(clk),
				.reset(reset));

endmodule
