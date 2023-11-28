`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////// 
// Module Name: AddRoundKey
// Project Name: AES
////////////////////////////////////////////////////////////////////////////////////


module AddRoundKey(
    input clk,reset_n,enable,
    input [127:0] data_in, Key_in,
    output reg [127:0] data_rounded,
    output reg done
    );
    
    wire [127:0] Data_round;
    
    assign Data_round = data_in ^ Key_in ;
     always @(posedge clk ,negedge reset_n)
        begin
            if(~reset_n)
                begin
                    data_rounded<=0 ;
                    done <=0;
                 end
            
            else if (enable)
                    begin
                        data_rounded <= Data_round ;
                        done <= 1 ;
                    end    
            else 
                   done <=0;
        end
endmodule
