`timescale 100ps / 10ps

module cpu( Data, Data2, Data3, Data4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, RnW, RnW2, RnW3, RnW4, nOE, nOE2, nOE3, nOE4, SDO, SDO2, SDO3, SDO4, Clock, nReset, Test, Test2, Test3, Test4, SDI, SDI2, SDI3, SDI4 );

//quad core
inout [63:0] Data;
inout [63:0] Data2;
inout [63:0] Data3;
inout [63:0] Data4;
output nME, nALE, RnW, nOE, SDO, nME2, nALE2, RnW2, nOE2, SDO2;
output nME3, nALE3, RnW3, nOE3, SDO3, nME4, nALE4, RnW4, nOE4, SDO4;
input Clock, nReset, Test, SDI, Test2, SDI2, Test3, SDI3, Test4, SDI4;

wire [63:0] Data_in;
wire [63:0] Data_out;
wire [63:0] Data_in2;
wire [63:0] Data_out2;
wire ENB, ENB2;
wire [63:0] Data_in3;
wire [63:0] Data_out3;
wire [63:0] Data_in4;
wire [63:0] Data_out4;
wire ENB3, ENB4;

assign Data = (ENB == 0) ? Data_out : 64'bz;
assign Data2 = (ENB2 == 0) ? Data_out2 : 64'bz;
assign Data3 = (ENB3 == 0) ? Data_out3 : 64'bz;
assign Data4 = (ENB4 == 0) ? Data_out4 : 64'bz;

assign Data_in = Data;
assign Data_in2 = Data2;
assign Data_in3 = Data3;
assign Data_in4 = Data4;


cpu_core CPU_core( Data_out, Data_out2, Data_out3, Data_out4, Data_in, Data_in2, Data_in3, Data_in4, ENB, ENB2, ENB3, ENB4, nME, nME2, nME3, nME4, nALE, nALE2, nALE3, nALE4, RnW, RnW2, RnW3, RnW4, nOE, nOE2, nOE3, nOE4, SDO, SDO2, SDO3, SDO4, Clock, nReset, Test, Test2, Test3, Test4, SDI, SDI2, SDI3, SDI4  );

//cpu_core CPU_core( Data_out, Data_out2, Data_in, Data_in2, ENB, ENB2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2, SDO, SDO2, Clock, nReset, Test, Test2, SDI, SDI2 );

endmodule

