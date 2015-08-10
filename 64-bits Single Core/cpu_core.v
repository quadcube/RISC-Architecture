`include "opcodes.v"
`timescale 100ps / 10ps

module cpu_core( Sysbus, Data_in, ENB, nME, nALE, RnW, nOE, SDO, Clock, nReset, Test, SDI );

inout [63:0] Sysbus;
input [63:0] Data_in;
input Clock, nReset, Test, SDI;
output ENB, nME, nALE, RnW, nOE, SDO;
wire [63:0] Sysbus;
wire [5:0] Function;
wire Zero;
wire TrisALU, TrisMem, TrisPC;
assign SDO = SDI;
assign Sysbus = (TrisMem) ? Data_in: 64'bz;
wire [63:0] PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR;
control Control(Sysbus, nOE, RnW, nME, nALE, Zero, Function, Clock, nReset, TrisPC, TrisALU, ENB, TrisMem, TrisRs2, TrisRd, nTrisRd, ReadPC_1, ReadPC_2, ReadR0_1, ReadR0_2, ReadR1_1, ReadR1_2, ReadR2_1, ReadR2_2, ReadR3_1, ReadR3_2, ReadR4_1, ReadR4_2, ReadR5_1, ReadR5_2, ReadR6_1, ReadR6_2, ReadR7_1, ReadR7_2, ReadR8_1, ReadR8_2, ReadR9_1, ReadR9_2, ReadR10_1, ReadR10_2, ReadR11_1, ReadR11_2, ReadR12_1, ReadR12_2, ReadR13_1, ReadR13_2, ReadR14_1, ReadR14_2, ReadR15_1, ReadR15_2, ReadR16_1, ReadR16_2, ReadR17_1, ReadR17_2, WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17, PC_inc, Rs2_sel, LoadDR, LoadPC);
datapath Datapath( Sysbus, Zero, Function, TrisALU, TrisPC, TrisRs2, TrisRd, nTrisRd, Clock, nReset, ReadPC_1, ReadPC_2, ReadR0_1, ReadR0_2, ReadR1_1, ReadR1_2, ReadR2_1, ReadR2_2, ReadR3_1, ReadR3_2,ReadR4_1, ReadR4_2, ReadR5_1, ReadR5_2, ReadR6_1, ReadR6_2, ReadR7_1, ReadR7_2, ReadR8_1, ReadR8_2, ReadR9_1, ReadR9_2, ReadR10_1, ReadR10_2, ReadR11_1, ReadR11_2, ReadR12_1, ReadR12_2, ReadR13_1, ReadR13_2, ReadR14_1, ReadR14_2, ReadR15_1, ReadR15_2, ReadR16_1, ReadR16_2, ReadR17_1, ReadR17_2, PC_inc, WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17, Rs2_sel, LoadDR, LoadPC, PC, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R0, DR);

endmodule

