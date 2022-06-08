package typedefs;
   typedef enum logic[0:2] {HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP} opcode_t;
   typedef enum bit[2:0] {INST_ADDR, INST_FETCH, INST_LOAD, IDLE, OP_ADDR, OP_FETCH, ALU_OP, STORE} state_t;
endpackage:typedefs
   
