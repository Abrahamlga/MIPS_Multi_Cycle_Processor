// Memory ram
// Jesus Abraham Lizarraga Banuelos
// March-09-2018
// mem.sv
//

timeunit 1ns;
timeprecision 100ps;
module mem
#(
    parameter BIT_WIDTH=32
)
(
 output logic [BIT_WIDTH-1:0] Read_Data_out,
 input logic  [BIT_WIDTH-1:0] Write_Data_in, Address_in,
 input logic  MemWrite,clk
);

//logic
//logic [BIT_WIDTH-1:0] register [BIT_WIDTH-1:0];
logic [BIT_WIDTH-1:0] register [128-1:0];

logic [BIT_WIDTH-1:0] register_out;

always_comb
begin
 register_out = register[Address_in];
 Read_Data_out= register_out;
end

always_ff @(posedge clk)
begin
    if(MemWrite) begin
     // write
     register[Address_in]<= Write_Data_in;
    end
end //always

endmodule
