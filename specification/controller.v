//
// EECE 479: Project Verilog File: controller.v
//
// This is the stub for the controller block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Redmond, Kirat
// Number:  70949094, 39208103 
//


//NOTE: VALID HIGH AFTER 5'b10010 CYCLES

module controller(load,
                   add,
                   shift,
                   inbit,
                   sel,
		   valid,
                   start,
                   sign, 
                   clk,
                   reset);
output load;
output add;
output shift;
output inbit;
output [1:0] sel;
output valid;   
input start;
input sign;
input clk;
input reset;
reg load;
reg add;
reg shift;
reg inbit;
reg [1:0]sel;
wire valid;

reg [1:0] curr_state_s1;  // The current state
reg [1:0] next_state_s1;  // The next state

reg [4:0] counter;
reg [4:0] counter_next;

parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;

always@(curr_state_s1) begin
case (curr_state_s1)
	s0: begin
		load <= 1'b1;
		sel <= 2'b10;		
		shift <= 1'b1;
		inbit <= 1'b0;
		add <= 1'bx;
		counter <= 5'b00000;
		end
	s1: begin
		load <= 1'b0;
		sel <= 2'b01;
		shift <= 1'b0;
		inbit <= 1'bx;
		add <= 1'b0;
		end
	s2: begin
		load <= 1'b0;
		sel <= 2'b01;
		shift <= 1'b1;
		inbit <= 1'b0;
		add <= 1'b1;
		end
	default: begin
		load <= 1'b0;
		sel <= 2'b11;
		shift <= 1'b1;
		inbit <= 1'b1;
		add <= 1'bx;
		end
endcase
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		curr_state_s1 <= 2'b00;
	end
	else begin
	if(counter < 5'b10010)
	counter <= counter + 1;
	else 
	counter <= 5'b00000;

		case (curr_state_s1)
	s0: if(start)
		curr_state_s1 <= s0;
		else
		curr_state_s1 <= s1;
	s1:  if(start)
		curr_state_s1 <= s0;
		else if(sign)
		curr_state_s1 <= s2;
		else
		curr_state_s1 <= s3;
	s2: if(start)
		curr_state_s1 <= s0;
		else
		curr_state_s1 <= s1;
	default: if(start)
		curr_state_s1 <= s0;
		else
		curr_state_s1 <= s1;
endcase
	end
		
end

assign valid = (counter == 5'b10010) ? 1'b1:1'b0;

endmodule

/*
always @(curr_state_s1 or start or sign)  
begin
case (curr_state_s1) 
      2'b00:   if (start) next_state_s1 = 2'b00;
		else next_state_s1 = 2'b01;
      2'b01:  if (start) next_state_s1 = 2'b00;
		else if (sign) next_state_s1 = 2'b10;
               else next_state_s1 = 2'b11;
      2'b10:   if (start) next_state_s1 = 2'b00;
		else next_state_s1 = 2'b01;
      default: if (start) next_state_s1 = 2'b00;
		 else next_state_s1 = 2'b01;
   endcase
end

always @(posedge clk or negedge reset)
	if (!reset)
		curr_state_s1 <= 2'b00;
	else if (start)
		curr_state_s1 <= 2'b00;
	else 
	curr_state_s1 <= next_state_s1;

always @(posedge clk)
case(curr_state_s1)
			2'b00: begin
					load <= 1'b1;
					sel <= 2'b10;
					shift <= 1'b1;
					inbit <= 1'b0;
					add <= 1'bx;
				end
			2'b01: begin
					load <= 1'b0;
					sel <= 2'b01;
					shift <= 1'b0;
					inbit <= 1'bx;
					add <= 1'b0;
				end
			2'b10: begin
					load <= 1'b0;
					sel <= 2'b01;
					shift <= 1'b1;
					inbit <= 1'b0;
					add <= 1'b1;
				end
			default: begin
					load <= 1'b0;
					sel <= 2'b11;
					shift <= 1'b1;
					inbit <= 1'b1;
					add <= 1'bx;
				end
endcase

endmodule
*/
