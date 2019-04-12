
// File to select 1 output with 4 inputs
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// mux_2.sv
//

timeunit 1ns;
timeprecision 100ps;

module mux_4
#(
    parameter BIT_WIDTH=32,
    parameter BIT_SEL=2
)
(
 output logic [BIT_WIDTH-1:0] Mux_out,
 input logic  [BIT_WIDTH-1:0] Mux_in0, Mux_in1, Mux_in2, Mux_in3,
 input logic [BIT_SEL-1:0] sel
);

always_comb
begin
 case(sel)
  0:Mux_out=Mux_in0;
  1:Mux_out=Mux_in1;
  2:Mux_out=Mux_in2;
  3:Mux_out=Mux_in3;
  default:Mux_out=32'h0;
 endcase
end
endmodule
