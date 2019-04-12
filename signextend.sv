// Sign Extend
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// signextend.sv
//

timeunit 1ns;
timeprecision 100ps;

module signextend
#(
    parameter BIT_WIDTH=32,
    parameter HALF_BIT_WIDTH=16
)
(
 output logic [BIT_WIDTH-1:0] SignImm,
 input logic  [HALF_BIT_WIDTH-1:0] half_sign_in
);

always_comb
begin
 if(half_sign_in[HALF_BIT_WIDTH-1]) begin
  SignImm={16'hFFFF,half_sign_in};
 end
 else begin
  SignImm={16'h0,half_sign_in};
 end
end

endmodule
