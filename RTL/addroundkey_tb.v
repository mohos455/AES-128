`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 02:40:11 PM
// Design Name: 
// Module Name: addroundkey_tb
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


module addroundkey_tb( );
reg clk , reset_n ;
reg [127:0] datain1,datain2 ;
reg enable ;
wire done;
wire [127:0] dataout;

    initial
    begin
    datain1 = 128'h3243f6a8885a308d313198a2e0370734;
    datain2 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    enable = 1;
    end
    
    
initial begin
		clk = 1'b0;
		//testbench_out = 15'd0 ;
	end	
	//Toggle the clocks
	always begin
		#10
		clk = !clk;
	end
	

initial begin
		reset_n  = 1'b0;
		#10 
		reset_n  = 1'b1;
		#30
		reset_n  = 1'b0;
	end
	
	AddRoundKey DUT(
	   .clk(clk),
	   .reset_n(reset_n),
	   .enable(enable),
	   .data_in(datain1),
	   .Key_in(datain2),
	   .data_rounded(dataout),
	   .done(done)
	);
  
	initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
   end
	initial
	begin
     #100
     enable = 0 ;
    	end
endmodule
