//
// EECE 479: Project Verilog File: datapath.v
//
// This is the stub for the datapath block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Redmond, Kirat
// Number:  70949094, 39208103 
//

module datapath(remainder, 
                quotient, 
                sign,
                divisorin,
                dividendin,
                load,
                add,
                shift,
                inbit,
                sel,
                clk,
                reset);

output [6:0] remainder;
output [7:0] quotient;
output sign;
input [6:0] divisorin;
input [7:0] dividendin;
input load;
input add;
input shift;
input inbit;
input [1:0] sel;
input clk;
input reset;

reg [15:0] shiftout;
reg [7:0] divisorout;
reg [15:0] remainout;
reg [7:0] addout;
reg sign;
reg [15:0] muxout;

wire [6:0] remainder;
wire [7:0] quotient;

//Divisor and Remainder Registers
always @(posedge clk or posedge reset) begin
	if(reset) begin
		divisorout <= 0;
		remainout <= 0;
	end
	else begin

	if(load) begin
		divisorout <= 	{1'b0, divisorin};
	end
	remainout <= shiftout;

	end
end

//Add/Sub module
always @(divisorout or remainout[15:8] or add) begin
//always @(divisorout or remainout[15:8]) begin
if (add == 1'b1) begin
addout = remainout[15:8] + divisorout;
sign = addout[7];
end
else if(add == 1'b0) begin
addout = remainout[15:8] - divisorout;
sign = addout[7];
end

end

//3-1 mux
always @(sel or dividendin or addout or remainout) begin
//always @(dividendin or addout or remainout) begin
if(sel == 2'b10)
muxout <= {8'b00000000, dividendin};
else if(sel == 2'b01)
muxout <= {addout, remainout[7:0]};
else if (sel == 2'b11)
muxout <= remainout;
end

//Shift
always @(shift or muxout) begin
//always @(shift or muxout) begin
//always @(posedge(shift) or muxout) begin
//always @(muxout) begin
if(shift)
	shiftout <= {muxout[14:0] , inbit};
else if(!shift)
	shiftout <= muxout;
end

assign remainder = remainout[15:9];
assign quotient = remainout[7:0];

endmodule
