`timescale 100ps / 10ps

module cpu( Data, Data2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2, SDO, SDO2, Clock, nReset, Test, Test2, SDI, SDI2 );

inout [63:0] Data;
inout [63:0] Data2;
output nME, nALE, RnW, nOE, SDO, nME2, nALE2, RnW2, nOE2, SDO2;
input Clock, nReset, Test, SDI, Test2, SDI2;

wire [63:0] Data_in;
wire [63:0] Data_out;
wire [63:0] Data_in2;
wire [63:0] Data_out2;
wire ENB, ENB2;

assign Data = (ENB == 0) ? Data_out : 64'bz;
assign Data2 = (ENB2 == 0) ? Data_out2 : 64'bz;

assign Data_in = Data;
assign Data_in2 = Data2;

//cpu_core CPU_core ( Data_out, Data_in, ENB, nME, nALE, RnW, nOE, SDO, Clock, nReset, Test, SDI );

cpu_core CPU_core( Data_out, Data_out2, Data_in, Data_in2, ENB, ENB2, nME, nME2, nALE, nALE2, RnW, RnW2, nOE, nOE2, SDO, SDO2, Clock, nReset, Test, Test2, SDI, SDI2 );

endmodule

