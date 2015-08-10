`include "opcodes.v"
`timescale 100ps / 10ps

module rom( Data_bus, Address_bus, Address_bus2, notOE, notOE2, notCE );

output [127:0] Data_bus;
input [53:0] Address_bus;
input [53:0] Address_bus2;
input notOE, notOE2, notCE;

specify
  specparam tViolate=250;
  $width(negedge notCE, tViolate);
  $width(posedge notCE, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus2, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE2, tViolate, tViolate);
endspecify


reg [127:0] Data_stored [ 4095 :0 ];

assign Data_bus = ((notOE == 0) && (notCE == 0)) ?Data_stored [Address_bus] : 128'bz;
assign Data_bus = ((notOE2 == 0) && (notCE == 0)) ?Data_stored [Address_bus2] : 128'bz;

initial
  begin
        Data_stored[0] = {`ADDi, `R1, `R0, `R0,`ADDi, `R1_1, `R0_1, `R0_1};
	Data_stored[1] = {64'd1, 64'd17};
	Data_stored[2] = {`ADDi, `R2, `R0, `R0,`ADDi, `R2_1, `R0_1, `R0_1};
	Data_stored[3] = {64'd2, 64'd16};
	Data_stored[4] = {`ADDi, `R3, `R0, `R0,`ADDi, `R3_1, `R0_1, `R0_1};
	Data_stored[5] = {64'd3, 64'd15};
	Data_stored[6] = {`ADDi, `R4, `R0, `R0,`ADDi, `R4_1, `R0_1, `R0_1};
	Data_stored[7] = {64'd4, 64'd14};
	Data_stored[8] = {`ADDi, `R5, `R0, `R0,`ADDi, `R5_1, `R0_1, `R0_1};
	Data_stored[9] = {64'd5, 64'd13};
	Data_stored[10] = {`ADDi, `R6, `R0, `R0,`ADDi, `R6_1, `R0_1, `R0_1};
	Data_stored[11] = {64'd6, 64'd12};
	Data_stored[12] = {`ADDi, `R7, `R0, `R0,`ADDi, `R7_1, `R0_1, `R0_1};
	Data_stored[13] = {64'd7, 64'd11};
	Data_stored[14] = {`ADDi, `R8, `R0, `R0,`ADDi, `R8_1, `R0_1, `R0_1};
	Data_stored[15] = {64'd8, 64'd10};
	Data_stored[16] = {`ADDi, `R9, `R0, `R0,`ADDi, `R9_1, `R0_1, `R0_1};
	Data_stored[17] = {64'd9, 64'd9};
	Data_stored[18] = {`ADDi, `R10, `R0, `R0,`ADDi, `R10_1, `R0_1, `R0_1};
	Data_stored[19] = {64'd10, 64'd8};
	//Data_stored[20] = {`ADDi, `R11, `R0, `R0,`ADDi, `R11_1, `R0_1, `R0_1};
	Data_stored[20] = {`ADDi, `R11, `R0, `R0,`ADDr, `R11_1, `R3_1, `R4_1};
	Data_stored[21] = {64'd11, 64'd7};
	//Data_stored[22] = {`ADDi, `R12, `R0, `R0,`ADDi, `R12_1, `R0_1, `R0_1};
	Data_stored[22] = {`ADDi, `R12, `R0, `R0,`ADDr, `R13_1, `R9_1, `R10_1};
	Data_stored[23] = {64'd12, 64'd6};
	//Data_stored[24] = {`ADDi, `R13, `R0, `R0,`ADDi, `R13_1, `R0_1, `R0_1};
	Data_stored[24] = {`ADDi, `R13, `R0, `R0,`SUBr, `R13_1, `R2_1, `R3_1};
	Data_stored[25] = {64'd13, 64'd5};
	Data_stored[26] = {`ADDi, `R14, `R0, `R0,`ADDi, `R14_1, `R0_1, `R0_1};
	Data_stored[27] = {64'd14, 64'd4};
	Data_stored[28] = {`ADDi, `R15, `R0, `R0,`ADDi, `R15_1, `R0_1, `R0_1};
	Data_stored[29] = {64'd15, 64'd3};
	Data_stored[30] = {`ADDi, `R16, `R0, `R0,`ADDi, `R16_1, `R0_1, `R0_1};
	Data_stored[31] = {64'd16, 64'd2};
	Data_stored[32] = {`ADDi, `R17, `R0, `R0,`ADDi, `R17_1, `R0_1, `R0_1};
	Data_stored[33] = {64'd17, 64'd1};
	//Data_stored[34] = {4'b0000, `ADD, `R3, `R5, `R4};
	//Data_stored[35] = {4'b0000, `MUL, `R3, `R4, `R2};
	//Data_stored[36] = {4'b0000, `PWR, `R3, `R10, `R4};
	//Data_stored[37] = {4'b0000, `SUB, `R3, `R7, `R2};
	//Data_stored[38] = {4'b0000, `DEC, `R3, `R17, `R1};
	//Data_stored[39] = {4'b0000, `INC, `R3, `R15, `R1};
	//Data_stored[40] = {4'b0000, `DIV, `R3, `R10, `R4};
	//Data_stored[41] = {4'b0000, `MOD, `R3, `R10, `R4};
	//Data_stored[42] = {4'b0000, `FACT, `R3, `R17, `R1};
	//Data_stored[43] = {4'b0000, `NAND, `R3, `R11, `R12};
	//Data_stored[44] = {4'b0000, `NOR, `R3, `R11, `R12};
	//Data_stored[45] = {4'b0000, `CBE, `R3, `R13, `R7};
	//Data_stored[46] = {4'b0000, `ADD, `R1, `R1, `R1};
	//Data_stored[47] = {4'b0000, `ADD, `R1, `R1, `R1};
	//Data_stored[48] = {4'b0000, `ADD, `R1, `R1, `R1};
  end 



endmodule

