module logic_elements(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

assign LEDR[0] = ~SW[0];

assign LEDR[1] = SW[0] & SW[1];

assign LEDR[2] = ~(SW[0] & SW[1]);

assign LEDR[3] = SW[0] | SW[1];

assign LEDR[4] = ~(SW[0] | SW[1]);

assign LEDR[5] = SW[0] ^ SW[1];

assign LEDR[9:6] = 4'b1010;

endmodule
