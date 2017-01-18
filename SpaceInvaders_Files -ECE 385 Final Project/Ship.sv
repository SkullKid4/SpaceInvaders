module  ship ( input Reset, frame_clk, hitconfirm, SGo,
               output [9:0]  ShipX, ShipY, ShipS);
								//	  Ship_Y_Max, Ship_Y_Min, Ship_X_Max, Ship_X_Min, Ship_X_Center, Ship_Y_Center);
    
    logic [9:0] Ship_X_Pos, Ship_X_Motion, Ship_Y_Pos, Ship_Y_Motion, Ship_Size;
	 
    parameter [9:0] Ship_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ship_Y_Center=40;  // Center position on the Y axis
    parameter [9:0] Ship_X_Min=22;       // Leftmost point on the X axis
    parameter [9:0] Ship_X_Max=619;     // Rightmost point on the X axis
    parameter [9:0] Ship_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ship_Y_Max=479;     // Bottommost point on the Y axis*/
    parameter [9:0] Ship_X_Step=2;      // Step size on the X axis
    parameter [9:0] Ship_Y_Step=5;      // Step size on the Y axis

    assign Ship_Size = 6;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ship
        if (Reset)  // Asynchronous Reset
        begin 
				//usleep(3000000);
            Ship_Y_Motion <= 10'd0; //Ship_Y_Step;
				Ship_X_Motion <= 10'd1; //Ship_X_Step;
				Ship_Y_Pos <= Ship_Y_Center;
				Ship_X_Pos <= Ship_X_Center;
        end
           
        else 
        begin 
		   //if(SGo == 1'b1)
		   //begin
		  
			if(hitconfirm)
			begin
				Ship_Y_Motion <= 10'd0;
				Ship_Y_Motion <= 10'd0;
				Ship_Y_Pos <= 510;
				Ship_X_Pos <= 700;
			end
			else
			begin
					  		  
				  if ( (Ship_X_Pos + Ship_Size) >= Ship_X_Max )  // Ship is at the right edge, BOUNCE!
				  begin
					  Ship_X_Motion <= 1'b0;
					  Ship_Y_Motion <= Ship_Y_Step;	//Moves down
					  Ship_X_Motion <= (~ (Ship_X_Step) + 1'b1);  // Goes Left
					 end
					  
				 else if ( (Ship_X_Pos - Ship_Size) <= Ship_X_Min )  // Ship is at the left edge, BOUNCE!
				 begin
					  Ship_X_Motion <= 1'b0;
					  Ship_Y_Motion <= Ship_Y_Step;  //Moves down
					  Ship_X_Motion <= Ship_X_Step;	//Goes Right
					 end
					  
				 else 
				 begin
					  Ship_X_Motion <= Ship_X_Motion;  // Ship is somewhere in the middle, don't bounce, just keep moving
					  Ship_Y_Motion <= 10'd0;
					 end
			/*	if((Ship_Y_Pos - Ship_Size) >= Ship_Y_Max)
					Ship_Y_Motion <= 10'd0;
				*/	  
				 
				 Ship_Y_Pos <= (Ship_Y_Pos + Ship_Y_Motion);  // Update Ship position
				 Ship_X_Pos <= (Ship_X_Pos + Ship_X_Motion);
			
			
			end
		 end
		 /*else
		 begin
		   Ship_Y_Motion <= 10'd0; //Ship_Y_Step;
	   	Ship_X_Motion <= 10'd0; //Ship_X_Step;
			if(~hitconfirm)
			begin
				Ship_X_Pos <= Ship_X_Center;
				Ship_Y_Pos <= Ship_Y_Center;
			end
		 end
		end*/ 
    end
       
    assign ShipX = Ship_X_Pos;
   
    assign ShipY = Ship_Y_Pos;
   
    assign ShipS = Ship_Size;
    

endmodule
