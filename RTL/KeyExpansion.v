`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: KeyExpansion
// Project Name: AES
// 
//////////////////////////////////////////////////////////////////////////////////
module KeyExpansion(
    input clk,reset_n,
    input enable,
    input [3:0] round,
    input [127:0] key_in,
    output reg [127:0] key_out
 );
 
 
 
 wire [31:0] W0,W1,W2,W3 ,ROW ,Subyte_out ,rcon;
 
   assign ROW = {key_in[23:0] , key_in[31:24]};
   
   Subytes SUB1 ( .sboxw(ROW),
                 .new_sboxw(Subyte_out) 
                   );
   Rcon R_con1(
       .round(round),
       .rcon_out(rcon)
   );      
             
  assign W0 = Subyte_out ^ key_in[127:96] ^ rcon ;
  assign W1 = key_in[95:64] ^ W0 ;
  assign W2 = key_in[63:32] ^ W1 ;
  assign W3 = key_in[31:0] ^ W2 ;
  
  
  always @(posedge clk ,negedge reset_n)
        begin
            if(~reset_n)
                begin
                    key_out<=0 ;
                 end
            
            else if (enable)
                    begin
                        key_out <= {W0,W1,W2,W3} ;
                    end    
            else 
                key_out <= 0;
        end
endmodule
