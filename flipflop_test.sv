///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : flipflop_test.sv
// Title       : Flipflop Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Flipflop testbench module
// Notes       : I only own the parts written by me as a solution, in the case of this file
// 
///////////////////////////////////////////////////////////////////////////

module testflop ();
   timeunit 1ns;

   logic reset;
   logic [7:0] qin,qout;

   // ---- clock generator code begin------
`define PERIOD 10
   logic       clk = 1'b1;

   always
     #(`PERIOD/2)clk = ~clk;

   // ---- clock generator code end------


   flipflop DUV(.*);

   //   <add clocking block>
   default clocking cb @(posedge clk);
      default input #1step output #4ns;
      output qin, reset;
      input qout;
   endclocking      
      
   
   //   <add stimulus to drive clocking block>

   initial begin @(cb);
      cb.reset <= 1;
      ##3 cb.reset <= 0;
      
      /*always begin (@cb);
       ##1 cb.qin <= random();
      end*/
      
//      ##1 cb.reset <= 1;
      ##1 cb.qin <= 1;
      ##1 cb.qin <= 2;  
      ##1 cb.qin <= 4;
      ##1 cb.qin <= 8;
      ##1 cb.qin <= 16;
      ##1 cb.qin <= 32;
      ##1 cb.qin <= 64;
      ##1 cb.reset <= 1;
      $finish;
   end

endmodule
