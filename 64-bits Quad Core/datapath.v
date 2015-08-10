`include "opcodes.v"
`timescale 100ps / 10ps

module datapath( Sysbus, Sysbus2, Sysbus3, Sysbus4, Zero, Zero2, Zero3, Zero4, Function, Function2, Function3, Function4, TrisALU, TrisALU2, TrisALU3, TrisALU4, TrisPC, TrisPC2, TrisPC3, TrisPC4, TrisRs2, TrisRs22, TrisRs23, TrisRs24, TrisRd, TrisRd2, TrisRd3, TrisRd4, nTrisRd, nTrisRd2, nTrisRd3, nTrisRd4, Clock, nReset, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadPC_5, ReadPC_6, ReadPC_7, ReadPC_8, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR0_5, ReadR0_6, ReadR0_7, ReadR0_8, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR1_5, ReadR1_6, ReadR1_7, ReadR1_8, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR2_5, ReadR2_6, ReadR2_7, ReadR2_8, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR3_5, ReadR3_6, ReadR3_7, ReadR3_8, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR4_5, ReadR4_6, ReadR4_7, ReadR4_8, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR5_5, ReadR5_6, ReadR5_7, ReadR5_8, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR6_5, ReadR6_6, ReadR6_7, ReadR6_8, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR7_5, ReadR7_6, ReadR7_7, ReadR7_8, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR8_5, ReadR8_6, ReadR8_7, ReadR8_8, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR9_5, ReadR9_6, ReadR9_7, ReadR9_8, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR10_5, ReadR10_6, ReadR10_7, ReadR10_8, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR11_5, ReadR11_6, ReadR11_7, ReadR11_8, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR12_5, ReadR12_6, ReadR12_7, ReadR12_8, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR13_5, ReadR13_6, ReadR13_7, ReadR13_8, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR14_5, ReadR14_6, ReadR14_7, ReadR14_8, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR15_5, ReadR15_6, ReadR15_7, ReadR15_8, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR16_5, ReadR16_6, ReadR16_7, ReadR16_8, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, ReadR17_5, ReadR17_6, ReadR17_7, ReadR17_8, PC_inc, PC_inc2, PC_inc3, PC_inc4, WriteR1, WriteR1_1, WriteR1_2, WriteR1_3, WriteR2, WriteR2_1, WriteR2_2, WriteR2_3, WriteR3, WriteR3_1, WriteR3_2, WriteR3_3, WriteR4, WriteR4_1, WriteR4_2, WriteR4_3, WriteR5, WriteR5_1, WriteR5_2, WriteR5_3, WriteR6, WriteR6_1, WriteR6_2, WriteR6_3, WriteR7, WriteR7_1, WriteR7_2, WriteR7_3, WriteR8, WriteR8_1, WriteR8_2, WriteR8_3, WriteR9, WriteR9_1, WriteR9_2, WriteR9_3, WriteR10, WriteR10_1, WriteR10_2, WriteR10_3, WriteR11, WriteR11_1, WriteR11_2, WriteR11_3, WriteR12, WriteR12_1, WriteR12_2, WriteR12_3, WriteR13, WriteR13_1, WriteR13_2, WriteR13_3, WriteR14, WriteR14_1, WriteR14_2, WriteR14_3, WriteR15, WriteR15_1, WriteR15_2, WriteR15_3, WriteR16, WriteR16_1, WriteR16_2, WriteR16_3, WriteR17, WriteR17_1, WriteR17_2, WriteR17_3, Rs2_sel, Rs2_sel2, Rs2_sel3, Rs2_sel4, LoadDR, LoadDR2, LoadDR3, LoadDR4, LoadPC, LoadPC2, LoadPC3, LoadPC4, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR, PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2, PC3, R1_2, R2_2, R3_2, R4_2, R5_2, R6_2, R7_2, R8_2, R9_2, R10_2, R11_2, R12_2, R13_2, R14_2, R15_2, R16_2, R17_2, R0_2, DR3, PC4, R1_3, R2_3, R3_3, R4_3, R5_3, R6_3, R7_3, R8_3, R9_3, R10_3, R11_3, R12_3, R13_3, R14_3, R15_3, R16_3, R17_3, R0_3, DR4, state, state2, state3, state4, sub_state, sub_state2, sub_state3, sub_state4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);


inout [63:0] Sysbus;
inout [63:0] Sysbus2;
inout [63:0] Sysbus3;
inout [63:0] Sysbus4;
output Zero, Zero2;
output Zero3, Zero4;
input [5:0] Function;
input [5:0] Function2;
input [5:0] Function3;
input [5:0] Function4;
input TrisALU, TrisPC, TrisRs2, TrisRd, nTrisRd, Rs2_sel, PC_inc, LoadDR, LoadPC, TrisALU2, TrisPC2, TrisRs22, TrisRd2, nTrisRd2, Rs2_sel2, PC_inc2, LoadDR2, LoadPC2;
input TrisALU3, TrisPC3, TrisRs23, TrisRd3, nTrisRd3, Rs2_sel3, PC_inc3, LoadDR3, LoadPC3, TrisALU4, TrisPC4, TrisRs24, TrisRd4, nTrisRd4, Rs2_sel4, PC_inc4, LoadDR4, LoadPC4;
input Clock, nReset;
input ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
input ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
input ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
input ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
input ReadPC_5, ReadR0_5, ReadR1_5, ReadR2_5, ReadR3_5, ReadR4_5, ReadR5_5, ReadR6_5, ReadR7_5, ReadR8_5, ReadR9_5, ReadR10_5, ReadR11_5, ReadR12_5, ReadR13_5, ReadR14_5, ReadR15_5, ReadR16_5, ReadR17_5;
input ReadPC_6, ReadR0_6, ReadR1_6, ReadR2_6, ReadR3_6, ReadR4_6, ReadR5_6, ReadR6_6, ReadR7_6, ReadR8_6, ReadR9_6, ReadR10_6, ReadR11_6, ReadR12_6, ReadR13_6, ReadR14_6, ReadR15_6, ReadR16_6, ReadR17_6;
input ReadPC_7, ReadR0_7, ReadR1_7, ReadR2_7, ReadR3_7, ReadR4_7, ReadR5_7, ReadR6_7, ReadR7_7, ReadR8_7, ReadR9_7, ReadR10_7, ReadR11_7, ReadR12_7, ReadR13_7, ReadR14_7, ReadR15_7, ReadR16_7, ReadR17_7;
input ReadPC_8, ReadR0_8, ReadR1_8, ReadR2_8, ReadR3_8, ReadR4_8, ReadR5_8, ReadR6_8, ReadR7_8, ReadR8_8, ReadR9_8, ReadR10_8, ReadR11_8, ReadR12_8, ReadR13_8, ReadR14_8, ReadR15_8, ReadR16_8, ReadR17_8;
input WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
input WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;
input WriteR1_2, WriteR2_2, WriteR3_2, WriteR4_2, WriteR5_2, WriteR6_2, WriteR7_2, WriteR8_2, WriteR9_2, WriteR10_2, WriteR11_2, WriteR12_2, WriteR13_2, WriteR14_2, WriteR15_2, WriteR16_2, WriteR17_2;
input WriteR1_3, WriteR2_3, WriteR3_3, WriteR4_3, WriteR5_3, WriteR6_3, WriteR7_3, WriteR8_3, WriteR9_3, WriteR10_3, WriteR11_3, WriteR12_3, WriteR13_3, WriteR14_3, WriteR15_3, WriteR16_3, WriteR17_3;
output reg [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
output reg [63:0] PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2;
output reg [63:0] PC3, R1_2, R2_2, R3_2, R4_2, R5_2, R6_2, R7_2, R8_2, R9_2, R10_2, R11_2, R12_2, R13_2, R14_2, R15_2, R16_2, R17_2, R0_2, DR3;
output reg [63:0] PC4, R1_3, R2_3, R3_3, R4_3, R5_3, R6_3, R7_3, R8_3, R9_3, R10_3, R11_3, R12_3, R13_3, R14_3, R15_3, R16_3, R17_3, R0_3, DR4;
input [1:0] state, state2, sub_state, sub_state2;
input [1:0] state3, state4, sub_state3, sub_state4;
wire Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, Zero2, Compare2, Parity_ODD2, Parity_EVEN2, Overflow2;
wire Zero3, Compare3, Parity_ODD3, Parity_EVEN3, Overflow3, Zero4, Compare4, Parity_ODD4, Parity_EVEN4, Overflow4;
wire [31:0] overf;
wire [31:0] overf2;
wire [31:0] overf3;
wire [31:0] overf4;
wire [63:0] Rd, Rs1, Rs2, result, Rd2, Rs1_1, Rs2_1, result2;
wire [63:0] Rd3, Rs1_2, Rs2_2, result3, Rd4, Rs1_3, Rs2_3, result4;
wire [63:0] Mux2_out, Mux1_out, Mux2_out2, Mux1_out2;
wire [63:0] Mux2_out3, Mux1_out3, Mux2_out4, Mux1_out4;
input EN_ALU1,EN_ALU2,EN_ALU3,EN_ALU4;


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

   assign Rs1_2 = ( ReadPC_5) ? PC3 : 64'bz;
   assign Rs1_2 = ( ReadR0_5) ? R0_2 : 64'bz;
   assign Rs1_2 = ( ReadR1_5) ? R1_2 : 64'bz;
   assign Rs1_2 = ( ReadR2_5) ? R2_2 : 64'bz;
   assign Rs1_2 = ( ReadR3_5) ? R3_2 : 64'bz;
   assign Rs1_2 = ( ReadR4_5) ? R4_2 : 64'bz;   
   assign Rs1_2 = ( ReadR5_5) ? R5_2 : 64'bz;
   assign Rs1_2 = ( ReadR6_5) ? R6_2 : 64'bz;
   assign Rs1_2 = ( ReadR7_5) ? R7_2 : 64'bz;
   assign Rs1_2 = ( ReadR8_5) ? R8_2 : 64'bz;
   assign Rs1_2 = ( ReadR9_5) ? R9_2 : 64'bz;
   assign Rs1_2 = ( ReadR10_5) ? R10_2 : 64'bz;
   assign Rs1_2 = ( ReadR11_5) ? R11_2 : 64'bz;
   assign Rs1_2 = ( ReadR12_5) ? R12_2 : 64'bz;
   assign Rs1_2 = ( ReadR13_5) ? R13_2 : 64'bz;
   assign Rs1_2 = ( ReadR14_5) ? R14_2 : 64'bz;
   assign Rs1_2 = ( ReadR15_5) ? R15_2 : 64'bz;
   assign Rs1_2 = ( ReadR16_5) ? R16_2 : 64'bz;
   assign Rs1_2 = ( ReadR17_5) ? R17_2 : 64'bz;

   assign Rs2_2 = ( ReadPC_6) ? PC3 : 64'bz;
   assign Rs2_2 = ( ReadR0_6) ? R0_2 : 64'bz;
   assign Rs2_2 = ( ReadR1_6) ? R1_2 : 64'bz;
   assign Rs2_2 = ( ReadR2_6) ? R2_2 : 64'bz;
   assign Rs2_2 = ( ReadR3_6) ? R3_2 : 64'bz;
   assign Rs2_2 = ( ReadR4_6) ? R4_2 : 64'bz;   
   assign Rs2_2 = ( ReadR5_6) ? R5_2 : 64'bz;
   assign Rs2_2 = ( ReadR6_6) ? R6_2 : 64'bz;
   assign Rs2_2 = ( ReadR7_6) ? R7_2 : 64'bz;
   assign Rs2_2 = ( ReadR8_6) ? R8_2 : 64'bz;
   assign Rs2_2 = ( ReadR9_6) ? R9_2 : 64'bz;
   assign Rs2_2 = ( ReadR10_6) ? R10_2 : 64'bz;
   assign Rs2_2 = ( ReadR11_6) ? R11_2 : 64'bz;
   assign Rs2_2 = ( ReadR12_6) ? R12_2 : 64'bz;
   assign Rs2_2 = ( ReadR13_6) ? R13_2 : 64'bz;
   assign Rs2_2 = ( ReadR14_6) ? R14_2 : 64'bz;
   assign Rs2_2 = ( ReadR15_6) ? R15_2 : 64'bz;
   assign Rs2_2 = ( ReadR16_6) ? R16_2 : 64'bz;
   assign Rs2_2 = ( ReadR17_6) ? R17_2 : 64'bz;

   assign Rs1_3 = ( ReadPC_7) ? PC4 : 64'bz;
   assign Rs1_3 = ( ReadR0_7) ? R0_3 : 64'bz;
   assign Rs1_3 = ( ReadR1_7) ? R1_3 : 64'bz;
   assign Rs1_3 = ( ReadR2_7) ? R2_3 : 64'bz;
   assign Rs1_3 = ( ReadR3_7) ? R3_3 : 64'bz;
   assign Rs1_3 = ( ReadR4_7) ? R4_3 : 64'bz;   
   assign Rs1_3 = ( ReadR5_7) ? R5_3 : 64'bz;
   assign Rs1_3 = ( ReadR6_7) ? R6_3 : 64'bz;
   assign Rs1_3 = ( ReadR7_7) ? R7_3 : 64'bz;
   assign Rs1_3 = ( ReadR8_7) ? R8_3 : 64'bz;
   assign Rs1_3 = ( ReadR9_7) ? R9_3 : 64'bz;
   assign Rs1_3 = ( ReadR10_7) ? R10_3 : 64'bz;
   assign Rs1_3 = ( ReadR11_7) ? R11_3 : 64'bz;
   assign Rs1_3 = ( ReadR12_7) ? R12_3 : 64'bz;
   assign Rs1_3 = ( ReadR13_7) ? R13_3 : 64'bz;
   assign Rs1_3 = ( ReadR14_7) ? R14_3 : 64'bz;
   assign Rs1_3 = ( ReadR15_7) ? R15_3 : 64'bz;
   assign Rs1_3 = ( ReadR16_7) ? R16_3 : 64'bz;
   assign Rs1_3 = ( ReadR17_7) ? R17_3 : 64'bz;

   assign Rs2_3 = ( ReadPC_8) ? PC4 : 64'bz;
   assign Rs2_3 = ( ReadR0_8) ? R0_3 : 64'bz;
   assign Rs2_3 = ( ReadR1_8) ? R1_3 : 64'bz;
   assign Rs2_3 = ( ReadR2_8) ? R2_3 : 64'bz;
   assign Rs2_3 = ( ReadR3_8) ? R3_3 : 64'bz;
   assign Rs2_3 = ( ReadR4_8) ? R4_3 : 64'bz;   
   assign Rs2_3 = ( ReadR5_8) ? R5_3 : 64'bz;
   assign Rs2_3 = ( ReadR6_8) ? R6_3 : 64'bz;
   assign Rs2_3 = ( ReadR7_8) ? R7_3 : 64'bz;
   assign Rs2_3 = ( ReadR8_8) ? R8_3 : 64'bz;
   assign Rs2_3 = ( ReadR9_8) ? R9_3 : 64'bz;
   assign Rs2_3 = ( ReadR10_8) ? R10_3 : 64'bz;
   assign Rs2_3 = ( ReadR11_8) ? R11_3 : 64'bz;
   assign Rs2_3 = ( ReadR12_8) ? R12_3 : 64'bz;
   assign Rs2_3 = ( ReadR13_8) ? R13_3 : 64'bz;
   assign Rs2_3 = ( ReadR14_8) ? R14_3 : 64'bz;
   assign Rs2_3 = ( ReadR15_8) ? R15_3 : 64'bz;
   assign Rs2_3 = ( ReadR16_8) ? R16_3 : 64'bz;
   assign Rs2_3 = ( ReadR17_8) ? R17_3 : 64'bz;

//alu ALU(alu_Zero, alu_Zero2, Compare, Compare2, Parity_ODD, Parity_ODD2, Parity_EVEN, Parity_EVEN2, Overflow, Overflow2, result, result2, overf, overf2, Rs1, Rs1_1, Mux2_out, Mux2_out2, Function, Function2);
alu ALU(alu_Zero, alu_Zero2, alu_Zero3, alu_Zero4, Compare, Compare2, Compare3, Compare4, Parity_ODD, Parity_ODD2, Parity_ODD3, Parity_ODD4, Parity_EVEN, Parity_EVEN2, Parity_EVEN3, Parity_EVEN4, Overflow, Overflow2, Overflow3, Overflow4, result, result2, result3, result4, overf, overf2, overf3, overf4, Rs1, Rs1_1, Rs1_2, Rs1_3, Mux2_out, Mux2_out2, Mux2_out3, Mux2_out4, Function, Function2, Function3, Function4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);
   
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

   if (LoadPC3) PC3 = Mux1_out3;
   if (WriteR1_2) R1_2 = Rd3;     
   if (WriteR2_2) R2_2 = Rd3;   
   if (WriteR3_2) R3_2 = Rd3;
   if (WriteR4_2) R4_2 = Rd3;     
   if (WriteR5_2) R5_2 = Rd3;   
   if (WriteR6_2) R6_2 = Rd3;
   if (WriteR7_2) R7_2 = Rd3;     
   if (WriteR8_2) R8_2 = Rd3;   
   if (WriteR9_2) R9_2 = Rd3;
   if (WriteR10_2) R10_2 = Rd3;     
   if (WriteR11_2) R11_2 = Rd3;   
   if (WriteR12_2) R12_2 = Rd3;
   if (WriteR13_2) R13_2 = Rd3;     
   if (WriteR14_2) R14_2 = Rd3;   
   if (WriteR15_2) R15_2 = Rd3;
   if (WriteR16_2) R16_2 = Rd3;     
   if (WriteR17_2) R17_2 = Rd3;   
   if (LoadDR3) DR3 = Sysbus3;

   if (LoadPC4) PC4 = Mux1_out4;
   if (WriteR1_3) R1_3 = Rd4;     
   if (WriteR2_3) R2_3 = Rd4;   
   if (WriteR3_3) R3_3 = Rd4;
   if (WriteR4_3) R4_3 = Rd4;     
   if (WriteR5_3) R5_3 = Rd4;   
   if (WriteR6_3) R6_3 = Rd4;
   if (WriteR7_3) R7_3 = Rd4;     
   if (WriteR8_3) R8_3 = Rd4;   
   if (WriteR9_3) R9_3 = Rd4;
   if (WriteR10_3) R10_3 = Rd4;     
   if (WriteR11_3) R11_3 = Rd4;   
   if (WriteR12_3) R12_3 = Rd4;
   if (WriteR13_3) R13_3 = Rd4;     
   if (WriteR14_3) R14_3 = Rd4;   
   if (WriteR15_3) R15_3 = Rd4;
   if (WriteR16_3) R16_3 = Rd4;     
   if (WriteR17_3) R17_3 = Rd4;   
   if (LoadDR4) DR4 = Sysbus4;
   end
   
   assign Mux2_out = ( Rs2_sel ) ? Rs2 : DR;
   assign Mux2_out2 = ( Rs2_sel2 ) ? Rs2_1 : DR2;
   assign Mux2_out3 = ( Rs2_sel3 ) ? Rs2_2 : DR3;
   assign Mux2_out4 = ( Rs2_sel4 ) ? Rs2_3 : DR4;

   assign Zero = alu_Zero;
   assign Zero2 = alu_Zero2;
   assign Zero3 = alu_Zero3;
   assign Zero4 = alu_Zero4;

//   assign Zero = ((result == 0));
//   assign Zero2 = (result2 == 0);
//   assign Zero3 = (result3 == 0);
//   assign Zero4 = (result4 == 0);

   assign Mux1_out = ( PC_inc ) ? PC + 1 : Rd;
   assign Mux1_out2 = ( PC_inc2 ) ? PC2 + 1 : Rd2;
   assign Mux1_out3 = ( PC_inc3 ) ? PC3 + 1 : Rd3;
   assign Mux1_out4 = ( PC_inc4 ) ? PC4 + 1 : Rd4;

   assign Rd = (TrisRd ) ? Sysbus : 64'bz; 
   assign Rd2 = (TrisRd2 ) ? Sysbus2 : 64'bz; 
   assign Rd3 = (TrisRd3 ) ? Sysbus3 : 64'bz; 
   assign Rd4 = (TrisRd4 ) ? Sysbus4 : 64'bz; 

   assign Rd = (nTrisRd) ? result : 64'bz;
   assign Rd2 = (nTrisRd2) ? result2 : 64'bz;
   assign Rd3 = (nTrisRd3) ? result3 : 64'bz;
   assign Rd4 = (nTrisRd4) ? result4 : 64'bz;

   assign Sysbus = ( TrisALU ) ? result : 64'bz;
   assign Sysbus2 = ( TrisALU2 ) ? result2 : 64'bz;
   assign Sysbus3 = ( TrisALU3 ) ? result3 : 64'bz;
   assign Sysbus4 = ( TrisALU4 ) ? result4 : 64'bz;

   assign Sysbus = ( TrisPC ) ? PC : 64'bz;
   assign Sysbus2 = ( TrisPC2 ) ? PC2 : 64'bz;
   assign Sysbus3 = ( TrisPC3 ) ? PC3 : 64'bz;
   assign Sysbus4 = ( TrisPC4 ) ? PC4 : 64'bz;

   assign Sysbus = ( TrisRs2) ? Rs2 : 64'bz;
   assign Sysbus2 = ( TrisRs22) ? Rs2_1 : 64'bz;
   assign Sysbus3 = ( TrisRs23) ? Rs2_2 : 64'bz;
   assign Sysbus4 = ( TrisRs24) ? Rs2_3 : 64'bz;   

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
            assign PC3 = 0;
	    assign R1_2 = 0;
	    assign R2_2 = 0;
	    assign R3_2 = 0;
	    assign R4_2 = 0;
	    assign R5_2 = 0;
	    assign R6_2 = 0;
	    assign R7_2 = 0;
	    assign R8_2 = 0;
	    assign R9_2 = 0;
	    assign R10_2 = 0;
	    assign R11_2 = 0;
	    assign R12_2 = 0;
	    assign R13_2 = 0;
	    assign R14_2 = 0;
	    assign R15_2 = 0;
	    assign R16_2 = 0;
	    assign R17_2 = 0;
	    assign DR3 = 0;
	    assign R0_2 = 0;
            assign PC4 = 0;
	    assign R1_3 = 0;
	    assign R2_3 = 0;
	    assign R3_3 = 0;
	    assign R4_3 = 0;
	    assign R5_3 = 0;
	    assign R6_3 = 0;
	    assign R7_3 = 0;
	    assign R8_3 = 0;
	    assign R9_3 = 0;
	    assign R10_3 = 0;
	    assign R11_3 = 0;
	    assign R12_3 = 0;
	    assign R13_3 = 0;
	    assign R14_3 = 0;
	    assign R15_3 = 0;
	    assign R16_3 = 0;
	    assign R17_3 = 0;
	    assign DR4 = 0;
	    assign R0_3 = 0;
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

	    deassign PC3;
	    deassign R1_2;
	    deassign R2_2;
	    deassign R3_2;
	    deassign R4_2;
	    deassign R5_2;
	    deassign R6_2;
	    deassign R7_2;
	    deassign R8_2;
	    deassign R9_2;
	    deassign R10_2;
	    deassign R11_2;
	    deassign R12_2;
	    deassign R13_2;
	    deassign R14_2;
	    deassign R15_2;
	    deassign R16_2;
	    deassign R17_2;
	    deassign DR3;

	    deassign PC4;
	    deassign R1_3;
	    deassign R2_3;
	    deassign R3_3;
	    deassign R4_3;
	    deassign R5_3;
	    deassign R6_3;
	    deassign R7_3;
	    deassign R8_3;
	    deassign R9_3;
	    deassign R10_3;
	    deassign R11_3;
	    deassign R12_3;
	    deassign R13_3;
	    deassign R14_3;
	    deassign R15_3;
	    deassign R16_3;
	    deassign R17_3;
	    deassign DR4;
         end
   
   always@(Function)
   begin
   	if((Function == 6'd63) && (state == 2'b00))
	begin
		if(ReadPC_1)
		begin
			if(ReadPC_2) begin PC2<=PC; end
			if(ReadR0_2) begin R0_1<=PC; end
			if(ReadR1_2) begin R1_1<=PC; end
			if(ReadR2_2) begin R2_1<=PC; end
			if(ReadR3_2) begin R3_1<=PC; end
			if(ReadR4_2) begin R4_1<=PC; end
			if(ReadR5_2) begin R5_1<=PC; end
			if(ReadR6_2) begin R6_1<=PC; end
			if(ReadR7_2) begin R7_1<=PC; end
			if(ReadR8_2) begin R8_1<=PC; end
			if(ReadR9_2) begin R9_1<=PC; end
			if(ReadR10_2) begin R10_1<=PC; end
			if(ReadR11_2) begin R11_1<=PC; end
			if(ReadR12_2) begin R12_1<=PC; end
			if(ReadR13_2) begin R13_1<=PC; end
			if(ReadR14_2) begin R14_1<=PC; end
			if(ReadR15_2) begin R15_1<=PC; end
			if(ReadR16_2) begin R16_1<=PC; end
			if(ReadR17_2) begin R17_1<=PC; end
		end
		if(ReadR0_1)
		begin
			if(ReadPC_2) begin PC2<=R0; end
			if(ReadR0_2) begin R0_1<=R0; end
			if(ReadR1_2) begin R1_1<=R0; end
			if(ReadR2_2) begin R2_1<=R0; end
			if(ReadR3_2) begin R3_1<=R0; end
			if(ReadR4_2) begin R4_1<=R0; end
			if(ReadR5_2) begin R5_1<=R0; end
			if(ReadR6_2) begin R6_1<=R0; end
			if(ReadR7_2) begin R7_1<=R0; end
			if(ReadR8_2) begin R8_1<=R0; end
			if(ReadR9_2) begin R9_1<=R0; end
			if(ReadR10_2) begin R10_1<=R0; end
			if(ReadR11_2) begin R11_1<=R0; end
			if(ReadR12_2) begin R12_1<=R0; end
			if(ReadR13_2) begin R13_1<=R0; end
			if(ReadR14_2) begin R14_1<=R0; end
			if(ReadR15_2) begin R15_1<=R0; end
			if(ReadR16_2) begin R16_1<=R0; end
			if(ReadR17_2) begin R17_1<=R0; end
		end		
		if(ReadR1_1)
		begin
			if(ReadPC_2) begin PC2<=R1; end
			if(ReadR0_2) begin R0_1<=R1; end
			if(ReadR1_2) begin R1_1<=R1; end
			if(ReadR2_2) begin R2_1<=R1; end
			if(ReadR3_2) begin R3_1<=R1; end
			if(ReadR4_2) begin R4_1<=R1; end
			if(ReadR5_2) begin R5_1<=R1; end
			if(ReadR6_2) begin R6_1<=R1; end
			if(ReadR7_2) begin R7_1<=R1; end
			if(ReadR8_2) begin R8_1<=R1; end
			if(ReadR9_2) begin R9_1<=R1; end
			if(ReadR10_2) begin R10_1<=R1; end
			if(ReadR11_2) begin R11_1<=R1; end
			if(ReadR12_2) begin R12_1<=R1; end
			if(ReadR13_2) begin R13_1<=R1; end
			if(ReadR14_2) begin R14_1<=R1; end
			if(ReadR15_2) begin R15_1<=R1; end
			if(ReadR16_2) begin R16_1<=R1; end
			if(ReadR17_2) begin R17_1<=R1; end
		end	
		if(ReadR2_1)
		begin
			if(ReadPC_2) begin PC2<=R2; end
			if(ReadR0_2) begin R0_1<=R2; end
			if(ReadR1_2) begin R1_1<=R2; end
			if(ReadR2_2) begin R2_1<=R2; end
			if(ReadR3_2) begin R3_1<=R2; end
			if(ReadR4_2) begin R4_1<=R2; end
			if(ReadR5_2) begin R5_1<=R2; end
			if(ReadR6_2) begin R6_1<=R2; end
			if(ReadR7_2) begin R7_1<=R2; end
			if(ReadR8_2) begin R8_1<=R2; end
			if(ReadR9_2) begin R9_1<=R2; end
			if(ReadR10_2) begin R10_1<=R2; end
			if(ReadR11_2) begin R11_1<=R2; end
			if(ReadR12_2) begin R12_1<=R2; end
			if(ReadR13_2) begin R13_1<=R2; end
			if(ReadR14_2) begin R14_1<=R2; end
			if(ReadR15_2) begin R15_1<=R2; end
			if(ReadR16_2) begin R16_1<=R2; end
			if(ReadR17_2) begin R17_1<=R2; end
		end
		if(ReadR3_1)
		begin
			if(ReadPC_2) begin PC2<=R3; end
			if(ReadR0_2) begin R0_1<=R3; end
			if(ReadR1_2) begin R1_1<=R3; end
			if(ReadR2_2) begin R2_1<=R3; end
			if(ReadR3_2) begin R3_1<=R3; end
			if(ReadR4_2) begin R4_1<=R3; end
			if(ReadR5_2) begin R5_1<=R3; end
			if(ReadR6_2) begin R6_1<=R3; end
			if(ReadR7_2) begin R7_1<=R3; end
			if(ReadR8_2) begin R8_1<=R3; end
			if(ReadR9_2) begin R9_1<=R3; end
			if(ReadR10_2) begin R10_1<=R3; end
			if(ReadR11_2) begin R11_1<=R3; end
			if(ReadR12_2) begin R12_1<=R3; end
			if(ReadR13_2) begin R13_1<=R3; end
			if(ReadR14_2) begin R14_1<=R3; end
			if(ReadR15_2) begin R15_1<=R3; end
			if(ReadR16_2) begin R16_1<=R3; end
			if(ReadR17_2) begin R17_1<=R3; end
		end
		if(ReadR4_1)
		begin
			if(ReadPC_2) begin PC2<=R4; end
			if(ReadR0_2) begin R0_1<=R4; end
			if(ReadR1_2) begin R1_1<=R4; end
			if(ReadR2_2) begin R2_1<=R4; end
			if(ReadR3_2) begin R3_1<=R4; end
			if(ReadR4_2) begin R4_1<=R4; end
			if(ReadR5_2) begin R5_1<=R4; end
			if(ReadR6_2) begin R6_1<=R4; end
			if(ReadR7_2) begin R7_1<=R4; end
			if(ReadR8_2) begin R8_1<=R4; end
			if(ReadR9_2) begin R9_1<=R4; end
			if(ReadR10_2) begin R10_1<=R4; end
			if(ReadR11_2) begin R11_1<=R4; end
			if(ReadR12_2) begin R12_1<=R4; end
			if(ReadR13_2) begin R13_1<=R4; end
			if(ReadR14_2) begin R14_1<=R4; end
			if(ReadR15_2) begin R15_1<=R4; end
			if(ReadR16_2) begin R16_1<=R4; end
			if(ReadR17_2) begin R17_1<=R4; end
		end
		if(ReadR5_1)
		begin
			if(ReadPC_2) begin PC2<=R5; end
			if(ReadR0_2) begin R0_1<=R5; end
			if(ReadR1_2) begin R1_1<=R5; end
			if(ReadR2_2) begin R2_1<=R5; end
			if(ReadR3_2) begin R3_1<=R5; end
			if(ReadR4_2) begin R4_1<=R5; end
			if(ReadR5_2) begin R5_1<=R5; end
			if(ReadR6_2) begin R6_1<=R5; end
			if(ReadR7_2) begin R7_1<=R5; end
			if(ReadR8_2) begin R8_1<=R5; end
			if(ReadR9_2) begin R9_1<=R5; end
			if(ReadR10_2) begin R10_1<=R5; end
			if(ReadR11_2) begin R11_1<=R5; end
			if(ReadR12_2) begin R12_1<=R5; end
			if(ReadR13_2) begin R13_1<=R5; end
			if(ReadR14_2) begin R14_1<=R5; end
			if(ReadR15_2) begin R15_1<=R5; end
			if(ReadR16_2) begin R16_1<=R5; end
			if(ReadR17_2) begin R17_1<=R5; end
		end
		if(ReadR6_1)
		begin
			if(ReadPC_2) begin PC2<=R6; end
			if(ReadR0_2) begin R0_1<=R6; end
			if(ReadR1_2) begin R1_1<=R6; end
			if(ReadR2_2) begin R2_1<=R6; end
			if(ReadR3_2) begin R3_1<=R6; end
			if(ReadR4_2) begin R4_1<=R6; end
			if(ReadR5_2) begin R5_1<=R6; end
			if(ReadR6_2) begin R6_1<=R6; end
			if(ReadR7_2) begin R7_1<=R6; end
			if(ReadR8_2) begin R8_1<=R6; end
			if(ReadR9_2) begin R9_1<=R6; end
			if(ReadR10_2) begin R10_1<=R6; end
			if(ReadR11_2) begin R11_1<=R6; end
			if(ReadR12_2) begin R12_1<=R6; end
			if(ReadR13_2) begin R13_1<=R6; end
			if(ReadR14_2) begin R14_1<=R6; end
			if(ReadR15_2) begin R15_1<=R6; end
			if(ReadR16_2) begin R16_1<=R6; end
			if(ReadR17_2) begin R17_1<=R6; end
		end
		if(ReadR7_1)
		begin
			if(ReadPC_2) begin PC2<=R7; end
			if(ReadR0_2) begin R0_1<=R7; end
			if(ReadR1_2) begin R1_1<=R7; end
			if(ReadR2_2) begin R2_1<=R7; end
			if(ReadR3_2) begin R3_1<=R7; end
			if(ReadR4_2) begin R4_1<=R7; end
			if(ReadR5_2) begin R5_1<=R7; end
			if(ReadR6_2) begin R6_1<=R7; end
			if(ReadR7_2) begin R7_1<=R7; end
			if(ReadR8_2) begin R8_1<=R7; end
			if(ReadR9_2) begin R9_1<=R7; end
			if(ReadR10_2) begin R10_1<=R7; end
			if(ReadR11_2) begin R11_1<=R7; end
			if(ReadR12_2) begin R12_1<=R7; end
			if(ReadR13_2) begin R13_1<=R7; end
			if(ReadR14_2) begin R14_1<=R7; end
			if(ReadR15_2) begin R15_1<=R7; end
			if(ReadR16_2) begin R16_1<=R7; end
			if(ReadR17_2) begin R17_1<=R7; end
		end
		if(ReadR8_1)
		begin
			if(ReadPC_2) begin PC2<=R8; end
			if(ReadR0_2) begin R0_1<=R8; end
			if(ReadR1_2) begin R1_1<=R8; end
			if(ReadR2_2) begin R2_1<=R8; end
			if(ReadR3_2) begin R3_1<=R8; end
			if(ReadR4_2) begin R4_1<=R8; end
			if(ReadR5_2) begin R5_1<=R8; end
			if(ReadR6_2) begin R6_1<=R8; end
			if(ReadR7_2) begin R7_1<=R8; end
			if(ReadR8_2) begin R8_1<=R8; end
			if(ReadR9_2) begin R9_1<=R8; end
			if(ReadR10_2) begin R10_1<=R8; end
			if(ReadR11_2) begin R11_1<=R8; end
			if(ReadR12_2) begin R12_1<=R8; end
			if(ReadR13_2) begin R13_1<=R8; end
			if(ReadR14_2) begin R14_1<=R8; end
			if(ReadR15_2) begin R15_1<=R8; end
			if(ReadR16_2) begin R16_1<=R8; end
			if(ReadR17_2) begin R17_1<=R8; end
		end
		if(ReadR9_1)
		begin
			if(ReadPC_2) begin PC2<=R9; end
			if(ReadR0_2) begin R0_1<=R9; end
			if(ReadR1_2) begin R1_1<=R9; end
			if(ReadR2_2) begin R2_1<=R9; end
			if(ReadR3_2) begin R3_1<=R9; end
			if(ReadR4_2) begin R4_1<=R9; end
			if(ReadR5_2) begin R5_1<=R9; end
			if(ReadR6_2) begin R6_1<=R9; end
			if(ReadR7_2) begin R7_1<=R9; end
			if(ReadR8_2) begin R8_1<=R9; end
			if(ReadR9_2) begin R9_1<=R9; end
			if(ReadR10_2) begin R10_1<=R9; end
			if(ReadR11_2) begin R11_1<=R9; end
			if(ReadR12_2) begin R12_1<=R9; end
			if(ReadR13_2) begin R13_1<=R9; end
			if(ReadR14_2) begin R14_1<=R9; end
			if(ReadR15_2) begin R15_1<=R9; end
			if(ReadR16_2) begin R16_1<=R9; end
			if(ReadR17_2) begin R17_1<=R9; end
		end
		if(ReadR10_1)
		begin
			if(ReadPC_2) begin PC2<=R10; end
			if(ReadR0_2) begin R0_1<=R10; end
			if(ReadR1_2) begin R1_1<=R10; end
			if(ReadR2_2) begin R2_1<=R10; end
			if(ReadR3_2) begin R3_1<=R10; end
			if(ReadR4_2) begin R4_1<=R10; end
			if(ReadR5_2) begin R5_1<=R10; end
			if(ReadR6_2) begin R6_1<=R10; end
			if(ReadR7_2) begin R7_1<=R10; end
			if(ReadR8_2) begin R8_1<=R10; end
			if(ReadR9_2) begin R9_1<=R10; end
			if(ReadR10_2) begin R10_1<=R10; end
			if(ReadR11_2) begin R11_1<=R10; end
			if(ReadR12_2) begin R12_1<=R10; end
			if(ReadR13_2) begin R13_1<=R10; end
			if(ReadR14_2) begin R14_1<=R10; end
			if(ReadR15_2) begin R15_1<=R10; end
			if(ReadR16_2) begin R16_1<=R10; end
			if(ReadR17_2) begin R17_1<=R10; end
		end
		if(ReadR11_1)
		begin
			if(ReadPC_2) begin PC2<=R11; end
			if(ReadR0_2) begin R0_1<=R11; end
			if(ReadR1_2) begin R1_1<=R11; end
			if(ReadR2_2) begin R2_1<=R11; end
			if(ReadR3_2) begin R3_1<=R11; end
			if(ReadR4_2) begin R4_1<=R11; end
			if(ReadR5_2) begin R5_1<=R11; end
			if(ReadR6_2) begin R6_1<=R11; end
			if(ReadR7_2) begin R7_1<=R11; end
			if(ReadR8_2) begin R8_1<=R11; end
			if(ReadR9_2) begin R9_1<=R11; end
			if(ReadR10_2) begin R10_1<=R11; end
			if(ReadR11_2) begin R11_1<=R11; end
			if(ReadR12_2) begin R12_1<=R11; end
			if(ReadR13_2) begin R13_1<=R11; end
			if(ReadR14_2) begin R14_1<=R11; end
			if(ReadR15_2) begin R15_1<=R11; end
			if(ReadR16_2) begin R16_1<=R11; end
			if(ReadR17_2) begin R17_1<=R11; end
		end
		if(ReadR12_1)
		begin
			if(ReadPC_2) begin PC2<=R12; end
			if(ReadR0_2) begin R0_1<=R12; end
			if(ReadR1_2) begin R1_1<=R12; end
			if(ReadR2_2) begin R2_1<=R12; end
			if(ReadR3_2) begin R3_1<=R12; end
			if(ReadR4_2) begin R4_1<=R12; end
			if(ReadR5_2) begin R5_1<=R12; end
			if(ReadR6_2) begin R6_1<=R12; end
			if(ReadR7_2) begin R7_1<=R12; end
			if(ReadR8_2) begin R8_1<=R12; end
			if(ReadR9_2) begin R9_1<=R12; end
			if(ReadR10_2) begin R10_1<=R12; end
			if(ReadR11_2) begin R11_1<=R12; end
			if(ReadR12_2) begin R12_1<=R12; end
			if(ReadR13_2) begin R13_1<=R12; end
			if(ReadR14_2) begin R14_1<=R12; end
			if(ReadR15_2) begin R15_1<=R12; end
			if(ReadR16_2) begin R16_1<=R12; end
			if(ReadR17_2) begin R17_1<=R12; end
		end
		if(ReadR13_1)
		begin
			if(ReadPC_2) begin PC2<=R13; end
			if(ReadR0_2) begin R0_1<=R13; end
			if(ReadR1_2) begin R1_1<=R13; end
			if(ReadR2_2) begin R2_1<=R13; end
			if(ReadR3_2) begin R3_1<=R13; end
			if(ReadR4_2) begin R4_1<=R13; end
			if(ReadR5_2) begin R5_1<=R13; end
			if(ReadR6_2) begin R6_1<=R13; end
			if(ReadR7_2) begin R7_1<=R13; end
			if(ReadR8_2) begin R8_1<=R13; end
			if(ReadR9_2) begin R9_1<=R13; end
			if(ReadR10_2) begin R10_1<=R13; end
			if(ReadR11_2) begin R11_1<=R13; end
			if(ReadR12_2) begin R12_1<=R13; end
			if(ReadR13_2) begin R13_1<=R13; end
			if(ReadR14_2) begin R14_1<=R13; end
			if(ReadR15_2) begin R15_1<=R13; end
			if(ReadR16_2) begin R16_1<=R13; end
			if(ReadR17_2) begin R17_1<=R13; end
		end
		if(ReadR14_1)
		begin
			if(ReadPC_2) begin PC2<=R14; end
			if(ReadR0_2) begin R0_1<=R14; end
			if(ReadR1_2) begin R1_1<=R14; end
			if(ReadR2_2) begin R2_1<=R14; end
			if(ReadR3_2) begin R3_1<=R14; end
			if(ReadR4_2) begin R4_1<=R14; end
			if(ReadR5_2) begin R5_1<=R14; end
			if(ReadR6_2) begin R6_1<=R14; end
			if(ReadR7_2) begin R7_1<=R14; end
			if(ReadR8_2) begin R8_1<=R14; end
			if(ReadR9_2) begin R9_1<=R14; end
			if(ReadR10_2) begin R10_1<=R14; end
			if(ReadR11_2) begin R11_1<=R14; end
			if(ReadR12_2) begin R12_1<=R14; end
			if(ReadR13_2) begin R13_1<=R14; end
			if(ReadR14_2) begin R14_1<=R14; end
			if(ReadR15_2) begin R15_1<=R14; end
			if(ReadR16_2) begin R16_1<=R14; end
			if(ReadR17_2) begin R17_1<=R14; end
		end
		if(ReadR15_1)
		begin
			if(ReadPC_2) begin PC2<=R15; end
			if(ReadR0_2) begin R0_1<=R15; end
			if(ReadR1_2) begin R1_1<=R15; end
			if(ReadR2_2) begin R2_1<=R15; end
			if(ReadR3_2) begin R3_1<=R15; end
			if(ReadR4_2) begin R4_1<=R15; end
			if(ReadR5_2) begin R5_1<=R15; end
			if(ReadR6_2) begin R6_1<=R15; end
			if(ReadR7_2) begin R7_1<=R15; end
			if(ReadR8_2) begin R8_1<=R15; end
			if(ReadR9_2) begin R9_1<=R15; end
			if(ReadR10_2) begin R10_1<=R15; end
			if(ReadR11_2) begin R11_1<=R15; end
			if(ReadR12_2) begin R12_1<=R15; end
			if(ReadR13_2) begin R13_1<=R15; end
			if(ReadR14_2) begin R14_1<=R15; end
			if(ReadR15_2) begin R15_1<=R15; end
			if(ReadR16_2) begin R16_1<=R15; end
			if(ReadR17_2) begin R17_1<=R15; end
		end
		if(ReadR16_1)
		begin
			if(ReadPC_2) begin PC2<=R16; end
			if(ReadR0_2) begin R0_1<=R16; end
			if(ReadR1_2) begin R1_1<=R16; end
			if(ReadR2_2) begin R2_1<=R16; end
			if(ReadR3_2) begin R3_1<=R16; end
			if(ReadR4_2) begin R4_1<=R16; end
			if(ReadR5_2) begin R5_1<=R16; end
			if(ReadR6_2) begin R6_1<=R16; end
			if(ReadR7_2) begin R7_1<=R16; end
			if(ReadR8_2) begin R8_1<=R16; end
			if(ReadR9_2) begin R9_1<=R16; end
			if(ReadR10_2) begin R10_1<=R16; end
			if(ReadR11_2) begin R11_1<=R16; end
			if(ReadR12_2) begin R12_1<=R16; end
			if(ReadR13_2) begin R13_1<=R16; end
			if(ReadR14_2) begin R14_1<=R16; end
			if(ReadR15_2) begin R15_1<=R16; end
			if(ReadR16_2) begin R16_1<=R16; end
			if(ReadR17_2) begin R17_1<=R16; end
		end
		if(ReadR17_1)
		begin
			if(ReadPC_2) begin PC2<=R17; end
			if(ReadR0_2) begin R0_1<=R17; end
			if(ReadR1_2) begin R1_1<=R17; end
			if(ReadR2_2) begin R2_1<=R17; end
			if(ReadR3_2) begin R3_1<=R17; end
			if(ReadR4_2) begin R4_1<=R17; end
			if(ReadR5_2) begin R5_1<=R17; end
			if(ReadR6_2) begin R6_1<=R17; end
			if(ReadR7_2) begin R7_1<=R17; end
			if(ReadR8_2) begin R8_1<=R17; end
			if(ReadR9_2) begin R9_1<=R17; end
			if(ReadR10_2) begin R10_1<=R17; end
			if(ReadR11_2) begin R11_1<=R17; end
			if(ReadR12_2) begin R12_1<=R17; end
			if(ReadR13_2) begin R13_1<=R17; end
			if(ReadR14_2) begin R14_1<=R17; end
			if(ReadR15_2) begin R15_1<=R17; end
			if(ReadR16_2) begin R16_1<=R17; end
			if(ReadR17_2) begin R17_1<=R17; end
		end
	end
	if((Function2 == 6'd62) && (state2 == 2'b00))
	begin
		if(ReadPC_3)
		begin
			if(ReadPC_4) begin PC<=PC2; end
			if(ReadR0_4) begin R0<=PC2; end
			if(ReadR1_4) begin R1<=PC2; end
			if(ReadR2_4) begin R2<=PC2; end
			if(ReadR3_4) begin R3<=PC2; end
			if(ReadR4_4) begin R4<=PC2; end
			if(ReadR5_4) begin R5<=PC2; end
			if(ReadR6_4) begin R6<=PC2; end
			if(ReadR7_4) begin R7<=PC2; end
			if(ReadR8_4) begin R8<=PC2; end
			if(ReadR9_4) begin R9<=PC2; end
			if(ReadR10_4) begin R10<=PC2; end
			if(ReadR11_4) begin R11<=PC2; end
			if(ReadR12_4) begin R12<=PC2; end
			if(ReadR13_4) begin R13<=PC2; end
			if(ReadR14_4) begin R14<=PC2; end
			if(ReadR15_4) begin R15<=PC2; end
			if(ReadR16_4) begin R16<=PC2; end
			if(ReadR17_4) begin R17<=PC2; end
		end
		if(ReadR0_3)
		begin
			if(ReadPC_4) begin PC<=R0_1; end
			if(ReadR0_4) begin R0<=R0_1; end
			if(ReadR1_4) begin R1<=R0_1; end
			if(ReadR2_4) begin R2<=R0_1; end
			if(ReadR3_4) begin R3<=R0_1; end
			if(ReadR4_4) begin R4<=R0_1; end
			if(ReadR5_4) begin R5<=R0_1; end
			if(ReadR6_4) begin R6<=R0_1; end
			if(ReadR7_4) begin R7<=R0_1; end
			if(ReadR8_4) begin R8<=R0_1; end
			if(ReadR9_4) begin R9<=R0_1; end
			if(ReadR10_4) begin R10<=R0_1; end
			if(ReadR11_4) begin R11<=R0_1; end
			if(ReadR12_4) begin R12<=R0_1; end
			if(ReadR13_4) begin R13<=R0_1; end
			if(ReadR14_4) begin R14<=R0_1; end
			if(ReadR15_4) begin R15<=R0_1; end
			if(ReadR16_4) begin R16<=R0_1; end
			if(ReadR17_4) begin R17<=R0_1; end
		end		
		if(ReadR1_3)
		begin
			if(ReadPC_4) begin PC<=R1_1; end
			if(ReadR0_4) begin R0<=R1_1; end
			if(ReadR1_4) begin R1<=R1_1; end
			if(ReadR2_4) begin R2<=R1_1; end
			if(ReadR3_4) begin R3<=R1_1; end
			if(ReadR4_4) begin R4<=R1_1; end
			if(ReadR5_4) begin R5<=R1_1; end
			if(ReadR6_4) begin R6<=R1_1; end
			if(ReadR7_4) begin R7<=R1_1; end
			if(ReadR8_4) begin R8<=R1_1; end
			if(ReadR9_4) begin R9<=R1_1; end
			if(ReadR10_4) begin R10<=R1_1; end
			if(ReadR11_4) begin R11<=R1_1; end
			if(ReadR12_4) begin R12<=R1_1; end
			if(ReadR13_4) begin R13<=R1_1; end
			if(ReadR14_4) begin R14<=R1_1; end
			if(ReadR15_4) begin R15<=R1_1; end
			if(ReadR16_4) begin R16<=R1_1; end
			if(ReadR17_4) begin R17<=R1_1; end
		end	
		if(ReadR2_3)
		begin
			if(ReadPC_4) begin PC<=R2_1; end
			if(ReadR0_4) begin R0<=R2_1; end
			if(ReadR1_4) begin R1<=R2_1; end
			if(ReadR2_4) begin R2<=R2_1; end
			if(ReadR3_4) begin R3<=R2_1; end
			if(ReadR4_4) begin R4<=R2_1; end
			if(ReadR5_4) begin R5<=R2_1; end
			if(ReadR6_4) begin R6<=R2_1; end
			if(ReadR7_4) begin R7<=R2_1; end
			if(ReadR8_4) begin R8<=R2_1; end
			if(ReadR9_4) begin R9<=R2_1; end
			if(ReadR10_4) begin R10<=R2_1; end
			if(ReadR11_4) begin R11<=R2_1; end
			if(ReadR12_4) begin R12<=R2_1; end
			if(ReadR13_4) begin R13<=R2_1; end
			if(ReadR14_4) begin R14<=R2_1; end
			if(ReadR15_4) begin R15<=R2_1; end
			if(ReadR16_4) begin R16<=R2_1; end
			if(ReadR17_4) begin R17<=R2_1; end
		end
		if(ReadR3_3)
		begin
			if(ReadPC_4) begin PC<=R3_1; end
			if(ReadR0_4) begin R0<=R3_1; end
			if(ReadR1_4) begin R1<=R3_1; end
			if(ReadR2_4) begin R2<=R3_1; end
			if(ReadR3_4) begin R3<=R3_1; end
			if(ReadR4_4) begin R4<=R3_1; end
			if(ReadR5_4) begin R5<=R3_1; end
			if(ReadR6_4) begin R6<=R3_1; end
			if(ReadR7_4) begin R7<=R3_1; end
			if(ReadR8_4) begin R8<=R3_1; end
			if(ReadR9_4) begin R9<=R3_1; end
			if(ReadR10_4) begin R10<=R3_1; end
			if(ReadR11_4) begin R11<=R3_1; end
			if(ReadR12_4) begin R12<=R3_1; end
			if(ReadR13_4) begin R13<=R3_1; end
			if(ReadR14_4) begin R14<=R3_1; end
			if(ReadR15_4) begin R15<=R3_1; end
			if(ReadR16_4) begin R16<=R3_1; end
			if(ReadR17_4) begin R17<=R3_1; end
		end
		if(ReadR4_3)
		begin
			if(ReadPC_4) begin PC<=R4_1; end
			if(ReadR0_4) begin R0<=R4_1; end
			if(ReadR1_4) begin R1<=R4_1; end
			if(ReadR2_4) begin R2<=R4_1; end
			if(ReadR3_4) begin R3<=R4_1; end
			if(ReadR4_4) begin R4<=R4_1; end
			if(ReadR5_4) begin R5<=R4_1; end
			if(ReadR6_4) begin R6<=R4_1; end
			if(ReadR7_4) begin R7<=R4_1; end
			if(ReadR8_4) begin R8<=R4_1; end
			if(ReadR9_4) begin R9<=R4_1; end
			if(ReadR10_4) begin R10<=R4_1; end
			if(ReadR11_4) begin R11<=R4_1; end
			if(ReadR12_4) begin R12<=R4_1; end
			if(ReadR13_4) begin R13<=R4_1; end
			if(ReadR14_4) begin R14<=R4_1; end
			if(ReadR15_4) begin R15<=R4_1; end
			if(ReadR16_4) begin R16<=R4_1; end
			if(ReadR17_4) begin R17<=R4_1; end
		end
		if(ReadR5_3)
		begin
			if(ReadPC_4) begin PC<=R5_1; end
			if(ReadR0_4) begin R0<=R5_1; end
			if(ReadR1_4) begin R1<=R5_1; end
			if(ReadR2_4) begin R2<=R5_1; end
			if(ReadR3_4) begin R3<=R5_1; end
			if(ReadR4_4) begin R4<=R5_1; end
			if(ReadR5_4) begin R5<=R5_1; end
			if(ReadR6_4) begin R6<=R5_1; end
			if(ReadR7_4) begin R7<=R5_1; end
			if(ReadR8_4) begin R8<=R5_1; end
			if(ReadR9_4) begin R9<=R5_1; end
			if(ReadR10_4) begin R10<=R5_1; end
			if(ReadR11_4) begin R11<=R5_1; end
			if(ReadR12_4) begin R12<=R5_1; end
			if(ReadR13_4) begin R13<=R5_1; end
			if(ReadR14_4) begin R14<=R5_1; end
			if(ReadR15_4) begin R15<=R5_1; end
			if(ReadR16_4) begin R16<=R5_1; end
			if(ReadR17_4) begin R17<=R5_1; end
		end
		if(ReadR6_3)
		begin
			if(ReadPC_4) begin PC<=R6_1; end
			if(ReadR0_4) begin R0<=R6_1; end
			if(ReadR1_4) begin R1<=R6_1; end
			if(ReadR2_4) begin R2<=R6_1; end
			if(ReadR3_4) begin R3<=R6_1; end
			if(ReadR4_4) begin R4<=R6_1; end
			if(ReadR5_4) begin R5<=R6_1; end
			if(ReadR6_4) begin R6<=R6_1; end
			if(ReadR7_4) begin R7<=R6_1; end
			if(ReadR8_4) begin R8<=R6_1; end
			if(ReadR9_4) begin R9<=R6_1; end
			if(ReadR10_4) begin R10<=R6_1; end
			if(ReadR11_4) begin R11<=R6_1; end
			if(ReadR12_4) begin R12<=R6_1; end
			if(ReadR13_4) begin R13<=R6_1; end
			if(ReadR14_4) begin R14<=R6_1; end
			if(ReadR15_4) begin R15<=R6_1; end
			if(ReadR16_4) begin R16<=R6_1; end
			if(ReadR17_4) begin R17<=R6_1; end
		end
		if(ReadR7_3)
		begin
			if(ReadPC_4) begin PC<=R7_1; end
			if(ReadR0_4) begin R0<=R7_1; end
			if(ReadR1_4) begin R1<=R7_1; end
			if(ReadR2_4) begin R2<=R7_1; end
			if(ReadR3_4) begin R3<=R7_1; end
			if(ReadR4_4) begin R4<=R7_1; end
			if(ReadR5_4) begin R5<=R7_1; end
			if(ReadR6_4) begin R6<=R7_1; end
			if(ReadR7_4) begin R7<=R7_1; end
			if(ReadR8_4) begin R8<=R7_1; end
			if(ReadR9_4) begin R9<=R7_1; end
			if(ReadR10_4) begin R10<=R7_1; end
			if(ReadR11_4) begin R11<=R7_1; end
			if(ReadR12_4) begin R12<=R7_1; end
			if(ReadR13_4) begin R13<=R7_1; end
			if(ReadR14_4) begin R14<=R7_1; end
			if(ReadR15_4) begin R15<=R7_1; end
			if(ReadR16_4) begin R16<=R7_1; end
			if(ReadR17_4) begin R17<=R7_1; end
		end
		if(ReadR8_3)
		begin
			if(ReadPC_4) begin PC<=R8_1; end
			if(ReadR0_4) begin R0<=R8_1; end
			if(ReadR1_4) begin R1<=R8_1; end
			if(ReadR2_4) begin R2<=R8_1; end
			if(ReadR3_4) begin R3<=R8_1; end
			if(ReadR4_4) begin R4<=R8_1; end
			if(ReadR5_4) begin R5<=R8_1; end
			if(ReadR6_4) begin R6<=R8_1; end
			if(ReadR7_4) begin R7<=R8_1; end
			if(ReadR8_4) begin R8<=R8_1; end
			if(ReadR9_4) begin R9<=R8_1; end
			if(ReadR10_4) begin R10<=R8_1; end
			if(ReadR11_4) begin R11<=R8_1; end
			if(ReadR12_4) begin R12<=R8_1; end
			if(ReadR13_4) begin R13<=R8_1; end
			if(ReadR14_4) begin R14<=R8_1; end
			if(ReadR15_4) begin R15<=R8_1; end
			if(ReadR16_4) begin R16<=R8_1; end
			if(ReadR17_4) begin R17<=R8_1; end
		end
		if(ReadR9_3)
		begin
			if(ReadPC_4) begin PC<=R9_1; end
			if(ReadR0_4) begin R0<=R9_1; end
			if(ReadR1_4) begin R1<=R9_1; end
			if(ReadR2_4) begin R2<=R9_1; end
			if(ReadR3_4) begin R3<=R9_1; end
			if(ReadR4_4) begin R4<=R9_1; end
			if(ReadR5_4) begin R5<=R9_1; end
			if(ReadR6_4) begin R6<=R9_1; end
			if(ReadR7_4) begin R7<=R9_1; end
			if(ReadR8_4) begin R8<=R9_1; end
			if(ReadR9_4) begin R9<=R9_1; end
			if(ReadR10_4) begin R10<=R9_1; end
			if(ReadR11_4) begin R11<=R9_1; end
			if(ReadR12_4) begin R12<=R9_1; end
			if(ReadR13_4) begin R13<=R9_1; end
			if(ReadR14_4) begin R14<=R9_1; end
			if(ReadR15_4) begin R15<=R9_1; end
			if(ReadR16_4) begin R16<=R9_1; end
			if(ReadR17_4) begin R17<=R9_1; end
		end
		if(ReadR10_3)
		begin
			if(ReadPC_4) begin PC<=R10_1; end
			if(ReadR0_4) begin R0<=R10_1; end
			if(ReadR1_4) begin R1<=R10_1; end
			if(ReadR2_4) begin R2<=R10_1; end
			if(ReadR3_4) begin R3<=R10_1; end
			if(ReadR4_4) begin R4<=R10_1; end
			if(ReadR5_4) begin R5<=R10_1; end
			if(ReadR6_4) begin R6<=R10_1; end
			if(ReadR7_4) begin R7<=R10_1; end
			if(ReadR8_4) begin R8<=R10_1; end
			if(ReadR9_4) begin R9<=R10_1; end
			if(ReadR10_4) begin R10<=R10_1; end
			if(ReadR11_4) begin R11<=R10_1; end
			if(ReadR12_4) begin R12<=R10_1; end
			if(ReadR13_4) begin R13<=R10_1; end
			if(ReadR14_4) begin R14<=R10_1; end
			if(ReadR15_4) begin R15<=R10_1; end
			if(ReadR16_4) begin R16<=R10_1; end
			if(ReadR17_4) begin R17<=R10_1; end
		end
		if(ReadR11_3)
		begin
			if(ReadPC_4) begin PC<=R11_1; end
			if(ReadR0_4) begin R0<=R11_1; end
			if(ReadR1_4) begin R1<=R11_1; end
			if(ReadR2_4) begin R2<=R11_1; end
			if(ReadR3_4) begin R3<=R11_1; end
			if(ReadR4_4) begin R4<=R11_1; end
			if(ReadR5_4) begin R5<=R11_1; end
			if(ReadR6_4) begin R6<=R11_1; end
			if(ReadR7_4) begin R7<=R11_1; end
			if(ReadR8_4) begin R8<=R11_1; end
			if(ReadR9_4) begin R9<=R11_1; end
			if(ReadR10_4) begin R10<=R11_1; end
			if(ReadR11_4) begin R11<=R11_1; end
			if(ReadR12_4) begin R12<=R11_1; end
			if(ReadR13_4) begin R13<=R11_1; end
			if(ReadR14_4) begin R14<=R11_1; end
			if(ReadR15_4) begin R15<=R11_1; end
			if(ReadR16_4) begin R16<=R11_1; end
			if(ReadR17_4) begin R17<=R11_1; end
		end
		if(ReadR12_3)
		begin
			if(ReadPC_4) begin PC<=R12_1; end
			if(ReadR0_4) begin R0<=R12_1; end
			if(ReadR1_4) begin R1<=R12_1; end
			if(ReadR2_4) begin R2<=R12_1; end
			if(ReadR3_4) begin R3<=R12_1; end
			if(ReadR4_4) begin R4<=R12_1; end
			if(ReadR5_4) begin R5<=R12_1; end
			if(ReadR6_4) begin R6<=R12_1; end
			if(ReadR7_4) begin R7<=R12_1; end
			if(ReadR8_4) begin R8<=R12_1; end
			if(ReadR9_4) begin R9<=R12_1; end
			if(ReadR10_4) begin R10<=R12_1; end
			if(ReadR11_4) begin R11<=R12_1; end
			if(ReadR12_4) begin R12<=R12_1; end
			if(ReadR13_4) begin R13<=R12_1; end
			if(ReadR14_4) begin R14<=R12_1; end
			if(ReadR15_4) begin R15<=R12_1; end
			if(ReadR16_4) begin R16<=R12_1; end
			if(ReadR17_4) begin R17<=R12_1; end
		end
		if(ReadR13_3)
		begin
			if(ReadPC_4) begin PC<=R13_1; end
			if(ReadR0_4) begin R0<=R13_1; end
			if(ReadR1_4) begin R1<=R13_1; end
			if(ReadR2_4) begin R2<=R13_1; end
			if(ReadR3_4) begin R3<=R13_1; end
			if(ReadR4_4) begin R4<=R13_1; end
			if(ReadR5_4) begin R5<=R13_1; end
			if(ReadR6_4) begin R6<=R13_1; end
			if(ReadR7_4) begin R7<=R13_1; end
			if(ReadR8_4) begin R8<=R13_1; end
			if(ReadR9_4) begin R9<=R13_1; end
			if(ReadR10_4) begin R10<=R13_1; end
			if(ReadR11_4) begin R11<=R13_1; end
			if(ReadR12_4) begin R12<=R13_1; end
			if(ReadR13_4) begin R13<=R13_1; end
			if(ReadR14_4) begin R14<=R13_1; end
			if(ReadR15_4) begin R15<=R13_1; end
			if(ReadR16_4) begin R16<=R13_1; end
			if(ReadR17_4) begin R17<=R13_1; end
		end
		if(ReadR14_3)
		begin
			if(ReadPC_4) begin PC<=R14_1; end
			if(ReadR0_4) begin R0<=R14_1; end
			if(ReadR1_4) begin R1<=R14_1; end
			if(ReadR2_4) begin R2<=R14_1; end
			if(ReadR3_4) begin R3<=R14_1; end
			if(ReadR4_4) begin R4<=R14_1; end
			if(ReadR5_4) begin R5<=R14_1; end
			if(ReadR6_4) begin R6<=R14_1; end
			if(ReadR7_4) begin R7<=R14_1; end
			if(ReadR8_4) begin R8<=R14_1; end
			if(ReadR9_4) begin R9<=R14_1; end
			if(ReadR10_4) begin R10<=R14_1; end
			if(ReadR11_4) begin R11<=R14_1; end
			if(ReadR12_4) begin R12<=R14_1; end
			if(ReadR13_4) begin R13<=R14_1; end
			if(ReadR14_4) begin R14<=R14_1; end
			if(ReadR15_4) begin R15<=R14_1; end
			if(ReadR16_4) begin R16<=R14_1; end
			if(ReadR17_4) begin R17<=R14_1; end
		end
		if(ReadR15_3)
		begin
			if(ReadPC_4) begin PC<=R15_1; end
			if(ReadR0_4) begin R0<=R15_1; end
			if(ReadR1_4) begin R1<=R15_1; end
			if(ReadR2_4) begin R2<=R15_1; end
			if(ReadR3_4) begin R3<=R15_1; end
			if(ReadR4_4) begin R4<=R15_1; end
			if(ReadR5_4) begin R5<=R15_1; end
			if(ReadR6_4) begin R6<=R15_1; end
			if(ReadR7_4) begin R7<=R15_1; end
			if(ReadR8_4) begin R8<=R15_1; end
			if(ReadR9_4) begin R9<=R15_1; end
			if(ReadR10_4) begin R10<=R15_1; end
			if(ReadR11_4) begin R11<=R15_1; end
			if(ReadR12_4) begin R12<=R15_1; end
			if(ReadR13_4) begin R13<=R15_1; end
			if(ReadR14_4) begin R14<=R15_1; end
			if(ReadR15_4) begin R15<=R15_1; end
			if(ReadR16_4) begin R16<=R15_1; end
			if(ReadR17_4) begin R17<=R15_1; end
		end
		if(ReadR16_3)
		begin
			if(ReadPC_4) begin PC<=R16_1; end
			if(ReadR0_4) begin R0<=R16_1; end
			if(ReadR1_4) begin R1<=R16_1; end
			if(ReadR2_4) begin R2<=R16_1; end
			if(ReadR3_4) begin R3<=R16_1; end
			if(ReadR4_4) begin R4<=R16_1; end
			if(ReadR5_4) begin R5<=R16_1; end
			if(ReadR6_4) begin R6<=R16_1; end
			if(ReadR7_4) begin R7<=R16_1; end
			if(ReadR8_4) begin R8<=R16_1; end
			if(ReadR9_4) begin R9<=R16_1; end
			if(ReadR10_4) begin R10<=R16_1; end
			if(ReadR11_4) begin R11<=R16_1; end
			if(ReadR12_4) begin R12<=R16_1; end
			if(ReadR13_4) begin R13<=R16_1; end
			if(ReadR14_4) begin R14<=R16_1; end
			if(ReadR15_4) begin R15<=R16_1; end
			if(ReadR16_4) begin R16<=R16_1; end
			if(ReadR17_4) begin R17<=R16_1; end
		end
		if(ReadR17_3)
		begin
			if(ReadPC_4) begin PC<=R17_1; end
			if(ReadR0_4) begin R0<=R17_1; end
			if(ReadR1_4) begin R1<=R17_1; end
			if(ReadR2_4) begin R2<=R17_1; end
			if(ReadR3_4) begin R3<=R17_1; end
			if(ReadR4_4) begin R4<=R17_1; end
			if(ReadR5_4) begin R5<=R17_1; end
			if(ReadR6_4) begin R6<=R17_1; end
			if(ReadR7_4) begin R7<=R17_1; end
			if(ReadR8_4) begin R8<=R17_1; end
			if(ReadR9_4) begin R9<=R17_1; end
			if(ReadR10_4) begin R10<=R17_1; end
			if(ReadR11_4) begin R11<=R17_1; end
			if(ReadR12_4) begin R12<=R17_1; end
			if(ReadR13_4) begin R13<=R17_1; end
			if(ReadR14_4) begin R14<=R17_1; end
			if(ReadR15_4) begin R15<=R17_1; end
			if(ReadR16_4) begin R16<=R17_1; end
			if(ReadR17_4) begin R17<=R17_1; end
		end
	end


//************************************************************************************** xchg **************************************************************************
	if((Function == 6'd61) && (state == 2'b00))
	begin
		if(ReadPC_1)
		begin
			if(ReadPC_2) begin PC<=PC; end
			if(ReadR0_2) begin R0<=PC; PC<=R0; end
			if(ReadR1_2) begin R1<=PC; PC<=R1; end
			if(ReadR2_2) begin R2<=PC; PC<=R2; end
			if(ReadR3_2) begin R3<=PC; PC<=R3; end
			if(ReadR4_2) begin R4<=PC; PC<=R4; end
			if(ReadR5_2) begin R5<=PC; PC<=R5; end
			if(ReadR6_2) begin R6<=PC; PC<=R6; end
			if(ReadR7_2) begin R7<=PC; PC<=R7; end
			if(ReadR8_2) begin R8<=PC; PC<=R8; end
			if(ReadR9_2) begin R9<=PC; PC<=R9; end
			if(ReadR10_2) begin R10<=PC; PC<=R10; end
			if(ReadR11_2) begin R11<=PC; PC<=R11; end
			if(ReadR12_2) begin R12<=PC; PC<=R12; end
			if(ReadR13_2) begin R13<=PC; PC<=R13; end
			if(ReadR14_2) begin R14<=PC; PC<=R14; end
			if(ReadR15_2) begin R15<=PC; PC<=R15; end
			if(ReadR16_2) begin R16<=PC; PC<=R16; end
			if(ReadR17_2) begin R17<=PC; PC<=R17; end
		end
		if(ReadR0_1)
		begin
			if(ReadPC_2) begin PC<=R0; end
			if(ReadR0_2) begin R0<=R0; end
			if(ReadR1_2) begin R1<=R0; end
			if(ReadR2_2) begin R2<=R0; end
			if(ReadR3_2) begin R3<=R0; end
			if(ReadR4_2) begin R4<=R0; end
			if(ReadR5_2) begin R5<=R0; end
			if(ReadR6_2) begin R6<=R0; end
			if(ReadR7_2) begin R7<=R0; end
			if(ReadR8_2) begin R8<=R0; end
			if(ReadR9_2) begin R9<=R0; end
			if(ReadR10_2) begin R10<=R0; end
			if(ReadR11_2) begin R11<=R0; end
			if(ReadR12_2) begin R12<=R0; end
			if(ReadR13_2) begin R13<=R0; end
			if(ReadR14_2) begin R14<=R0; end
			if(ReadR15_2) begin R15<=R0; end
			if(ReadR16_2) begin R16<=R0; end
			if(ReadR17_2) begin R17<=R0; end
		end		
		if(ReadR1_1)
		begin
			if(ReadPC_2) begin PC<=R1; R1<=PC; end
			if(ReadR0_2) begin R0<=R1; R1<=R0; end
			if(ReadR1_2) begin R1<=R1; R1<=R1; end
			if(ReadR2_2) begin R2<=R1; R1<=R2; end
			if(ReadR3_2) begin R3<=R1; R1<=R3; end
			if(ReadR4_2) begin R4<=R1; R1<=R4; end
			if(ReadR5_2) begin R5<=R1; R1<=R5; end
			if(ReadR6_2) begin R6<=R1; R1<=R6; end
			if(ReadR7_2) begin R7<=R1; R1<=R7; end
			if(ReadR8_2) begin R8<=R1; R1<=R8; end
			if(ReadR9_2) begin R9<=R1; R1<=R9; end
			if(ReadR10_2) begin R10<=R1; R1<=R10; end
			if(ReadR11_2) begin R11<=R1; R1<=R11; end
			if(ReadR12_2) begin R12<=R1; R1<=R12; end
			if(ReadR13_2) begin R13<=R1; R1<=R13; end
			if(ReadR14_2) begin R14<=R1; R1<=R14; end
			if(ReadR15_2) begin R15<=R1; R1<=R15; end
			if(ReadR16_2) begin R16<=R1; R1<=R16; end
			if(ReadR17_2) begin R17<=R1; R1<=R17; end
		end	
		if(ReadR2_1)
		begin
			if(ReadPC_2) begin PC<=R2; R2<=PC; end
			if(ReadR0_2) begin R0<=R2; R2<=R0; end
			if(ReadR1_2) begin R1<=R2; R2<=R1; end
			if(ReadR2_2) begin R2<=R2; R2<=R2; end
			if(ReadR3_2) begin R3<=R2; R2<=R3; end
			if(ReadR4_2) begin R4<=R2; R2<=R4; end
			if(ReadR5_2) begin R5<=R2; R2<=R5; end
			if(ReadR6_2) begin R6<=R2; R2<=R6; end
			if(ReadR7_2) begin R7<=R2; R2<=R7; end
			if(ReadR8_2) begin R8<=R2; R2<=R8; end
			if(ReadR9_2) begin R9<=R2; R2<=R9; end
			if(ReadR10_2) begin R10<=R2; R2<=R10; end
			if(ReadR11_2) begin R11<=R2; R2<=R11; end
			if(ReadR12_2) begin R12<=R2; R2<=R12; end
			if(ReadR13_2) begin R13<=R2; R2<=R13; end
			if(ReadR14_2) begin R14<=R2; R2<=R14; end
			if(ReadR15_2) begin R15<=R2; R2<=R15; end
			if(ReadR16_2) begin R16<=R2; R2<=R16; end
			if(ReadR17_2) begin R17<=R2; R2<=R17; end
		end
		if(ReadR3_1)
		begin
			if(ReadPC_2) begin PC<=R3; R3<=PC; end
			if(ReadR0_2) begin R0<=R3; R3<=R0; end
			if(ReadR1_2) begin R1<=R3; R3<=R1; end
			if(ReadR2_2) begin R2<=R3; R3<=R2; end
			if(ReadR3_2) begin R3<=R3; R3<=R3; end
			if(ReadR4_2) begin R4<=R3; R3<=R4; end
			if(ReadR5_2) begin R5<=R3; R3<=R5; end
			if(ReadR6_2) begin R6<=R3; R3<=R6; end
			if(ReadR7_2) begin R7<=R3; R3<=R7; end
			if(ReadR8_2) begin R8<=R3; R3<=R8; end
			if(ReadR9_2) begin R9<=R3; R3<=R9; end
			if(ReadR10_2) begin R10<=R3; R3<=R10; end
			if(ReadR11_2) begin R11<=R3; R3<=R11; end
			if(ReadR12_2) begin R12<=R3; R3<=R12; end
			if(ReadR13_2) begin R13<=R3; R3<=R13; end
			if(ReadR14_2) begin R14<=R3; R3<=R14; end
			if(ReadR15_2) begin R15<=R3; R3<=R15; end
			if(ReadR16_2) begin R16<=R3; R3<=R16; end
			if(ReadR17_2) begin R17<=R3; R3<=R17; end
		end
		if(ReadR4_1)
		begin
			if(ReadPC_2) begin PC<=R4; R4<=PC; end
			if(ReadR0_2) begin R0<=R4; R4<=R0; end
			if(ReadR1_2) begin R1<=R4; R4<=R1; end
			if(ReadR2_2) begin R2<=R4; R4<=R2; end
			if(ReadR3_2) begin R3<=R4; R4<=R3; end
			if(ReadR4_2) begin R4<=R4; R4<=R4; end
			if(ReadR5_2) begin R5<=R4; R4<=R5; end
			if(ReadR6_2) begin R6<=R4; R4<=R6; end
			if(ReadR7_2) begin R7<=R4; R4<=R7; end
			if(ReadR8_2) begin R8<=R4; R4<=R8; end
			if(ReadR9_2) begin R9<=R4; R4<=R9; end
			if(ReadR10_2) begin R10<=R4; R4<=R10; end
			if(ReadR11_2) begin R11<=R4; R4<=R11; end
			if(ReadR12_2) begin R12<=R4; R4<=R12; end
			if(ReadR13_2) begin R13<=R4; R4<=R13; end
			if(ReadR14_2) begin R14<=R4; R4<=R14; end
			if(ReadR15_2) begin R15<=R4; R4<=R15; end
			if(ReadR16_2) begin R16<=R4; R4<=R16; end
			if(ReadR17_2) begin R17<=R4; R4<=R17; end
		end
		if(ReadR5_1)
		begin
			if(ReadPC_2) begin PC<=R5; end
			if(ReadR0_2) begin R0<=R5; end
			if(ReadR1_2) begin R1<=R5; end
			if(ReadR2_2) begin R2<=R5; end
			if(ReadR3_2) begin R3<=R5; end
			if(ReadR4_2) begin R4<=R5; end
			if(ReadR5_2) begin R5<=R5; end
			if(ReadR6_2) begin R6<=R5; end
			if(ReadR7_2) begin R7<=R5; end
			if(ReadR8_2) begin R8<=R5; end
			if(ReadR9_2) begin R9<=R5; end
			if(ReadR10_2) begin R10<=R5; end
			if(ReadR11_2) begin R11<=R5; end
			if(ReadR12_2) begin R12<=R5; end
			if(ReadR13_2) begin R13<=R5; end
			if(ReadR14_2) begin R14<=R5; end
			if(ReadR15_2) begin R15<=R5; end
			if(ReadR16_2) begin R16<=R5; end
			if(ReadR17_2) begin R17<=R5; end
		end
		if(ReadR6_1)
		begin
			if(ReadPC_2) begin PC<=R6; R6<=PC; end
			if(ReadR0_2) begin R0<=R6; R6<=R0; end
			if(ReadR1_2) begin R1<=R6; R6<=R1; end
			if(ReadR2_2) begin R2<=R6; R6<=R2; end
			if(ReadR3_2) begin R3<=R6; R6<=R3; end
			if(ReadR4_2) begin R4<=R6; R6<=R4; end
			if(ReadR5_2) begin R5<=R6; R6<=R5; end
			if(ReadR6_2) begin R6<=R6; R6<=R6; end
			if(ReadR7_2) begin R7<=R6; R6<=R7; end
			if(ReadR8_2) begin R8<=R6; R6<=R8; end
			if(ReadR9_2) begin R9<=R6; R6<=R9; end
			if(ReadR10_2) begin R10<=R6; R6<=R10; end
			if(ReadR11_2) begin R11<=R6; R6<=R11; end
			if(ReadR12_2) begin R12<=R6; R6<=R12; end
			if(ReadR13_2) begin R13<=R6; R6<=R13; end
			if(ReadR14_2) begin R14<=R6; R6<=R14; end
			if(ReadR15_2) begin R15<=R6; R6<=R15; end
			if(ReadR16_2) begin R16<=R6; R6<=R16; end
			if(ReadR17_2) begin R17<=R6; R6<=R17; end
		end
		if(ReadR7_1)
		begin
			if(ReadPC_2) begin PC<=R7; R7<=PC;end
			if(ReadR0_2) begin R0<=R7; R7<=R0; end
			if(ReadR1_2) begin R1<=R7; R7<=R1; end
			if(ReadR2_2) begin R2<=R7; R7<=R2; end
			if(ReadR3_2) begin R3<=R7; R7<=R3; end
			if(ReadR4_2) begin R4<=R7; R7<=R4; end
			if(ReadR5_2) begin R5<=R7; R7<=R5; end
			if(ReadR6_2) begin R6<=R7; R7<=R6; end
			if(ReadR7_2) begin R7<=R7; R7<=R7; end
			if(ReadR8_2) begin R8<=R7; R7<=R8; end
			if(ReadR9_2) begin R9<=R7; R7<=R9; end
			if(ReadR10_2) begin R10<=R7; R7<=R10; end
			if(ReadR11_2) begin R11<=R7; R7<=R11; end
			if(ReadR12_2) begin R12<=R7; R7<=R12; end
			if(ReadR13_2) begin R13<=R7; R7<=R13; end
			if(ReadR14_2) begin R14<=R7; R7<=R14; end
			if(ReadR15_2) begin R15<=R7; R7<=R15; end
			if(ReadR16_2) begin R16<=R7; R7<=R16; end
			if(ReadR17_2) begin R17<=R7; R7<=R17; end
		end
		if(ReadR8_1)
		begin
			if(ReadPC_2) begin PC<=R8; R8<=PC; end
			if(ReadR0_2) begin R0<=R8; R8<=R0; end
			if(ReadR1_2) begin R1<=R8; R8<=R1; end
			if(ReadR2_2) begin R2<=R8; R8<=R2; end
			if(ReadR3_2) begin R3<=R8; R8<=R3; end
			if(ReadR4_2) begin R4<=R8; R8<=R4; end
			if(ReadR5_2) begin R5<=R8; R8<=R5; end
			if(ReadR6_2) begin R6<=R8; R8<=R6; end
			if(ReadR7_2) begin R7<=R8; R8<=R7; end
			if(ReadR8_2) begin R8<=R8; R8<=R8; end
			if(ReadR9_2) begin R9<=R8; R8<=R9; end
			if(ReadR10_2) begin R10<=R8; R8<=R10; end
			if(ReadR11_2) begin R11<=R8; R8<=R11; end
			if(ReadR12_2) begin R12<=R8; R8<=R12; end
			if(ReadR13_2) begin R13<=R8; R8<=R13; end
			if(ReadR14_2) begin R14<=R8; R8<=R14; end
			if(ReadR15_2) begin R15<=R8; R8<=R15; end
			if(ReadR16_2) begin R16<=R8; R8<=R16; end
			if(ReadR17_2) begin R17<=R8; R8<=R17; end
		end
		if(ReadR9_1)
		begin
			if(ReadPC_2) begin PC<=R9; R9<=PC; end
			if(ReadR0_2) begin R0<=R9; R9<=R0; end
			if(ReadR1_2) begin R1<=R9; R9<=R1; end
			if(ReadR2_2) begin R2<=R9; R9<=R2; end
			if(ReadR3_2) begin R3<=R9; R9<=R3; end
			if(ReadR4_2) begin R4<=R9; R9<=R4; end
			if(ReadR5_2) begin R5<=R9; R9<=R5; end
			if(ReadR6_2) begin R6<=R9; R9<=R6; end
			if(ReadR7_2) begin R7<=R9; R9<=R7; end
			if(ReadR8_2) begin R8<=R9; R9<=R8; end
			if(ReadR9_2) begin R9<=R9; R9<=R9; end
			if(ReadR10_2) begin R10<=R9; R9<=R10; end
			if(ReadR11_2) begin R11<=R9; R9<=R11; end
			if(ReadR12_2) begin R12<=R9; R9<=R12; end
			if(ReadR13_2) begin R13<=R9; R9<=R13; end
			if(ReadR14_2) begin R14<=R9; R9<=R14; end
			if(ReadR15_2) begin R15<=R9; R9<=R15; end
			if(ReadR16_2) begin R16<=R9; R9<=R16; end
			if(ReadR17_2) begin R17<=R9; R9<=R17; end
		end
		if(ReadR10_1)
		begin
			if(ReadPC_2) begin PC<=R10; R10<=PC; end
			if(ReadR0_2) begin R0<=R10; R10<=R0; end
			if(ReadR1_2) begin R1<=R10; R10<=R1; end
			if(ReadR2_2) begin R2<=R10; R10<=R2; end
			if(ReadR3_2) begin R3<=R10; R10<=R3; end
			if(ReadR4_2) begin R4<=R10; R10<=R4; end
			if(ReadR5_2) begin R5<=R10; R10<=R5; end
			if(ReadR6_2) begin R6<=R10; R10<=R6; end
			if(ReadR7_2) begin R7<=R10; R10<=R7; end
			if(ReadR8_2) begin R8<=R10; R10<=R8; end
			if(ReadR9_2) begin R9<=R10; R10<=R9; end
			if(ReadR10_2) begin R10<=R10; R10<=R10; end
			if(ReadR11_2) begin R11<=R10; R10<=R11; end
			if(ReadR12_2) begin R12<=R10; R10<=R12; end
			if(ReadR13_2) begin R13<=R10; R10<=R13; end
			if(ReadR14_2) begin R14<=R10; R10<=R14; end
			if(ReadR15_2) begin R15<=R10; R10<=R15; end
			if(ReadR16_2) begin R16<=R10; R10<=R16; end
			if(ReadR17_2) begin R17<=R10; R10<=R17; end
		end
		if(ReadR11_1)
		begin
			if(ReadPC_2) begin PC<=R11; R11<=PC; end
			if(ReadR0_2) begin R0<=R11; R11<=R0; end
			if(ReadR1_2) begin R1<=R11; R11<=R1; end
			if(ReadR2_2) begin R2<=R11; R11<=R2; end
			if(ReadR3_2) begin R3<=R11; R11<=R3; end
			if(ReadR4_2) begin R4<=R11; R11<=R4; end
			if(ReadR5_2) begin R5<=R11; R11<=R5; end
			if(ReadR6_2) begin R6<=R11; R11<=R6; end
			if(ReadR7_2) begin R7<=R11; R11<=R7; end
			if(ReadR8_2) begin R8<=R11; R11<=R8; end
			if(ReadR9_2) begin R9<=R11; R11<=R9; end
			if(ReadR10_2) begin R10<=R11; R11<=R10; end
			if(ReadR11_2) begin R11<=R11; R11<=R11; end
			if(ReadR12_2) begin R12<=R11; R11<=R12; end
			if(ReadR13_2) begin R13<=R11; R11<=R13; end
			if(ReadR14_2) begin R14<=R11; R11<=R14; end
			if(ReadR15_2) begin R15<=R11; R11<=R15; end
			if(ReadR16_2) begin R16<=R11; R11<=R16; end
			if(ReadR17_2) begin R17<=R11; R11<=R17; end
		end
		if(ReadR12_1)
		begin
			if(ReadPC_2) begin PC<=R12; R12<=PC; end
			if(ReadR0_2) begin R0<=R12; R12<=R0; end
			if(ReadR1_2) begin R1<=R12; R12<=R1; end
			if(ReadR2_2) begin R2<=R12; R12<=R2; end
			if(ReadR3_2) begin R3<=R12; R12<=R3; end
			if(ReadR4_2) begin R4<=R12; R12<=R4; end
			if(ReadR5_2) begin R5<=R12; R12<=R5; end
			if(ReadR6_2) begin R6<=R12; R12<=R6; end
			if(ReadR7_2) begin R7<=R12; R12<=R7; end
			if(ReadR8_2) begin R8<=R12; R12<=R8; end
			if(ReadR9_2) begin R9<=R12; R12<=R9; end
			if(ReadR10_2) begin R10<=R12; R12<=R10; end
			if(ReadR11_2) begin R11<=R12; R12<=R11; end
			if(ReadR12_2) begin R12<=R12; R12<=R12; end
			if(ReadR13_2) begin R13<=R12; R12<=R13; end
			if(ReadR14_2) begin R14<=R12; R12<=R14; end
			if(ReadR15_2) begin R15<=R12; R12<=R15; end
			if(ReadR16_2) begin R16<=R12; R12<=R16; end
			if(ReadR17_2) begin R17<=R12; R12<=R17; end
		end
		if(ReadR13_1)
		begin
			if(ReadPC_2) begin PC<=R13; R13<=PC; end
			if(ReadR0_2) begin R0<=R13; R13<=R0; end
			if(ReadR1_2) begin R1<=R13; R13<=R1; end
			if(ReadR2_2) begin R2<=R13; R13<=R2; end
			if(ReadR3_2) begin R3<=R13; R13<=R3; end
			if(ReadR4_2) begin R4<=R13; R13<=R4; end
			if(ReadR5_2) begin R5<=R13; R13<=R5; end
			if(ReadR6_2) begin R6<=R13; R13<=R6; end
			if(ReadR7_2) begin R7<=R13; R13<=R7; end
			if(ReadR8_2) begin R8<=R13; R13<=R8; end
			if(ReadR9_2) begin R9<=R13; R13<=R9; end
			if(ReadR10_2) begin R10<=R13; R13<=R10; end
			if(ReadR11_2) begin R11<=R13; R13<=R11; end
			if(ReadR12_2) begin R12<=R13; R13<=R12; end
			if(ReadR13_2) begin R13<=R13; R13<=R13; end
			if(ReadR14_2) begin R14<=R13; R13<=R14; end
			if(ReadR15_2) begin R15<=R13; R13<=R15; end
			if(ReadR16_2) begin R16<=R13; R13<=R16; end
			if(ReadR17_2) begin R17<=R13; R13<=R17; end
		end
		if(ReadR14_1)
		begin
			if(ReadPC_2) begin PC<=R14; R14<=PC; end
			if(ReadR0_2) begin R0<=R14; R14<=R0; end
			if(ReadR1_2) begin R1<=R14; R14<=R1; end
			if(ReadR2_2) begin R2<=R14; R14<=R2; end
			if(ReadR3_2) begin R3<=R14; R14<=R3; end
			if(ReadR4_2) begin R4<=R14; R14<=R4; end
			if(ReadR5_2) begin R5<=R14; R14<=R5; end
			if(ReadR6_2) begin R6<=R14; R14<=R6; end
			if(ReadR7_2) begin R7<=R14; R14<=R7; end
			if(ReadR8_2) begin R8<=R14; R14<=R8; end
			if(ReadR9_2) begin R9<=R14; R14<=R9; end
			if(ReadR10_2) begin R10<=R14; R14<=R10; end
			if(ReadR11_2) begin R11<=R14; R14<=R11; end
			if(ReadR12_2) begin R12<=R14; R14<=R12; end
			if(ReadR13_2) begin R13<=R14; R14<=R13; end
			if(ReadR14_2) begin R14<=R14; R14<=R14; end
			if(ReadR15_2) begin R15<=R14; R14<=R15; end
			if(ReadR16_2) begin R16<=R14; R14<=R16; end
			if(ReadR17_2) begin R17<=R14; R14<=R17; end
		end
		if(ReadR15_1)
		begin
			if(ReadPC_2) begin PC<=R15; R15<=PC; end
			if(ReadR0_2) begin R0<=R15; R15<=R0; end
			if(ReadR1_2) begin R1<=R15; R15<=R1; end
			if(ReadR2_2) begin R2<=R15; R15<=R2; end
			if(ReadR3_2) begin R3<=R15; R15<=R3; end
			if(ReadR4_2) begin R4<=R15; R15<=R4; end
			if(ReadR5_2) begin R5<=R15; R15<=R5; end
			if(ReadR6_2) begin R6<=R15; R15<=R6; end
			if(ReadR7_2) begin R7<=R15; R15<=R7; end
			if(ReadR8_2) begin R8<=R15; R15<=R8; end
			if(ReadR9_2) begin R9<=R15; R15<=R9; end
			if(ReadR10_2) begin R10<=R15; R15<=R10; end
			if(ReadR11_2) begin R11<=R15; R15<=R11; end
			if(ReadR12_2) begin R12<=R15; R15<=R12; end
			if(ReadR13_2) begin R13<=R15; R15<=R13; end
			if(ReadR14_2) begin R14<=R15; R15<=R14; end
			if(ReadR15_2) begin R15<=R15; R15<=R15; end
			if(ReadR16_2) begin R16<=R15; R15<=R16; end
			if(ReadR17_2) begin R17<=R15; R15<=R17; end
		end
		if(ReadR16_1)
		begin
			if(ReadPC_2) begin PC<=R16; R16<=PC; end
			if(ReadR0_2) begin R0<=R16; R16<=R0; end
			if(ReadR1_2) begin R1<=R16; R16<=R1; end
			if(ReadR2_2) begin R2<=R16; R16<=R2; end
			if(ReadR3_2) begin R3<=R16; R16<=R3; end
			if(ReadR4_2) begin R4<=R16; R16<=R4; end
			if(ReadR5_2) begin R5<=R16; R16<=R5; end
			if(ReadR6_2) begin R6<=R16; R16<=R6; end
			if(ReadR7_2) begin R7<=R16; R16<=R7; end
			if(ReadR8_2) begin R8<=R16; R16<=R8; end
			if(ReadR9_2) begin R9<=R16; R16<=R9; end
			if(ReadR10_2) begin R10<=R16; R16<=R10; end
			if(ReadR11_2) begin R11<=R16; R16<=R11; end
			if(ReadR12_2) begin R12<=R16; R16<=R12; end
			if(ReadR13_2) begin R13<=R16; R16<=R13; end
			if(ReadR14_2) begin R14<=R16; R16<=R14; end
			if(ReadR15_2) begin R15<=R16; R16<=R15; end
			if(ReadR16_2) begin R16<=R16; R16<=R16; end
			if(ReadR17_2) begin R17<=R16; R16<=R17; end
		end
		if(ReadR17_1)
		begin
			if(ReadPC_2) begin PC<=R17; R17<=PC; end
			if(ReadR0_2) begin R0<=R17; R17<=R0; end
			if(ReadR1_2) begin R1<=R17; R17<=R1; end
			if(ReadR2_2) begin R2<=R17; R17<=R2; end
			if(ReadR3_2) begin R3<=R17; R17<=R3; end
			if(ReadR4_2) begin R4<=R17; R17<=R4; end
			if(ReadR5_2) begin R5<=R17; R17<=R5; end
			if(ReadR6_2) begin R6<=R17; R17<=R6; end
			if(ReadR7_2) begin R7<=R17; R17<=R7; end
			if(ReadR8_2) begin R8<=R17; R17<=R8; end
			if(ReadR9_2) begin R9<=R17; R17<=R9; end
			if(ReadR10_2) begin R10<=R17; R17<=R10; end
			if(ReadR11_2) begin R11<=R17; R17<=R11; end
			if(ReadR12_2) begin R12<=R17; R17<=R12; end
			if(ReadR13_2) begin R13<=R17; R17<=R13; end
			if(ReadR14_2) begin R14<=R17; R17<=R14; end
			if(ReadR15_2) begin R15<=R17; R17<=R15; end
			if(ReadR16_2) begin R16<=R17; R17<=R16; end
			if(ReadR17_2) begin R17<=R17; R17<=R17; end
		end
	end	
//******************************************* end of xchg *******************************************

   end
   
endmodule


