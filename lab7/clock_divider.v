module clock_divider(CLOCK_50, KEY, GPIO_0);

input           CLOCK_50;
input   [1:0]   KEY;
output  [35:0]  GPIO_0;

reg     [9:0]     div_reg;

wire    clk     = CLOCK_50;
wire    rst_n   = KEY[1];

assign GPIO_0[0]  = div_reg[9];
assign GPIO_0[1]  = CLOCK_50;

always @(posedge clk, negedge rst_n) begin
    if(~rst_n) begin
        div_reg <= 10'd1;
    end else begin
        div_reg <= {div_reg[8:0], div_reg[9]};
    end
end


endmodule
