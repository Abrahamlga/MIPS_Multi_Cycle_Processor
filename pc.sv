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
 output logic [BIT_WIDTH-1:0] pc_out,
 input logic  [BIT_WIDTH-1:0] Write_Data,
 input logic pc_branch,clk,rst
);

logic [BIT_WIDTH-1:0] reg_branch;

always_comb
begin
 if(pc_branch) begin
  reg_branch=Write_Data;
 end
 else begin
  reg_branch=32'h0;
end

always_ff @(posedge clk)
begin
 if (!rst)
  begin
   pc_out<=0;
  end
  else
  begin
     pc_out<=pc_out+Write_Data+32'h4;
  end 
end //always

endmodule
