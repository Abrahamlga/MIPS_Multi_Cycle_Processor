// TB Top module, includes GPIO block and MIPS_arch
// Jesus Abraham Lizarraga Banuelos
// Mar-24-2018
// TB_Top_module.sv
//


timeunit 1ns;
timeprecision 100ps;

module TB_Top_module;
   parameter BIT_WIDTH=32;
   parameter BIT_SEL=3;
   parameter BIT_CTRL=5;

`define PERIOD 10

 logic clk, rst;
 logic [8:0] GPIO_PORT_OUT;

Top_module Top_module1 (.*);

always
 begin
    #(`PERIOD/2) clk = ~clk;
 end

initial
begin
 rst=0;
 clk=0;
 #(`PERIOD * 5);
 rst=1;
 #(`PERIOD * 1500);
 $finish;
end


endmodule
