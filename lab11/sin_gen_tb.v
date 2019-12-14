`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;

reg         i_clk, i_rst_n;
wire [7:0]  o_dac;
wire        o_dac_clk;


sin_gen sin_gen_inst( .CLOCK_50 (i_clk), 
                      .KEY ({i_rst_n,  1'b0}), 
                      .VGA_R (o_dac), 
                      .VGA_CLK (o_dac_clk)
                      );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;

    @(negedge i_clk) i_rst_n = 1'b1;
    
    repeat (1024*4) @(negedge i_clk);

    $finish;  
end
  
endmodule