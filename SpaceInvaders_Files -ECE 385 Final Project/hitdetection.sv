module hitdetection ( input Reset, frame_clk, loaded,
							input [9:0] BulletX, BulletY,
											S0X, S0Y, S0S, //ship 1
							output bulletHit, S0Hit);
							
							
	always_ff @ (posedge Reset or posedge frame_clk)
	begin: CollisionCheck
	
	
		//hitdetect reset = Reset || loaded
		if(Reset)
		begin
			bulletHit = 1'b0;
			S0Hit = 1'b0;
		end
		
		
		else
		begin
			if(loaded)
			begin
				bulletHit = 1'b0;
				S0Hit = 1'b0;
			end
			
			if(BulletX >= (S0X - S0S) && BulletX <= (S0X + S0S) && BulletY >= (S0Y - S0S) && BulletY <= (S0Y + S0S))	//bullet center is inside enemy ship, counts as hit
			begin
				bulletHit = 1'b1;
				S0Hit = 1'b1;
			end
			
			else
			begin
				bulletHit = bulletHit;
				S0Hit = S0Hit;
			end
			
		end
	end
endmodule
