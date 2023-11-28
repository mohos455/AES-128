`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 04:51:36 AM
// Design Name: 
// Module Name: SR_TB
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


module SR_TB();

reg clk , reset_n ;
reg [127:0] datain ;
reg enable ;
wire done;
wire [127:0] dataout;

    initial
    begin
    datain = 128'hd42711aee0bf98f1b8b45de51e415230;
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
	
	Shift_Row DUT(
	   .clk(clk),
	   .reset_n(reset_n),
	   .enable(enable),
	   .data_in(datain),
	   .data_Shifted(dataout),
	   .done(done)
	);
	
	initial
	begin
     #100
     enable = 0 ;	
	 #200 $stop;
	end
endmodule
