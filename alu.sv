module alu import typedefs::*;(
			       output logic [7:0] out,
			       output logic zero,
			       input logic [7:0]  accum, data,
			       input [2:0] opcode,
			       input clk
			       );
   timeunit 1ns;
   timeprecision 100ps;

   always_comb
     zero = (accum == 0)? 1 : 0;

   always_ff @(negedge clk)
     begin
	unique case(opcode)
	  HLT: out = accum;
	  SKZ: out = accum;
	  ADD: out = data + accum;
	  AND: out = data & accum;
	  XOR: out = data ^ accum;
	  LDA: out = data;
	  STO: out = accum;
	  JMP: out = accum;
	  default: out = accum;
	endcase // unique case (opcode)
     end // always_ff @ (negedge clk)

endmodule
