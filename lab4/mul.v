module mul(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire [4:0] a = SW[4:0];
wire [4:0] b = SW[9:5];

wire [9:0] y;

assign y = a * b;

assign LEDR[9:0] = y;

endmodule
