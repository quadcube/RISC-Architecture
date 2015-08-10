`include "opcodes.v"
`timescale 100ps/10ps

module alu(Zero, Zero2, Compare, Compare2, Parity_ODD, Parity_ODD2, Parity_EVEN, Parity_EVEN2, Overflow, Overflow2, result, result2, overf, overf2, input1, input1_1, input2, input2_1, Function, Function2);

output	[63:0]	result;
output	[63:0]	result2;
output	[31:0]	overf;
output	[31:0]	overf2;
output		Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, Zero2, Compare2, Parity_ODD2, Parity_EVEN2, Overflow2;
input	[63:0]	input1, input2;
input	[63:0]	input1_1, input2_1;
input	[5:0]	Function;
input	[5:0]	Function2;
reg	[63:0]	result;
reg	[63:0]	result2;
wire		Parity_EVEN, Parity_EVEN2, Zero, Overflow, Zero2, Overflow2;
reg		Compare, Parity_ODD, Compare2, Parity_ODD2;
reg	[31:0]	overf;
reg	[31:0]	overf2;
reg	[63:0]	i;
reg	[63:0]	i2;

initial
begin
i=0;
i2=0;
Compare=0;
Compare2=0;
Parity_ODD=0;
Parity_ODD2=0;
overf=0;
overf2=0;
end


assign Zero = (result == 0);
assign Zero2 = (result2 == 0);
assign Overflow = (overf>0);
assign Overflow2 = (overf2>0);
assign Parity_EVEN = ~Parity_ODD;
assign Parity_EVEN2 = ~Parity_ODD2;
	
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
    			Parity_ODD = 1'b0;
  			end
		else 
			begin
    			Parity_ODD = 1'b1;
  			end
	end


	always @(input1_1 or input2_1 or Function2)
	begin
		case (Function2)
			`ADD	:	{overf2,result2} = input1_1 + input2_1;
			`SUB	:	{overf2,result2} = input1_1 - input2_1;
			`MUL	:	{overf2,result2} = input1_1 * input2_1;
			`DIV	:	result2 = input1_1 / input2_1;
			`MOD	:	result2 = input1_1 % input2_1;
			`AND	:	result2 = input1_1 & input2_1;
			`NAND	:	result2 = input1_1 &~ input2_1;
			`OR	:	result2 = input1_1 | input2_1;
			`NOR	:	result2 = input1_1 |~ input2_1;
			`XOR	:	result2 = input1_1 ^ input2_1;
			`XNOR	:	result2 = input1_1 ~^ input2_1;
			`NOT	:	result2 = ~input1_1;
			`SRL	:	result2 = input1_1 >> 1;
			`SLL	:	result2 = input1_1 << 1;
			`SRA	:	result2 = input1_1 >>> 1;
			`SLA	:	result2 = input1_1 <<< 1;
			`INC	:	{overf2,result2} = input1_1 + 1;
			`DEC	:	{overf2,result2} = input1_1 - 1;
			`CE	:	if(input1_1 == input2_1) Compare2<=1;
			`CBE	:	if(input1_1 <= input2_1) Compare2<=1;
			`CAE	:	if(input1_1 >= input2_1) Compare2<=1;
			`CB	:	if(input1_1 < input2_1) Compare2<=1;
			`CA	:	if(input1_1 > input2_1) Compare2<=1;
			`CNE	:	if(input1_1 != input2_1) Compare2<=1;
			`PWR	:	{overf2,result2} = input1_1 ** input2_1;
			`FACT	:	begin
						result2 = input1_1;
						for(i2 = input1_1; i2>1 ; i2=i2-1)
						begin
							{overf2,result2} = result2 * (i2-1);
						end
					end
			
			default	:	result2 = input1_1;
		endcase
		if (^result2[63:0] == 1) 
			begin
    			Parity_ODD2 = 1'b0;
  			end
		else 
			begin
    			Parity_ODD2 = 1'b1;
  			end
	end
endmodule
