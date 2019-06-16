module alu(i_a, i_b, i_alucontrol, i_sa, o_result, o_zero);

input       [31:0]  i_a; 
input       [31:0]  i_b;
input       [3:0]   i_alucontrol;
input       [4:0]   i_sa;
output  reg [31:0]  o_result;
output              o_zero;

wire    [31:0]  condinvb = i_alucontrol[3] ? ~i_b : i_b; 
wire    [31:0]  sum = i_a + condinvb + i_alucontrol[3];

assign          o_zero = (o_result == 32'b0);

always @* begin

    o_result = 32'd0;

    case (i_alucontrol[2:0])
      3'b000: o_result = i_a & i_b;
      3'b001: o_result = i_a | i_b;
      3'b010: o_result = sum;
      3'b011: o_result = sum[31];
      3'b100: o_result = i_b << i_sa;
      3'b101: o_result = i_b >> i_sa;
    endcase
  
end

endmodule
