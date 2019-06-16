module mips_soc(CLOCK_50, KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

input           CLOCK_50;
input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;
output  [6:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

wire    [31:0]  instr_addr; 
wire    [31:0]  instr; 
reg     [31:0]  readdata;
wire    [31:0]  mem_out_data;
wire    [31:0]  buttons_out_data;
  
wire    [31:0]  writedata; 
wire    [31:0]  dataadr; 
wire            memwrite;

wire    [1:0]   read_mux_ctrl;

wire            mem_en;
wire            led_en;
wire            seg7_disp_en;

wire sys_clk = CLOCK_50;
wire sys_rst_n = KEY[1]; 

mips_core mips_inst(.i_clk (sys_clk), 
                   .i_rst_n (sys_rst_n), 
                   .i_instr (instr), 
                   .i_readdata (readdata), 
                   .o_pc (instr_addr), 
                   .o_memwrite (memwrite), 
                   .o_dataddr (dataadr), 
                   .o_writedata (writedata)
                  );

rom     imem_inst(.i_addr(instr_addr[31:2]), 
                    .o_data(instr)
                    );

ram     dmem_inst(.i_clk(sys_clk), 
                    .i_we(memwrite & mem_en), 
                    .i_addr(dataadr), 
                    .i_data(writedata), 
                    .o_data(mem_out_data)
                    );

addr_decoder  addr_dec_inst(.i_addr (dataadr), 
                            .o_mux_ctrl (read_mux_ctrl), 
                            .o_mem_en (mem_en), 
                            .o_led_en (led_en), 
                            .o_7seg_en (seg7_disp_en)
                           );

buttons  butons_inst(.i_clk (sys_clk), 
                     .i_rst_n (sys_rst_n), 
                     .i_buttons (SW), 
                     .o_data (buttons_out_data)
                     );

leds     leds_inst(.i_clk (sys_clk), 
                   .i_rst_n (sys_rst_n), 
                   .i_we (memwrite & led_en), 
                   .i_data (writedata), 
                   .o_leds (LEDR)
                   );

displays7seg  disp_inst(.i_clk (sys_clk), 
                        .i_rst_n (sys_rst_n), 
                        .i_addr (dataadr[2:0]), 
                        .i_we (memwrite & seg7_disp_en), 
                        .i_data (writedata), 
                        .o_disp0 (HEX0), 
                        .o_disp1 (HEX1), 
                        .o_disp2 (HEX2), 
                        .o_disp3 (HEX3), 
                        .o_disp4 (HEX4), 
                        .o_disp5 (HEX5)
                        );

always @* begin
    case (read_mux_ctrl)
        2'b00:   readdata = mem_out_data;
        2'b01:   readdata = buttons_out_data;
        default: readdata = 32'd0;
    endcase
end

endmodule
