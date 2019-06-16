module buttons(i_clk, i_rst_n, i_buttons, o_data);

input               i_clk;
input               i_rst_n;
input       [31:0]  i_buttons;
output reg  [31:0]  o_data;

always @(posedge i_clk, negedge i_rst_n)
    if(~i_rst_n)
        o_data <= 0;
    else
        o_data <= i_buttons;

endmodule

