`include "opcodes.v"
`timescale	100ps/10ps

`define	Fetch1	0
`define Execute	1
`define	Fetch2	3

`define address_setup	0
`define address_hold	1
`define	data_setup	3
`define	data_hold	2


module control(Sysbus, Sysbus2, Sysbus3, Sysbus4, nOE, nOE2, nOE3, nOE4, RnW, RnW2, RnW3, RnW4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, Zero, Zero2, Zero3, Zero4, Function, Function2, Function3, Function4, Clock, nReset, TrisPC, TrisPC2, TrisPC3, TrisPC4, TrisALU, TrisALU2, TrisALU3, TrisALU4, ENB, ENB2, ENB3, ENB4, TrisMem, TrisMem2, TrisMem3, TrisMem4, TrisRs2, TrisRs22, TrisRs23, TrisRs24, TrisRd, TrisRd2, TrisRd3, TrisRd4, nTrisRd, nTrisRd2, nTrisRd3, nTrisRd4, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadPC_5, ReadPC_6, ReadPC_7, ReadPC_8, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR0_5, ReadR0_6, ReadR0_7, ReadR0_8, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR1_5, ReadR1_6, ReadR1_7, ReadR1_8, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR2_5, ReadR2_6, ReadR2_7, ReadR2_8, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR3_5, ReadR3_6, ReadR3_7, ReadR3_8, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR4_5, ReadR4_6, ReadR4_7, ReadR4_8, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR5_5, ReadR5_6, ReadR5_7, ReadR5_8, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR6_5, ReadR6_6, ReadR6_7, ReadR6_8, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR7_5, ReadR7_6, ReadR7_7, ReadR7_8, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR8_5, ReadR8_6, ReadR8_7, ReadR8_8, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR9_5, ReadR9_6, ReadR9_7, ReadR9_8, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR10_5, ReadR10_6, ReadR10_7, ReadR10_8, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR11_5, ReadR11_6, ReadR11_7, ReadR11_8, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR12_5, ReadR12_6, ReadR12_7, ReadR12_8, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR13_5, ReadR13_6, ReadR13_7, ReadR13_8, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR14_5, ReadR14_6, ReadR14_7, ReadR14_8, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR15_5, ReadR15_6, ReadR15_7, ReadR15_8, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR16_5, ReadR16_6, ReadR16_7, ReadR16_8, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, ReadR17_5, ReadR17_6, ReadR17_7, ReadR17_8, WriteR1, WriteR1_1, WriteR1_2, WriteR1_3, WriteR2, WriteR2_1, WriteR2_2, WriteR2_3, WriteR3, WriteR3_1, WriteR3_2, WriteR3_3, WriteR4, WriteR4_1, WriteR4_2, WriteR4_3, WriteR5, WriteR5_1, WriteR5_2, WriteR5_3, WriteR6, WriteR6_1, WriteR6_2, WriteR6_3, WriteR7, WriteR7_1, WriteR7_2, WriteR7_3, WriteR8, WriteR8_1, WriteR8_2, WriteR8_3, WriteR9, WriteR9_1, WriteR9_2, WriteR9_3, WriteR10, WriteR10_1, WriteR10_2, WriteR10_3, WriteR11, WriteR11_1, WriteR11_2, WriteR11_3, WriteR12, WriteR12_1, WriteR12_2, WriteR12_3, WriteR13, WriteR13_1, WriteR13_2, WriteR13_3, WriteR14, WriteR14_1, WriteR14_2, WriteR14_3, WriteR15, WriteR15_1, WriteR15_2, WriteR15_3, WriteR16, WriteR16_1, WriteR16_2, WriteR16_3, WriteR17, WriteR17_1, WriteR17_2, WriteR17_3, PC_inc, PC_inc2, PC_inc3, PC_inc4, Rs2_sel, Rs2_sel2, Rs2_sel3, Rs2_sel4, LoadDR, LoadDR2, LoadDR3, LoadDR4, LoadPC, LoadPC2, LoadPC3, LoadPC4, state, state2, state3, state4, sub_state, sub_state2, sub_state3, sub_state4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);

input Zero, Zero2, Zero3, Zero4, Clock, nReset;
//dual core
output TrisPC, TrisPC2, TrisALU, TrisALU2, ENB, ENB2, TrisMem, TrisMem2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2;
//quad core
output TrisPC3, TrisPC4, TrisALU3, TrisALU4, ENB3, ENB4, TrisMem3, TrisMem4, TrisRs23, TrisRs24, TrisRd3, TrisRd4, nTrisRd3, nTrisRd4, nME3, nME4, nALE3, nALE4, RnW3, RnW4, nOE3, nOE4;
//dual core
output Rs2_sel, Rs2_sel2, PC_inc, PC_inc2, LoadDR, LoadDR2, LoadPC, LoadPC2;
//quad core
output Rs2_sel3, Rs2_sel4, PC_inc3, PC_inc4, LoadDR3, LoadDR4, LoadPC3, LoadPC4;
//64-bit
output ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
output ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
//dual core
output ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
output ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
//quad core
output ReadPC_5, ReadR0_5, ReadR1_5, ReadR2_5, ReadR3_5, ReadR4_5, ReadR5_5, ReadR6_5, ReadR7_5, ReadR8_5, ReadR9_5, ReadR10_5, ReadR11_5, ReadR12_5, ReadR13_5, ReadR14_5, ReadR15_5, ReadR16_5, ReadR17_5;
output ReadPC_6, ReadR0_6, ReadR1_6, ReadR2_6, ReadR3_6, ReadR4_6, ReadR5_6, ReadR6_6, ReadR7_6, ReadR8_6, ReadR9_6, ReadR10_6, ReadR11_6, ReadR12_6, ReadR13_6, ReadR14_6, ReadR15_6, ReadR16_6, ReadR17_6;
output ReadPC_7, ReadR0_7, ReadR1_7, ReadR2_7, ReadR3_7, ReadR4_7, ReadR5_7, ReadR6_7, ReadR7_7, ReadR8_7, ReadR9_7, ReadR10_7, ReadR11_7, ReadR12_7, ReadR13_7, ReadR14_7, ReadR15_7, ReadR16_7, ReadR17_7;
output ReadPC_8, ReadR0_8, ReadR1_8, ReadR2_8, ReadR3_8, ReadR4_8, ReadR5_8, ReadR6_8, ReadR7_8, ReadR8_8, ReadR9_8, ReadR10_8, ReadR11_8, ReadR12_8, ReadR13_8, ReadR14_8, ReadR15_8, ReadR16_8, ReadR17_8;
//dual core
output WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
output WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;
//quad core
output WriteR1_2, WriteR2_2, WriteR3_2, WriteR4_2, WriteR5_2, WriteR6_2, WriteR7_2, WriteR8_2, WriteR9_2, WriteR10_2, WriteR11_2, WriteR12_2, WriteR13_2, WriteR14_2, WriteR15_2, WriteR16_2, WriteR17_2;
output WriteR1_3, WriteR2_3, WriteR3_3, WriteR4_3, WriteR5_3, WriteR6_3, WriteR7_3, WriteR8_3, WriteR9_3, WriteR10_3, WriteR11_3, WriteR12_3, WriteR13_3, WriteR14_3, WriteR15_3, WriteR16_3, WriteR17_3;
//dual core
output [5:0]	Function, Function2;
//quad core
output [5:0]	Function3, Function4;
//dual core
output [1:0] state, state2, sub_state, sub_state2;
//quad core
output [1:0] state3, state4, sub_state3, sub_state4;
//dual core
inout [63:0]	Sysbus, Sysbus2;
//quad core
inout [63:0]	Sysbus3, Sysbus4;
//dual core
reg [63:0] IR;
reg [63:0] IR2;
//quad core
reg [63:0] IR3;
reg [63:0] IR4;
//dual core
wire [5:0] ALUfunc;
wire [5:0] ALUfunc2;
//quad core
wire [5:0] ALUfunc3;
wire [5:0] ALUfunc4;
//dual core
wire [17:0] Rd;
wire [17:0] Rd2;
wire [17:0] Rs1;
wire [17:0] Rs1_1;
wire [17:0] Rs2;
wire [17:0] Rs2_1;
wire [9:0] Opcode;
wire [9:0] Opcode2;
//quad core
wire [17:0] Rd3;
wire [17:0] Rd4;
wire [17:0] Rs1_2;
wire [17:0] Rs1_3;
wire [17:0] Rs2_2;
wire [17:0] Rs2_3;
wire [9:0] Opcode3;
wire [9:0] Opcode4;
//dual core
wire ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
wire ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
wire ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
wire ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
wire WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
wire WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;
//quad core
wire ReadPC_5, ReadR0_5, ReadR1_5, ReadR2_5, ReadR3_5, ReadR4_5, ReadR5_5, ReadR6_5, ReadR7_5, ReadR8_5, ReadR9_5, ReadR10_5, ReadR11_5, ReadR12_5, ReadR13_5, ReadR14_5, ReadR15_5, ReadR16_5, ReadR17_5;
wire ReadPC_6, ReadR0_6, ReadR1_6, ReadR2_6, ReadR3_6, ReadR4_6, ReadR5_6, ReadR6_6, ReadR7_6, ReadR8_6, ReadR9_6, ReadR10_6, ReadR11_6, ReadR12_6, ReadR13_6, ReadR14_6, ReadR15_6, ReadR16_6, ReadR17_6;
wire ReadPC_7, ReadR0_7, ReadR1_7, ReadR2_7, ReadR3_7, ReadR4_7, ReadR5_7, ReadR6_7, ReadR7_7, ReadR8_7, ReadR9_7, ReadR10_7, ReadR11_7, ReadR12_7, ReadR13_7, ReadR14_7, ReadR15_7, ReadR16_7, ReadR17_7;
wire ReadPC_8, ReadR0_8, ReadR1_8, ReadR2_8, ReadR3_8, ReadR4_8, ReadR5_8, ReadR6_8, ReadR7_8, ReadR8_8, ReadR9_8, ReadR10_8, ReadR11_8, ReadR12_8, ReadR13_8, ReadR14_8, ReadR15_8, ReadR16_8, ReadR17_8;
//dual core
//wire WriteR1_2, WriteR2_2, WriteR3_2, WriteR4_2, WriteR5_2, WriteR6_2, WriteR7_2, WriteR8_2, WriteR9_2, WriteR10_2, WriteR11_2, WriteR12_2, WriteR13_2, WriteR14_2, WriteR15_2, WriteR16_2, WriteR17_2;
//wire WriteR1_3, WriteR2_3, WriteR3_3, WriteR4_3, WriteR5_3, WriteR6_3, WriteR7_3, WriteR8_3, WriteR9_3, WriteR10_3, WriteR11_3, WriteR12_3, WriteR13_3, WriteR14_3, WriteR15_3, WriteR16_3, WriteR17_3;
//quad core
wire WriteR1_2, WriteR2_2, WriteR3_2, WriteR4_2, WriteR5_2, WriteR6_2, WriteR7_2, WriteR8_2, WriteR9_2, WriteR10_2, WriteR11_2, WriteR12_2, WriteR13_2, WriteR14_2, WriteR15_2, WriteR16_2, WriteR17_2;
wire WriteR1_3, WriteR2_3, WriteR3_3, WriteR4_3, WriteR5_3, WriteR6_3, WriteR7_3, WriteR8_3, WriteR9_3, WriteR10_3, WriteR11_3, WriteR12_3, WriteR13_3, WriteR14_3, WriteR15_3, WriteR16_3, WriteR17_3;
//dual core
reg [1:0] state;
reg [1:0] state2;
reg [1:0] sub_state;
reg [1:0] sub_state2;
reg zero_flag_reg, zero_flag_reg2;
wire [1:0] ModeBit;
wire [1:0] ModeBit2;
wire setbit, setbit2, testbit, testbit2;
wire TrisPC, TrisPC2, TrisALU, TrisALU2, TrisRs2, TrisRs22, Rs2_sel, Rs2_sel2, PC_inc, PC_inc2, TrisMem, TrisMem2, LoadDR, LoadDR2;
wire memory_write, memory_write2;
wire Mux1_out, Mux1_out2;
wire En_wrt_dec, En_read_dec, En_wrt_dec2, En_read_dec2;
wire LoadPC, WritePC, LoadPC2, WritePC2;
//quad core
reg [1:0] state3;
reg [1:0] state4;
reg [1:0] sub_state3;
reg [1:0] sub_state4;
reg zero_flag_reg3, zero_flag_reg4;
wire [1:0] ModeBit3;
wire [1:0] ModeBit4;
wire setbit3, setbit4, testbit3, testbit4;
wire TrisPC3, TrisPC4, TrisALU3, TrisALU4, TrisRs23, TrisRs24, Rs2_sel3, Rs2_sel4, PC_inc3, PC_inc4, TrisMem3, TrisMem4, LoadDR3, LoadDR4;
wire memory_write3, memory_write4;
wire Mux1_out3, Mux1_out4;
wire En_wrt_dec3, En_read_dec3, En_wrt_dec4, En_read_dec4;
wire LoadPC3, WritePC3, LoadPC4, WritePC4;

//quad core
output EN_ALU1,EN_ALU2,EN_ALU3,EN_ALU4;
wire EN_ALU1,EN_ALU2,EN_ALU3,EN_ALU4;

//
// Divide instruction into Opcode, Rd, Rs1, Rs2 and Immediate
//
	assign Opcode = IR[63:54];
	assign ModeBit = IR[63:62];
	assign Rd = IR[53:36];
	assign Rs1 = IR[35:18];
	assign Rs2 = IR[17:0];
	assign ALUfunc = IR[59:54];
	assign setbit = IR[61];
	assign testbit = IR[60];

	assign Opcode2 = IR2[63:54];
	assign ModeBit2 = IR2[63:62];
	assign Rd2 = IR2[53:36];
	assign Rs1_1 = IR2[35:18];
	assign Rs2_1 = IR2[17:0];
	assign ALUfunc2 = IR2[59:54];
	assign setbit2 = IR2[61];
	assign testbit2 = IR2[60];

	assign Opcode3 = IR3[63:54];
	assign ModeBit3 = IR3[63:62];
	assign Rd3 = IR3[53:36];
	assign Rs1_2 = IR3[35:18];
	assign Rs2_2 = IR3[17:0];
	assign ALUfunc3 = IR3[59:54];
	assign setbit3 = IR3[61];
	assign testbit3 = IR3[60];

	assign Opcode4 = IR4[63:54];
	assign ModeBit4 = IR4[63:62];
	assign Rd4 = IR4[53:36];
	assign Rs1_3 = IR4[35:18];
	assign Rs2_3 = IR4[17:0];
	assign ALUfunc4 = IR4[59:54];
	assign setbit4 = IR4[61];
	assign testbit4 = IR4[60];

//
//Identify memory write and generate memory control signals
//
	assign memory_write = (Opcode == `ST)&&(state == `Execute);
	assign nME = (sub_state == `address_setup)||(sub_state == `data_hold);
	assign nALE = (sub_state == `address_setup);
	assign RnW = (sub_state == `address_setup)||(sub_state == `address_hold)||~memory_write;
	assign nOE = (sub_state == `address_setup)||(sub_state == `address_hold)||memory_write;
	assign ENB = ~nOE;

	assign memory_write2 = (Opcode2 == `ST)&&(state2 == `Execute);
	assign nME2 = (sub_state2 == `address_setup)||(sub_state2 == `data_hold);
	assign nALE2 = (sub_state2 == `address_setup);
	assign RnW2 = (sub_state2 == `address_setup)||(sub_state2 == `address_hold)||~memory_write2;
	assign nOE2 = (sub_state2 == `address_setup)||(sub_state2 == `address_hold)||memory_write2;
	assign ENB2 = ~nOE2;

	assign memory_write3 = (Opcode3 == `ST)&&(state3 == `Execute);
	assign nME3 = (sub_state3 == `address_setup)||(sub_state3 == `data_hold);
	assign nALE3 = (sub_state3 == `address_setup);
	assign RnW3 = (sub_state3 == `address_setup)||(sub_state3 == `address_hold)||~memory_write3;
	assign nOE3 = (sub_state3 == `address_setup)||(sub_state3 == `address_hold)||memory_write3;
	assign ENB3 = ~nOE3;

	assign memory_write4 = (Opcode4 == `ST)&&(state4 == `Execute);
	assign nME4 = (sub_state4 == `address_setup)||(sub_state4 == `data_hold);
	assign nALE4 = (sub_state4 == `address_setup);
	assign RnW4 = (sub_state4 == `address_setup)||(sub_state4 == `address_hold)||~memory_write4;
	assign nOE4 = (sub_state4 == `address_setup)||(sub_state4 == `address_hold)||memory_write4;
	assign ENB4 = ~nOE4;

//
//Generate tri-state control signals for Sysbus
//Sysbus is driven by exactly one driver in each cycle
//
	assign TrisMem = ((sub_state == `data_setup||sub_state == `data_hold)&&(state == `Fetch1||state == `Fetch2||(state == `Execute&&(ModeBit == 2'b10||ModeBit == 2'b01))));
	assign TrisALU = (((sub_state == `address_setup)||(sub_state == `address_hold))&&(state == `Execute)&&(ModeBit == 2'b11||ModeBit == 2'b10));
	assign TrisPC = (((state == `Fetch1)||(state == `Fetch2)||(state == `Execute&&ModeBit == 2'b01))&&(sub_state == `address_setup||sub_state == `address_hold));
	assign TrisRs2 = (((sub_state == `data_setup)||(sub_state == `data_hold))&&memory_write)&&(ModeBit == 2'b11);
	assign TrisRd = ((state == `Execute)&&(sub_state == `data_setup)&&(ModeBit == 2'b10));
	assign nTrisRd = ~TrisRd;
	assign LoadPC = WritePC||PC_inc;

	assign TrisMem2 = ((sub_state2 == `data_setup||sub_state2 == `data_hold)&&(state2 == `Fetch1||state2 == `Fetch2||(state2 == `Execute&&(ModeBit2 == 2'b10||ModeBit2 == 2'b01))));
	assign TrisALU2 = (((sub_state2 == `address_setup)||(sub_state2 == `address_hold))&&(state2 == `Execute)&&(ModeBit2 == 2'b11||ModeBit2 == 2'b10));
	assign TrisPC2 = (((state2 == `Fetch1)||(state2 == `Fetch2)||(state2 == `Execute&&ModeBit2 == 2'b01))&&(sub_state2 == `address_setup||sub_state2 == `address_hold));
	assign TrisRs22 = (((sub_state2 == `data_setup)||(sub_state2 == `data_hold))&&memory_write2)&&(ModeBit2 == 2'b11);
	assign TrisRd2 = ((state2 == `Execute)&&(sub_state2 == `data_setup)&&(ModeBit2 == 2'b10));
	assign nTrisRd2 = ~TrisRd2;
	assign LoadPC2 = WritePC2||PC_inc2;

	assign TrisMem3 = ((sub_state3 == `data_setup||sub_state3 == `data_hold)&&(state3 == `Fetch1||state3 == `Fetch2||(state3 == `Execute&&(ModeBit3 == 2'b10||ModeBit3 == 2'b01))));
	assign TrisALU3 = (((sub_state3 == `address_setup)||(sub_state3 == `address_hold))&&(state3 == `Execute)&&(ModeBit3 == 2'b11||ModeBit3 == 2'b10));
	assign TrisPC3 = (((state3 == `Fetch1)||(state3 == `Fetch2)||(state3 == `Execute&&ModeBit3 == 2'b01))&&(sub_state3 == `address_setup||sub_state3 == `address_hold));
	assign TrisRs23 = (((sub_state3 == `data_setup)||(sub_state3 == `data_hold))&&memory_write3)&&(ModeBit3 == 2'b11);
	assign TrisRd3 = ((state3 == `Execute)&&(sub_state3 == `data_setup)&&(ModeBit3 == 2'b10));
	assign nTrisRd3 = ~TrisRd3;
	assign LoadPC3 = WritePC3||PC_inc3;

	assign TrisMem4 = ((sub_state4 == `data_setup||sub_state4 == `data_hold)&&(state4 == `Fetch1||state4 == `Fetch2||(state4 == `Execute&&(ModeBit4 == 2'b10||ModeBit4 == 2'b01))));
	assign TrisALU4 = (((sub_state4 == `address_setup)||(sub_state4 == `address_hold))&&(state4 == `Execute)&&(ModeBit4 == 2'b11||ModeBit4 == 2'b10));
	assign TrisPC4 = (((state4 == `Fetch1)||(state4 == `Fetch2)||(state4 == `Execute&&ModeBit4 == 2'b01))&&(sub_state4 == `address_setup||sub_state4 == `address_hold));
	assign TrisRs24 = (((sub_state4 == `data_setup)||(sub_state4 == `data_hold))&&memory_write4)&&(ModeBit4 == 2'b11);
	assign TrisRd4 = ((state4 == `Execute)&&(sub_state4 == `data_setup)&&(ModeBit4 == 2'b10));
	assign nTrisRd4 = ~TrisRd4;
	assign LoadPC4 = WritePC4||PC_inc4;


//
//Generate control signals for datapath
//
	assign En_wrt_dec = (((state == `Fetch1&&sub_state == `data_hold&&ModeBit == 2'b00)||(state == `Execute&&sub_state == `data_setup&&ModeBit == 2'b10)||(state == `Execute&&sub_state == `data_hold&&ModeBit == 2'b01))&&((zero_flag_reg&&testbit == 1'b1)||~testbit));
	assign En_wrt_dec2 = (((state2 == `Fetch1&&sub_state2 == `data_hold&&ModeBit2 == 2'b00)||(state2 == `Execute&&sub_state2 == `data_setup&&ModeBit2 == 2'b10)||(state2 == `Execute&&sub_state2 == `data_hold&&ModeBit2 == 2'b01))&&((zero_flag_reg2&&testbit2 == 1'b1)||~testbit2));	
	assign En_wrt_dec3 = (((state3 == `Fetch1&&sub_state3 == `data_hold&&ModeBit3 == 2'b00)||(state3 == `Execute&&sub_state3 == `data_setup&&ModeBit3 == 2'b10)||(state3 == `Execute&&sub_state3 == `data_hold&&ModeBit3 == 2'b01))&&((zero_flag_reg3&&testbit3 == 1'b1)||~testbit3));
	assign En_wrt_dec4 = (((state4 == `Fetch1&&sub_state4 == `data_hold&&ModeBit4 == 2'b00)||(state4 == `Execute&&sub_state4 == `data_setup&&ModeBit4 == 2'b10)||(state4 == `Execute&&sub_state4 == `data_hold&&ModeBit4 == 2'b01))&&((zero_flag_reg4&&testbit4 == 1'b1)||~testbit4));


	assign WriteR1 = (En_wrt_dec&&(Rd == 18'b000000000000000001))? 1:0;
	assign WriteR2 = (En_wrt_dec&&(Rd == 18'b000000000000000010))? 1:0;
	assign WriteR3 = (En_wrt_dec&&(Rd == 18'b000000000000000011))? 1:0;
	assign WriteR4 = (En_wrt_dec&&(Rd == 18'b000000000000000100))? 1:0;
	assign WriteR5 = (En_wrt_dec&&(Rd == 18'b000000000000000101))? 1:0;
	assign WriteR6 = (En_wrt_dec&&(Rd == 18'b000000000000000110))? 1:0;
	assign WriteR7 = (En_wrt_dec&&(Rd == 18'b000000000000000111))? 1:0;
	assign WriteR8 = (En_wrt_dec&&(Rd == 18'b000000000000001000))? 1:0;
	assign WriteR9 = (En_wrt_dec&&(Rd == 18'b000000000000001001))? 1:0;
	assign WriteR10 =(En_wrt_dec&&(Rd == 18'b000000000000001010))? 1:0;
	assign WriteR11 =(En_wrt_dec&&(Rd == 18'b000000000000001011))? 1:0;
	assign WriteR12 =(En_wrt_dec&&(Rd == 18'b000000000000001100))? 1:0;
	assign WriteR13 =(En_wrt_dec&&(Rd == 18'b000000000000001101))? 1:0;
	assign WriteR14 =(En_wrt_dec&&(Rd == 18'b000000000000001110))? 1:0;
	assign WriteR15 =(En_wrt_dec&&(Rd == 18'b000000000000001111))? 1:0;
	assign WriteR16 =(En_wrt_dec&&(Rd == 18'b000000000000010000))? 1:0;
	assign WriteR17 =(En_wrt_dec&&(Rd == 18'b000000000000010001))? 1:0;
	assign WritePC = (En_wrt_dec&&(Rd == 18'b000000000000010010))? 1:0;
	assign Mux1_out =(En_wrt_dec&&(Rd == 18'b000000000000010010))? 1:0;

	assign WriteR1_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000001))? 1:0;
	assign WriteR2_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000010))? 1:0;
	assign WriteR3_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000011))? 1:0;
	assign WriteR4_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000100))? 1:0;
	assign WriteR5_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000101))? 1:0;
	assign WriteR6_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000110))? 1:0;
	assign WriteR7_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000000111))? 1:0;
	assign WriteR8_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000001000))? 1:0;
	assign WriteR9_1 = (En_wrt_dec2&&(Rd2 == 18'b000000000000001001))? 1:0;
	assign WriteR10_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001010))? 1:0;
	assign WriteR11_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001011))? 1:0;
	assign WriteR12_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001100))? 1:0;
	assign WriteR13_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001101))? 1:0;
	assign WriteR14_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001110))? 1:0;
	assign WriteR15_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000001111))? 1:0;
	assign WriteR16_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000010000))? 1:0;
	assign WriteR17_1 =(En_wrt_dec2&&(Rd2 == 18'b000000000000010001))? 1:0;
	assign WritePC2 = (En_wrt_dec2&&(Rd2 == 18'b000000000000010010))? 1:0;
	assign Mux1_out2 =(En_wrt_dec2&&(Rd2 == 18'b000000000000010010))? 1:0;

	assign WriteR1_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000001))? 1:0;
	assign WriteR2_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000010))? 1:0;
	assign WriteR3_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000011))? 1:0;
	assign WriteR4_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000100))? 1:0;
	assign WriteR5_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000101))? 1:0;
	assign WriteR6_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000110))? 1:0;
	assign WriteR7_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000000111))? 1:0;
	assign WriteR8_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000001000))? 1:0;
	assign WriteR9_2 = (En_wrt_dec3&&(Rd3 == 18'b000000000000001001))? 1:0;
	assign WriteR10_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001010))? 1:0;
	assign WriteR11_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001011))? 1:0;
	assign WriteR12_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001100))? 1:0;
	assign WriteR13_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001101))? 1:0;
	assign WriteR14_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001110))? 1:0;
	assign WriteR15_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000001111))? 1:0;
	assign WriteR16_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000010000))? 1:0;
	assign WriteR17_2 =(En_wrt_dec3&&(Rd3 == 18'b000000000000010001))? 1:0;
	assign WritePC3 = (En_wrt_dec3&&(Rd3 == 18'b000000000000010010))? 1:0;
	assign Mux1_out3 =(En_wrt_dec3&&(Rd3 == 18'b000000000000010010))? 1:0;

	assign WriteR1_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000001))? 1:0;
	assign WriteR2_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000010))? 1:0;
	assign WriteR3_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000011))? 1:0;
	assign WriteR4_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000100))? 1:0;
	assign WriteR5_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000101))? 1:0;
	assign WriteR6_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000110))? 1:0;
	assign WriteR7_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000000111))? 1:0;
	assign WriteR8_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000001000))? 1:0;
	assign WriteR9_3 = (En_wrt_dec4&&(Rd4 == 18'b000000000000001001))? 1:0;
	assign WriteR10_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001010))? 1:0;
	assign WriteR11_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001011))? 1:0;
	assign WriteR12_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001100))? 1:0;
	assign WriteR13_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001101))? 1:0;
	assign WriteR14_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001110))? 1:0;
	assign WriteR15_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000001111))? 1:0;
	assign WriteR16_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000010000))? 1:0;
	assign WriteR17_3 =(En_wrt_dec4&&(Rd4 == 18'b000000000000010001))? 1:0;
	assign WritePC4 = (En_wrt_dec4&&(Rd4 == 18'b000000000000010010))? 1:0;
	assign Mux1_out4 =(En_wrt_dec4&&(Rd4 == 18'b000000000000010010))? 1:0;

	assign En_read_dec = ((state == `Fetch1 && ModeBit == 2'b00) || (state == `Execute && (ModeBit == 2'b01 || ModeBit == 2'b10 || ModeBit == 2'b11)) || (state == `Fetch2 && (ModeBit == 2'b11 || ModeBit == 2'b10)));
	assign En_read_dec2 = ((state2 == `Fetch1 && ModeBit2 == 2'b00) || (state2 == `Execute && (ModeBit2 == 2'b01 || ModeBit2 == 2'b10 || ModeBit2 == 2'b11)) || (state2 == `Fetch2 && (ModeBit2 == 2'b11 || ModeBit2 == 2'b10)));
	assign En_read_dec3 = ((state3 == `Fetch1 && ModeBit3 == 2'b00) || (state3 == `Execute && (ModeBit3 == 2'b01 || ModeBit3 == 2'b10 || ModeBit3 == 2'b11)) || (state3 == `Fetch2 && (ModeBit3 == 2'b11 || ModeBit3 == 2'b10)));
	assign En_read_dec4 = ((state4 == `Fetch1 && ModeBit4 == 2'b00) || (state4 == `Execute && (ModeBit4 == 2'b01 || ModeBit4 == 2'b10 || ModeBit4 == 2'b11)) || (state4 == `Fetch2 && (ModeBit4 == 2'b11 || ModeBit4 == 2'b10)));

	assign EN_ALU1 = (En_read_dec) ? 1:0;
	assign EN_ALU2 = (En_read_dec2) ? 1:0;
	assign EN_ALU3 = (En_read_dec3) ? 1:0;
	assign EN_ALU4 = (En_read_dec4) ? 1:0;

	assign ReadR0_1 = (En_read_dec&&(Rs1 == 18'b000000000000000000))? 1:0;
	assign ReadR1_1 = (En_read_dec&&(Rs1 == 18'b000000000000000001))? 1:0;
	assign ReadR2_1 = (En_read_dec&&(Rs1 == 18'b000000000000000010))? 1:0;
	assign ReadR3_1 = (En_read_dec&&(Rs1 == 18'b000000000000000011))? 1:0;
	assign ReadR4_1 = (En_read_dec&&(Rs1 == 18'b000000000000000100))? 1:0;
	assign ReadR5_1 = (En_read_dec&&(Rs1 == 18'b000000000000000101))? 1:0;
	assign ReadR6_1 = (En_read_dec&&(Rs1 == 18'b000000000000000110))? 1:0;
	assign ReadR7_1 = (En_read_dec&&(Rs1 == 18'b000000000000000111))? 1:0;
	assign ReadR8_1 = (En_read_dec&&(Rs1 == 18'b000000000000001000))? 1:0;
	assign ReadR9_1 = (En_read_dec&&(Rs1 == 18'b000000000000001001))? 1:0;
	assign ReadR10_1 =(En_read_dec&&(Rs1 == 18'b000000000000001010))? 1:0;
	assign ReadR11_1 =(En_read_dec&&(Rs1 == 18'b000000000000001011))? 1:0;
	assign ReadR12_1 =(En_read_dec&&(Rs1 == 18'b000000000000001100))? 1:0;
	assign ReadR13_1 =(En_read_dec&&(Rs1 == 18'b000000000000001101))? 1:0;
	assign ReadR14_1 =(En_read_dec&&(Rs1 == 18'b000000000000001110))? 1:0;
	assign ReadR15_1 =(En_read_dec&&(Rs1 == 18'b000000000000001111))? 1:0;
	assign ReadR16_1 =(En_read_dec&&(Rs1 == 18'b000000000000010000))? 1:0;
	assign ReadR17_1 =(En_read_dec&&(Rs1 == 18'b000000000000010001))? 1:0;
	assign ReadPC_1 = (En_read_dec&&(Rs1 == 18'b000000000000010010))? 1:0;

	assign ReadR0_2 = (En_read_dec&&(Rs2 == 18'b000000000000000000))? 1:0;
	assign ReadR1_2 = (En_read_dec&&(Rs2 == 18'b000000000000000001))? 1:0;
	assign ReadR2_2 = (En_read_dec&&(Rs2 == 18'b000000000000000010))? 1:0;
	assign ReadR3_2 = (En_read_dec&&(Rs2 == 18'b000000000000000011))? 1:0;
	assign ReadR4_2 = (En_read_dec&&(Rs2 == 18'b000000000000000100))? 1:0;
	assign ReadR5_2 = (En_read_dec&&(Rs2 == 18'b000000000000000101))? 1:0;
	assign ReadR6_2 = (En_read_dec&&(Rs2 == 18'b000000000000000110))? 1:0;
	assign ReadR7_2 = (En_read_dec&&(Rs2 == 18'b000000000000000111))? 1:0;
	assign ReadR8_2 = (En_read_dec&&(Rs2 == 18'b000000000000001000))? 1:0;
	assign ReadR9_2 = (En_read_dec&&(Rs2 == 18'b000000000000001001))? 1:0;
	assign ReadR10_2 =(En_read_dec&&(Rs2 == 18'b000000000000001010))? 1:0;
	assign ReadR11_2 =(En_read_dec&&(Rs2 == 18'b000000000000001011))? 1:0;
	assign ReadR12_2 =(En_read_dec&&(Rs2 == 18'b000000000000001100))? 1:0;
	assign ReadR13_2 =(En_read_dec&&(Rs2 == 18'b000000000000001101))? 1:0;
	assign ReadR14_2 =(En_read_dec&&(Rs2 == 18'b000000000000001110))? 1:0;
	assign ReadR15_2 =(En_read_dec&&(Rs2 == 18'b000000000000001111))? 1:0;
	assign ReadR16_2 =(En_read_dec&&(Rs2 == 18'b000000000000010000))? 1:0;
	assign ReadR17_2 =(En_read_dec&&(Rs2 == 18'b000000000000010001))? 1:0;
	assign ReadPC_2 = (En_read_dec&&(Rs2 == 18'b000000000000010010))? 1:0;

	assign ReadR0_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000000))? 1:0;
	assign ReadR1_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000001))? 1:0;
	assign ReadR2_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000010))? 1:0;
	assign ReadR3_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000011))? 1:0;
	assign ReadR4_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000100))? 1:0;
	assign ReadR5_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000101))? 1:0;
	assign ReadR6_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000110))? 1:0;
	assign ReadR7_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000000111))? 1:0;
	assign ReadR8_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000001000))? 1:0;
	assign ReadR9_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000001001))? 1:0;
	assign ReadR10_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001010))? 1:0;
	assign ReadR11_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001011))? 1:0;
	assign ReadR12_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001100))? 1:0;
	assign ReadR13_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001101))? 1:0;
	assign ReadR14_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001110))? 1:0;
	assign ReadR15_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000001111))? 1:0;
	assign ReadR16_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000010000))? 1:0;
	assign ReadR17_3 =(En_read_dec2&&(Rs1_1 == 18'b000000000000010001))? 1:0;
	assign ReadPC_3 = (En_read_dec2&&(Rs1_1 == 18'b000000000000010010))? 1:0;

	assign ReadR0_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000000))? 1:0;
	assign ReadR1_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000001))? 1:0;
	assign ReadR2_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000010))? 1:0;
	assign ReadR3_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000011))? 1:0;
	assign ReadR4_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000100))? 1:0;
	assign ReadR5_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000101))? 1:0;
	assign ReadR6_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000110))? 1:0;
	assign ReadR7_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000000111))? 1:0;
	assign ReadR8_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000001000))? 1:0;
	assign ReadR9_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000001001))? 1:0;
	assign ReadR10_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001010))? 1:0;
	assign ReadR11_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001011))? 1:0;
	assign ReadR12_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001100))? 1:0;
	assign ReadR13_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001101))? 1:0;
	assign ReadR14_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001110))? 1:0;
	assign ReadR15_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000001111))? 1:0;
	assign ReadR16_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000010000))? 1:0;
	assign ReadR17_4 =(En_read_dec2&&(Rs2_1 == 18'b000000000000010001))? 1:0;
	assign ReadPC_4 = (En_read_dec2&&(Rs2_1 == 18'b000000000000010010))? 1:0;

	assign ReadR0_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000000))? 1:0;
	assign ReadR1_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000001))? 1:0;
	assign ReadR2_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000010))? 1:0;
	assign ReadR3_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000011))? 1:0;
	assign ReadR4_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000100))? 1:0;
	assign ReadR5_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000101))? 1:0;
	assign ReadR6_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000110))? 1:0;
	assign ReadR7_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000000111))? 1:0;
	assign ReadR8_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000001000))? 1:0;
	assign ReadR9_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000001001))? 1:0;
	assign ReadR10_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001010))? 1:0;
	assign ReadR11_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001011))? 1:0;
	assign ReadR12_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001100))? 1:0;
	assign ReadR13_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001101))? 1:0;
	assign ReadR14_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001110))? 1:0;
	assign ReadR15_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000001111))? 1:0;
	assign ReadR16_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000010000))? 1:0;
	assign ReadR17_5 =(En_read_dec3&&(Rs1_2 == 18'b000000000000010001))? 1:0;
	assign ReadPC_5 = (En_read_dec3&&(Rs1_2 == 18'b000000000000010010))? 1:0;

	assign ReadR0_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000000))? 1:0;
	assign ReadR1_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000001))? 1:0;
	assign ReadR2_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000010))? 1:0;
	assign ReadR3_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000011))? 1:0;
	assign ReadR4_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000100))? 1:0;
	assign ReadR5_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000101))? 1:0;
	assign ReadR6_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000110))? 1:0;
	assign ReadR7_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000000111))? 1:0;
	assign ReadR8_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000001000))? 1:0;
	assign ReadR9_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000001001))? 1:0;
	assign ReadR10_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001010))? 1:0;
	assign ReadR11_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001011))? 1:0;
	assign ReadR12_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001100))? 1:0;
	assign ReadR13_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001101))? 1:0;
	assign ReadR14_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001110))? 1:0;
	assign ReadR15_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000001111))? 1:0;
	assign ReadR16_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000010000))? 1:0;
	assign ReadR17_6 =(En_read_dec3&&(Rs2_2 == 18'b000000000000010001))? 1:0;
	assign ReadPC_6 = (En_read_dec3&&(Rs2_2 == 18'b000000000000010010))? 1:0;

	assign ReadR0_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000000))? 1:0;
	assign ReadR1_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000001))? 1:0;
	assign ReadR2_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000010))? 1:0;
	assign ReadR3_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000011))? 1:0;
	assign ReadR4_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000100))? 1:0;
	assign ReadR5_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000101))? 1:0;
	assign ReadR6_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000110))? 1:0;
	assign ReadR7_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000000111))? 1:0;
	assign ReadR8_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000001000))? 1:0;
	assign ReadR9_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000001001))? 1:0;
	assign ReadR10_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001010))? 1:0;
	assign ReadR11_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001011))? 1:0;
	assign ReadR12_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001100))? 1:0;
	assign ReadR13_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001101))? 1:0;
	assign ReadR14_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001110))? 1:0;
	assign ReadR15_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000001111))? 1:0;
	assign ReadR16_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000010000))? 1:0;
	assign ReadR17_7 =(En_read_dec4&&(Rs1_3 == 18'b000000000000010001))? 1:0;
	assign ReadPC_7 = (En_read_dec4&&(Rs1_3 == 18'b000000000000010010))? 1:0;

	assign ReadR0_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000000))? 1:0;
	assign ReadR1_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000001))? 1:0;
	assign ReadR2_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000010))? 1:0;
	assign ReadR3_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000011))? 1:0;
	assign ReadR4_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000100))? 1:0;
	assign ReadR5_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000101))? 1:0;
	assign ReadR6_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000110))? 1:0;
	assign ReadR7_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000000111))? 1:0;
	assign ReadR8_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000001000))? 1:0;
	assign ReadR9_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000001001))? 1:0;
	assign ReadR10_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001010))? 1:0;
	assign ReadR11_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001011))? 1:0;
	assign ReadR12_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001100))? 1:0;
	assign ReadR13_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001101))? 1:0;
	assign ReadR14_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001110))? 1:0;
	assign ReadR15_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000001111))? 1:0;
	assign ReadR16_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000010000))? 1:0;
	assign ReadR17_8 =(En_read_dec4&&(Rs2_3 == 18'b000000000000010001))? 1:0;
	assign ReadPC_8 = (En_read_dec4&&(Rs2_3 == 18'b000000000000010010))? 1:0;

	assign Rs2_sel = ~((( sub_state == `address_setup || sub_state == `address_hold ) && ( state == `Execute && ( ModeBit == 2'b11 || ModeBit == 2'b10))) || ( sub_state == `data_hold && ((state == `Execute && ModeBit == 2'b01) || state == `Fetch2 )));
	assign Rs2_sel2 = ~((( sub_state2 == `address_setup || sub_state2 == `address_hold ) && ( state2 == `Execute && ( ModeBit2 == 2'b11 || ModeBit2 == 2'b10))) || ( sub_state2 == `data_hold && ((state2 == `Execute && ModeBit2 == 2'b01) || state2 == `Fetch2 )));
	assign Rs2_sel3 = ~((( sub_state3 == `address_setup || sub_state3 == `address_hold ) && ( state3 == `Execute && ( ModeBit3 == 2'b11 || ModeBit3 == 2'b10))) || ( sub_state3 == `data_hold && ((state3 == `Execute && ModeBit3 == 2'b01) || state3 == `Fetch2 )));
	assign Rs2_sel4 = ~((( sub_state4 == `address_setup || sub_state4 == `address_hold ) && ( state4 == `Execute && ( ModeBit4 == 2'b11 || ModeBit4 == 2'b10))) || ( sub_state4 == `data_hold && ((state4 == `Execute && ModeBit4 == 2'b01) || state4 == `Fetch2 )));

	assign PC_inc = ((sub_state == `address_hold ) && (( state == `Fetch1 ) || ( state == `Fetch2 ) || (state == `Execute && ModeBit == 2'b01 ) ));
	assign PC_inc2 = ((sub_state2 == `address_hold ) && (( state2 == `Fetch1 ) || ( state2 == `Fetch2 ) || (state2 == `Execute && ModeBit2 == 2'b01 ) ));
	assign PC_inc3 = ((sub_state3 == `address_hold ) && (( state3 == `Fetch1 ) || ( state3 == `Fetch2 ) || (state3 == `Execute && ModeBit3 == 2'b01 ) ));
	assign PC_inc4 = ((sub_state4 == `address_hold ) && (( state4 == `Fetch1 ) || ( state4 == `Fetch2 ) || (state4 == `Execute && ModeBit4 == 2'b01 ) ));
	
	assign LoadDR = (( state == `Fetch2 ) && ( sub_state == `data_setup)) || (( state == `Execute ) && ( sub_state == `data_setup) && (ModeBit == 2'b01));
	assign LoadDR2 = (( state2 == `Fetch2 ) && ( sub_state2 == `data_setup)) || (( state2 == `Execute ) && ( sub_state2 == `data_setup) && (ModeBit2 == 2'b01));
	assign LoadDR3 = (( state3 == `Fetch2 ) && ( sub_state3 == `data_setup)) || (( state3 == `Execute ) && ( sub_state3 == `data_setup) && (ModeBit3 == 2'b01));
	assign LoadDR4 = (( state4 == `Fetch2 ) && ( sub_state4 == `data_setup)) || (( state4 == `Execute ) && ( sub_state4 == `data_setup) && (ModeBit4 == 2'b01));
//
//Generate ALU control
//
	assign Function = ALUfunc;
	assign Function2 = ALUfunc2;
	assign Function3 = ALUfunc3;
	assign Function4 = ALUfunc4;

//
//Conditional instruction
	
	always@(posedge Clock)
	begin
		if ((((state == `Execute && ModeBit == 2'b01) && sub_state == `data_hold) || (state == `Fetch1 && ModeBit == 2'b00 && sub_state == `data_setup)) && setbit == 1'b1)
		zero_flag_reg <= Zero;
		if ((((state2 == `Execute && ModeBit2 == 2'b01) && sub_state2 == `data_hold) || (state2 == `Fetch1 && ModeBit2 == 2'b00 && sub_state2 == `data_setup)) && setbit2 == 1'b1)
		zero_flag_reg2 <= Zero2;
		if ((((state3 == `Execute && ModeBit3 == 2'b01) && sub_state3 == `data_hold) || (state3 == `Fetch1 && ModeBit3 == 2'b00 && sub_state3 == `data_setup)) && setbit3 == 1'b1)
		zero_flag_reg3 <= Zero3;
		if ((((state4 == `Execute && ModeBit4 == 2'b01) && sub_state4 == `data_hold) || (state4 == `Fetch1 && ModeBit4 == 2'b00 && sub_state4 == `data_setup)) && setbit4 == 1'b1)
		zero_flag_reg4 <= Zero4;
	end

//All instructions complete in exactly 12 clock cycles
//state is Fetch1 (R+R), Fetch2(R+I) & Execute(L/S)

//sub_state controls memory cycle
//
	always@(posedge Clock)
	begin
		if (nReset == 0)
		begin
		state <= 64'bz;
		state2 <= 64'bz;
		state3 <= 64'bz;
		state4 <= 64'bz;
		end
		else
		begin
			case (state)
			0:	if (sub_state == `data_hold && (ModeBit == 2'b00)) state <= #20 0;
				else if (sub_state == `data_hold && ModeBit == 2'b01) state <=#20 1;
				else if (sub_state == `data_hold && ((ModeBit == 2'b10) || (ModeBit == 2'b11))) state<= #20 3;
				else if (ModeBit == 2'b01 || ModeBit == 2'b00) state <= #20 0;
			3:	if (sub_state == `data_hold && ((ModeBit == 2'b10) || (ModeBit == 2'b11))) state <= #20 1;
				else if (ModeBit == 2'b10 || ModeBit == 2'b11) state <= #20 3;
			1:	if (sub_state == `data_hold) state <= #20 0;
				else state <= #20 1;
			endcase
		sub_state[0] <= #20 ~sub_state[1];
		sub_state[1] <= #20 sub_state[0];

			case (state2)
			0:	if (sub_state2 == `data_hold && (ModeBit2 == 2'b00)) state2 <= #20 0;
				else if (sub_state2 == `data_hold && ModeBit2 == 2'b01) state2 <=#20 1;
				else if (sub_state2 == `data_hold && ((ModeBit2 == 2'b10) || (ModeBit2 == 2'b11))) state2 <= #20 3;
				else if (ModeBit2 == 2'b01 || ModeBit2 == 2'b00) state2 <= #20 0;
			3:	if (sub_state2 == `data_hold && ((ModeBit2 == 2'b10) || (ModeBit2 == 2'b11))) state2 <= #20 1;
				else if (ModeBit2 == 2'b10 || ModeBit2 == 2'b11) state2 <= #20 3;
			1:	if (sub_state2 == `data_hold) state2 <= #20 0;
				else state2 <= #20 1;
			endcase
		sub_state2[0] <= #20 ~sub_state2[1];
		sub_state2[1] <= #20 sub_state2[0];

			case (state3)
			0:	if (sub_state3 == `data_hold && (ModeBit3 == 2'b00)) state3 <= #20 0;
				else if (sub_state3 == `data_hold && ModeBit3 == 2'b01) state3 <=#20 1;
				else if (sub_state3 == `data_hold && ((ModeBit3 == 2'b10) || (ModeBit3 == 2'b11))) state3 <= #20 3;
				else if (ModeBit3 == 2'b01 || ModeBit3 == 2'b00) state3 <= #20 0;
			3:	if (sub_state3 == `data_hold && ((ModeBit3 == 2'b10) || (ModeBit3 == 2'b11))) state3 <= #20 1;
				else if (ModeBit3 == 2'b10 || ModeBit3 == 2'b11) state3 <= #20 3;
			1:	if (sub_state3 == `data_hold) state3 <= #20 0;
				else state3 <= #20 1;
			endcase
		sub_state3[0] <= #20 ~sub_state3[1];
		sub_state3[1] <= #20 sub_state3[0];

			case (state4)
			0:	if (sub_state4 == `data_hold && (ModeBit4 == 2'b00)) state4 <= #20 0;
				else if (sub_state4 == `data_hold && ModeBit4 == 2'b01) state4 <=#20 1;
				else if (sub_state4 == `data_hold && ((ModeBit4 == 2'b10) || (ModeBit4 == 2'b11))) state4 <= #20 3;
				else if (ModeBit4 == 2'b01 || ModeBit4 == 2'b00) state4 <= #20 0;
			3:	if (sub_state4 == `data_hold && ((ModeBit4 == 2'b10) || (ModeBit4 == 2'b11))) state4 <= #20 1;
				else if (ModeBit4 == 2'b10 || ModeBit4 == 2'b11) state4 <= #20 3;
			1:	if (sub_state4 == `data_hold) state4 <= #20 0;
				else state4 <= #20 1;
			endcase
		sub_state4[0] <= #20 ~sub_state4[1];
		sub_state4[1] <= #20 sub_state4[0];
		end
	end

//
//Update IR as required
//
	always@(posedge Clock)
	begin
		if((state == `Fetch1) && (sub_state == `data_setup))
		IR <= #20 Sysbus;
		if((state2 == `Fetch1) && (sub_state2 == `data_setup))
		IR2 <= #20 Sysbus2;
		if((state3 == `Fetch1) && (sub_state3 == `data_setup))
		IR3 <= #20 Sysbus3;
		if((state4 == `Fetch1) && (sub_state4 == `data_setup))
		IR4 <= #20 Sysbus4;
	end

//
//Asynchronous reset
//
//
	always@(nReset)
	
		if(!nReset)
		begin
			assign state = 0;
			assign sub_state = 0;
			assign IR = 0;
			assign zero_flag_reg = 0;
			assign state2 = 0;
			assign sub_state2 = 0;
			assign IR2 = 0;
			assign zero_flag_reg2 = 0;
			assign state3 = 0;
			assign sub_state3 = 0;
			assign IR3 = 0;
			assign zero_flag_reg3 = 0;
			assign state4 = 0;
			assign sub_state4 = 0;
			assign IR4 = 0;
			assign zero_flag_reg4 = 0;
		end
		else
		begin
			deassign state;
			deassign sub_state;
			deassign IR;
			deassign zero_flag_reg;
			deassign state2;
			deassign sub_state2;
			deassign IR2;
			deassign zero_flag_reg2;
			deassign state3;
			deassign sub_state3;
			deassign IR3;
			deassign zero_flag_reg3;
			deassign state4;
			deassign sub_state4;
			deassign IR4;
			deassign zero_flag_reg4;
		end
	
endmodule
























