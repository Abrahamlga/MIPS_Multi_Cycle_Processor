// File to select 1 output with 4 inputs
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// mux_2.sv
//

timeunit 1ns;
timeprecision 100ps;

module mux_2
#(
    parameter BIT_WIDTH=32
)
(
 output logic [BIT_WIDTH-1:0] Mux_out,
 input logic  [BIT_WIDTH-1:0] Mux_in0, Mux_in1,
 input logic sel
);

always_comb
begin
 if(sel) begin
  Mux_out=Mux_in1;
 end
 else begin
  Mux_out=Mux_in0;
 end
end

endmodule
