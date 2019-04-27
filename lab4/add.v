module add(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire [4:0] a;
wire [4:0] b;

wire [5:0] y;

assign a = SW[4:0];
assign b = SW[9:5];

assign y = a + b;

assign LEDR[5:0] = y;

endmodule
