 module raycast (input clk, init, mult, loop, ceil_calc, output hitwall, input logic [31:0] player_x,input logic [31:0] player_y, input logic [31:0] player_a, input logic [31:0] col, output logic [12:0] depth, output logic [12:0] Distwall, output logic [31:0] testx);

// take drawx as a col
// add the map rom thing too
logic map_out;
logic [31:0] fOff, fOffsetfov, testy, eyey, eyex;
sin si (.angle(fOffsetfov>>5), .val(eyex));
cos co (.angle(fOffsetfov>>5), .val(eyey));



always_ff @ (posedge clk) begin
if(init) begin
	Distwall <= 0;
	fOff <= (player_a - 20'd1440) + (((col<<5) * 4'd9)>>5);
	if(fOff[31] == 1) begin
		fOffsetfov <= fOff + 20'd11520;
	end
	else begin
		fOffsetfov <= fOff;
		end
	end
else if(mult) begin
	testx <= (player_x + ((eyex * Distwall)>>5))>>5;
	testy <= (player_y + ((eyey * Distwall)>>5))>>5;
end
else if(loop) begin
	Distwall <= Distwall + 4'd8;
	if(testx<0 || testx>=4'd8 || testy<0 || testy>=4'd8) begin
		hitwall <= 1;
		Distwall <= 15'd512;
	end
	else if(map_out == 1) begin
		hitwall <= 1;
	end
end
else if(ceil_calc) begin
	depth <= 20'd7680 - 20'd245760/Distwall;
end
end
endmodule
