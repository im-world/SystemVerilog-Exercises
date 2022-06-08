///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem_test.sv
// Title       : Memory Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Memory testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module mem_test ( input logic clk, 
                  output logic 	     read, 
                  output logic 	     write, 
                  output logic [4:0] addr, 
                  output logic [7:0] data_in, // data TO memory
                  input wire [7:0]   data_out     // data FROM memory
                  );
   // SYSTEMVERILOG: timeunit and timeprecision specification
   timeunit 1ns;
   timeprecision 1ns;

   // SYSTEMVERILOG: new data types - bit ,logic
   bit 				     debug = 1;
   logic [7:0] 			     rdata;      // stores data read from memory for checking

   // Monitor Results
   initial begin
      $timeformat ( -9, 0, " ns", 9 );
      // SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
   end

   initial
     begin: memtest
	int error_status;

	$display("Clear Memory Test");
	error_status = '0;
	
	for (int i = 0; i< 32; i++)
	  begin
	     // Write zero data to every address location
	     write_mem(i, 0);
	  end
	
	for (int i = 0; i<32; i++)
	  begin 
	     // Read every address location
	     logic [7:0] read_data;
	     read_mem(i, read_data);
	     // check each memory location for data = 'h00
	     error_status = (read_data == 'h00)? error_status : (error_status+1);	  
	  end

	// print results of test
	printstatus(error_status);
	
	$display("Data = Address Test");

	for (int i = 0; i< 32; i++)
	  // Write data = address to every address location
	  write_mem(i, i);
       
	for (int i = 0; i<32; i++)
	  begin
	     // Read every address location
	     logic [7:0] read_data;
	     read_mem(i, read_data);	     
	     // check each memory location for data = address
	     error_status = (read_data == i)? error_status : (error_status + 1);  
	  end
	
	// print results of test
	printstatus(error_status);
	
	$finish;
     end

   // add read_mem and write_mem tasks
   task automatic write_mem( input logic [4:0] addr_local, 
				   input logic [7:0] data_in_local, // data TO memory
				   input logic 	     debug = 0
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
				input logic 	   debug = 0
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
   
   
   // add result print function
   function automatic void printstatus(int status);
      if(status == 0)
	$display("TEST PASSED");
      else
	$display("TEST FAILED: %d ERRORS", status);
      return;
   endfunction // printstatus
   
endmodule
