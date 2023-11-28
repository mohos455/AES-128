`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: AES_tb
// Project Name: AES
//////////////////////////////////////////////////////////////////////////////////


module AES_tb(

    );
reg clk , reset_n ;
reg [127:0] datain ,key ;
reg enable ;
wire done;
wire [127:0] dataout;

    initial
    begin
    datain = 128'h3243f6a8885a308d313198a2e0370734;
    key =    128'h2b7e151628aed2a6abf7158809cf4f3c;
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
		reset_n  = 1'b1;
		#10 
		reset_n  = 1'b0;
		#30
		reset_n  = 1'b1;
	end
	
	AES_control DUT(
	   .clk(clk),
	   .reset_n(reset_n),
	   .enable(enable),
	   .datain(datain),
	   .key(key),
	   .dataout(dataout),
	   .done(done)
	);
  
	initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
   end
	initial
	begin
     #8000
     enable = 0 ;
    	end
endmodule