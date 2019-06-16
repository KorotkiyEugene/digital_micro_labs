module regfile(i_clk, i_we, i_raddr1, i_raddr2, i_waddr, i_wdata, o_data1, o_data2);

input           i_clk; 
input           i_we; 
input   [4:0]   i_raddr1; 
input   [4:0]   i_raddr2;
input   [4:0]   i_waddr;
input   [31:0]  i_wdata; 
output  [31:0]  o_data1;
output  [31:0]  o_data2;

reg     [31:0]  rf[31:0];

always @(posedge i_clk)
    if (i_we) rf[i_waddr] <= i_wdata;	

assign o_data1 = (i_raddr1 != 0) ? rf[i_raddr1] : 0;
assign o_data2 = (i_raddr2 != 0) ? rf[i_raddr2] : 0;

endmodule
