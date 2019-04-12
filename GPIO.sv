// GPIO block  Design For Test
// Jesus Abraham Lizarraga Banuelos
// Mar-24-2018
// GPIO.sv
//

timeunit 1ns;
timeprecision 100ps;

module GPIO
#(
   parameter BIT_WIDTH=32,
   parameter REG_WIDTH = $clog2(BIT_WIDTH),
   parameter BIT_SEL=3,
   parameter BIT_CTRL=5
)
(
 input logic  [BIT_WIDTH-1:0] Data, Address,
 input rst, clk,
 output logic [7:0] GPIO_PORT_OUT
);

always_ff @(posedge clk, negedge rst)
begin
 if(!rst)
  GPIO_PORT_OUT=8'd0;
 else if(Address==32'h10010024) begin
  GPIO_PORT_OUT=Data[7:0];
 end
end

endmodule
