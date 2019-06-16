module mips_core(i_clk, i_rst_n, i_instr, i_readdata, o_pc, o_memwrite, o_dataddr, o_writedata);

input           i_clk; 
input           i_rst_n;
input   [31:0]  i_instr;            
input   [31:0]  i_readdata;

output  [31:0]  o_pc;
output          o_memwrite;
output  [31:0]  o_dataddr; 
output  [31:0]  o_writedata;


wire    [4:0]   writereg;

wire    [31:0]  pcnext; 
wire    [31:0]  pcnextbr; 

wire    [31:0]  writedata;

wire    [31:0]  pcbranch;
wire    [31:0]  pcplus4;
wire    [31:0]  signimmsh;

reg     [31:0]  pc;

wire    [31:0]  signimm;
wire    [31:0]  srca; 
wire    [31:0]  srcb;
wire    [31:0]  regout1; 
wire    [31:0]  regout2;
wire    [31:0]  result;
            
wire            memtoreg; 
wire            memwrite;
wire            alusrc; 
wire            regdst; 
wire            regwrite; 
wire            jump; 
wire            pcsrc; 
wire            zero;
wire    [3:0]   alucontrol;
wire            branch;
wire    [1:0]   aluop;
wire    [31:0]  aluout;


assign o_pc = pc;
assign o_memwrite = memwrite;
assign o_dataddr = aluout;
assign o_writedata = regout2;

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n) 
        pc <= 32'd0;
    else       
        pc <= pcnext;

assign signimmsh = {signimm[29:0], 2'b00};

assign pcplus4 = pc + 32'b100;

assign pcbranch = pcplus4 + signimmsh;

assign signimm = {{16{i_instr[15]}}, i_instr[15:0]};

// Multiplexers

assign writereg = regdst ? i_instr[15:11] : i_instr[20:16];

assign result = memtoreg ? i_readdata : aluout; 

assign pcnextbr = pcsrc ? pcbranch : pcplus4;

assign pcnext = jump ? {pcplus4[31:28], i_instr[25:0], 2'b00} : pcnextbr; 

assign srca = regout1;

assign srcb = alusrc ? signimm : regout2; 

assign pcsrc = branch & zero;


main_ctrl  main_ctrl_inst(.i_op (i_instr[31:26]), 
                           .o_memtoreg (memtoreg), 
                           .o_memwrite (memwrite), 
                           .o_branch (branch), 
                           .o_alusrc (alusrc), 
                           .o_regdst (regdst), 
                           .o_regwrite (regwrite), 
                           .o_jump (jump), 
                           .o_aluop (aluop)
                           );

alu_ctrl  alu_ctrl_inst(.i_funct (i_instr[5:0]), 
                         .i_aluop (aluop), 
                         .o_alucontrol (alucontrol)
                         );

regfile  rf_int( .i_clk (i_clk), 
                  .i_we (regwrite), 
                  .i_raddr1 (i_instr[25:21]), 
                  .i_raddr2 (i_instr[20:16]), 
                  .i_waddr (writereg), 
                  .i_wdata (result), 
                  .o_data1 (regout1), 
                  .o_data2 (regout2)
                 );

alu    alu_inst(.i_a (srca), 
                 .i_b (srcb), 
                 .i_alucontrol (alucontrol), 
                 .i_sa(i_instr[10:6]),
                 .o_result (aluout), 
                 .o_zero (zero)
                );

endmodule
