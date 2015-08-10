`include "opcodes.v"
`timescale 100ps / 10ps

module cpu_core( Sysbus, Sysbus2, Sysbus3, Sysbus4, Data_in, Data_in2, Data_in3, Data_in4, ENB, ENB2, ENB3, ENB4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, RnW, RnW2, RnW3, RnW4, nOE, nOE2, nOE3, nOE4, SDO, SDO2, SDO3, SDO4, Clock, nReset, Test, Test2, Test3, Test4, SDI, SDI2, SDI3, SDI4  );

//quad core
inout [63:0] Sysbus;
inout [63:0] Sysbus2;
inout [63:0] Sysbus3;
inout [63:0] Sysbus4;
input [63:0] Data_in;
input [63:0] Data_in2;
input [63:0] Data_in3;
input [63:0] Data_in4;
input Clock, nReset, Test, SDI, Test2, SDI2, Test3, SDI3, Test4, SDI4;
output ENB, nME, nALE, RnW, nOE, SDO, ENB2, nME2, nALE2, RnW2, nOE2, SDO2;
output ENB3, nME3, nALE3, RnW3, nOE3, SDO3, ENB4, nME4, nALE4, RnW4, nOE4, SDO4;
wire [63:0] Sysbus;
wire [63:0] Sysbus2;
wire [63:0] Sysbus3;
wire [63:0] Sysbus4;
wire [5:0] Function;
wire [5:0] Function2;
wire [5:0] Function3;
wire [5:0] Function4;
wire Zero, Zero2;
wire Zero3, Zero4;
wire TrisALU, TrisMem, TrisPC, TrisALU2, TrisMem2, TrisPC2;
wire TrisALU3, TrisMem3, TrisPC3, TrisALU4, TrisMem4, TrisPC4;
assign SDO = SDI;
assign SDO2 = SDI2;
assign SDO3 = SDI3;
assign SDO4 = SDI4;
assign Sysbus = (TrisMem) ? Data_in: 64'bz;
assign Sysbus2 = (TrisMem2) ? Data_in2: 64'bz;
assign Sysbus3 = (TrisMem3) ? Data_in3: 64'bz;
assign Sysbus4 = (TrisMem4) ? Data_in4: 64'bz;
wire [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
wire [63:0] PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2;
wire [63:0] PC3, R1_2, R2_2, R3_2, R4_2, R5_2, R6_2, R7_2, R8_2, R9_2, R10_2, R11_2, R12_2, R13_2, R14_2, R15_2, R16_2, R17_2, R0_2, DR3;
wire [63:0] PC4, R1_3, R2_3, R3_3, R4_3, R5_3, R6_3, R7_3, R8_3, R9_3, R10_3, R11_3, R12_3, R13_3, R14_3, R15_3, R16_3, R17_3, R0_3, DR4;
wire [1:0] state, state2, sub_state, sub_state2;
wire [1:0] state3, state4, sub_state3, sub_state4;

control Control(Sysbus, Sysbus2, Sysbus3, Sysbus4, nOE, nOE2, nOE3, nOE4, RnW, RnW2, RnW3, RnW4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, Zero, Zero2, Zero3, Zero4, Function, Function2, Function3, Function4, Clock, nReset, TrisPC, TrisPC2, TrisPC3, TrisPC4, TrisALU, TrisALU2, TrisALU3, TrisALU4, ENB, ENB2, ENB3, ENB4, TrisMem, TrisMem2, TrisMem3, TrisMem4, TrisRs2, TrisRs22, TrisRs23, TrisRs24, TrisRd, TrisRd2, TrisRd3, TrisRd4, nTrisRd, nTrisRd2, nTrisRd3, nTrisRd4, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadPC_5, ReadPC_6, ReadPC_7, ReadPC_8, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR0_5, ReadR0_6, ReadR0_7, ReadR0_8, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR1_5, ReadR1_6, ReadR1_7, ReadR1_8, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR2_5, ReadR2_6, ReadR2_7, ReadR2_8, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR3_5, ReadR3_6, ReadR3_7, ReadR3_8, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR4_5, ReadR4_6, ReadR4_7, ReadR4_8, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR5_5, ReadR5_6, ReadR5_7, ReadR5_8, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR6_5, ReadR6_6, ReadR6_7, ReadR6_8, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR7_5, ReadR7_6, ReadR7_7, ReadR7_8, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR8_5, ReadR8_6, ReadR8_7, ReadR8_8, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR9_5, ReadR9_6, ReadR9_7, ReadR9_8, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR10_5, ReadR10_6, ReadR10_7, ReadR10_8, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR11_5, ReadR11_6, ReadR11_7, ReadR11_8, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR12_5, ReadR12_6, ReadR12_7, ReadR12_8, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR13_5, ReadR13_6, ReadR13_7, ReadR13_8, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR14_5, ReadR14_6, ReadR14_7, ReadR14_8, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR15_5, ReadR15_6, ReadR15_7, ReadR15_8, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR16_5, ReadR16_6, ReadR16_7, ReadR16_8, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, ReadR17_5, ReadR17_6, ReadR17_7, ReadR17_8, WriteR1, WriteR1_1, WriteR1_2, WriteR1_3, WriteR2, WriteR2_1, WriteR2_2, WriteR2_3, WriteR3, WriteR3_1, WriteR3_2, WriteR3_3, WriteR4, WriteR4_1, WriteR4_2, WriteR4_3, WriteR5, WriteR5_1, WriteR5_2, WriteR5_3, WriteR6, WriteR6_1, WriteR6_2, WriteR6_3, WriteR7, WriteR7_1, WriteR7_2, WriteR7_3, WriteR8, WriteR8_1, WriteR8_2, WriteR8_3, WriteR9, WriteR9_1, WriteR9_2, WriteR9_3, WriteR10, WriteR10_1, WriteR10_2, WriteR10_3, WriteR11, WriteR11_1, WriteR11_2, WriteR11_3, WriteR12, WriteR12_1, WriteR12_2, WriteR12_3, WriteR13, WriteR13_1, WriteR13_2, WriteR13_3, WriteR14, WriteR14_1, WriteR14_2, WriteR14_3, WriteR15, WriteR15_1, WriteR15_2, WriteR15_3, WriteR16, WriteR16_1, WriteR16_2, WriteR16_3, WriteR17, WriteR17_1, WriteR17_2, WriteR17_3, PC_inc, PC_inc2, PC_inc3, PC_inc4, Rs2_sel, Rs2_sel2, Rs2_sel3, Rs2_sel4, LoadDR, LoadDR2, LoadDR3, LoadDR4, LoadPC, LoadPC2, LoadPC3, LoadPC4, state, state2, state3, state4, sub_state, sub_state2, sub_state3, sub_state4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);


datapath Datapath( Sysbus, Sysbus2, Sysbus3, Sysbus4, Zero, Zero2, Zero3, Zero4, Function, Function2, Function3, Function4, TrisALU, TrisALU2, TrisALU3, TrisALU4, TrisPC, TrisPC2, TrisPC3, TrisPC4, TrisRs2, TrisRs22, TrisRs23, TrisRs24, TrisRd, TrisRd2, TrisRd3, TrisRd4, nTrisRd, nTrisRd2, nTrisRd3, nTrisRd4, Clock, nReset, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadPC_5, ReadPC_6, ReadPC_7, ReadPC_8, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR0_5, ReadR0_6, ReadR0_7, ReadR0_8, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR1_5, ReadR1_6, ReadR1_7, ReadR1_8, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR2_5, ReadR2_6, ReadR2_7, ReadR2_8, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR3_5, ReadR3_6, ReadR3_7, ReadR3_8, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR4_5, ReadR4_6, ReadR4_7, ReadR4_8, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR5_5, ReadR5_6, ReadR5_7, ReadR5_8, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR6_5, ReadR6_6, ReadR6_7, ReadR6_8, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR7_5, ReadR7_6, ReadR7_7, ReadR7_8, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR8_5, ReadR8_6, ReadR8_7, ReadR8_8, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR9_5, ReadR9_6, ReadR9_7, ReadR9_8, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR10_5, ReadR10_6, ReadR10_7, ReadR10_8, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR11_5, ReadR11_6, ReadR11_7, ReadR11_8, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR12_5, ReadR12_6, ReadR12_7, ReadR12_8, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR13_5, ReadR13_6, ReadR13_7, ReadR13_8, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR14_5, ReadR14_6, ReadR14_7, ReadR14_8, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR15_5, ReadR15_6, ReadR15_7, ReadR15_8, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR16_5, ReadR16_6, ReadR16_7, ReadR16_8, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, ReadR17_5, ReadR17_6, ReadR17_7, ReadR17_8, PC_inc, PC_inc2, PC_inc3, PC_inc4, WriteR1, WriteR1_1, WriteR1_2, WriteR1_3, WriteR2, WriteR2_1, WriteR2_2, WriteR2_3, WriteR3, WriteR3_1, WriteR3_2, WriteR3_3, WriteR4, WriteR4_1, WriteR4_2, WriteR4_3, WriteR5, WriteR5_1, WriteR5_2, WriteR5_3, WriteR6, WriteR6_1, WriteR6_2, WriteR6_3, WriteR7, WriteR7_1, WriteR7_2, WriteR7_3, WriteR8, WriteR8_1, WriteR8_2, WriteR8_3, WriteR9, WriteR9_1, WriteR9_2, WriteR9_3, WriteR10, WriteR10_1, WriteR10_2, WriteR10_3, WriteR11, WriteR11_1, WriteR11_2, WriteR11_3, WriteR12, WriteR12_1, WriteR12_2, WriteR12_3, WriteR13, WriteR13_1, WriteR13_2, WriteR13_3, WriteR14, WriteR14_1, WriteR14_2, WriteR14_3, WriteR15, WriteR15_1, WriteR15_2, WriteR15_3, WriteR16, WriteR16_1, WriteR16_2, WriteR16_3, WriteR17, WriteR17_1, WriteR17_2, WriteR17_3, Rs2_sel, Rs2_sel2, Rs2_sel3, Rs2_sel4, LoadDR, LoadDR2, LoadDR3, LoadDR4, LoadPC, LoadPC2, LoadPC3, LoadPC4, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR, PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2, PC3, R1_2, R2_2, R3_2, R4_2, R5_2, R6_2, R7_2, R8_2, R9_2, R10_2, R11_2, R12_2, R13_2, R14_2, R15_2, R16_2, R17_2, R0_2, DR3, PC4, R1_3, R2_3, R3_3, R4_3, R5_3, R6_3, R7_3, R8_3, R9_3, R10_3, R11_3, R12_3, R13_3, R14_3, R15_3, R16_3, R17_3, R0_3, DR4, state, state2, state3, state4, sub_state, sub_state2, sub_state3, sub_state4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);


endmodule

