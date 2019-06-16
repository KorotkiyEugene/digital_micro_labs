module ram(i_clk, i_we, i_addr, i_data, o_data);

parameter RAM_WORDS = 128;

input           i_clk;
input           i_we;
input   [31:0]  i_addr; 
input   [31:0]  i_data;
output  [31:0]  o_data;

reg     [31:0]  RAM[0:RAM_WORDS-1];

assign o_data = RAM[i_addr[31:2]];

always @(posedge i_clk)
    if (i_we) RAM[i_addr[31:2]] <= i_data;

endmodule
