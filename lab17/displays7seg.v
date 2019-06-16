module displays7seg(i_clk, i_rst_n, i_addr, i_we, i_data, o_disp0, o_disp1, o_disp2, o_disp3, o_disp4, o_disp5);

input           i_clk;
input           i_rst_n;
input           i_we;
input   [2:0]   i_addr;
input   [31:0]  i_data;
output  [6:0]   o_disp0;
output  [6:0]   o_disp1;
output  [6:0]   o_disp2;
output  [6:0]   o_disp3;
output  [6:0]   o_disp4;
output  [6:0]   o_disp5;

reg     [6:0]   displays[0:5];

assign o_disp0 = displays[0];
assign o_disp1 = displays[1];
assign o_disp2 = displays[2];
assign o_disp3 = displays[3];
assign o_disp4 = displays[4];
assign o_disp5 = displays[5];

integer i = 0;

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n)
        for (i=0; i<6; i=i+1)
            displays[i] <= 0;
    else if (i_we)
        displays[i_addr] <= i_data[6:0];  

endmodule

