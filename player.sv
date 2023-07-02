module drawplayer(input clk, input[7:0]keycode, output[9:0] playerx, playery, playerang);

logic[9:0] ang, x, y, dx, dy;
cos co (.angle(ang), .val(dx));
sin si (.angle(ang), .val(dy));

always_ff @ (posedge(clk)) begin
	case (keycode)
					8'h04 : begin
							if(playerang == 0)
							playerang <= 10'd359;
							else
							ang = playerang - 1;
							  end
					        
					8'h07 : begin
							if(playerang == 10'd359)
							playerang <= 10'd0;
							else
							ang = playerang + 1;
							  end

							  
					8'h16 : begin
							x = playerx - dx>>>2;
							y = playery - dy>>>2;
							 end
							  
					8'h1A : begin
					      x = playerx + dx>>>2;
							y = playery + dy>>>2;
							 end	  
					default: ;
			   endcase
			end
			assign playerx = x;
			assign playery = y;
			

endmodule
