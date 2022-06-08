module counter(output logic [4:0] count,
	       input logic [4:0] data,
	       input logic clk, rst_, enable, load);
   timeunit 1ns;
   timeprecision 100ps;

  /* always_ff @(posedge clk, rst_)
     if(clk == 1 && rst_ == 1 && enable == 1) //hard-coding the write states, so that the counter registers only when the user means it to (specification about this not clear)
       if(load == 1)
	 count <= data;
       else
	 count <= count + 1;
     else if(rst_ === 0)
       count <= 0;
     else
       ;*/
   always_ff @(posedge clk, rst_)
	if(!rst_)
	  count = '0;
	else if(clk)
	  if(load)
	    count = data;  
	  else if(enable)
	    count++;
          else
	    ;
        else
	  ;
	
endmodule // counter

       
   
	       
