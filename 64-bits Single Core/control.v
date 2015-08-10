`include "opcodes.v"
`timescale	100ps/10ps

`define	Fetch1	0
`define Execute	1
`define	Fetch2	3

`define address_setup	0
`define address_hold	1
`define	data_setup	3
`define	data_hold	2


module control(Sysbus, nOE, RnW, nME, nALE, Zero, Function, Clock, nReset, TrisPC, TrisALU, ENB, TrisMem, TrisRs2, TrisRd, nTrisRd, ReadPC_1, ReadPC_2, ReadR0_1, ReadR0_2, ReadR1_1, ReadR1_2, ReadR2_1, ReadR2_2, ReadR3_1, ReadR3_2, ReadR4_1, ReadR4_2, ReadR5_1, ReadR5_2, ReadR6_1, ReadR6_2, ReadR7_1, ReadR7_2, ReadR8_1, ReadR8_2, ReadR9_1, ReadR9_2, ReadR10_1, ReadR10_2, ReadR11_1, ReadR11_2, ReadR12_1, ReadR12_2, ReadR13_1, ReadR13_2, ReadR14_1, ReadR14_2, ReadR15_1, ReadR15_2, ReadR16_1, ReadR16_2, ReadR17_1, ReadR17_2, WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17, PC_inc, Rs2_sel, LoadDR, LoadPC);
input Zero, Clock, nReset;
output TrisPC, TrisALU, ENB, TrisMem, TrisRs2, TrisRd, nTrisRd, nME, nALE, RnW, nOE;
output Rs2_sel, PC_inc, LoadDR, LoadPC;

//64-bit
output ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
output ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
output WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;
output [5:0]	Function;
inout [63:0]	Sysbus;
reg [63:0] IR;
wire [5:0] ALUfunc;
wire [17:0] Rd;
wire [17:0] Rs1;
wire [17:0] Rs2;
wire [9:0] Opcode;
wire ReadPC_1, ReadR0_1, ReadR1_1, ReadR2_1, ReadR3_1, ReadR4_1, ReadR5_1, ReadR6_1, ReadR7_1, ReadR8_1, ReadR9_1, ReadR10_1, ReadR11_1, ReadR12_1, ReadR13_1, ReadR14_1, ReadR15_1, ReadR16_1, ReadR17_1;
wire ReadPC_2, ReadR0_2, ReadR1_2, ReadR2_2, ReadR3_2, ReadR4_2, ReadR5_2, ReadR6_2, ReadR7_2, ReadR8_2, ReadR9_2, ReadR10_2, ReadR11_2, ReadR12_2, ReadR13_2, ReadR14_2, ReadR15_2, ReadR16_2, ReadR17_2;
wire WriteR1, WriteR2, WriteR3, WriteR4, WriteR5, WriteR6, WriteR7, WriteR8, WriteR9, WriteR10, WriteR11, WriteR12, WriteR13, WriteR14, WriteR15, WriteR16, WriteR17;

reg [1:0] state;
reg [1:0] sub_state;
reg zero_flag_reg;
wire [1:0] ModeBit;
wire setbit, testbit;
wire TrisPC, TrisALU, TrisRs2, Rs2_sel, PC_inc, TrisMem, LoadDR;
wire memory_write;
wire Mux1_out;
wire En_wrt_dec, En_read_dec;
wire LoadPC, WritePC;

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

//
//Identify memory write and generate memory control signals
//
	assign memory_write = (Opcode == `ST)&&(state == `Execute);
	assign nME = (sub_state == `address_setup)||(sub_state == `data_hold);
	assign nALE = (sub_state == `address_setup);
	assign RnW = (sub_state == `address_setup)||(sub_state == `address_hold)||~memory_write;
	assign nOE = (sub_state == `address_setup)||(sub_state == `address_hold)||memory_write;
	assign ENB = ~nOE;

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

//
//Generate control signals for datapath
//
	assign En_wrt_dec = (((state == `Fetch1&&sub_state == `data_hold&&ModeBit == 2'b00)||(state == `Execute&&sub_state == `data_setup&&ModeBit == 2'b10)||(state == `Execute&&sub_state == `data_hold&&ModeBit == 2'b01))&&((zero_flag_reg&&testbit == 1'b1)||~testbit));
	
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

	assign En_read_dec = ((state == `Fetch1 && ModeBit == 2'b00) || (state == `Execute && (ModeBit == 2'b01 || ModeBit == 2'b10 || ModeBit == 2'b11)) || (state == `Fetch2 && (ModeBit == 2'b11 || ModeBit == 2'b10)));
	
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

	assign Rs2_sel = ~((( sub_state == `address_setup || sub_state == `address_hold ) && ( state == `Execute && ( ModeBit == 2'b11 || ModeBit == 2'b10))) || ( sub_state == `data_hold && ((state == `Execute && ModeBit == 2'b01) || state == `Fetch2 )));

	assign PC_inc = ((sub_state == `address_hold ) && (( state == `Fetch1 ) || ( state == `Fetch2 ) || (state == `Execute && ModeBit == 2'b01 ) ));
	
	assign LoadDR = (( state == `Fetch2 ) && ( sub_state == `data_setup)) || (( state == `Execute ) && ( sub_state == `data_setup) && (ModeBit == 2'b01));

//
//Generate ALU control
//
	assign Function = ALUfunc;

//
//Conditional instruction
	
	always@(posedge Clock)
	begin
		if ((((state == `Execute && ModeBit == 2'b01) && sub_state == `data_hold) || (state == `Fetch1 && ModeBit == 2'b00 && sub_state == `data_setup)) && setbit == 1'b1)
		zero_flag_reg <= Zero;
	end

//All instructions complete in exactly 12 clock cycles
//state is Fetch1 (R+R), Fetch2(R+I) & Execute(L/S)

//sub_state controls memory cycle
//
	always@(posedge Clock)
	begin
		if (nReset == 0)
		state <= 64'bz;
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
		end
	end

//
//Update IR as required
//
	always@(posedge Clock)
	begin
		if((state == `Fetch1) && (sub_state == `data_setup))
		IR <= #20 Sysbus;
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
		end
		else
		begin
			deassign state;
			deassign sub_state;
			deassign IR;
			deassign zero_flag_reg;
		end
	
endmodule
























