
// DFT UART block  Design For Test
// Jesus Abraham Lizarraga Banuelos
// Abr-01-2018
// DFT_UART_t2.sv
//

timeunit 1ns;
timeprecision 100ps;

module DFT_UART_t2
#(
   parameter BIT_WIDTH=32,
   parameter REG_WIDTH = $clog2(BIT_WIDTH),
   parameter BIT_SEL=3,
   parameter BIT_CTRL=5
)
(
 input logic  [BIT_WIDTH-1:0] Data, Address,PC,
 input rst, clk, uart_busy, RegWrite,
 output logic [7:0] uart_dat_i,
 output logic uart_wr_i
);


localparam IDLE= 5'd0,COUNT3= 5'd1,
	   COUNT2= 5'd2,COUNT1= 5'd3,
           COUNT0= 5'd4,FINISH_ST=5'd5; 

logic [4:0] state, nstate;
logic  [BIT_WIDTH-1:0] data_tmp;
logic f_work;

logic ser_clk; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd50000000; //1 sec

always @(posedge clk)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
end

assign ser_clk = (counter<DIVISOR/2)?1'b0:1'b1;

always_ff @(posedge clk, negedge rst)
begin
 if(!rst)
  data_tmp=32'h0;
 else if(Address==32'h00000002 && PC==32'h400040 && RegWrite==1'b1) begin
  data_tmp=Data;
 end
end //always

always_comb
begin
 nstate= state;
 case (state)
  IDLE: nstate =  (~uart_busy & |data_tmp &f_work)? COUNT3: IDLE;
  COUNT3: nstate =  (~uart_busy)? COUNT2: COUNT3;
  COUNT2: nstate =  (~uart_busy)? COUNT1: COUNT2;
  COUNT1: nstate =  (~uart_busy)? COUNT0: COUNT1;
  COUNT0: nstate =  (~uart_busy)? COUNT3: COUNT0;
 endcase //state
end

always_ff @(posedge ser_clk, negedge rst)
begin
 if (!rst)
  begin
    state<= IDLE;
  end
  else
  begin
   state<=nstate;
  end 
end




always_comb
begin
 uart_wr_i=1'b0;
 uart_dat_i=8'hAA;
 f_work=1'b0;
 case (state)
  IDLE: begin
   f_work=(Address==32'h00000002 && PC==32'h400040 && RegWrite==1'b1)? 1:0;
  end //IDLE case 
  
  COUNT3: begin
    //uart_dat_i=data_tmp[31:24];
    uart_dat_i=8'hF1;
    uart_wr_i=1'b1;
	 i=3'd1;
  end //COUNT3 case 
  COUNT2: begin
   // uart_dat_i=data_tmp[23:16];
	 uart_dat_i=8'hE2;
    uart_wr_i=1'b1;
	 i=3'd2
  end //COUNT2 case 
  COUNT1: begin
   // uart_dat_i=data_tmp[15:8];
	 uart_dat_i=8'hD3;
    uart_wr_i=1'b1;
	 i=3'd3;
  end //COUNT1 case 
  COUNT0: begin
//    uart_dat_i=data_tmp[7:0];
 	 uart_dat_i=8'hC4;
    uart_wr_i=1'b1;
  end //COUNT0 case 
  FINISH_ST: begin
  end //FINISH_ST case

 endcase
end //always

endmodule