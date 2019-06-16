module leds(i_clk, i_rst_n, i_we, i_data, o_leds);

input               i_clk;
input               i_rst_n;
input               i_we;
input       [31:0]  i_data;
output reg  [9:0]  o_leds;

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n)
        o_leds <= 0;
    else if (i_we)
        o_leds <= i_data[9:0];  

endmodule
