module shift_reg (KEY, SW, LEDR);

input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

wire            clk = KEY[0];

reg     [9:0]   shift_reg;

assign LEDR = shift_reg;
                                        
always @(posedge clk) begin
    shift_reg <= {shift_reg[8:0], SW[0]};    
end
    
endmodule
