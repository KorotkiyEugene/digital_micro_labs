module audio_pcm_pwm (CLOCK_50, GPIO_0, KEY);

input           CLOCK_50;
inout   [35:0]  GPIO_0;
input   [1:0]   KEY;

wire            sys_clk   = CLOCK_50;
wire            sys_rst_n = KEY[0];

reg             pwm_out_ff;
reg     [7:0]   pwm_cnt_ff;
reg     [7:0]   pcm_sample_ff;
wire    [7:0]   uart_dat;

simple_uart_receiver uart_rec(.i_clk (sys_clk), 
                                .i_rst_n (sys_rst_n), 
                                .i_rx (GPIO_0[0]), 
                                .o_dat (uart_dat), 
                                .o_dat_vld ()
                                );

always @(posedge sys_clk)
    pcm_sample_ff <= uart_dat;

always @(posedge sys_clk)
    pwm_cnt_ff <= pwm_cnt_ff + 1'b1;

always @(posedge sys_clk)
    pwm_out_ff <= (pwm_cnt_ff < pcm_sample_ff);

assign GPIO_0[1] = pwm_out_ff;

endmodule


