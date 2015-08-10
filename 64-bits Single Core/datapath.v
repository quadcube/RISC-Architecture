`include "opcodes.v"
`timescale 100ps / 10ps

module datapath( Sysbus, Zero, Function, TrisALU, TrisPC, TrisRs2, TrisRd, nTrisRd, Clock, nReset, ReadPC_1, ReadPC_2, ReadR0_1, ReadR0_2, ReadR1_1, ReadR1_2, ReadR2_1, ReadR2_2, ReadR3_1, ReadR3_2,ReadR4_1, ReadR4_2, ReadR5_1, ReadR5_2, ReadR6_1, ReadR6_2, ReadR7_1, ReadR7_2, ReadR8_1, ReadR8_2, ReadR9_1, ReadR9_2, ReadR10_1, ReadR10_2, ReadR11_1, ReadR11_2, ReadR12_1, ReadR12_2, ReadR13_1, ReadR13_2, ReadR14_1, ReadR14_2, ReadR15_1, ReadR15_2, ReadR16_1, ReadR16_2, ReadR17_1, ReadR17_2, PC_inc, WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17, Rs2_sel, LoadDR, LoadPC, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR);

inout [63:0] Sysbus;

output Zero;
input [5:0] Function;
input TrisALU, TrisPC, TrisRs2, TrisRd, nTrisRd, Rs2_sel, PC_inc, LoadDR, LoadPC;
input Clock, nReset;
input ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
input ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
input WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
output reg [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
wire Zero, Compare, Parity_ODD, Parity_EVEN, Overflow;
wire [31:0] overf;

wire [63:0] Rd, Rs1, Rs2, result;
wire [63:0] Mux2_out, Mux1_out;


   assign Rs1 = ( ReadPC_1) ? PC : 64'bz;
   assign Rs1 = ( ReadR0_1) ? R0 : 64'bz;
   assign Rs1 = ( ReadR1_1) ? R1 : 64'bz;
   assign Rs1 = ( ReadR2_1) ? R2 : 64'bz;
   assign Rs1 = ( ReadR3_1) ? R3 : 64'bz;
   assign Rs1 = ( ReadR4_1) ? R4 : 64'bz;   
   assign Rs1 = ( ReadR5_1) ? R5 : 64'bz;
   assign Rs1 = ( ReadR6_1) ? R6 : 64'bz;
   assign Rs1 = ( ReadR7_1) ? R7 : 64'bz;
   assign Rs1 = ( ReadR8_1) ? R8 : 64'bz;
   assign Rs1 = ( ReadR9_1) ? R9 : 64'bz;
   assign Rs1 = ( ReadR10_1) ? R10 : 64'bz;
   assign Rs1 = ( ReadR11_1) ? R11 : 64'bz;
   assign Rs1 = ( ReadR12_1) ? R12 : 64'bz;
   assign Rs1 = ( ReadR13_1) ? R13 : 64'bz;
   assign Rs1 = ( ReadR14_1) ? R14 : 64'bz;
   assign Rs1 = ( ReadR15_1) ? R15 : 64'bz;
   assign Rs1 = ( ReadR16_1) ? R16 : 64'bz;
   assign Rs1 = ( ReadR17_1) ? R17 : 64'bz;


   assign Rs2 = ( ReadPC_2) ? PC : 64'bz;
   assign Rs2 = ( ReadR0_2) ? R0 : 64'bz;
   assign Rs2 = ( ReadR1_2) ? R1 : 64'bz;
   assign Rs2 = ( ReadR2_2) ? R2 : 64'bz;
   assign Rs2 = ( ReadR3_2) ? R3 : 64'bz;
   assign Rs2 = ( ReadR4_2) ? R4 : 64'bz;   
   assign Rs2 = ( ReadR5_2) ? R5 : 64'bz;
   assign Rs2 = ( ReadR6_2) ? R6 : 64'bz;
   assign Rs2 = ( ReadR7_2) ? R7 : 64'bz;
   assign Rs2 = ( ReadR8_2) ? R8 : 64'bz;
   assign Rs2 = ( ReadR9_2) ? R9 : 64'bz;
   assign Rs2 = ( ReadR10_2) ? R10 : 64'bz;
   assign Rs2 = ( ReadR11_2) ? R11 : 64'bz;
   assign Rs2 = ( ReadR12_2) ? R12 : 64'bz;
   assign Rs2 = ( ReadR13_2) ? R13 : 64'bz;
   assign Rs2 = ( ReadR14_2) ? R14 : 64'bz;
   assign Rs2 = ( ReadR15_2) ? R15 : 64'bz;
   assign Rs2 = ( ReadR16_2) ? R16 : 64'bz;
   assign Rs2 = ( ReadR17_2) ? R17 : 64'bz;


alu ALU(alu_Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, result, overf, Rs1, Mux2_out, Function);    
always @(posedge Clock)
   begin
   if (LoadPC) PC = Mux1_out;
   if (WriteR1) R1 = Rd;     
   if (WriteR2) R2 = Rd;   
   if (WriteR3) R3 = Rd;
   if (WriteR4) R4 = Rd;     
   if (WriteR5) R5 = Rd;   
   if (WriteR6) R6 = Rd;
   if (WriteR7) R7 = Rd;     
   if (WriteR8) R8 = Rd;   
   if (WriteR9) R9 = Rd;
   if (WriteR10) R10 = Rd;     
   if (WriteR11) R11 = Rd;   
   if (WriteR12) R12 = Rd;
   if (WriteR13) R13 = Rd;     
   if (WriteR14) R14 = Rd;   
   if (WriteR15) R15 = Rd;
   if (WriteR16) R16 = Rd;     
   if (WriteR17) R17 = Rd;   
   if (LoadDR) DR = Sysbus;  
   end
   
   assign Mux2_out = ( Rs2_sel ) ? Rs2 : DR;
   assign Zero = (result == 0);
   assign Mux1_out = ( PC_inc ) ? PC + 1 : Rd;
   assign Rd = (TrisRd ) ? Sysbus : 64'bz; 
   assign Rd = (nTrisRd) ? result : 64'bz;
   assign Sysbus = ( TrisALU ) ? result : 64'bz;
   assign Sysbus = ( TrisPC ) ? PC : 64'bz;
   assign Sysbus = ( TrisRs2) ? Rs2 : 64'bz;
   
   always @(nReset)
      if (!nReset)
         begin
          assign PC = 0;
	    assign R1 = 0;
	    assign R2 = 0;
	    assign R3 = 0;
	    assign R4 = 0;
	    assign R5 = 0;
	    assign R6 = 0;
	    assign R7 = 0;
	    assign R8 = 0;
	    assign R9 = 0;
	    assign R10 = 0;
	    assign R11 = 0;
	    assign R12 = 0;
	    assign R13 = 0;
	    assign R14 = 0;
	    assign R15 = 0;
	    assign R16 = 0;
	    assign R17 = 0;
	    assign DR = 0;
	    assign R0 = 0;
         end
      else
         begin
            deassign PC;
	    deassign R1;
	    deassign R2;
	    deassign R3;
	    deassign R4;
	    deassign R5;
	    deassign R6;
	    deassign R7;
	    deassign R8;
	    deassign R9;
	    deassign R10;
	    deassign R11;
	    deassign R12;
	    deassign R13;
	    deassign R14;
	    deassign R15;
	    deassign R16;
	    deassign R17;
	    deassign DR;
         end
   
   
endmodule


