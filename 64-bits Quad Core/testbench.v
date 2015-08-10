`include "opcodes.v"
`timescale	100ps/10ps

module testbench;

//wire [127:0] Data_bus;
wire [255:0] Data_bus;
//dual core
tri [63:0] Data;
tri [63:0] Data2;
wire nME, nALE, RnW, nOE, SDO, nME2, nALE2, RnW2, nOE2, SDO2;
reg Clock, nReset, Test, SDI, Test2, SDI2;
reg [53:0] Address_bus;
reg [53:0] Address_bus2;
reg [53:0] Store_add;
reg [53:0] Store_add2;
//quad core
tri [63:0] Data3;
tri [63:0] Data4;
wire nME3, nALE3, RnW3, nOE3, SDO3, nME4, nALE4, RnW4, nOE4, SDO4;
reg Test3, SDI3, Test4, SDI4;
reg [53:0] Address_bus3;
reg [53:0] Address_bus4;
reg [53:0] Store_add3;
reg [53:0] Store_add4;


cpu CPU( Data, Data2, Data3, Data4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, RnW, RnW2, RnW3, RnW4, nOE, nOE2, nOE3, nOE4, SDO, SDO2, SDO3, SDO4, Clock, nReset, Test, Test2, Test3, Test4, SDI, SDI2, SDI3, SDI4 );

rom Rom( Data_bus, Address_bus, Address_bus2, Address_bus3, Address_bus4, nOE, nOE2, nOE3, nOE4, 0 );
//ram Ram( Data_bus, Address_bus, Address_bus2, notOE, notOE2, RnotW, 0 );

always #15 Clock=~Clock;

always@(nOE)
begin
if(nOE)	
begin
Store_add[53:0] = Data[53:0];
end
else	
begin
Address_bus[53:0] = Store_add[53:0];
end
end

always@(nOE2)
begin
if(nOE2)	
begin
Store_add2[53:0] = Data2[53:0];
end
else	
begin
Address_bus2[53:0] = Store_add2[53:0];
end
end

always@(nOE3)
begin
if(nOE3)	
begin
Store_add3[53:0] = Data3[53:0];
end
else	
begin
Address_bus3[53:0] = Store_add3[53:0];
end
end

always@(nOE4)
begin
if(nOE4)	
begin
Store_add4[53:0] = Data4[53:0];
end
else	
begin
Address_bus4[53:0] = Store_add4[53:0];
end
end


//assign Data3[63:0] = Data_bus[255:192];
//assign Data4[63:0] = Data_bus[191:128];
//assign Data[63:0] = Data_bus[127:64];
//assign Data2[63:0] = Data_bus[63:0];

assign Data[63:0] = Data_bus[255:192];
assign Data2[63:0] = Data_bus[191:128];
assign Data3[63:0] = Data_bus[127:64];
assign Data4[63:0] = Data_bus[63:0];

initial
begin
Address_bus=54'bz;
Address_bus2=54'bz;
Address_bus3=54'bz;
Address_bus4=54'bz;
Clock = 0;
nReset = 0;
Test = 0;
SDI = 0;
Test2 = 0;
SDI2 = 0;
Test3 = 0;
SDI3 = 0;
Test4 = 0;
SDI4 = 0;
#5 nReset = 1;
#1800 $stop;
#20 $finish;


end

endmodule