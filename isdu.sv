//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------


module ISDU (   input logic         Clk, 
									
				input logic[8:0]		Distwall,
				input logic[12:0]		ceil, testx,
				input logic hitwall,
				
				  
				output logic       init, mult, loop, ceil_calc
				
				);

	enum logic [5:0] {  instant, multiply, whileloop, ceiling
						
						
						}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		init = 0;
		mult = 0;
		loop = 0;
		ceil_calc = 0;

	
		// Assign next state
		unique case (State)                     
			instant : 
				Next_state = multiply;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			multiply :
			if(testx > 0)
				Next_state = whileloop;
			else
				Next_state = multiply;
			whileloop : 
			if(Distwall >= 10'd512 || hitwall == 1)
				Next_state = ceiling;
			else
				Next_state = multiply;
			ceiling :
				if(ceil > 0)
				Next_state = instant;
				else
				Next_state = ceiling;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
//		PauseIR1 :
//	begin	
//				if (~Continue) 
//					Next_state = PauseIR1;
//				else 
//					Next_state = PauseIR2;
//					
//					end
//			PauseIR2 : 
//			begin
//				if (Continue) 
//					Next_state = PauseIR2;
//				else 
//					Next_state = S_18;
//					end
//			S_32 : 
//				case (Opcode)
//					4'b0001 : Next_state = S_01; //ADD
//					4'b0101 : Next_state = S_05; //AND 
//					4'b0000 : Next_state = S_0; //BR
//					4'b1100 : Next_state = S_12; //JMP
//					4'b0100 : Next_state = S_04; //JSR
//					4'b0110 : Next_state = S_06; //LDR
//					4'b0111 : Next_state = S_07; //STR
//					4'b1001 : Next_state = S_09; //NOT
//					4'b1101: Next_state = PauseIR1;//PSE//
//
//					// You need to finish the rest of opcodes.....
//
//					default : 
//						Next_state = S_18;
//				endcase
//			S_01 : 
//				Next_state = S_18;
//				
//			S_05 :
//				Next_state = S_18;
//				
//			S_09 :
//				Next_state = S_18;
//			
//			S_06 :
//				Next_state = S_25;
//				
//			S_25 :
//				Next_state = S_25_2;
//			
//			S_25_2 :
//				Next_state = S_25_3;
//				
//			S_25_3 :
//				Next_state = S_25_4;
//			
//			S_25_4 :
//				Next_state = S_25_5;
//			
//			S_25_5 : 
//				Next_state = S_27;
//				
//				
//			S_27 :
//				Next_state = S_18;		
//				
//			S_07 :
//				Next_state = S_23;		
//				
//			S_23 :
//				Next_state = S_16;		
//				
//			S_16 :
//				Next_state = S_16_2;
//		
//			S_16_2 :
//				Next_state = S_16_3;
//			
//			S_16_3 :
//				Next_state = S_16_4;
//			
//			S_16_4 :
//				Next_state = S_16_5;
//				
//			S_16_5 :
//				Next_state = S_18;
//		
//				
//					
////			S_0 :
////			case (BEN)
////				1'b0 :Next_state = S_18; //has two states to go to 
////				1'b1 :Next_state = S_22;
////					default:
////				Next_state = S_18;	
////					endcase
//
//
//
//
//			S_0:
//			if(BEN == 0)
//			Next_state = S_18;
//			else
//			Next_state = S_22;
//
//					
//			S_12 :
//				Next_state = S_18;
//					
//			S_04 :
//				Next_state = S_21;
//				
//			S_21 :
//				Next_state = S_18;		
//				
//			S_22 :
//				Next_state = S_18;
					
			
				
			
	
				
			

			// You need to finish the rest of states.....

			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			instant : begin
						init = 1;
						mult = 0;
						loop = 0;
						ceil_calc = 0;
					end
			multiply : begin
						init = 0;
						mult = 1;
						loop = 0;
						ceil_calc = 0;
					end
			whileloop : begin
						init = 0;
						mult = 0;
						loop = 1;
						ceil_calc = 0;
					end
			ceiling : begin
						init = 0;
						mult = 0;
						loop = 0;
						ceil_calc = 1;
					end

//			Halted: ;
//			S_18 : 
//				begin 
//					GatePC = 1'b1;
//					LD_MAR = 1'b1;
//					PCMUX = 2'b00;
//					LD_PC = 1'b1;
//				end
//			S_33_1 : 
//				Mem_OE = 1'b1;
//			S_33_2 : 
//				begin 
//					Mem_OE = 1'b1;
//				end
//				
//			S_33_3 : 
//				begin 
//					Mem_OE = 1'b1;
//				end
//			
//			S_33_4 : 
//				begin 
//					Mem_OE = 1'b1;
//					LD_MDR = 1'b1;
//				end
//				
//			S_35 : 
//				begin 
//					GateMDR = 1'b1;
//					LD_IR = 1'b1;
//				end
//				
//				
//			S_25 :
//			begin 
//					Mem_OE = 1'b1;
//					
//				end
//					
//			S_25_2 :
//			begin 
//					Mem_OE = 1'b1;
//				end
//				
//						
//			S_25_3 :
//			begin 
//					Mem_OE = 1'b1;
//				end
//				
//						
//			S_25_4 :
//			begin 
//					
//					Mem_OE = 1'b1;
//				end
//			S_25_5:
//				begin
//					GateMDR = 1'b0;
//					LD_MDR = 1'b1;
//					LD_MAR = 1'b0; //??
//					Mem_OE = 1'b1;
//				
//				end
//				//chnaged oe to we
//		S_16 : 
//				begin 
//					Mem_WE = 1'b1;
//				end
//		S_16_2 : 
//				begin 
//					Mem_WE = 1'b1;
//				end
//				
//		S_16_3 : 
//				begin 
//					Mem_WE = 1'b1;
//				end
//				
//		S_16_4 : 
//				begin 
//					Mem_WE = 1'b1;	
//				end
//				
//		S_16_5 : 
//			begin
//					//Mem_OE = 1'b1;
//					Mem_WE = 1'b1;
//					LD_MDR = 1'b0;
//			end
//		
//		
//		S_05: 
//		begin
//					SR2MUX = IR_5;
//					SR1MUX = 1'b1 ;
//					ALUK = 2'b01;
//					GateALU = 1'b1;
//					DRMUX = 1'b0;
//					LD_REG = 1'b1;
//					LD_CC = 1'b1;
//					//LD_BEN = 1'b1;
//					
//					
//		
//		end
//		
//		S_09:
//		begin
//		
//					SR1MUX = 1'b1 ;
//					ALUK = 2'b10;
//					GateALU = 1'b1;
//					LD_REG = 1'b1;
//					LD_CC = 1'b1;
//					//LD_BEN = 1'b1 ;
//					DRMUX = 1'b0;			
//		end
//		
//		
//		S_06:
//		begin
//			ADDR1MUX = 1'b1;
//			SR1MUX = 1'b1; 
//			ADDR2MUX = 2'b01;
//			GateMARMUX = 1'b1;
//			LD_MAR = 1'b1;
//		end
//		
//		
//		
//		
//		
//		
//		
//		S_27:
//		begin
//		GateMDR = 1'b1;
//		LD_MDR = 1'b0;
//		LD_CC = 1'b1;
//		LD_REG = 1'b1;
//		DRMUX = 1'b0;
//		//LD_BEN = 1'b1; 
//		end
//		
//		
//		
//		
//		
//		
//		
//		S_07:
//		begin
//		ADDR1MUX = 1'b1;
//		SR1MUX = 1'b1; 
//		ADDR2MUX = 2'b01;
//		GateMARMUX = 1'b1; 
//		LD_MAR = 1'b1;
//		end
//		
//		
//		
//		S_23:
//		begin
//		
//		ALUK = 2'b11;
//		GateALU = 1'b1;
//		LD_MDR = 1'b1;
//		
//		end
//		
//		
//		S_0: ; 
//		
//		
//		S_22:
//		begin
//		ADDR1MUX = 1'b0;
//		ADDR2MUX = 2'b10;
//		PCMUX = 2'b10;
//		LD_PC= 1'b1;
//		end
//		
//		
//		S_12:
//		begin
//		
//		SR1MUX = 1'b1;
//		ADDR2MUX = 2'b00;
//		ADDR1MUX = 1'b1;
//		PCMUX = 2'b10;
//		LD_PC = 1'b1;
//		
//		
//		
//		
//		end
//		
//		S_04:
//		begin
//		GatePC = 1'b1;
//		DRMUX = IR_11;
//		LD_REG = 1'b1;
//		end
//		
//		
//		
//		S_21:
//		begin
//		LD_PC = 1'b1;
//		ADDR1MUX = 1'b0;
//		ADDR2MUX = 2'b11;
//		PCMUX = 2'b10;
//		end
//		   
//			
//			PauseIR1: 
//			begin
//			LD_LED = 1'b1 ;
//			end
//			
//			PauseIR2:
//			begin
//			LD_LED = 1'b1 ;
//			end
//			
//			
//			
//			S_32 : 
//				LD_BEN = 1'b1;
//			S_01 : 
//				begin 
//					DRMUX = 1'b0;
//					SR1MUX = 1'b1 ;
//					SR2MUX = IR_5;
//					ALUK = 2'b00;
//					GateALU = 1'b1;
//					LD_REG = 1'b1;
//					LD_CC = 1'b1;
//					//LD_BEN = 1'b1;
//				end

			// You need to finish the rest of states.....

			default : ;
		endcase
	end 

	
endmodule
