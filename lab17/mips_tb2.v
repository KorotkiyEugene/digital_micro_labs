`timescale 1ns / 1ps

module mips_tb2;

parameter PERIOD = 20;

reg         clk;
reg         rst_n;

wire [31:0] writedata; 
wire [31:0] dataadr;
wire        memwrite;
wire [6:0]  hex0, hex1, hex2, hex3, hex4, hex5; 

wire [9:0]  leds;

reg  [9:0]  sw;

mips_soc mips_soc_inst(.CLOCK_50 (clk), 
                       .KEY ({rst_n, 1'b0}), 
                       .SW (sw), 
                       .LEDR (leds), 
                       .HEX0 (hex0), 
                       .HEX1 (hex1), 
                       .HEX2 (hex2), 
                       .HEX3 (hex3), 
                       .HEX4 (hex4), 
                       .HEX5 (hex5)
                       );
  
 
initial begin
    clk = 1'b0;
    forever #(PERIOD/2) clk = ~clk;
end


initial begin

rst_n = 1'b0;

sw = 10'd0;

repeat (3) @(negedge clk);

rst_n = 1'b1;

forever begin

    @(negedge clk);

    repeat (20*30_000_000) @(negedge clk);

    $finish;

end

end

endmodule
