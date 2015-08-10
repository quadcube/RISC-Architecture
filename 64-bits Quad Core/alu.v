`include "opcodes.v"
`timescale 100ps/10ps

module alu(Zero, Zero2, Zero3, Zero4, Compare, Compare2, Compare3, Compare4, Parity_ODD, Parity_ODD2, Parity_ODD3, Parity_ODD4, Parity_EVEN, Parity_EVEN2, Parity_EVEN3, Parity_EVEN4, Overflow, Overflow2, Overflow3, Overflow4, result, result2, result3, result4, overf, overf2, overf3, overf4, input1, input1_1, input1_2, input1_3, input2, input2_1, input2_2, input2_3, Function, Function2, Function3, Function4, EN_ALU1, EN_ALU2, EN_ALU3, EN_ALU4);

//dual core
output	[63:0]	result;
output	[63:0]	result2;
output	[31:0]	overf;
output	[31:0]	overf2;
output		Zero, Compare, Parity_ODD, Parity_EVEN, Overflow, Zero2, Compare2, Parity_ODD2, Parity_EVEN2, Overflow2;
input	[63:0]	input1, input2;
input	[63:0]	input1_1, input2_1;
input	[5:0]	Function;
input	[5:0]	Function2;
input EN_ALU1,EN_ALU2,EN_ALU3,EN_ALU4;
reg	[63:0]	result;
reg	[63:0]	result2;
wire		Parity_EVEN, Parity_EVEN2, Overflow, Overflow2;
reg		Compare, Parity_ODD, Compare2, Parity_ODD2;
reg	[31:0]	overf;
reg	[31:0]	overf2;
reg	[63:0]	i;
reg	[63:0]	i2;
//quad core
output	[63:0]	result3;
output	[63:0]	result4;
output	[31:0]	overf3;
output	[31:0]	overf4;
output		Zero3, Compare3, Parity_ODD3, Parity_EVEN3, Overflow3, Zero4, Compare4, Parity_ODD4, Parity_EVEN4, Overflow4;
input	[63:0]	input1_2, input2_2;
input	[63:0]	input1_3, input2_3;
input	[5:0]	Function3;
input	[5:0]	Function4;
reg	[63:0]	result3;
reg	[63:0]	result4;
wire		Parity_EVEN3, Parity_EVEN4, Overflow3, Overflow4;
reg		Compare3, Parity_ODD3, Compare4, Parity_ODD4;
reg	[31:0]	overf3;
reg	[31:0]	overf4;
reg	[63:0]	i3;
reg	[63:0]	i4;
reg		Zero, Zero2, Zero3, Zero4;


initial
begin
i=0;
i2=0;
i3=0;
i4=0;
Compare=0;
Compare2=0;
Compare3=0;
Compare4=0;
Parity_ODD=0;
Parity_ODD2=0;
Parity_ODD3=0;
Parity_ODD4=0;
overf=0;
overf2=0;
overf3=0;
overf4=0;
end

assign Overflow = (EN_ALU1 && (overf>0))? 1:0;
assign Overflow2 = (EN_ALU2 && (overf2>0))? 1:0;
assign Overflow3 = (EN_ALU3 && (overf3>0))? 1:0;
assign Overflow4 = (EN_ALU4 && (overf4>0))? 1:0;



assign Parity_EVEN = ~Parity_ODD;
assign Parity_EVEN2 = ~Parity_ODD2;
assign Parity_EVEN3 = ~Parity_ODD3;
assign Parity_EVEN4 = ~Parity_ODD4;

	
	always @(input1 or input2 or Function)
	begin
	if(EN_ALU1)
	begin	
		case (Function)
			`ADD	:	{overf,result} = input1 + input2;
			`SUB	:	{overf,result} = input1 - input2;
			`MUL	:	{overf,result} = input1 * input2;
			`DIV	:	result = input1 / input2;
			`MOD	:	result = input1 % input2;
			`AND	:	result = input1 & input2;
			`NAND	:	result = ~(input1 & input2);
			`OR	:	result = input1 | input2;
			`NOR	:	result = ~(input1 | input2);
			`XOR	:	result = input1 ^ input2;
			`XNOR	:	result = input1 ~^ input2;
			`NOT	:	result = ~input1;
			`SRL	:	result = input1 >> 1;
			`SLL	:	result = input1 << 1;
			`SRA	:	result = input1 >>> 1;
			`SLA	:	result = input1 <<< 1;
			`INC	:	{overf,result} = input1 + 1;
			`DEC	:	{overf,result} = input1 - 1;
			`CE	:	begin if(input1 == input2) Compare<=1; else Compare<=0; end
			`CBE	:	begin if(input1 <= input2) Compare<=1; else Compare<=0; end
			`CAE	:	begin if(input1 >= input2) Compare<=1; else Compare<=0; end
			`CB	:	begin if(input1 < input2) Compare<=1; else Compare<=0; end
			`CA	:	begin if(input1 > input2) Compare<=1; else Compare<=0; end
			`CNE	:	begin if(input1 != input2) Compare<=1; else Compare<=0; end
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
		if ((result[63:0]&1) == 1) 
			begin
    			Parity_ODD = 1'b1;
  			end
		else 
			begin
    			Parity_ODD = 1'b0;
  			end
		if (result==0) begin Zero<=1; end
		else begin Zero<=0; end
	end
	else
	begin
		result = 64'bz;
		Zero <= 1'bz;
	end
	end


	always @(input1_1 or input2_1 or Function2)
	begin
	if(EN_ALU2)
	begin	
		case (Function2)
			`ADD	:	{overf2,result2} = input1_1 + input2_1;
			`SUB	:	{overf2,result2} = input1_1 - input2_1;
			`MUL	:	{overf2,result2} = input1_1 * input2_1;
			`DIV	:	result2 = input1_1 / input2_1;
			`MOD	:	result2 = input1_1 % input2_1;
			`AND	:	result2 = input1_1 & input2_1;
			`NAND	:	result2 = ~(input1_1 & input2_1);
			`OR	:	result2 = input1_1 | input2_1;
			`NOR	:	result2 = ~(input1_1 | input2_1);
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
		if ((result2[63:0]&1) == 1) 
			begin
    			Parity_ODD2 = 1'b1;
  			end
		else 
			begin
    			Parity_ODD2 = 1'b0;
  			end
		if (result2==0) begin Zero2<=1; end
		else begin Zero2<=0; end
	end
	else
	begin
		result2 = 64'bz;
		Zero2 <= 1'bz;
	end
	end


	always @(input1_2 or input2_2 or Function3)
	begin
	if(EN_ALU3)
	begin	
		i3=0;
		case (Function3)
			`ADD	:	{overf3,result3} = input1_2 + input2_2;
			`SUB	:	{overf3,result3} = input1_2 - input2_2;
			`MUL	:	{overf3,result3} = input1_2 * input2_2;
			`DIV	:	result3 = input1_2 / input2_2;
			`MOD	:	result3 = input1_2 % input2_2;
			`AND	:	result3 = input1_2 & input2_2;
			`NAND	:	result3 = ~(input1_2 & input2_2);
			`OR	:	result3 = input1_2 | input2_2;
			`NOR	:	result3 = ~(input1_2 | input2_2);
			`XOR	:	result3 = input1_2 ^ input2_2;
			`XNOR	:	result3 = input1_2 ~^ input2_2;
			`NOT	:	result3 = ~input1_2;
			`SRL	:	result3 = input1_2 >> 1;
			`SLL	:	result3 = input1_2 << 1;
			`SRA	:	result3 = input1_2 >>> 1;
			`SLA	:	result3 = input1_2 <<< 1;
			`INC	:	{overf3,result3} = input1_2 + 1;
			`DEC	:	{overf3,result3} = input1_2 - 1;
			`CE	:	if(input1_2 == input2_2) Compare3<=1;
			`CBE	:	if(input1_2 <= input2_2) Compare3<=1;
			`CAE	:	if(input1_2 >= input2_2) Compare3<=1;
			`CB	:	if(input1_2 < input2_2) Compare3<=1;
			`CA	:	if(input1_2 > input2_2) Compare3<=1;
			`CNE	:	if(input1_2 != input2_2) Compare3<=1;
			`PWR	:	{overf3,result3} = input1_2 ** input2_2;
			`FACT	:	begin
						result3 = input1_2;
						for(i3 = input1_2; i3>1 ; i3=i3-1)
						begin
							{overf3,result3} = result3 * (i3-1);
						end
					end
			
			default	:	result3 = input1_2;
		endcase
		if ((result3[63:0]&1) == 1) 
			begin
    			Parity_ODD3 = 1'b1;
  			end
		else 
			begin
    			Parity_ODD3 = 1'b0;
  			end
		if (result3==0) begin Zero3<=1; end
		else begin Zero3<=0; end
	end
	else
	begin
		result3 = 64'bz;
		Zero3 <= 1'bz;
	end
	end

	always @(input1_3 or input2_3 or Function4)
	begin
	if(EN_ALU4)
	begin	
		case (Function4)
			`ADD	:	{overf4,result4} = input1_3 + input2_3;
			`SUB	:	{overf4,result4} = input1_3 - input2_3;
			`MUL	:	{overf4,result4} = input1_3 * input2_3;
			`DIV	:	result4 = input1_3 / input2_3;
			`MOD	:	result4 = input1_3 % input2_3;
			`AND	:	result4 = input1_3 & input2_3;
			`NAND	:	result4 = ~(input1_3 & input2_3);
			`OR	:	result4 = input1_3 | input2_3;
			`NOR	:	result4 = ~(input1_3 | input2_3);
			`XOR	:	result4 = input1_3 ^ input2_3;
			`XNOR	:	result4 = input1_3 ~^ input2_3;
			`NOT	:	result4 = ~input1_3;
			`SRL	:	result4 = input1_3 >> 1;
			`SLL	:	result4 = input1_3 << 1;
			`SRA	:	result4 = input1_3 >>> 1;
			`SLA	:	result4 = input1_3 <<< 1;
			`INC	:	{overf4,result4} = input1_3 + 1;
			`DEC	:	{overf4,result4} = input1_3 - 1;
			`CE	:	if(input1_3 == input2_3) Compare4<=1;
			`CBE	:	if(input1_3 <= input2_3) Compare4<=1;
			`CAE	:	if(input1_3 >= input2_3) Compare4<=1;
			`CB	:	if(input1_3 < input2_3) Compare4<=1;
			`CA	:	if(input1_3 > input2_3) Compare4<=1;
			`CNE	:	if(input1_3 != input2_3) Compare4<=1;
			`PWR	:	{overf4,result4} = input1_3 ** input2_3;
			`FACT	:	begin
						result4 = input1_3;
						for(i4 = input1_3; i4>1 ; i4=i4-1)
						begin
							{overf4,result4} = result4 * (i4-1);
						end
					end
			
			default	:	result4 = input1_3;
		endcase
		if ((result4[63:0]&1) == 1) 
			begin
    			Parity_ODD4 = 1'b1;
  			end
		else 
			begin
    			Parity_ODD4 = 1'b0;
  			end
		if (result4==0) begin Zero4<=1; end
		else begin Zero4<=0; end
	end
	else
	begin
		result4 = 64'bz;
		Zero4 <= 1'bz;
	end
	end
endmodule
