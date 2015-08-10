`include "opcodes.v"
`timescale 100ps / 10ps

module cpu_core( Sysbus, Sysbus2, Data_in, Data_in2, ENB, ENB2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2, SDO, SDO2, Clock, nReset, Test, Test2, SDI, SDI2 );

inout [63:0] Sysbus;
inout [63:0] Sysbus2;
input [63:0] Data_in;
input [63:0] Data_in2;
input Clock, nReset, Test, SDI, Test2, SDI2;
output ENB, nME, nALE, RnW, nOE, SDO, ENB2, nME2, nALE2, RnW2, nOE2, SDO2;
wire [63:0] Sysbus;
wire [63:0] Sysbus2;
wire [5:0] Function;
wire [5:0] Function2;
wire Zero, Zero2;
wire TrisALU, TrisMem, TrisPC, TrisALU2, TrisMem2, TrisPC2;
assign SDO = SDI;
assign SDO2 = SDI2;
assign Sysbus = (TrisMem) ? Data_in: 64'bz;
assign Sysbus2 = (TrisMem2) ? Data_in2: 64'bz;
wire [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
wire [63:0] PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2;

control Control(Sysbus, Sysbus2, nOE, nOE2, RnW, RnW2, nME, nME2, nALE, nALE2, Zero, Zero2, Function, Function2, Clock, nReset, TrisPC, TrisPC2, TrisALU, TrisALU2, ENB, ENB2, TrisMem, TrisMem2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, WriteR1, WriteR1_1, WriteR2, WriteR2_1, WriteR3, WriteR3_1, WriteR4, WriteR4_1, WriteR5, WriteR5_1, WriteR6, WriteR6_1, WriteR7, WriteR7_1, WriteR8, WriteR8_1, WriteR9, WriteR9_1, WriteR10, WriteR10_1, WriteR11, WriteR11_1, WriteR12, WriteR12_1, WriteR13, WriteR13_1, WriteR14, WriteR14_1, WriteR15, WriteR15_1, WriteR16, WriteR16_1, WriteR17, WriteR17_1, PC_inc, PC_inc2, Rs2_sel, Rs2_sel2, LoadDR, LoadDR2, LoadPC, LoadPC2);

datapath Datapath( Sysbus, Sysbus2, Zero, Zero2, Function, Function2, TrisALU, TrisALU2, TrisPC, TrisPC2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, Clock, nReset, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, PC_inc, PC_inc2, WriteR1, WriteR1_1, WriteR2, WriteR2_1, WriteR3, WriteR3_1, WriteR4, WriteR4_1, WriteR5, WriteR5_1, WriteR6, WriteR6_1, WriteR7, WriteR7_1, WriteR8, WriteR8_1, WriteR9, WriteR9_1, WriteR10, WriteR10_1, WriteR11, WriteR11_1, WriteR12, WriteR12_1, WriteR13, WriteR13_1, WriteR14, WriteR14_1, WriteR15, WriteR15_1, WriteR16, WriteR16_1, WriteR17, WriteR17_1, Rs2_sel, Rs2_sel2, LoadDR, LoadDR2, LoadPC, LoadPC2, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR, PC2, R1_1, R2_1, R3_1, R4_1, R5_1, R6_1, R7_1, R8_1, R9_1, R10_1, R11_1, R12_1, R13_1, R14_1, R15_1, R16_1, R17_1, R0_1, DR2);


endmodule

