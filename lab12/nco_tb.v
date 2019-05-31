`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;

reg         i_clk, i_rst_n;
reg  [9:0]  i_freq_step;
wire [7:0]  o_dac;
wire        o_dac_clk;
wire [35:0] o_gpio;

nco  nco_inst(.CLOCK_50 (i_clk), 
                .KEY ({i_rst_n, 1'b0}),
                .SW (i_freq_step), 
                .VGA_R (o_dac),
                .VGA_CLK(o_dac_clk),
                .GPIO_0(o_gpio)
                );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;
    i_freq_step = 10'd64;

    @(negedge i_clk) i_rst_n = 1'b1;

    repeat (15) begin
        repeat (500000) @(negedge i_clk);
        i_freq_step = i_freq_step + 50;
    end

    $finish;  
end
  
endmodule
