
module lab7soc (
	clk_clk,
	clk_sdram_clk,
	hex_digits_export,
	key_external_connection_export,
	keycode_export,
	keys_external_connection_export,
	leds_export,
	player_cond_player_x,
	player_cond_player_y,
	player_cond_player_a,
	player_x_pio_export,
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	vga_port_blue,
	vga_port_red,
	vga_port_green,
	vga_port_hs,
	vga_port_vs,
	player_y_pio_export,
	player_a_pio_export);	

	input		clk_clk;
	output		clk_sdram_clk;
	output	[15:0]	hex_digits_export;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_export;
	input	[1:0]	keys_external_connection_export;
	output	[13:0]	leds_export;
	input	[31:0]	player_cond_player_x;
	input	[31:0]	player_cond_player_y;
	input	[31:0]	player_cond_player_a;
	output	[31:0]	player_x_pio_export;
	input		reset_reset_n;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	output	[3:0]	vga_port_blue;
	output	[3:0]	vga_port_red;
	output	[3:0]	vga_port_green;
	output		vga_port_hs;
	output		vga_port_vs;
	output	[31:0]	player_y_pio_export;
	output	[31:0]	player_a_pio_export;
endmodule
