`include "opcodes.v"
`timescale 100ps/10ps

module alu(Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, result, overf, input1, input2, Function);

output	[63:0]	result;
output	[31:0]	overf;
output		Zero, Compare, Parity_ODD, Parity_EVEN, Overflow;
input	[63:0]	input1, input2;
input	[5:0]	Function;
reg	[63:0]	result;
wire		Zero, Parity_EVEN, Overflow;
reg		Compare, Parity_ODD;
reg	[31:0]	overf;
reg	[63:0]	i;
assign Zero = (result == 0);
assign Overflow = (overf>0);
assign Parity_EVEN = ~Parity_ODD;
	
	always @(input1 or input2 or Function)
	begin
		case (Function)
			`ADD	:	{overf,result} = input1 + input2;
			`SUB	:	{overf,result} = input1 - input2;
			`MUL	:	{overf,result} = input1 * input2;
			`DIV	:	result = input1 / input2;
			`MOD	:	result = input1 % input2;
			`AND	:	result = input1 & input2;
			`NAND	:	result = input1 &~ input2;
			`OR	:	result = input1 | input2;
			`NOR	:	result = input1 |~ input2;
			`XOR	:	result = input1 ^ input2;
			`XNOR	:	result = input1 ~^ input2;
			`NOT	:	result = ~input1;
			`SRL	:	result = input1 >> 1;
			`SLL	:	result = input1 << 1;
			`SRA	:	result = input1 >>> 1;
			`SLA	:	result = input1 <<< 1;
			`INC	:	{overf,result} = input1 + 1;
			`DEC	:	{overf,result} = input1 - 1;
			`CE	:	if(input1 == input2) Compare<=1;
			`CBE	:	if(input1 <= input2) Compare<=1;
			`CAE	:	if(input1 >= input2) Compare<=1;
			`CB	:	if(input1 < input2) Compare<=1;
			`CA	:	if(input1 > input2) Compare<=1;
			`CNE	:	if(input1 != input2) Compare<=1;
			`PWR	:	{overf,result} = input1 ** input2;
			`FACT	:	begin
						result = input1;
						for(i = input1; i>1 ; i=i-1)
						begin
							{overf,result} = result * (i-1);
						end
					end
			
			default	:	result = input1;
		endcase
		if (^result[63:0] == 1) 
			begin
    			Parity_ODD = 1'b1;
  			end
		else 
			begin
    			Parity_ODD = 1'b0;
  			end
	end
endmodule
