module addr_decoder(i_addr, o_mux_ctrl, o_mem_en, o_led_en, o_7seg_en);

input       [31:0]  i_addr;
output reg  [1:0]   o_mux_ctrl;
output reg          o_mem_en;
output reg          o_led_en;
output reg          o_7seg_en;

always @* begin

    o_mux_ctrl = 2'b11;  // reading zeroes
    o_mem_en   = 1'b0;
    o_led_en   = 1'b0;
    o_7seg_en  = 1'b0;

    casez (i_addr[31:2])
    
        30'b0?????????: begin
                            o_mem_en   = 1'b1;  // writing to mem
                            o_mux_ctrl = 2'b00; // reading from mem
                        end

        30'h20000000:   begin
                            o_mux_ctrl = 2'b01; // reading from buttons reg
                        end        

        30'h20000001:   begin
                            o_led_en   = 1'b1;  // writing to leds
                        end

        30'h2000001?:   begin
                            o_7seg_en   = 1'b1;  // writing to 7seg displays
                        end

    endcase

end

endmodule

