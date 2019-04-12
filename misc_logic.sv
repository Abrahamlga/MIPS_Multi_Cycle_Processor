// miscellaneous
// File to select 1 output with 4 inputs
// Jesus Abraham Lizarraga Banuelos
// Mar-21-2018
// misc_logic.sv
//

timeunit 1ns;
timeprecision 100ps;

module misc_logic
#(
    parameter BIT_WIDTH=32,
    parameter BIT_SEL=2
)
(
 input logic alu_zero, branch, pcwrite,
 output logic PCEn
);

always_comb
begin
 PCEn =  (alu_zero & branch) | pcwrite ;
end

endmodule
 
