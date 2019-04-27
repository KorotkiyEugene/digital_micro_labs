module cmp(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire tmp;

wire [4:0] a = SW[4:0];
wire [4:0] b = SW[9:5];

assign tmp = |(a ^ b);

assign LEDR[0] = ~tmp;

endmodule 


/*module cmp(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire [4:0] a;
wire [4:0] b;

wire tmp1[4:0];
wire tmp2;

assign a = SW[4:0];
assign b = SW[9:5];

assign tmp1[0] = a[0] ^ b[0];
assign tmp1[1] = a[1] ^ b[1];
assign tmp1[2] = a[2] ^ b[2];
assign tmp1[3] = a[3] ^ b[3];
assign tmp1[4] = a[4] ^ b[4];

assign tmp2 = tmp1[0] | tmp1[1] | tmp1[2] | tmp1[3] | tmp1[4];

assign LEDR[0] = ~tmp2;

endmodule*/
