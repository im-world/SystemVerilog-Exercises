///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : control.sv
// Title       : Control Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Control module
// Notes       : I only own the parts written by me as a solution, in the case of this file
// 
///////////////////////////////////////////////////////////////////////////

// import SystemVerilog package for opcode_t and state_t

module control import typedefs::*;(
                output logic      load_ac ,
                output logic      mem_rd  ,
                output logic      mem_wr  ,
                output logic      inc_pc  ,
                output logic      load_pc ,
                output logic      load_ir ,
                output logic      halt    ,
                input  opcode_t opcode  , // opcode type name must be opcode_t
                input             zero    ,
                input             clk     ,
                input             rst_   
                );
// SystemVerilog: time units and time precision specification
timeunit 1ns;
timeprecision 100ps;

state_t state;   
logic ALUOP;
   
always_ff @(posedge clk or negedge rst_)
  begin
     if (!rst_) // < add code for initial state>
       state = state_t'(0);
     else
	  state = state_t'(++state);
  end
   
//<add code for output decode>

always_comb
  begin
     //zero = (load_ac == 0)? 1 : 0; assigning to input
     ALUOP = (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA)? 1 : 0;
     unique case(state)
       INST_ADDR:
	 begin
	    mem_rd = 0;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       INST_FETCH:
	 begin
	    mem_rd = 1;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       INST_LOAD:
	 begin
	    mem_rd = 1;
	    load_ir = 1;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       IDLE:
	 begin
	    mem_rd = 1;
	    load_ir = 1;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       OP_ADDR:
	 begin
	    mem_rd = 0;
	    load_ir = 0;
	    halt = (opcode == HLT)? 1 : 0;
	    inc_pc = 1;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       OP_FETCH:
	 begin
	    mem_rd = ALUOP;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
       ALU_OP:
	 begin
	    mem_rd = ALUOP;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = (opcode == SKZ && zero == 1)? 1 : 0;
	    load_ac = ALUOP;
	    load_pc = (opcode == JMP)? 1 : 0;
	    mem_wr = 0;
	 end
       STORE:
	 begin
	    mem_rd = ALUOP;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = (opcode == JMP)? 1 : 0;
	    load_ac = ALUOP;
	    load_pc = (opcode == JMP)? 1 : 0;
	    mem_wr = (opcode == STO)? 1 : 0;
	 end
       default:
	 begin
	    mem_rd = 0;
	    load_ir = 0;
	    halt = 0;
	    inc_pc = 0;
	    load_ac = 0;
	    load_pc = 0;
	    mem_wr = 0;
	 end
     endcase
  end
endmodule
