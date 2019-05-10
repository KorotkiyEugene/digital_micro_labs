module parallel_reg (KEY, SW, LEDR);

input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

wire            clk = KEY[0];
reg     [9:0]   register;

assign LEDR = register;
                                        
always @(posedge clk) begin
    register <= SW;    
end
    
endmodule
