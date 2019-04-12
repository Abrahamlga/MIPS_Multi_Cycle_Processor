
// File to select 1 output with 4 inputs
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// mux_3.sv
//

timeunit 1ns;
timeprecision 100ps;

module mux_3
#(
    parameter BIT_WIDTH=32,
    parameter BIT_SEL=2
)
(
 output logic [BIT_WIDTH-1:0] Mux_out,
 input logic  [BIT_WIDTH-1:0] Mux_in0, Mux_in1, Mux_in2,
 input logic [BIT_SEL-1:0] sel
);

always_comb
begin
 case(sel)
  0:Mux_out=Mux_in0;
  1:Mux_out=Mux_in1;
  2:Mux_out=Mux_in2;
  default:Mux_out=Mux_in0;
 endcase
end
endmodule
