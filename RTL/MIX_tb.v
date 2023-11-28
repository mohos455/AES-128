`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 01:43:34 PM
// Design Name: 
// Module Name: MIX_tb
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


module MIX_tb(

    );

reg clk , reset_n ;
reg [127:0] datain ;
reg enable ;
wire done;
wire [127:0] dataout;

    initial
    begin
    datain = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
   enable = 1;
    #11
   datain = 128'h49db873b453953897f02d2f177de961a;
    #11
   datain = 128'hacc1d6b8efb55a7b1323cfdf457311b5;
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
	
	MixColumns DUT(
	   .clk(clk),
	   .reset_n(reset_n),
	   .enable(enable),
	   .data_in(datain),
	   .data_mixed(dataout),
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