module  ship3 ( input Reset, frame_clk, hitconfirm, //S2Go,
               output [9:0]  Ship3X, Ship3Y, Ship3S);
									  //Ship_Y_Max, Ship_Y_Min, Ship_X_Max, Ship_X_Min, Ship_X_Center, Ship_Y_Center);
    
    logic [9:0] Ship_X_Pos, Ship_X_Motion, Ship_Y_Pos, Ship_Y_Motion, Ship_Size;
	 
    parameter [9:0] Ship_X_Center=300;  // Center position on the X axis
    parameter [9:0] Ship_Y_Center=40;  // Center position on the Y axis
    parameter [9:0] Ship_X_Min=2;       // Leftmost point on the X axis
    parameter [9:0] Ship_X_Max=599;     // Rightmost point on the X axis
    parameter [9:0] Ship_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ship_Y_Max=479;     // Bottommost point on the Y axis*/
    parameter [9:0] Ship_X_Step=2;      // Step size on the X axis
    parameter [9:0] Ship_Y_Step=5;      // Step size on the Y axis

    assign Ship_Size = 6;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ship
        if (Reset)  // Asynchronous Reset
        begin 
            Ship_Y_Motion <= 10'd0; //Ship_Y_Step;
				Ship_X_Motion <= 10'd1; //Ship_X_Step;
				Ship_Y_Pos <= Ship_Y_Center;
				Ship_X_Pos <= Ship_X_Center;
        end
           
        else 
        begin 
		  //if(S2Go)
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
				/*if((Ship_Y_Pos - Ship_Size) >= Ship_Y_Max)
					Ship_Y_Motion <= 10'd0;
					*/  
				 
				 Ship_Y_Pos <= (Ship_Y_Pos + Ship_Y_Motion);  // Update Ship position
				 Ship_X_Pos <= (Ship_X_Pos + Ship_X_Motion);
			
			
			end
		 end
		/*else
		begin
			Ship_Y_Motion <= 10'd0; //Ship_Y_Step;
			Ship_X_Motion <= 10'd1; //Sh
			if(~hitconfirm)
			begin
				Ship_X_Pos <= Ship_X_Center;
				Ship_Y_Pos <= Ship_Y_Center;
			end
		end
		end */ 
    end
       
    assign Ship3X = Ship_X_Pos;
   
    assign Ship3Y = Ship_Y_Pos;
   
    assign Ship3S = Ship_Size;
    

endmodule