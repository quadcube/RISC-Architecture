`include "opcodes.v"
`timescale	100ps/10ps

module testbench;

tri [63:0] Data;
tri [63:0] Data2;
wire [127:0] Data_bus;
wire nME, nALE, RnW, nOE, SDO, nME2, nALE2, RnW2, nOE2, SDO2;
reg Clock, nReset, Test, SDI, Test2, SDI2;
reg [53:0] Address_bus;
reg [53:0] Address_bus2;
reg [53:0] temp_add;
reg [53:0] temp_add2;

cpu CPU( Data, Data2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2, SDO, SDO2, Clock, nReset, Test, Test2, SDI, SDI2 );
rom Rom( Data_bus, Address_bus, Address_bus2, nOE, nOE2, 0 );
//ram Ram( Data_bus, Address_bus, notOE, RnotW, notCE );

always #15 Clock=~Clock;

always@(nOE)
begin
if(nOE)	
begin
temp_add[53:0] = Data[53:0];
end
else	
begin
Address_bus[53:0] = temp_add[53:0];
end
end

always@(nOE2)
begin
if(nOE2)	
begin
temp_add2[53:0] = Data2[53:0];
end
else	
begin
Address_bus2[53:0] = temp_add2[53:0];
end
end

assign Data[63:0] = Data_bus[127:64];
assign Data2[63:0] = Data_bus[63:0];


initial
begin
Clock = 0;
nReset = 0;
Test = 0;
SDI = 0;
Test2 = 0;
SDI2 = 0;
#20 nReset = 1;
#10000 $stop;
#20 $finish;


end

endmodule