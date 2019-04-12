// Shift left 2 bits (X * 4)
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// Shiftl2.sv
//

timeunit 1ns;
timeprecision 100ps;

module Shiftl2
#(
    parameter BIT_WIDTH=32
)
(
 output logic [BIT_WIDTH-1:0] Shifl2_out,
 input logic  [BIT_WIDTH-1:0] SignImm
);

always_comb
begin
 Shifl2_out={SignImm[BIT_WIDTH-3:0],2'b00};
end

endmodule
