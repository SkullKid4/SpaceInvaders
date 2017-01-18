module  bullet ( input Reset, frame_clk, hitconfirm, BuGo,
					input shot,
					//output shotReset,
					input [9:0] BallX, BallY,
									ShipX, ShipY, Ship_size,
									Ship2X, Ship2Y, Ship2_size,
									Ship3X, Ship3Y, Ship3_size,
               output [9:0]  BulletX, BulletY, BulletS,
					output loaded, S0Hit, S1Hit, S2Hit, S3Hit, S4Hit, S5Hit, S6Hit, S7Hit, S8Hit, S9Hit);
    
    logic [9:0] Bullet_X_Pos, Bullet_X_Motion, Bullet_Y_Pos, Bullet_Y_Motion, Bullet_Size;
	 
    parameter [9:0] Bullet_X_Center=650;  // Center position on the X axis
    parameter [9:0] Bullet_Y_Center=500;  // Center position on the Y axis
    parameter [9:0] Bullet_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Bullet_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Bullet_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Bullet_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Bullet_X_Step=1;      // Step size on the X axis
    parameter [9:0] Bullet_Y_Step=5;      // Step size on the Y axis

    assign Bullet_Size = 2;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
    assign MotionX = Bullet_X_Motion[3:0];
	 assign MotionY = Bullet_Y_Motion[3:0];
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Bullet
	 
	 
			//bulletReset = Reset || hitconfirm
	 
        if (Reset)  // Asynchronous Reset
        begin 
            Bullet_Y_Motion <= 10'd0; //Bullet_Y_Step;
				//Bullet_Y_Motion <= 10'b1111111110;	//-2, test speed
				Bullet_X_Motion <= 10'd0; //Bullet_X_Step;
				Bullet_Y_Pos <= Bullet_Y_Center;
				Bullet_X_Pos <= Bullet_X_Center;
				loaded = 1'b1;
				S0Hit = 1'b0;
				S1Hit = 1'b0;
				S2Hit = 1'b0;
				//shotReset = 1'b0;
        end
           
        else 
				begin
				//if(BuGo)
				//begin
					/*if(hitconfirm)
					begin
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
						//shotReset = 1'b0;
					end
					
					else
					begin*/
					if(Bullet_Y_Pos <= 0)
					begin
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
							else if(shot == 1'b1)
							begin
								loaded = 1'b0;
								Bullet_X_Pos = BallX;
								Bullet_Y_Pos = BallY;
								Bullet_Y_Motion = (~ Bullet_Y_Step) + 1'b1;
								//Bullet_Y_Motion = 10'b1111111110;
								//shotReset = 1'b1;
							end
					//end
					
					else if(Bullet_Y_Pos <= 0)
					begin
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if (BulletX >= (ShipX - Ship_size) && BulletX <= (ShipX + Ship_size) && BulletY >= (ShipY - Ship_size) && BulletY <= (ShipY + Ship_size))
					begin
						S0Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
						
					else if(BulletX >= (Ship2X - Ship2_size) && BulletX <= (Ship2X + Ship2_size) && BulletY >= (Ship2Y - Ship2_size) && BulletY <= (Ship2Y + Ship2_size))	//bullet center is inside enemy ship, counts as hit
					begin
						S1Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
			
					else if(BulletX >= (Ship3X - Ship3_size) && BulletX <= (Ship3X + Ship3_size) && BulletY >= (Ship3Y - Ship3_size) && BulletY <= (Ship3Y + Ship3_size))	//bullet center is inside enemy ship, counts as hit
					begin
						S2Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
				/*	
					else if(BulletX >= (Ship2X - Ship2S) && BulletX <= (Ship2X + Ship2S) && BulletY >= (Ship2Y - Ship2S) && BulletY <= (Ship2Y + Ship2S))	//bullet center is inside enemy ship, counts as hit
					begin
						S2Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship3X - Ship3S) && BulletX <= (Ship3X + Ship3S) && BulletY >= (Ship3Y - Ship3S) && BulletY <= (Ship3Y + Ship3S))	//bullet center is inside enemy ship, counts as hit
					begin
						S3Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship4X - Ship4S) && BulletX <= (Ship4X + Ship4S) && BulletY >= (Ship4Y - Ship4S) && BulletY <= (Ship4Y + Ship4S))	//bullet center is inside enemy ship, counts as hit
					begin
						S4Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship5X - Ship5S) && BulletX <= (Ship5X + Ship5S) && BulletY >= (Ship5Y - Ship5S) && BulletY <= (Ship5Y + Ship5S))	//bullet center is inside enemy ship, counts as hit
					begin
						S5Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship6X - Ship6S) && BulletX <= (Ship6X + Ship6S) && BulletY >= (Ship6Y - Ship6S) && BulletY <= (Ship6Y + Ship6S))	//bullet center is inside enemy ship, counts as hit
					begin
						S6Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship7X - Ship7S) && BulletX <= (Ship7X + Ship7S) && BulletY >= (Ship7Y - Ship7S) && BulletY <= (Ship7Y + Ship7S))	//bullet center is inside enemy ship, counts as hit
					begin
						S7Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship8X - Ship8S) && BulletX <= (Ship8X + Ship8S) && BulletY >= (Ship8Y - Ship8S) && BulletY <= (Ship8Y + Ship8S))	//bullet center is inside enemy ship, counts as hit
					begin
						S8Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
					
					else if(BulletX >= (Ship9X - Ship9S) && BulletX <= (Ship9X + Ship9S) && BulletY >= (Ship9Y - Ship9S) && BulletY <= (Ship9Y + Ship9S))	//bullet center is inside enemy ship, counts as hit
					begin
						S9Hit = 1'b1;
						Bullet_X_Pos = Bullet_X_Center;
						Bullet_Y_Pos = Bullet_Y_Center;
						Bullet_Y_Motion = 10'd0;
						loaded = 1'b1;
					end
				
		  
		  */
		  
				
				 Bullet_Y_Pos = (Bullet_Y_Pos + Bullet_Y_Motion);  // Update Bullet position
				 //Bullet_X_Pos = (Bullet_X_Pos + Bullet_X_Motion);
				 
				 
			
	//		end
			/*else
			begin
				Bullet_X_Pos = Bullet_X_Center;
				Bullet_Y_Motion <= 10'd0; //Bullet_Y_Step;
				//Bullet_Y_Motion <= 10'b1111111110;	//-2, test speed
				Bullet_X_Motion <= 10'd0; //Bullet_X_Step;
				Bullet_Y_Pos <= Bullet_Y_Center;
				Bullet_X_Pos <= Bullet_X_Center;
			end*/
				
			
			
		end  
    end
       
    assign BulletX = Bullet_X_Pos;
   
    assign BulletY = Bullet_Y_Pos;
   
    assign BulletS = Bullet_Size;
    
endmodule