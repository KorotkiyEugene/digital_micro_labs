module alu_ctrl(i_funct, i_aluop, o_alucontrol);

input       [5:0]   i_funct;
input       [1:0]   i_aluop;
output reg  [3:0]   o_alucontrol;

always @* begin

    case(i_aluop)
        2'b00: o_alucontrol = 4'b0010;                   // add (for lw/sw/addi)
        2'b01: o_alucontrol = 4'b1010;                   // sub (for beq)
        default: case(i_funct)                          // R-type instructions
                     6'b100000: o_alucontrol = 4'b0010;  // add
                     6'b100010: o_alucontrol = 4'b1010;  // sub
                     6'b100100: o_alucontrol = 4'b0000;  // and
                     6'b100101: o_alucontrol = 4'b0001;  // or
                     6'b101010: o_alucontrol = 4'b1011;  // slt
                     6'b000000: o_alucontrol = 4'b0100;  // sll
                     6'b000010: o_alucontrol = 4'b0101;  // srl
                     default:   o_alucontrol = 4'bxxxx;  // ???
                 endcase
    endcase

end

endmodule

