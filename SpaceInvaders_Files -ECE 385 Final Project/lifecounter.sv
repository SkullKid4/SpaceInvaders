module lifecounter (input Reset, frame_clk, 
							input [7:0] keycode, 
							input [9:0] ShipY, ShipS, Ship2Y, Ship2S, BallY, BallS, Ship3Y, Ship3S,
							input ShipHit, Ship2Hit, Ship3Hit,
							output [1:0] lives,
							output BGo, BuGo, SGo, S2Go);
							
always_ff @ (posedge Reset or posedge frame_clk)
begin
	if(Reset)
	begin
		lives = 2'b11;
		BGo = 1'b0;
		BuGo = 1'b0;
		SGo = 1'b0;
		S2Go = 1'b0;
	end
	else
	begin
		if(((~ShipHit) && SGo && ((ShipY + ShipS) >= (BallY - BallS))) || ((~Ship2Hit) && S2Go && ((Ship2Y + Ship2S) >= (BallY - BallS))))
		begin
			if(lives > 0)
				lives = lives - 1'b1;
			BGo = 1'b0;
			BuGo = 1'b0;
			SGo = 1'b0;
			S2Go = 1'b0;
		end
		if(keycode == 8'h28)
		begin
			BGo = 1'b1;
			BuGo = 1'b1;
			if(ShipHit == 1'b0)	//don't activate ships if they've been hit this session
				SGo = 1'b1;
			else SGo = 1'b0;
			
			if(Ship2Hit == 1'b0)
				S2Go = 1'b1;
			else S2Go = 1'b0;
		end
	end	
			
end
			
			
endmodule
							