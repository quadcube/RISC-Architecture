//ALU functions-64 bit
`define	ADD	6'd0
`define	SUB	6'd1
`define MUL	6'd2
`define DIV	6'd3
`define MOD	6'd4
`define	AND	6'd5
`define NAND	6'd6
`define	OR	6'd7
`define NOR	6'd8
`define	XOR	6'd9
`define XNOR	6'd10
`define	NOT	6'd11
`define	SRL	6'd12
`define SLL	6'd13
`define SRA	6'd14
`define SLA	6'd15
`define INC	6'd16
`define DEC	6'd17
`define CE	6'd18
`define CBE	6'd19
`define CAE	6'd20
`define CB	6'd21
`define CA	6'd22
`define CNE	6'd23
`define PWR	6'd24
`define FACT	6'd25


//Registers-64 bit
`define	PC	18'b000000000000010010
`define	DR	18'b101000000000000000
`define	IR	18'b110000000000000000
`define	R0	18'b000000000000000000
`define R1	18'b000000000000000001
`define	R2	18'b000000000000000010
`define	R3	18'b000000000000000011
`define	R4	18'b000000000000000100
`define	R5	18'b000000000000000101
`define	R6	18'b000000000000000110
`define	R7	18'b000000000000000111
`define	R8	18'b000000000000001000
`define	R9	18'b000000000000001001
`define	R10	18'b000000000000001010
`define	R11	18'b000000000000001011
`define	R12	18'b000000000000001100
`define	R13	18'b000000000000001101
`define	R14	18'b000000000000001110
`define	R15	18'b000000000000001111
`define	R16	18'b000000000000010000
`define	R17	18'b000000000000010001


//Memory access macro-64 bit
`define LD 	{10'b1000000000} 
`define ST 	{10'b1100000000}



//Macro Opcodes-16 bit
`define ADDr	{4'b0000, `ADD} 
`define ADDi	{4'b0100, `ADD} 
`define ADDrcc	{4'b0010, `ADD} 
`define ADDicc	{4'b0110, `ADD} 
`define CADDrZ	{4'b0001, `ADD} 
`define CADDiZ	{4'b0101, `ADD} 
`define SUBr	{4'b0000, `SUB} 
`define SUBi	{4'b0100, `SUB} 
`define SUBrcc	{4'b0010, `SUB} 
`define SUBicc	{4'b0110, `SUB} 
`define CSUBrZ	{4'b0001, `SUB} 
`define CSUBiZ	{4'b0101, `SUB} 
`define ANDr	{4'b0000, `AND} 
`define ANDi	{4'b0100, `AND} 
`define ANDrcc	{4'b0010, `AND} 
`define ANDicc	{4'b0110, `AND} 
`define CANDrZ	{4'b0001, `AND} 
`define CANDiZ	{4'b0101, `AND} 
`define ORr	{4'b0000, `OR} 
`define ORi	{4'b0100, `OR} 
`define ORrcc	{4'b0010, `OR} 
`define ORicc	{4'b0110, `OR} 
`define CORrZ	{4'b0001, `OR} 
`define CORiZ	{4'b0101, `OR} 
`define XORr	{4'b0000, `XOR} 
`define XORi	{4'b0100, `XOR} 
`define XORrcc	{4'b0010, `XOR} 
`define XORicc	{4'b0110, `XOR} 
`define CXORrZ	{4'b0001, `XOR} 
`define CXORiZ 	{4'b0101, `XOR} 
`define NOTr 	{4'b0000, `NOT} 
`define NOTrcc 	{4'b0010, `NOT} 
`define CNOTrZ 	{4'b0001, `NOT} 
`define SRAr 	{4'b0000, `SRA} 


//The following line indicates that a file "monitor.v" exists and contains
//custom monitoring information
//
`define special_monitor

//The following line indicates that a file "stimulus.v" exists and contains
//custom stimulus information
//
//`define special_stimulus

//The following code specifies the default value of the input switches
//for the sumulation in not already defined from the command line
//
`ifdef switch_value
	//already defined - do nothing
`else
	`define switch_value	7
`endif