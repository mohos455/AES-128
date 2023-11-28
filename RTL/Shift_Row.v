`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Shift_Row
// Project Name: AES
//////////////////////////////////////////////////////////////////////////////////
module Shift_Row(
    input clk , reset_n,
    input enable,
    input wire [127:0] data_in,
    output reg [127:0] data_Shifted ,
    output reg done
    );
    
    wire [127 : 0 ] shifted_rows ;
    
    always @(posedge clk ,negedge reset_n)
        begin
            if(~reset_n)
                begin
                    data_Shifted<=0 ;
                    done <=0;
                 end
            
            else if (enable)
                    begin
                        data_Shifted <= shifted_rows ;
                        done <= 1 ;
                    end    
            else 
                   done <=0;
        end
    
  assign shifted_rows[127:96] = {data_in[127:120] ,data_in[87:80] ,data_in[47:40] ,data_in[7:00]} ; 
  assign shifted_rows[95:64] = {data_in[95:88] ,data_in[55:48] ,data_in[15:8] ,data_in[103:96]} ; 
  assign shifted_rows[63:32] = {data_in[63:56] ,data_in[23:16] ,data_in[111:104] ,data_in[71:64]} ; 
  assign shifted_rows[31:0] = {data_in[31:24] ,data_in[119:112] ,data_in[79:72] ,data_in[39:32]} ; 
endmodule
