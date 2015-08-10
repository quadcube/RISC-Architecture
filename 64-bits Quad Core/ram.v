`include "opcodes.v"
`timescale 100ps / 10ps

module ram( Data_bus, Address_bus, Address_bus2, notOE, notOE2, RnotW, notCE );

output [127:0] Data_bus;
input [53:0] Address_bus;
input [53:0] Address_bus2;
input notOE, notOE2, RnotW, notCE;

specify
  specparam tViolate=250;
  $width(negedge notCE, tViolate);
  $width(posedge notCE, tViolate);
  $width(negedge RnotW &&& ~notCE, tViolate);
  $width(posedge RnotW &&& ~notCE, tViolate);
  $setuphold(edge[10, 01] notCE, Address_bus, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, RnotW, tViolate, tViolate);
  $setuphold(edge[10, 01] notCE, notOE, tViolate, tViolate);
  $setuphold(edge[01] notCE &&& ~RnotW, Data_bus, tViolate, tViolate);
endspecify

reg [127:0] Data_stored [ 4095:0 ];

assign Data_bus = ((notOE == 0) && (RnotW == 1) && (notCE == 0)) ?Data_stored [Address_bus] : 128'bz;
assign Data_bus = ((notOE2 == 0) && (RnotW == 1) && (notCE == 0)) ?Data_stored [Address_bus2] : 128'bz;

initial
  begin
   Data_stored[0] = {128'd0};//VAR_A
   Data_stored[1] = {128'd1};//VAR_B
   Data_stored[2] = {128'd2};//VAR_C
   Data_stored[3] = {128'd3};//VAR_R
   Data_stored[4] = {128'd4};//VAR_P
   Data_stored[5] = {128'd5};//VAR_A
   Data_stored[6] = {128'd6};//VAR_B
   Data_stored[7] = {128'd7};//VAR_C
   Data_stored[8] = {128'd8};//VAR_R
   Data_stored[9] = {128'd9};//VAR_P
   Data_stored[10] = {128'd10};//VAR_A
   Data_stored[11] = {128'd11};//VAR_B
   Data_stored[12] = {128'd12};//VAR_C
   Data_stored[13] = {128'd13};//VAR_R
   Data_stored[14] = {128'd14};//VAR_P
   Data_stored[15] = {128'd15};//VAR_A
   Data_stored[16] = {128'd16};//VAR_B
   Data_stored[17] = {128'd17};//VAR_C
   Data_stored[18] = {128'd18};//VAR_R
   Data_stored[19] = {128'd19};//VAR_P
   Data_stored[20] = {128'd20};//VAR_A
   Data_stored[21] = {128'd21};//VAR_B
   Data_stored[22] = {128'd22};//VAR_C
   Data_stored[23] = {128'd23};//VAR_R
   Data_stored[24] = {128'd24};//VAR_P
  end 

always @(notCE or RnotW)
  begin
    while ((notCE == 0) && (RnotW == 0))
      begin
         Data_stored [Address_bus] = Data_bus;
        @(notCE or RnotW or Address_bus or Data_bus);
      end
  end


endmodule

