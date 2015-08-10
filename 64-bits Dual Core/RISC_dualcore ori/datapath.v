`include "opcodes.v"
`timescale 100ps / 10ps

module datapath( Sysbus, Sysbus2, Zero, Zero2, Function, Function2, TrisALU, TrisALU2, TrisPC, TrisPC2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, Clock, nReset, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, PC_inc, PC_inc2, WriteR1, WriteR1_1, WriteR2, WriteR2_1, WriteR3, WriteR3_1, WriteR4, WriteR4_1, WriteR5, WriteR5_1, WriteR6, WriteR6_1, WriteR7, WriteR7_1, WriteR8, WriteR8_1, WriteR9, WriteR9_1, WriteR10, WriteR10_1, WriteR11, WriteR11_1, WriteR12, WriteR12_1, WriteR13, WriteR13_1, WriteR14, WriteR14_1, WriteR15, WriteR15_1, WriteR16, WriteR16_1, WriteR17, WriteR17_1, Rs2_sel, Rs2_sel2, LoadDR, LoadDR2, LoadPC, LoadPC2, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR, PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2);


inout [63:0] Sysbus;
inout [63:0] Sysbus2;
output Zero, Zero2;
input [5:0] Function;
input [5:0] Function2;
input TrisALU, TrisPC, TrisRs2, TrisRd, nTrisRd, Rs2_sel, PC_inc, LoadDR, LoadPC, TrisALU2, TrisPC2, TrisRs22, TrisRd2, nTrisRd2, Rs2_sel2, PC_inc2, LoadDR2, LoadPC2;
input Clock, nReset;
input ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
input ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
input ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
input ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
input WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
input WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;
output reg [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
output reg [63:0] PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2;
wire Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, Zero2, Compare2, Parity_ODD2, Parity_EVEN2, Overflow2;
wire [31:0] overf;
wire [31:0] overf2;
wire [63:0] Rd, Rs1, Rs2, result, Rd2, Rs1_1, Rs2_1, result2;
wire [63:0] Mux2_out, Mux1_out, Mux2_out2, Mux1_out2;


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

   assign Rs1_1 = ( ReadPC_3) ? PC2 : 64'bz;
   assign Rs1_1 = ( ReadR0_3) ? R0_1 : 64'bz;
   assign Rs1_1 = ( ReadR1_3) ? R1_1 : 64'bz;
   assign Rs1_1 = ( ReadR2_3) ? R2_1 : 64'bz;
   assign Rs1_1 = ( ReadR3_3) ? R3_1 : 64'bz;
   assign Rs1_1 = ( ReadR4_3) ? R4_1 : 64'bz;   
   assign Rs1_1 = ( ReadR5_3) ? R5_1 : 64'bz;
   assign Rs1_1 = ( ReadR6_3) ? R6_1 : 64'bz;
   assign Rs1_1 = ( ReadR7_3) ? R7_1 : 64'bz;
   assign Rs1_1 = ( ReadR8_3) ? R8_1 : 64'bz;
   assign Rs1_1 = ( ReadR9_3) ? R9_1 : 64'bz;
   assign Rs1_1 = ( ReadR10_3) ? R10_1 : 64'bz;
   assign Rs1_1 = ( ReadR11_3) ? R11_1 : 64'bz;
   assign Rs1_1 = ( ReadR12_3) ? R12_1 : 64'bz;
   assign Rs1_1 = ( ReadR13_3) ? R13_1 : 64'bz;
   assign Rs1_1 = ( ReadR14_3) ? R14_1 : 64'bz;
   assign Rs1_1 = ( ReadR15_3) ? R15_1 : 64'bz;
   assign Rs1_1 = ( ReadR16_3) ? R16_1 : 64'bz;
   assign Rs1_1 = ( ReadR17_3) ? R17_1 : 64'bz;

   assign Rs2_1 = ( ReadPC_4) ? PC2 : 64'bz;
   assign Rs2_1 = ( ReadR0_4) ? R0_1 : 64'bz;
   assign Rs2_1 = ( ReadR1_4) ? R1_1 : 64'bz;
   assign Rs2_1 = ( ReadR2_4) ? R2_1 : 64'bz;
   assign Rs2_1 = ( ReadR3_4) ? R3_1 : 64'bz;
   assign Rs2_1 = ( ReadR4_4) ? R4_1 : 64'bz;   
   assign Rs2_1 = ( ReadR5_4) ? R5_1 : 64'bz;
   assign Rs2_1 = ( ReadR6_4) ? R6_1 : 64'bz;
   assign Rs2_1 = ( ReadR7_4) ? R7_1 : 64'bz;
   assign Rs2_1 = ( ReadR8_4) ? R8_1 : 64'bz;
   assign Rs2_1 = ( ReadR9_4) ? R9_1 : 64'bz;
   assign Rs2_1 = ( ReadR10_4) ? R10_1 : 64'bz;
   assign Rs2_1 = ( ReadR11_4) ? R11_1 : 64'bz;
   assign Rs2_1 = ( ReadR12_4) ? R12_1 : 64'bz;
   assign Rs2_1 = ( ReadR13_4) ? R13_1 : 64'bz;
   assign Rs2_1 = ( ReadR14_4) ? R14_1 : 64'bz;
   assign Rs2_1 = ( ReadR15_4) ? R15_1 : 64'bz;
   assign Rs2_1 = ( ReadR16_4) ? R16_1 : 64'bz;
   assign Rs2_1 = ( ReadR17_4) ? R17_1 : 64'bz;

alu ALU(alu_Zero, alu_Zero2, Compare, Compare2, Parity_ODD, Parity_ODD2, Parity_EVEN, Parity_EVEN2, Overflow, Overflow2, result, result2, overf, overf2, Rs1, Rs1_1, Mux2_out, Mux2_out2, Function, Function2);
//alu ALU(alu_Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, result, overf, Rs1, Mux2_out, Function);    
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
   if (LoadPC2) PC2 = Mux1_out2;
   if (WriteR1_1) R1_1 = Rd2;     
   if (WriteR2_1) R2_1 = Rd2;   
   if (WriteR3_1) R3_1 = Rd2;
   if (WriteR4_1) R4_1 = Rd2;     
   if (WriteR5_1) R5_1 = Rd2;   
   if (WriteR6_1) R6_1 = Rd2;
   if (WriteR7_1) R7_1 = Rd2;     
   if (WriteR8_1) R8_1 = Rd2;   
   if (WriteR9_1) R9_1 = Rd2;
   if (WriteR10_1) R10_1 = Rd2;     
   if (WriteR11_1) R11_1 = Rd2;   
   if (WriteR12_1) R12_1 = Rd2;
   if (WriteR13_1) R13_1 = Rd2;     
   if (WriteR14_1) R14_1 = Rd2;   
   if (WriteR15_1) R15_1 = Rd2;
   if (WriteR16_1) R16_1 = Rd2;     
   if (WriteR17_1) R17_1 = Rd2;   
   if (LoadDR2) DR2 = Sysbus2;
   end
   
   assign Mux2_out = ( Rs2_sel ) ? Rs2 : DR;
   assign Mux2_out2 = ( Rs2_sel2 ) ? Rs2_1 : DR2;

   assign Zero = (result == 0);
   assign Zero2 = (result2 == 0);

   assign Mux1_out = ( PC_inc ) ? PC + 1 : Rd;
   assign Mux1_out2 = ( PC_inc2 ) ? PC2 + 1 : Rd2;

   assign Rd = (TrisRd ) ? Sysbus : 64'bz; 
   assign Rd2 = (TrisRd2 ) ? Sysbus2 : 64'bz; 

   assign Rd = (nTrisRd) ? result : 64'bz;
   assign Rd2 = (nTrisRd2) ? result2 : 64'bz;

   assign Sysbus = ( TrisALU ) ? result : 64'bz;
   assign Sysbus2 = ( TrisALU2 ) ? result2 : 64'bz;

   assign Sysbus = ( TrisPC ) ? PC : 64'bz;
   assign Sysbus2 = ( TrisPC2 ) ? PC2 : 64'bz;

   assign Sysbus = ( TrisRs2) ? Rs2 : 64'bz;
   assign Sysbus2 = ( TrisRs22) ? Rs2_1 : 64'bz;
   
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
            assign PC2 = 0;
	    assign R1_1 = 0;
	    assign R2_1 = 0;
	    assign R3_1 = 0;
	    assign R4_1 = 0;
	    assign R5_1 = 0;
	    assign R6_1 = 0;
	    assign R7_1 = 0;
	    assign R8_1 = 0;
	    assign R9_1 = 0;
	    assign R10_1 = 0;
	    assign R11_1 = 0;
	    assign R12_1 = 0;
	    assign R13_1 = 0;
	    assign R14_1 = 0;
	    assign R15_1 = 0;
	    assign R16_1 = 0;
	    assign R17_1 = 0;
	    assign DR2 = 0;
	    assign R0_1 = 0;
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
	    deassign PC2;
	    deassign R1_1;
	    deassign R2_1;
	    deassign R3_1;
	    deassign R4_1;
	    deassign R5_1;
	    deassign R6_1;
	    deassign R7_1;
	    deassign R8_1;
	    deassign R9_1;
	    deassign R10_1;
	    deassign R11_1;
	    deassign R12_1;
	    deassign R13_1;
	    deassign R14_1;
	    deassign R15_1;
	    deassign R16_1;
	    deassign R17_1;
	    deassign DR2;
         end
   
   
endmodule


