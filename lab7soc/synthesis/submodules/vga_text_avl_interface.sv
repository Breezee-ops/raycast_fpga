/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	input  logic [31:0]  player_x, player_y, player_a,
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] ceil; // Registers
//logic [319:0] [8:0] ceils_per_col;
//put other local variables here
logic Reset_h, vssig, blank, sync, pixelclk;
logic [9:0] drawxsig, drawysig;
logic[9:0] cx, cy, offsetx;
logic [6:0] char;
logic [11:0] id, fgdcol, bgdcol;
logic [31:0] val, register;
logic [10:0] fontaddr;
logic iv, out;
logic [0:7] data;
logic [2:0] pixx;
logic [3:0] pixy, fgdidx, bgdidx;
logic [31:0] palate, datafroma, datafromb;

//Declare submodules..e.g. VGA controller, ROMS, etc


ram ra(
	.address_a(AVL_ADDR),
	.address_b(drawxsig>>1), // this address would be my row major order into the screen array
	.clock(CLK),
	.data_a(AVL_WRITEDATA),
	.data_b(1'b0),
	.wren_a(AVL_WRITE),
	.wren_b(1'b0),
	.rden_a(AVL_READ),
	.rden_b(1'b1),
	.q_a(AVL_READDATA),
	.q_b(ceil)); // index of color at that position





vga_controller	VGAAAAAAAA (.Clk(CLK), .Reset(Reset_h), .hs(hs), .vs(vs), .pixel_clk(pixelclk), .blank(blank), .sync(sync), .DrawX(drawxsig), .DrawY(drawysig));

	

//assign ceil = ceils_per_col[drawxsig>>1];

parameter logic [31:0] SH = 32'd15360;
logic[31:0] floor;
assign floor = (SH - ceil)>>5;
logic[31:0] nceil;
assign nceil = ceil>>5;

always_ff @(posedge pixelclk) begin
		red <= 4'h0;
		blue <= 4'h0;
		green <= 4'hf;
	if(blank)begin
	if(drawysig>floor || drawysig<nceil) begin
		red <= 4'h0;
		blue <= 4'h0;
		green <= 4'h0;
		end
	else begin
//	if(nceil < 10'd100) begin
//		red <= 4'h9;
//		blue <= 4'hA;
//		green <= 4'h0;
//		end
if (nceil >= 0 && nceil < 13) begin
red <= 4'd15;
blue <= 4'd0;
green <= 4'd0;
end
if (nceil >= 13 && nceil < 26) begin
red <= 4'd13;
blue <= 4'd0;
green <= 4'd1;
end
if (nceil >= 26 && nceil < 39) begin
red <= 4'd12;
blue <= 4'd0;
green <= 4'd2;
end
if (nceil >= 39 && nceil < 52) begin
red <= 4'd11;
blue <= 4'd0;
green <= 4'd3;
end
if (nceil >= 52 && nceil < 65) begin
red <= 4'd10;
blue <= 4'd0;
green <= 4'd4;
end
if (nceil >= 65 && nceil < 78) begin
red <= 4'd9;
blue <= 4'd0;
green <= 4'd5;
end
if (nceil >= 78 && nceil < 91) begin
red <= 4'd8;
blue <= 4'd0;
green <= 4'd6;
end
if (nceil >= 91 && nceil < 104) begin
red <= 4'd7;
blue <= 4'd0;
green <= 4'd7;
end
if (nceil >= 104 && nceil < 117) begin
red <= 4'd6;
blue <= 4'd0;
green <= 4'd8;
end
if (nceil >= 117 && nceil < 130) begin
red <= 4'd5;
blue <= 4'd0;
green <= 4'd9;
end
if (nceil >= 130 && nceil < 143) begin
red <= 4'd4;
blue <= 4'd0;
green <= 4'd10;
end
if (nceil >= 143 && nceil < 156) begin
red <= 4'd3;
blue <= 4'd0;
green <= 4'd11;
end
if (nceil >= 156 && nceil < 169) begin
red <= 4'd2;
blue <= 4'd0;
green <= 4'd12;
end
if (nceil >= 169 && nceil < 182) begin
red <= 4'd1;
blue <= 4'd0;
green <= 4'd13;
end
if (nceil >= 182 && nceil < 195) begin
red <= 4'd0;
blue <= 4'd0;
green <= 4'd15;
end
	if(nceil >= 10'd195)begin
		red <= 4'h0;
		blue <= 4'h0;
		green <= 4'h0;
	end
	end
	end
end


endmodule
