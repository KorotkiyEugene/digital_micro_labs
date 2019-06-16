module main_ctrl(i_op, o_memtoreg, o_memwrite, o_branch, o_alusrc, o_regdst, o_regwrite, o_jump, o_aluop);

input   [5:0]   i_op;
output          o_memtoreg; 
output          o_memwrite;
output          o_branch;
output          o_alusrc;
output          o_regdst; 
output          o_regwrite;
output          o_jump;
output  [1:0]   o_aluop;

reg     [8:0]   controls;

assign {o_regwrite, o_regdst, o_alusrc, o_branch, o_memwrite, o_memtoreg, o_jump, o_aluop} = controls;

always @* begin

    case(i_op)
        6'b000000: controls = 9'b110000010; // RTYPE
        6'b100011: controls = 9'b101001000; // LW
        6'b101011: controls = 9'b001010000; // SW
        6'b000100: controls = 9'b000100001; // BEQ
        6'b001000: controls = 9'b101000000; // ADDI
        6'b000010: controls = 9'b000000100; // J
        default:   controls = 9'bxxxxxxxxx; // illegal op
    endcase

end

endmodule
