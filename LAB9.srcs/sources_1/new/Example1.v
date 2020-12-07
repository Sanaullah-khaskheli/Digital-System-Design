`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2020 02:03:09 PM
// Design Name: 
// Module Name: Example1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Example1(clk, Rs, level, tick );
input clk, Rs, level;
output reg tick;
reg state, nextstate;
parameter S0= 0, S1 = 1;

always @(posedge clk , posedge Rs)
    if(Rs)
        state <=S0;
     else
     state <= nextstate;
     
  always @(state or level)
  begin 
        tick = 1'b0;
     case(state)
         S0: if(level) 
             begin
                 tick = 1; nextstate = S1;
                end
     else 
              nextstate = S0; 
         S1: if(level )
               nextstate = S0;
            else 
              begin
                 tick = 1; nextstate =1;
              end       
    default
            nextstate  = S0;         
   endcase   

end
endmodule

module TB;
reg clk, Rs, level;
wire tick;

 Example1   Mealy_2pr(clk, Rs, level, tick );
initial
clk = 0;

always
#10 clk = ~clk;

initial
begin
    Rs = 0;
   repeat (5)     @(negedge clk) Rs = ~Rs;
   
     level = 0;
     repeat (5)     @(negedge clk) level = ~level;
   $stop;
  

end

endmodule

