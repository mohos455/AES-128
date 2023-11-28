`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: MixColumns
// Project Name: AES
//////////////////////////////////////////////////////////////////////////////////


module MixColumns(
    input clk,reset_n,
    input [127:0] data_in,
    input enable ,
    output reg [127:0] data_mixed,
    output reg done 
    );
    wire [127:0] Mixed_columns;
    
    function [7:0] Multbytwo ;
        input [7:0] X;
        begin
            if(X[7] == 0)
                Multbytwo = X << 1;
            else
                Multbytwo = (X<<1) ^ (8'b00011011) ;
        end
    endfunction
       
      function [7:0] Multbythree ;
        input [7:0] X;
        begin
           Multbythree = Multbytwo(X) ^ X ;
        end
    endfunction           
    
    // 02   03   01   01  d4  1101 0100
    // 01   02   03   01  bf  1011 1111
    // 01   01   02   03  5d  0101 1101
    // 03   01   01   02  30  0011 0000
    // first colum
   assign Mixed_columns[127:120] = Multbytwo(data_in[127:120]) ^ Multbythree(data_in[119:112]) ^ data_in[111:104] ^data_in[103:96];
   assign Mixed_columns[119:112] = data_in[127:120] ^ Multbytwo(data_in[119:112]) ^ Multbythree(data_in[111:104])^ data_in[103:96];
   assign Mixed_columns[111:104] = data_in[127:120] ^ data_in[119:112] ^ Multbytwo(data_in[111:104]) ^ Multbythree(data_in[103:96]);
   assign Mixed_columns[103:96] = Multbythree(data_in[127:120]) ^ data_in[119:112] ^ data_in[111:104] ^ Multbytwo(data_in[103:96]) ;
   // second colum
   assign Mixed_columns[95:88] = Multbytwo(data_in[95:88]) ^ Multbythree(data_in[87:80]) ^ data_in[79:72] ^data_in[71:64];
   assign Mixed_columns[87:80] = data_in[95:88] ^ Multbytwo(data_in[87:80]) ^ Multbythree(data_in[79:72])^ data_in[71:64];
   assign Mixed_columns[79:72] = data_in[95:88] ^ data_in[87:80] ^ Multbytwo(data_in[79:72]) ^ Multbythree(data_in[71:64]);
   assign Mixed_columns[71:64] = Multbythree(data_in[95:88]) ^ data_in[87:80] ^ data_in[79:72] ^ Multbytwo(data_in[71:64]) ;
   // third colum
   assign Mixed_columns[63:56] = Multbytwo(data_in[63:56]) ^ Multbythree(data_in[55:48]) ^ data_in[47:40] ^data_in[39:32];
   assign Mixed_columns[55:48] = data_in[63:56] ^ Multbytwo(data_in[55:48]) ^ Multbythree(data_in[47:40])^ data_in[39:32];
   assign Mixed_columns[47:40] = data_in[63:56] ^ data_in[55:48] ^ Multbytwo(data_in[47:40]) ^ Multbythree(data_in[39:32]);
   assign Mixed_columns[39:32] = Multbythree(data_in[63:56]) ^ data_in[55:48] ^ data_in[47:40] ^ Multbytwo(data_in[39:32]) ;
   // fourth colum
   assign Mixed_columns[31:24] = Multbytwo(data_in[31:24]) ^ Multbythree(data_in[23:16]) ^ data_in[15:8] ^data_in[7:0];
   assign Mixed_columns[23:16] = data_in[31:24] ^ Multbytwo(data_in[23:16]) ^ Multbythree(data_in[15:8])^ data_in[7:0];
   assign Mixed_columns[15:8] = data_in[31:24] ^ data_in[23:16] ^ Multbytwo(data_in[15:8]) ^ Multbythree(data_in[7:0]);
   assign Mixed_columns[7:0] = Multbythree(data_in[31:24]) ^ data_in[23:16] ^ data_in[15:8] ^ Multbytwo(data_in[7:0]) ;
   
   
    always @(posedge clk ,negedge reset_n)
        begin
            if(~reset_n)
                begin
                    data_mixed<=0 ;
                    done <=0;
                 end
            
            else if (enable)
                    begin
                        data_mixed <= Mixed_columns ;
                        done <= 1 ;
                    end    
            else 
                   done <=0;
        end
   
   
endmodule
