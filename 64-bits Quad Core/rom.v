`include "opcodes.v"
`timescale 100ps / 10ps

//module rom( Data_bus, Address_bus, Address_bus2, notOE, notOE2, notCE );
module rom( Data_bus, Address_bus, Address_bus2, Address_bus3, Address_bus4, notOE, notOE2, notOE3, notOE4, notCE );
//output [127:0] Data_bus;
output [255:0] Data_bus;
input [53:0] Address_bus;
input [53:0] Address_bus2;
input [53:0] Address_bus3;
input [53:0] Address_bus4;
input notOE, notOE2, notOE3, notOE4, notCE;

specify
  specparam tViolate=250;
  $width(negedge notCE, tViolate);
  $width(posedge notCE, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus2, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE2, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus3, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE3, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus4, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE4, tViolate, tViolate);
endspecify

reg [255:0] Data_stored [ 4095 :0 ];
//reg [127:0] Data_stored [ 4095 :0 ];

assign Data_bus = ((notOE == 0) && (notCE == 0)) ?Data_stored [Address_bus] : 256'bz;
assign Data_bus = ((notOE2 == 0) && (notCE == 0)) ?Data_stored [Address_bus2] : 256'bz;
assign Data_bus = ((notOE3 == 0) && (notCE == 0)) ?Data_stored [Address_bus3] : 256'bz;
assign Data_bus = ((notOE4 == 0) && (notCE == 0)) ?Data_stored [Address_bus4] : 256'bz;

initial
  begin
//	Data_stored[x] = {	CORE 1		    ,		CORE 2	       ,       CORE 3       ,     CORE 4   	 };
        Data_stored[0] = {`ADDi, `R1, `R0, `R0,`ADDi, `R1_1, `R0_1, `R0_1,`ADDi, `R1_2, `R0_2, `R0_2,`ADDi, `R1_3, `R0_3, `R0_3};	//store 1 to core1r1,store 2 to core2r1,store 3 to core3r1,store 4 to core4r1
	Data_stored[1] = {64'd1,				 64'd2, 		64'd3, 			64'd4};
	Data_stored[2] = {`ADDi, `R2, `R0, `R0,`ADDi, `R2_1, `R0_1, `R0_1,`ADDi, `R2_2, `R0_2, `R0_2,`ADDi, `R2_3, `R0_3, `R0_3};	//store 5 to core1r2,store 6 to core2r2,store 7 to core3r2,store 8 to core4r2
	Data_stored[3] = {64'd5,				 64'd6,			64'd7,			64'd8};
	Data_stored[4] = {`ADDi, `R3, `R0, `R0,`ADDi, `R3_1, `R0_1, `R0_1,`ADDr, `R3_2, `R1_2, `R2_2,`SUBr, `R3_3, `R2_3, `R1_3};	//store 9 to core1r3,store 10 to core2r3,core 3 R3=R1+R2,core 4 R3=R2-R1
	Data_stored[5] = {64'd9,				 64'd10,		64'd0,			64'd0};
	Data_stored[6] = {`MULr, `R4, `R2, `R3,`DIVr, `R4_1, `R2_1, `R1_1,`MODr, `R4_2, `R2_2, `R1_2,`ANDr, `R4_3, `R1_3, `R2_3};	//core 1 R4=R2*R3,core 2 R4=R2/R1,core 3 R4=R2%R1,core 4 R4=R1&R2		
	Data_stored[7] = {`NANDr, `R5, `R1, `R2,`ORr, `R5_1, `R1_1, `R2_1,`NORr, `R5_2, `R1_2, `R2_2,`XORr, `R5_3, `R1_3, `R2_3};	//core 1 R5=R1~&R2,core 2 R5=R1|R2,core 3 R5=R1~|R2,core 4 R5=R1^R2
	Data_stored[8] = {`XNORr, `R6, `R1, `R2,`NOTr, `R6_1, `R1_1, `R2_1,`SRLr, `R6_2, `R1_2, `R2_2,`SLLr, `R6_3, `R1_3, `R2_3};	//core 1 R6=R1~^R2,core 2 R6=R1~R2,core 3 R6=R1>>R2,core 4 R6=R1<<R2
	Data_stored[9] = {`SRAr, `R7, `R1, `R2,`SLAr, `R7_1, `R1_1, `R2_1,`INCr, `R7_2, `R1_2, `R2_2,`DECr, `R7_3, `R1_3, `R2_3};	//core 1 R7=R1>>>R2,core 2 R7=R1<<<R2,core 3 R7=R1 inc,core 4 R7=R1 dec
	Data_stored[10] = {`CEr, `R8, `R1, `R2,`CBEr, `R8_1, `R1_1, `R2_1,`CAEr, `R8_2, `R1_2, `R2_2,`CBr, `R8_3, `R1_3, `R2_3};	//core 1 R7=R1==R2,core 2 R7=R1<=R2,core 3 R7=R1>=R2,core 4 R7=R1<R2
	Data_stored[11] = {`CAr, `R9, `R1, `R2,`CNEr, `R9_1, `R1_1, `R2_1,`PWRr, `R9_2, `R1_2, `R2_2,`FACTr, `R9_3, `R1_3, `R2_3};	//core 1 R7=R1>R2,core 2 R7=R1!=R2,core 3 R7=R1^R2 PWR,core 4 R7=!R1 FACTORIAL
	Data_stored[12] = {`MOVC1C2, `R3, `R4,`FACTr,`R10_1,`R8_1,`R0_1, 128'd0};				//move data from core 1,R3 to core 2, R4,core 2 factorial R10=!R8,core 3 and 4 idle
	Data_stored[13] = {`XCHG, `R3, `R4, `MOVC2C1, `R2_1, `R1_1,`PWRr, `R10_2, `R9_2, `R9_2, 64'd0};		//core 1 xchg R3 and R4, move data from core 2,R2 to core 1,R1,core 3 R10=R9^R9 (test overflow),core 3 and 4 idle

  end 




endmodule

