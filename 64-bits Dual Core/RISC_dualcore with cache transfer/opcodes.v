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

//Multi-core instruction
`define MOVC1	6'd63
`define MOVC2	6'd62


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

`define	PC2	18'b000000000000010010
`define	DR2	18'b101000000000000000
`define	IR2	18'b110000000000000000
`define	R0_1	18'b000000000000000000
`define R1_1	18'b000000000000000001
`define	R2_1	18'b000000000000000010
`define	R3_1	18'b000000000000000011
`define	R4_1	18'b000000000000000100
`define	R5_1	18'b000000000000000101
`define	R6_1	18'b000000000000000110
`define	R7_1	18'b000000000000000111
`define	R8_1	18'b000000000000001000
`define	R9_1	18'b000000000000001001
`define	R10_1	18'b000000000000001010
`define	R11_1	18'b000000000000001011
`define	R12_1	18'b000000000000001100
`define	R13_1	18'b000000000000001101
`define	R14_1	18'b000000000000001110
`define	R15_1	18'b000000000000001111
`define	R16_1	18'b000000000000010000
`define	R17_1	18'b000000000000010001


//Memory access macro-64 bit
`define LD 	{10'b1000000000} 
`define ST 	{10'b1100000000}



//Macro Opcodes-64 bit
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
`define MULr	{4'b0000, `MUL}
`define	MULi	{4'b0100, `MUL}
`define MULrcc	{4'b0010, `MUL}
`define MULicc	{4'b0110, `MUL}
`define CMULrZ	{4'b0001, `MUL}
`define CMULiZ	{4'b0101, `MUL}
`define DIVr	{4'b0000, `DIV}
`define	DIVi	{4'b0100, `DIV}
`define DIVrcc	{4'b0010, `DIV}
`define DIVicc	{4'b0110, `DIV}
`define CDIVrZ	{4'b0001, `DIV}
`define CDIViZ	{4'b0101, `DIV}
`define MODr	{4'b0000, `MOD}
`define	MODi	{4'b0100, `MOD}
`define MODrcc	{4'b0010, `MOD}
`define MODicc	{4'b0110, `MOD}
`define CMODrZ	{4'b0001, `MOD}
`define CMODiZ	{4'b0101, `MOD}
`define NANDr	{4'b0000, `NAND}
`define	NANDi	{4'b0100, `NAND}
`define NANDrcc	{4'b0010, `NAND}
`define NANDicc	{4'b0110, `NAND}
`define CNANDrZ	{4'b0001, `NAND}
`define CNANDiZ	{4'b0101, `NAND}
`define NORr	{4'b0000, `NOR}
`define	NORi	{4'b0100, `NOR}
`define NORrcc	{4'b0010, `NOR}
`define NORicc	{4'b0110, `NOR}
`define CNORrZ	{4'b0001, `NOR}
`define CNORiZ	{4'b0101, `NOR}
`define XNORr	{4'b0000, `XNOR}
`define	XNORi	{4'b0100, `XNOR}
`define XNORrcc	{4'b0010, `XNOR}
`define XNORicc	{4'b0110, `XNOR}
`define CXNORrZ	{4'b0001, `XNOR}
`define CXNORiZ	{4'b0101, `XNOR}
`define INCr	{4'b0000, `INC}
`define	INCi	{4'b0100, `INC}
`define INCrcc	{4'b0010, `INC}
`define INCicc	{4'b0110, `INC}
`define CINCrZ	{4'b0001, `INC}
`define CINCiZ	{4'b0101, `INC}
`define DECr	{4'b0000, `DEC}
`define	DECi	{4'b0100, `DEC}
`define DECrcc	{4'b0010, `DEC}
`define DECicc	{4'b0110, `DEC}
`define CDECrZ	{4'b0001, `DEC}
`define CDECiZ	{4'b0101, `DEC}
`define CEr	{4'b0000, `CE}
`define	CEi	{4'b0100, `CE}
`define CErcc	{4'b0010, `CE}
`define CEicc	{4'b0110, `CE}
`define CCErZ	{4'b0001, `CE}
`define CCEiZ	{4'b0101, `CE}
`define CBEr	{4'b0000, `CBE}
`define	CBEi	{4'b0100, `CBE}
`define CBErcc	{4'b0010, `CBE}
`define CBEicc	{4'b0110, `CBE}
`define CCBErZ	{4'b0001, `CBE}
`define CCBEiZ	{4'b0101, `CBE}
`define CAEr	{4'b0000, `CAE}
`define	CAEi	{4'b0100, `CAE}
`define CAErcc	{4'b0010, `CAE}
`define CAEicc	{4'b0110, `CAE}
`define CCAErZ	{4'b0001, `CAE}
`define CCAEiZ	{4'b0101, `CAE}
`define CBr	{4'b0000, `CB}
`define	CBi	{4'b0100, `CB}
`define CBrcc	{4'b0010, `CB}
`define CBicc	{4'b0110, `CB}
`define CCBrZ	{4'b0001, `CB}
`define CCBiZ	{4'b0101, `CB}
`define CAr	{4'b0000, `CA}
`define	CAi	{4'b0100, `CA}
`define CArcc	{4'b0010, `CA}
`define CAicc	{4'b0110, `CA}
`define CCArZ	{4'b0001, `CA}
`define CCAiZ	{4'b0101, `CA}
`define CNEr	{4'b0000, `CNE}
`define	CNEi	{4'b0100, `CNE}
`define CNErcc	{4'b0010, `CNE}
`define CNEicc	{4'b0110, `CNE}
`define CCNErZ	{4'b0001, `CNE}
`define CCNEiZ	{4'b0101, `CNE}
`define PWRr	{4'b0000, `PWR}
`define	PWRi	{4'b0100, `PWR}
`define PWRrcc	{4'b0010, `PWR}
`define PWRicc	{4'b0110, `PWR}
`define CPWRrZ	{4'b0001, `PWR}
`define CPWRiZ	{4'b0101, `PWR}
`define FACTr	{4'b0000, `FACT}
`define	FACTi	{4'b0100, `FACT}
`define FACTrcc	{4'b0010, `FACT}
`define FACTicc	{4'b0110, `FACT}
`define CFACTrZ	{4'b0001, `FACT}
`define CFACTiZ	{4'b0101, `FACT}
`define SRLr 	{4'b0000, `SRL} 
`define SLLr	{4'b0000, `SLL} 	
`define SLAr	{4'b0000, `SLA}


//Multi-core Opcodes
`define MOVC1C2 {4'b0000, `MOVC1, `R0}
`define MOVC2C1 {4'b0000, `MOVC2, `R0}

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