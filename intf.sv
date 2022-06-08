interface mem_if(input logic clk);
   timeunit 1ns;
   timeprecision 1ns;

   logic [4:0] addr;
   logic [7:0] data_in;
   logic [7:0] data_out;
   logic       read;
   logic       write;

   task automatic write_mem( input logic [4:0] addr_local, 
			     input logic [7:0] data_in_local, // data TO memory
			     input logic       debug = 0
			     );
      
      @(negedge clk); //set values at inactive edge
      read = 0;
      write = 1;
      data_in = data_in_local;
      addr = addr_local;
      
      @(posedge clk); //wait for active edge to complete writing
      if (debug == 1)
	$display("write address = %d, data value = %d", addr, data_in);
      else
	;
      return;
      
   endtask // write_mem

   task automatic read_mem(input logic [4:0] addr_local,
			   output logic [7:0] data_out_local,
			   input logic 	      debug = 0
			   );
      @(negedge clk);
      write = 0;
      read = 1;
      addr = addr_local;
      
      @(posedge clk);
      #10 data_out_local = data_out; //propogation delay
      if (debug == 1)
	$display("read address = %d, data value = %d", addr_local, data_out_local);
      else
	;
      return;
      
   endtask // read_mem
   

   modport test (input clk, data_out, output read, write, addr, data_in, import read_mem, write_mem);
   modport mem (input clk, read, write, addr, data_in, output data_out);
endinterface // mem_if

   
