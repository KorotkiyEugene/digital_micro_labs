module nco(CLOCK_50, KEY, SW, VGA_R, VGA_CLK, GPIO_0);

input           CLOCK_50;
input   [1:0]   KEY;
input   [9:0]   SW;
output  [35:0]  GPIO_0;
output  [7:0]   VGA_R;
output          VGA_CLK;

reg     [7:0]   sin_table_rom[0:1023];
reg     [31:0]  phase;
reg     [7:0]   dac_data;
reg     [31:0]  freq_step;

wire    sys_clk   = CLOCK_50;
wire    sys_rst_n = KEY[1];

assign  VGA_R     = dac_data;   
assign  VGA_CLK   = CLOCK_50;
assign  GPIO_0[0] = phase[31];

initial $readmemh("sintable_8bit.hex", sin_table_rom);

always @(posedge sys_clk)
    dac_data <= sin_table_rom[phase[31:22]];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        freq_step <= 0;
    end else begin
        freq_step <= {14'd0, SW, 8'd0};
    end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        phase <= 0;
    end else begin
        phase <= phase + freq_step;
    end
end

endmodule
