`include "opcodes.v"
`timescale 100ps / 10ps

module ram( Data_bus, Address_bus, notOE, RnotW, notCE );

output [15:0] Data_bus;
input [7:0] Address_bus;
input notOE, RnotW, notCE;

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

reg [15:0] Data_stored [ 255:0 ];

assign Data_bus = ((notOE == 0) && (RnotW == 1) && (notCE == 0)) ?Data_stored [Address_bus] : 16'bz;

initial
  begin
   Data_stored[0] = {16'b0};//VAR_A
   Data_stored[1] = {16'b0};//VAR_B
   Data_stored[2] = {16'b0};//VAR_C
   Data_stored[3] = {16'b0};//VAR_R
   Data_stored[4] = {16'b0};//VAR_P
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

