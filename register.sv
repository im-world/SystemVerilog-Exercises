module register(output logic [7:0] out,
                input logic [7:0] data,
		input logic rst_, clk, enable);
   
   timeunit 1ns;
   timeprecision 100ps;
   always_ff @(posedge clk, rst_)
	if(!rst_)
	  out = '0;
	else if(clk == 1 && enable == 1) //pass without clk==1, but this is a bug ;)
	  out = data;
	else
	  ;
     
endmodule // register

		
	    
