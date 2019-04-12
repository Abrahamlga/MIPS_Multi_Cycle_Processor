// Top module, includes GPIO block and MIPS_arch
// Jesus Abraham Lizarraga Banuelos
// Mar-24-2018
// Top_module.sv
//


timeunit 1ns;
timeprecision 100ps;

module Top_module
#(
   parameter BIT_WIDTH=32,
   parameter REG_WIDTH = $clog2(BIT_WIDTH),
   parameter BIT_SEL=3,
   parameter BIT_CTRL=5
)
(
  input logic clk, rst,
  output logic uart_tx

);

logic RegWrite,uart_busy;
logic  [BIT_WIDTH-1:0] Data, Address,PC,Read_Data_V0;
logic uart_wr_i;
logic [7:0] uart_dat_i;


MIPS_arch MIPS_arch1
(
 .clk(clk),
 .rst(rst),
 .DFT_data(Data),
 .DFT_Address_in(Address),
 .DFT_PC(PC),
 .DFT_RegWrite(RegWrite),
 .DFT_Read_Data_V0(Read_Data_V0)
);

DFT_UART DFT_UART1
(
 .rst(rst),
 .clk(clk),
 .Data(Data),
 .Address(Address),
 .uart_dat_i(uart_dat_i),
 .PC(PC),
 .uart_busy(1'b0), 
 .RegWrite(RegWrite),
 .Read_Data_V0(Read_Data_V0),
 .uart_wr_i(uart_wr_i)
);


 UART UART1(
   .uart_busy(uart_busy),   // High means UART is transmitting
   .uart_tx(uart_tx),     // UART transmit wire
   .uart_wr_i(uart_wr_i),   // Raise to transmit byte
   .uart_dat_i(uart_dat_i),  // 8-bit data
   .sys_clk_i(clk),   // System clock, 68 MHz
   .sys_rst_i(~rst)    // System reset

);
endmodule
