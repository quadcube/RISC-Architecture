`timescale 100ps / 10ps

module cpu( Data, nME, nALE, RnW, nOE, SDO, Clock, nReset, Test, SDI );

inout [63:0] Data;
output nME, nALE, RnW, nOE, SDO;
input Clock, nReset, Test, SDI;

wire [63:0] Data_in;
wire [63:0] Data_out;
wire ENB;

assign Data = (ENB == 0) ? Data_out : 64'bz;
assign Data_in = Data;

cpu_core CPU_core ( Data_out, Data_in, ENB, nME, nALE, RnW, nOE, SDO, Clock, nReset, Test, SDI );

endmodule

