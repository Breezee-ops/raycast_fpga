module inferram (
	input Clk,
	input [8:0] addr,
	input we,
	input [12:0] datain,
	output [12:0] dataout
);

logic[12:0] mem [320];
always_ff @ (posedge Clk) begin
	if(we) begin
		mem[addr] <= datain;
		end
	dataout <= mem[addr];
end

endmodule
