module square(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire [2:0] a = SW[2:0];
wire [5:0] y;

assign LEDR[5:0] = y;

assign y[0] = (~a[2] & ~a[1] & a[0]) | (~a[2] & a[1] & a[0]) | (a[2] & ~a[1] & a[0]) | (a[2] & a[1] & a[0]);

assign y[1] = 1'b0;

assign y[2] = (~a[2] & a[1] & ~a[0]) | (a[2] & a[1] & ~a[0]);

assign y[3] = (~a[2] & a[1] & a[0]) | (a[2] & ~a[1] & a[0]);

assign y[4] = (a[2] & ~a[1] & ~a[0]) | (a[2] & ~a[1] & a[0]) | (a[2] & a[1] & a[0]);

assign y[5] = (a[2] & a[1] & ~a[0]) | (a[2] & a[1] & a[0]);

endmodule
