`include "opcodes.v"
`timescale 100ps / 10ps

module ram( Data_bus, Address_bus, notOE, notCE );

output [63:0] Data_bus;
input [53:0] Address_bus;
input notOE, notCE;

specify
  specparam tViolate=250;
  $width(negedge notCE, tViolate);
  $width(posedge notCE, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE, tViolate, tViolate);
endspecify



reg [63:0] Data_stored [ 2047 :0 ];

assign Data_bus = ((notOE == 0) && (notCE == 0)) ?Data_stored [Address_bus] : 64'bz;

initial
  begin
        Data_stored[0] = {`ADDi, `R1, `R0, `R0};
	Data_stored[1] = 1;
	Data_stored[2] = {`ADDi, `R2, `R0, `R0};
	Data_stored[3] = 2;
	Data_stored[4] = {`ADDi, `R3, `R0, `R0};
	Data_stored[5] = 3;
	Data_stored[6] = {`ADDi, `R4, `R0, `R0};
	Data_stored[7] = 4;
	Data_stored[8] = {`ADDi, `R5, `R0, `R0};
	Data_stored[9] = 5;
	Data_stored[10] = {`ADDi, `R6, `R0, `R0};
	Data_stored[11] = 6;
	Data_stored[12] = {`ADDi, `R7, `R0, `R0};
	Data_stored[13] = 7;
	Data_stored[14] = {`ADDi, `R8, `R0, `R0};
	Data_stored[15] = 8;
	Data_stored[16] = {`ADDi, `R9, `R0, `R0};
	Data_stored[17] = 9;
	Data_stored[18] = {`ADDi, `R10, `R0, `R0};
	Data_stored[19] = 10;
	Data_stored[20] = {`ADDi, `R11, `R0, `R0};
	Data_stored[21] = 11;
	Data_stored[22] = {`ADDi, `R12, `R0, `R0};
	Data_stored[23] = 12;
	Data_stored[24] = {`ADDi, `R13, `R0, `R0};
	Data_stored[25] = 13;
	Data_stored[26] = {`ADDi, `R14, `R0, `R0};
	Data_stored[27] = 14;
	Data_stored[28] = {`ADDi, `R15, `R0, `R0};
	Data_stored[29] = 15;
	Data_stored[30] = {`ADDi, `R16, `R0, `R0};
	Data_stored[31] = 16;
	Data_stored[32] = {`ADDi, `R17, `R0, `R0};
	Data_stored[33] = 17;
	Data_stored[34] = {4'b0000, `ADD, `R3, `R5, `R4};
	Data_stored[35] = {4'b0000, `MUL, `R3, `R4, `R2};
	Data_stored[36] = {4'b0000, `PWR, `R3, `R10, `R4};
	Data_stored[37] = {4'b0000, `SUB, `R3, `R7, `R2};
	Data_stored[38] = {4'b0000, `DEC, `R3, `R17, `R1};
	Data_stored[39] = {4'b0000, `INC, `R3, `R15, `R1};
	Data_stored[40] = {4'b0000, `DIV, `R3, `R10, `R4};
	Data_stored[41] = {4'b0000, `MOD, `R3, `R10, `R4};
	Data_stored[42] = {4'b0000, `FACT, `R3, `R17, `R1};
	Data_stored[43] = {4'b0000, `NAND, `R3, `R11, `R12};
	Data_stored[44] = {4'b0000, `NOR, `R3, `R11, `R12};
	Data_stored[45] = {4'b0000, `CBE, `R3, `R13, `R7};
	Data_stored[46] = {4'b0000, `ADD, `R1, `R1, `R1};
	Data_stored[47] = {4'b0000, `ADD, `R1, `R1, `R1};
	Data_stored[48] = {4'b0000, `ADD, `R1, `R1, `R1};
  end 



endmodule

