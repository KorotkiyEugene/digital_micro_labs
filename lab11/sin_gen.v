module sin_gen(CLOCK_50, KEY, VGA_R, VGA_CLK);

input           CLOCK_50;
input   [1:0]   KEY;
output  [7:0]   VGA_R;
output          VGA_CLK;

reg     [7:0]   sin_table_rom[1023:0];
reg     [9:0]   phase;
reg     [7:0]   dac_data;

wire    sys_clk     = CLOCK_50;
wire    sys_rst_n   = KEY[1];

assign  VGA_R   = dac_data;   
assign  VGA_CLK = CLOCK_50;

initial $readmemh("sintable_8bit.hex", sin_table_rom);

always @(posedge sys_clk)
    dac_data <= sin_table_rom[phase];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        phase <= 0;
    end else begin
        phase <= phase + 1'b1;
    end
end

endmodule

