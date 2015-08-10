`include "opcodes.v"
`timescale	100ps/10ps

`define	Fetch1	0
`define Execute	1
`define	Fetch2	3

`define address_setup	0
`define address_hold	1
`define	data_setup	3
`define	data_hold	2


module control(Sysbus, Sysbus2, nOE, nOE2, RnW, RnW2, nME, nME2, nALE, nALE2, Zero, Zero2, Function, Function2, Clock, nReset, TrisPC, TrisPC2, TrisALU, TrisALU2, ENB, ENB2, TrisMem, TrisMem2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, ReadPC_1, ReadPC_2, ReadPC_3, ReadPC_4, ReadR0_1, ReadR0_2, ReadR0_3, ReadR0_4, ReadR1_1, ReadR1_2, ReadR1_3, ReadR1_4, ReadR2_1, ReadR2_2, ReadR2_3, ReadR2_4, ReadR3_1, ReadR3_2, ReadR3_3, ReadR3_4, ReadR4_1, ReadR4_2, ReadR4_3, ReadR4_4, ReadR5_1, ReadR5_2, ReadR5_3, ReadR5_4, ReadR6_1, ReadR6_2, ReadR6_3, ReadR6_4, ReadR7_1, ReadR7_2, ReadR7_3, ReadR7_4, ReadR8_1, ReadR8_2, ReadR8_3, ReadR8_4, ReadR9_1, ReadR9_2, ReadR9_3, ReadR9_4, ReadR10_1, ReadR10_2, ReadR10_3, ReadR10_4, ReadR11_1, ReadR11_2, ReadR11_3, ReadR11_4, ReadR12_1, ReadR12_2, ReadR12_3, ReadR12_4, ReadR13_1, ReadR13_2, ReadR13_3, ReadR13_4, ReadR14_1, ReadR14_2, ReadR14_3, ReadR14_4, ReadR15_1, ReadR15_2, ReadR15_3, ReadR15_4, ReadR16_1, ReadR16_2, ReadR16_3, ReadR16_4, ReadR17_1, ReadR17_2, ReadR17_3, ReadR17_4, WriteR1, WriteR1_1, WriteR2, WriteR2_1, WriteR3, WriteR3_1, WriteR4, WriteR4_1, WriteR5, WriteR5_1, WriteR6, WriteR6_1, WriteR7, WriteR7_1, WriteR8, WriteR8_1, WriteR9, WriteR9_1, WriteR10, WriteR10_1, WriteR11, WriteR11_1, WriteR12, WriteR12_1, WriteR13, WriteR13_1, WriteR14, WriteR14_1, WriteR15, WriteR15_1, WriteR16, WriteR16_1, WriteR17, WriteR17_1, PC_inc, PC_inc2, Rs2_sel, Rs2_sel2, LoadDR, LoadDR2, LoadPC, LoadPC2, state, state2, sub_state, sub_state2);

input Zero, Zero2, Clock, nReset;
output TrisPC, TrisPC2, TrisALU, TrisALU2, ENB, ENB2, TrisMem, TrisMem2, TrisRs2, TrisRs22, TrisRd, TrisRd2, nTrisRd, nTrisRd2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2;
output Rs2_sel, Rs2_sel2, PC_inc, PC_inc2, LoadDR, LoadDR2, LoadPC, LoadPC2;

//64-bit
output ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
output ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
output ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
output ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
output WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
output WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;
output [5:0]	Function, Function2;
output [1:0] state, state2, sub_state, sub_state2;
inout [63:0]	Sysbus, Sysbus2;
reg [63:0] IR;
reg [63:0] IR2;
wire [5:0] ALUfunc;
wire [5:0] ALUfunc2;
wire [17:0] Rd;
wire [17:0] Rd2;
wire [17:0] Rs1;
wire [17:0] Rs1_1;
wire [17:0] Rs2;
wire [17:0] Rs2_1;
wire [9:0] Opcode;
wire [9:0] Opcode2;
wire ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
wire ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
wire ReadPC_3, ReadR0_3, ReadR1_3, ReadR2_3, ReadR3_3, ReadR4_3, ReadR5_3, ReadR6_3, ReadR7_3, ReadR8_3, ReadR9_3, ReadR10_3, ReadR11_3, ReadR12_3, ReadR13_3, ReadR14_3, ReadR15_3, ReadR16_3, ReadR17_3;
wire ReadPC_4, ReadR0_4, ReadR1_4, ReadR2_4, ReadR3_4, ReadR4_4, ReadR5_4, ReadR6_4, ReadR7_4, ReadR8_4, ReadR9_4, ReadR10_4, ReadR11_4, ReadR12_4, ReadR13_4, ReadR14_4, ReadR15_4, ReadR16_4, ReadR17_4;
wire WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
wire WriteR1_1, WriteR2_1, WriteR3_1, WriteR4_1, WriteR5_1, WriteR6_1, WriteR7_1, WriteR8_1, WriteR9_1, WriteR10_1, WriteR11_1, WriteR12_1, WriteR13_1, WriteR14_1, WriteR15_1, WriteR16_1, WriteR17_1;

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

//
//Generate control signals for datapath
//
	assign En_wrt_dec = (((state == `Fetch1&&sub_state == `data_hold&&ModeBit == 2'b00)||(state == `Execute&&sub_state == `data_setup&&ModeBit == 2'b10)||(state == `Execute&&sub_state == `data_hold&&ModeBit == 2'b01))&&((zero_flag_reg&&testbit == 1'b1)||~testbit));
	assign En_wrt_dec2 = (((state2 == `Fetch1&&sub_state2 == `data_hold&&ModeBit2 == 2'b00)||(state2 == `Execute&&sub_state2 == `data_setup&&ModeBit2 == 2'b10)||(state2 == `Execute&&sub_state2 == `data_hold&&ModeBit2 == 2'b01))&&((zero_flag_reg2&&testbit2 == 1'b1)||~testbit2));	

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

	assign En_read_dec = ((state == `Fetch1 && ModeBit == 2'b00) || (state == `Execute && (ModeBit == 2'b01 || ModeBit == 2'b10 || ModeBit == 2'b11)) || (state == `Fetch2 && (ModeBit == 2'b11 || ModeBit == 2'b10)));
	assign En_read_dec2 = ((state2 == `Fetch1 && ModeBit2 == 2'b00) || (state2 == `Execute && (ModeBit2 == 2'b01 || ModeBit2 == 2'b10 || ModeBit2 == 2'b11)) || (state2 == `Fetch2 && (ModeBit2 == 2'b11 || ModeBit2 == 2'b10)));
	
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


	assign Rs2_sel = ~((( sub_state == `address_setup || sub_state == `address_hold ) && ( state == `Execute && ( ModeBit == 2'b11 || ModeBit == 2'b10))) || ( sub_state == `data_hold && ((state == `Execute && ModeBit == 2'b01) || state == `Fetch2 )));
	assign Rs2_sel2 = ~((( sub_state2 == `address_setup || sub_state2 == `address_hold ) && ( state2 == `Execute && ( ModeBit2 == 2'b11 || ModeBit2 == 2'b10))) || ( sub_state2 == `data_hold && ((state2 == `Execute && ModeBit2 == 2'b01) || state2 == `Fetch2 )));

	assign PC_inc = ((sub_state == `address_hold ) && (( state == `Fetch1 ) || ( state == `Fetch2 ) || (state == `Execute && ModeBit == 2'b01 ) ));
	assign PC_inc2 = ((sub_state2 == `address_hold ) && (( state2 == `Fetch1 ) || ( state2 == `Fetch2 ) || (state2 == `Execute && ModeBit2 == 2'b01 ) ));
	
	assign LoadDR = (( state == `Fetch2 ) && ( sub_state == `data_setup)) || (( state == `Execute ) && ( sub_state == `data_setup) && (ModeBit == 2'b01));
	assign LoadDR2 = (( state2 == `Fetch2 ) && ( sub_state2 == `data_setup)) || (( state2 == `Execute ) && ( sub_state2 == `data_setup) && (ModeBit2 == 2'b01));

//
//Generate ALU control
//
	assign Function = ALUfunc;
	assign Function2 = ALUfunc2;

//
//Conditional instruction
	
	always@(posedge Clock)
	begin
		if ((((state == `Execute && ModeBit == 2'b01) && sub_state == `data_hold) || (state == `Fetch1 && ModeBit == 2'b00 && sub_state == `data_setup)) && setbit == 1'b1)
		zero_flag_reg <= Zero;
		if ((((state2 == `Execute && ModeBit2 == 2'b01) && sub_state2 == `data_hold) || (state2 == `Fetch1 && ModeBit2 == 2'b00 && sub_state2 == `data_setup)) && setbit2 == 1'b1)
		zero_flag_reg2 <= Zero2;
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
		end
	
endmodule
























