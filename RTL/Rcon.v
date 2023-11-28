`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 04:04:32 PM
// Design Name: 
// Module Name: Rcon
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


module Rcon(
    input  [3:0] round,
    output reg [31:0] rcon_out
    );
    
    always @(*)
 case(round)
    4'h1: rcon_out=32'h01000000;
    4'h2: rcon_out=32'h02000000;
    4'h3: rcon_out=32'h04000000;
    4'h4: rcon_out=32'h08000000;
    4'h5: rcon_out=32'h10000000;
    4'h6: rcon_out=32'h20000000;
    4'h7: rcon_out=32'h40000000;
    4'h8: rcon_out=32'h80000000;
    4'h9: rcon_out=32'h1b000000;
    4'ha: rcon_out=32'h36000000;
    default: rcon_out=32'h00000000;
  endcase
endmodule
