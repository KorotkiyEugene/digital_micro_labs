module myxor(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

assign LEDR[0] = (~SW[1] & SW[0]) | (SW[1] & ~SW[0]);

endmodule
