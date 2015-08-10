`include "opcodes.v"
`timescale	100ps/10ps

module testbench;

tri [63:0] Data;
wire [63:0] Data_bus;
wire nME, nALE, RnW, nOE, SDO;
reg Clock, nReset, Test, SDI;
reg [53:0] Address_bus;
reg [53:0] temp_add;

cpu Cpu( Data, nME, nALE, RnW, nOE, SDO, Clock, nReset, Test, SDI );
ram Ram( Data_bus, Address_bus, nOE, 0 );


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

assign Data[63:0] = Data_bus[63:0];

initial
begin
Clock = 0;
nReset = 0;
Test = 0;
SDI = 0;
#20 nReset = 1;
#10000 $stop;
#20 $finish;


end

endmodule