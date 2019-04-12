// File ALU, select the ARIT-LOG operation
// Jesus Abraham Lizarraga Banuelos
// Mar-09-2018
// ALU.sv
//

timeunit 1ns;
timeprecision 100ps;

module ALU
#(
    parameter BIT_WIDTH=32,
    parameter BIT_SEL=3
)
(
 output logic [BIT_WIDTH-1:0] ALUResult,
 input logic  [BIT_WIDTH-1:0] SrcA, SrcB,
 input logic  [BIT_SEL:0] ALUControl,
 output logic Zero
);

always_comb
begin
 ALUResult=32'd0;  //No latch
 Zero=1'b0;   //No latch
 case(ALUControl)
  0:ALUResult=SrcA+SrcB;
  1:ALUResult=SrcA & SrcB;
  2:ALUResult=!(SrcA | SrcB);
  3:ALUResult=SrcA | SrcB;
  4:begin
     if(SrcA < SrcB)
      ALUResult=32'h1;
     else
      ALUResult=32'h0;
   end
  5:ALUResult=SrcB << SrcA ;
  6:ALUResult=SrcB >> SrcA ;
  7:ALUResult=SrcA-SrcB;
  8:ALUResult=SrcA/SrcB;
  9:ALUResult=SrcA*SrcB;
  10:begin
     if(SrcA == SrcB)
      Zero=1'b1;
     else
      Zero=1'b0;
     end
   11:begin
     if(SrcA != SrcB)
      Zero=1'b1;
     else
      Zero=1'b0;
     end
  12:ALUResult=SrcB;
  13:ALUResult=SrcA;
  14:ALUResult={SrcB[BIT_WIDTH/2-1:0],16'b0};
  default:ALUResult=32'h0;
 endcase
end
endmodule
