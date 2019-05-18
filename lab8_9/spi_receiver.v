module spi_receiver(CLOCK_50, GPIO_0, LEDR);

input           CLOCK_50;
input   [35:0]  GPIO_0;
output  [9:0]   LEDR;

reg     [7:0]   spi_reg;
reg     [7:0]   data_reg = 8'd0;
reg     [2:0]   cs_reg = 3'b000;

wire    sys_clk     = CLOCK_50;
wire    spi_sck     = GPIO_0[0];
wire    spi_cs_n    = GPIO_0[1];
wire    spi_mosi    = GPIO_0[2];   

wire    cs_posedge  = ~cs_reg[2] & cs_reg[1];

assign  LEDR        = {2'b00, data_reg};

always @(posedge spi_sck)
    if(~spi_cs_n)
        spi_reg <= {spi_reg[6:0], spi_mosi};

always @(posedge sys_clk)
    cs_reg <= {cs_reg[1:0], spi_cs_n};

always @(posedge sys_clk)
    if(cs_posedge)
        data_reg <= spi_reg;

endmodule


