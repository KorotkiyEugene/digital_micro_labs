module rom(i_addr, o_data);

parameter ROM_WORDS = 128;

input   [29:0] i_addr;
output  [31:0] o_data;

reg     [31:0] ROM[0:ROM_WORDS-1];

initial $readmemh("firmware.dat", ROM);

assign o_data = ROM[i_addr];

endmodule
