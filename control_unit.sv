// Control unit 
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// control_unit.sv
//

timeunit 1ns;
timeprecision 100ps;

module control_unit
#(
    parameter BIT_WIDTH=32,
    parameter BIT_SEL=3,
    parameter BIT_CTRL=6
)
(
 input logic clk, rst,
 input logic [BIT_CTRL-1:0] Op,Funct,
 output logic [BIT_WIDTH-1:0] Branch, PCWrite,
 output logic [BIT_SEL:0] ALUControl,
 output logic RegWrite,
 output logic MemWrite,
 output logic IorD,
 output logic [1:0] PCSrc,
 output logic [1:0] ALUSrcA,
 output logic [1:0] ALUSrcB,
 output logic MemtoReg,
 output logic [1:0] RegDst,
 output logic IRWrite
 
);

localparam I_FETCH=4'd0,I_DECODE= 4'd1,
	   EXE_I= 4'd2,WRITE_BACK= 4'd3,
           EXE_1= 4'd4, RESULT1= 4'd5,
           EXE_2= 4'd6, RESULT2= 4'd7,
	   EXE_3= 4'd8, RESULT3= 4'd9;


CU_statem CU_statem1
(
 .clk(clk),
 .rst(rst),
 .Op(Op),.Funct(Funct),
 .Branch(Branch),.PCWrite(PCWrite),
 .RegWrite(RegWrite),
 .MemWrite(MemWrite),
 .IorD(IorD),
 .PCSrc(PCSrc),
 .ALUSrcA(ALUSrcA),
 .ALUSrcB(ALUSrcB),
 .MemtoReg(MemtoReg),
 .RegDst(RegDst),
 .IRWrite(IRWrite),
 .ALUControl(ALUControl)

);
endmodule

