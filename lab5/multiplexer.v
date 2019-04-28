module multiplexer(SW, KEY, LEDR);

input   [3:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

wire [4:0] a = SW[4:0];
wire [4:0] b = SW[9:5];

wire [9:0] mul;
wire [5:0] add;

assign mul = a * b;
assign add = a + b;

assign LEDR[9:0] = KEY[0] ? mul : {4'b0000, add};

endmodule
