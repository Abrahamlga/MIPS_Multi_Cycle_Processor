// MIPS Architecture
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// MIPS_arch.sv
//

timeunit 1ns;
timeprecision 100ps;

module MIPS_arch
#(
   parameter BIT_WIDTH=32,
   parameter REG_WIDTH = $clog2(BIT_WIDTH),
   parameter BIT_SEL=3,
   parameter BIT_CTRL=5
)
(
  input logic clk, rst,
  //DFT UART
  output  logic [BIT_WIDTH-1:0] DFT_data, DFT_Address_in, DFT_PC, DFT_Read_Data_V0,
  output logic DFT_RegWrite

);

logic [BIT_WIDTH-1:0] Address_in;
logic [BIT_WIDTH-1:0] pc_mux;
logic [BIT_WIDTH-1:0] data_PC;
logic [BIT_WIDTH-1:0] PC_instruction;
logic [BIT_WIDTH-1:0] mem_2_instr_reg;
logic [BIT_WIDTH-1:0] memdata_2_muxWD3;
logic [BIT_WIDTH-1:0] reg_2regA, reg_2regB;
logic [BIT_WIDTH-1:0] regA_2pcALU;
logic [BIT_WIDTH-1:0] regB_4MuxALU;
logic [BIT_WIDTH-1:0] ALUResult, ALUOut;
logic [BIT_WIDTH-1:0] mux_regWD3;
logic [BIT_WIDTH-1:0] SrcA,SrcB;
logic [BIT_WIDTH-1:0] SignImm,Shifl2_out,Jaddress;
logic RegWrite;
logic [REG_WIDTH-1:0] mux_regWriteA3;
logic [BIT_SEL:0] ALUControl;

logic [1:0] ALUSrcA,ALUSrcB;
logic IorD;
logic [1:0] PCSrc;
logic branch,PCWrite,PCEn;
logic MemtoReg;
logic [1:0] RegDst;
logic IRWrite;
logic MemWrite;
logic Zero;

//DFT
assign DFT_Address_in=mux_regWriteA3;
assign DFT_data=mux_regWD3;
assign DFT_PC=pc_mux;
assign DFT_RegWrite=RegWrite;

pc_reg pc
(
 .Read_Data(pc_mux),
 .Write_Data(data_PC),
 .en(PCEn),
 .clk(clk),
 .rst(rst)
);

pc_reg mem_instr_reg
(
 .Read_Data(PC_instruction),
 .Write_Data(mem_2_instr_reg),
 .en(IRWrite),
 .clk(clk),
 .rst(rst)
);

pc_reg mem_data_reg
(
 .Read_Data(memdata_2_muxWD3),
 .Write_Data(mem_2_instr_reg),
 .en(1'b1),
 .clk(clk),
 .rst(rst)
);

pc_reg regA
(
 .Read_Data(regA_2pcALU),
 .Write_Data(reg_2regA),
 .en(1'b1),
 .clk(clk),
 .rst(rst)
);

pc_reg regB
(
 .Read_Data(regB_4MuxALU),
 .Write_Data(reg_2regB),
 .en(1'b1),
 .clk(clk),
 .rst(rst)
);

pc_reg reg_ALU
(
 .Read_Data(ALUOut),
 .Write_Data(ALUResult),
 .en(1'b1),
 .clk(clk),
 .rst(rst)
);

mux_2 mux_PC
(
 .Mux_out(Address_in),
 .Mux_in0(pc_mux),
 .Mux_in1(ALUOut),
 .sel(IorD)
);

mux_3 mux_A3
(
 .Mux_out(mux_regWriteA3),
 .Mux_in0(PC_instruction[20:16]),
 .Mux_in1(PC_instruction[15:11]),
 .Mux_in2(32'h1F),
 .sel(RegDst)
);

mux_2 mux_WD3
(
 .Mux_out(mux_regWD3),
 .Mux_in0(ALUOut),
 .Mux_in1(memdata_2_muxWD3),
 .sel(MemtoReg)
);

mux_3 mux_PCALU
(
 .Mux_out(SrcA),
 .Mux_in0(pc_mux),
 .Mux_in1(regA_2pcALU),
 .Mux_in2({27'd0,PC_instruction[10:6]}),
 .sel(ALUSrcA)
);

mux_3 mux_ALUout
(
 .Mux_out(data_PC),
 .Mux_in0(ALUResult),
 .Mux_in1(ALUOut),
 .Mux_in2({pc_mux[31:28],Jaddress[27:0]}),
 .sel(PCSrc)
);

mux_4 mux_4ALU
(
 .Mux_out(SrcB),
 .Mux_in0(regB_4MuxALU),
 .Mux_in1(32'h4),
 .Mux_in2(SignImm),
 .Mux_in3(Shifl2_out),
 .sel(ALUSrcB)
);

mem_arch instrdata_mem
(
 .Read_Data_out(mem_2_instr_reg),
 .Write_Data_in(regB_4MuxALU),
 .Address_in(Address_in),
 .MemWrite(MemWrite),
 .clk(clk),
 .rst(rst)
);
misc_logic mlogic1
(
 .alu_zero(Zero),
 .branch(branch),
 .pcwrite(PCWrite),
 .PCEn(PCEn)
);
control_unit cu
(
 .clk(clk),
 .rst(rst),
 .IorD(IorD),
 .MemWrite(MemWrite),
 .IRWrite(IRWrite),
 .Op(PC_instruction[31:26]),
 .Funct(PC_instruction[5:0]),
 .RegWrite(RegWrite),
 .ALUSrcA(ALUSrcA),
 .ALUSrcB(ALUSrcB),
 .ALUControl(ALUControl),
 .PCSrc(PCSrc),
 .Branch(branch),
 .PCWrite(PCWrite), 
 .MemtoReg(MemtoReg),
 .RegDst(RegDst)
);

signextend sign_ext
(
 .SignImm(SignImm),
 .half_sign_in(PC_instruction[15:0])
);

Shiftl2 shftl2
(
 .Shifl2_out(Shifl2_out),
 .SignImm(SignImm)
);

Shiftl2 shft_Jaddress
(
 .Shifl2_out(Jaddress),
 .SignImm({6'd0,PC_instruction[25:0]})
);


register_file reg_file
(
 .Read_Data_V0(DFT_Read_Data_V0),
 .Read_Data_1(reg_2regA),
 .Read_Data_2(reg_2regB),		
 .Write_Data(mux_regWD3),
 .Write_reg(mux_regWriteA3),
 .Read_reg1(PC_instruction[25:21]),
 .Read_reg2(PC_instruction[20:16]),
 .write(RegWrite),
 .clk(clk),
 .rst(rst)

);

ALU ALU1
(
 .ALUResult(ALUResult),
 .SrcA(SrcA),
 .SrcB(SrcB),
 .ALUControl(ALUControl),
 .Zero(Zero)
);

endmodule
