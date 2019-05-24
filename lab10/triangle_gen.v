module triangle_gen(CLOCK_50, KEY, VGA_R, VGA_CLK);

input           CLOCK_50;
input   [3:0]   KEY;
output  [7:0]   VGA_R;
output          VGA_CLK;

reg     [9:0]   clk_div_cnt;
reg     [7:0]   dac_cnt;

wire    sys_clk     = CLOCK_50;
wire    sys_rst_n   = KEY[1];

assign VGA_R    = dac_cnt;
assign VGA_CLK  = clk_div_cnt[9];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        clk_div_cnt <= 10'd0;
    end else begin
        clk_div_cnt <= clk_div_cnt + 1'b1;
    end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        dac_cnt <= 8'd0;
    end else begin
        if(&clk_div_cnt)
            dac_cnt <= dac_cnt + 1'b1;
    end
end


endmodule
