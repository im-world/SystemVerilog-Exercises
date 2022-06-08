module scale_mux #(parameter WIDTH = 1)
                 (output logic [WIDTH:1] out,
		 input logic [WIDTH:1] in_a, in_b,
		 input logic sel_a);
  
   timeunit 1ns;
   timeprecision 100ps;
   always_comb
     unique case(sel_a)
       1'b1: out = in_a;
       1'b0: out = in_b;
       default: ;
     endcase // unique case (sel_a)

endmodule // scale_mux

     
   
