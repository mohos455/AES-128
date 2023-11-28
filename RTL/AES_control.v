`timescale 1ns / 1ps

module AES_control(
    input clk,reset_n,enable,
    input [127:0] datain, key,
    output   [127:0] dataout,
    output   done
    );
    
    reg ADD_Round_en , KeyExpansion_en ,Shift_Row_en ,MixColumns_en  ;
    wire ADD_Round_done,Shift_Row_done,MixColumns_done ;
    wire [127:0] addround_out , subbyte_out , Shift_Row_out , MixColumns_out , KeyExpansion_out;
    reg [127:0] addround_data_in, addround_key_in;
    reg [3:0] round_reg , round_next;
    reg [127:0] key_reg , key_next ;
    reg [2:0] state_reg , state_next;

    
    AddRoundKey AddRoundKey_U1(
    .clk(clk),
    .reset_n(reset_n),
    .enable(ADD_Round_en),
    .data_in(addround_data_in),
    .Key_in(addround_key_in),
    .data_rounded(addround_out),
    .done(ADD_Round_done)
    );
       
     //// Subbytes
    Subytes Subytes_U1 (
        .sboxw(addround_out[127:96]),
        .new_sboxw(subbyte_out[127:96])
    );
    Subytes Subytes_U2 (
        .sboxw(addround_out[95:64]),
        .new_sboxw(subbyte_out[95:64])
    );
     Subytes Subytes_U3 (
        .sboxw(addround_out[63:32]),
        .new_sboxw(subbyte_out[63:32])
    );
     Subytes Subytes_U4 (
        .sboxw(addround_out[31:0]),
        .new_sboxw(subbyte_out[31:0])
    );
    
    
   Shift_Row Shift_Row_U1(
         .clk(clk),
       .reset_n(reset_n),
       .enable(Shift_Row_en),
       .data_in(subbyte_out),
       .data_Shifted(Shift_Row_out),
       .done(Shift_Row_done)
    );
    
    MixColumns MixColumns_U1(
        .clk(clk),
       .reset_n(reset_n),
       .enable(MixColumns_en),
       .data_in(Shift_Row_out),
       .data_mixed(MixColumns_out),
       .done(MixColumns_done)
        );
    KeyExpansion KeyExpansion_U1(
         .clk(clk),
       .reset_n(reset_n),
       .enable(KeyExpansion_en),
       .round(round_reg),
       .key_in(key_reg),
       .key_out(KeyExpansion_out)
    );
    ////////////////////////////////////////////
     localparam START = 0,
               SHIFT = 1,
               MIX = 2,
               ADDROUND = 3;
    always @(posedge clk , negedge reset_n) begin
        if(~reset_n)
            begin
                state_reg <= 0;
                round_reg <= 0;
                key_reg <=key;
            end
            else
               begin
               state_reg <= state_next;
                round_reg <= round_next;
                key_reg <=key_next;
               end
    end
    
    always @(*) begin
        round_next= round_reg;
        state_next = state_reg;
        key_next= key_reg;
        if(round_reg <=11)
            begin
        case(state_reg)
            START : begin
                     addround_data_in = datain;
                     addround_key_in =  key;
                     MixColumns_en = 0;
                     KeyExpansion_en = 1;
                     Shift_Row_en =0;
                     ADD_Round_en = 1;
                     round_next = round_reg +1 ;
                     state_next = SHIFT;
                    end
            SHIFT : begin
                        if(ADD_Round_done)
                            begin
                                KeyExpansion_en = 1;
                                MixColumns_en = 0;
                                Shift_Row_en =1;
                                ADD_Round_en = 0;
                                
                                if(round_reg<10)
                                    state_next = MIX;
                                else
                                    state_next = ADDROUND;
                                end
                            end
            MIX :  begin
                    if(Shift_Row_done)
                    begin
                     KeyExpansion_en = 1;
                    MixColumns_en = 1;
                    Shift_Row_en =0;
                    ADD_Round_en = 0;
                    state_next = ADDROUND;
                    end
                    end
          ADDROUND : begin
                    if(MixColumns_done || (Shift_Row_done && (round_reg>=10)) )
                     begin
                    MixColumns_en = 0;
                    Shift_Row_en =0;
                    KeyExpansion_en = 1;
                    ADD_Round_en = 1;
                      if(round_reg <10)
                                            addround_data_in = MixColumns_out;
                                        else
                                            addround_data_in = Shift_Row_out;
                    addround_key_in =KeyExpansion_out ;
                    key_next = KeyExpansion_out;
                    round_next = round_reg +1 ;
                    state_next = SHIFT;
                     end
                
                end
       endcase
       end
       else
                begin
                    KeyExpansion_en = 0;
                    Shift_Row_en = 0;
                    MixColumns_en = 0;
                    ADD_Round_en = 0;
                    round_next = 0;
                end
    
    end
    
    assign   dataout = (round_reg == 11 ) ?  addround_out :  0 ;
     assign  done = (round_reg == 11 ) ? 1 : 0 ;

endmodule
