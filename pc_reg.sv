// File to generate PC register file
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// pc_reg.sv
//

timeunit 1ns;
timeprecision 100ps;

module pc_reg
#(
    parameter BIT_WIDTH=32
)
(
 output logic [BIT_WIDTH-1:0] Read_Data,
 input logic  [BIT_WIDTH-1:0] Write_Data,
 input logic en,clk,rst
);

always_ff @(posedge clk)
begin
 if (!rst)
  begin
    Read_Data <= 32'h00400000;
  end
  else
  begin
    if(en)
    begin // rite in reg
     Read_Data<= Write_Data;
    end
  end 
end //always

endmodule
