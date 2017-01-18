//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size, ShipX, ShipY, Ship_size, 
														BullX, BullY, BullS, Ship2X, Ship2Y, Ship2_size,
														Ship3X, Ship3Y, Ship3_size,
								input [1:0] lives,
                       output logic [7:0]  Red, Green, Blue);
    
    logic Ball_on;
	 logic Ship_on, Ship2_on, Ship3_on;
	 logic Bullet_on;
	 
    int DistXb, DistYb, Sizeb;
	 assign DistXb = DrawX - BallX;
    assign DistYb = DrawY - BallY;
    assign Sizeb = Ball_size;
	 
	 int DistXs, DistYs, Sizes;
	 assign DistXs = DrawX - ShipX;
	 assign DistYs = DrawY - ShipY;
	 assign Sizes = Ship_size;
	 
	 int DistXs2, DistYs2, Sizes2;
	 assign DistXs2 = DrawX - Ship2X;
	 assign DistYs2 = DrawY - Ship2Y;
	 assign Sizes2 = Ship2_size;
	 
	 int DistXs3, DistYs3, Sizes3;
	 assign DistXs3 = DrawX - Ship3X;
	 assign DistYs3 = DrawY - Ship3Y;
	 assign Sizes3 = Ship3_size;
	 
	 int DistXbu, DistYbu, Sizebu;
	 assign DistXbu = DrawX - BullX;
	 assign DistYbu = DrawY - BullY;
	 assign Sizebu = BullS;
	 
	 logic [10:0] sprite_addr;
	 logic [7:0] sprite_data;
	 font_rom (.addr(sprite_addr), .data(sprite_data));
	 
	always
	begin:Ball_on_proc
		if ((DistXb*DistXb + DistYb*DistYb) <= (Sizeb*Sizeb))
		begin
			 Ball_on = 1'b1;
			 sprite_addr = (DrawY - BallY + 16*'h02);
	   end
	   else
			 Ball_on = 1'b0;
	end
	
	
	 always
	 begin:Ship_on_proc
		if((DistXs*DistXs + DistYs*DistYs) <= (Sizes*Sizes))
			Ship_on = 1'b1;
		else
			Ship_on = 1'b0;
	 end
	 
	 always
	 begin:Ship2_on_proc
		if ((DistXs2*DistXs2 + DistYs2*DistYs2) <= (Sizes2*Sizes2))
			Ship2_on = 1'b1;
		else
			Ship2_on = 1'b0;
	 end
	 
	 always
	 begin:Ship3_on_proc
		if ((DistXs3*DistXs3 + DistYs3*DistYs3) <= (Sizes3*Sizes3))
			Ship3_on = 1'b1;
		else
			Ship3_on = 1'b0;
	 end
	 
	  always
	  begin:Bullet_on_proc
		if((DistXbu * DistXbu + DistYbu * DistYbu) <= (Sizebu * Sizebu))
			Bullet_on = 1'b1;
		else
			Bullet_on = 1'b0;
	  end
   
    always
    begin:RGB_Display
	  if(~(lives == 2'b00))
	  begin
        if ((((Ball_on == 1'b1) && sprite_data[DrawX - BallX] == 1'b1) || (Ball_on == 1'b1 && Bullet_on == 1'b1)))
        begin 
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
        end
		  
		  if ((Ship_on == 1'b1))
		  begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'hff;
		  end
		  
		  if ((Ship2_on == 1'b1))
		  begin
				Red = 8'hff;
				Green = 8'h00;
				Blue = 8'h00;
		  end
		  
		  if ((Ship3_on == 1'b1))
		  begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'h00;
		  end
		
		  if(Bullet_on == 1'b1)
		  begin
				Red = 8'hff;
				Green = 8'h00;
				Blue = 8'h00;
		  end
		
        if(Ball_on == 1'b0 && Bullet_on == 1'b0 && Ship_on == 1'b0 && Ship2_on == 1'b0 && Ship3_on == 1'b0)
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end     
		 end 
		 else
		 begin
			Red = 8'h00;
			Green = 8'h00;
			Blue = 8'h00;
		 end
    end 
    
endmodule


