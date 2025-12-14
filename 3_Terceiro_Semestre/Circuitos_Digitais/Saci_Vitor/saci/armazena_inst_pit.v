/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : trad_inst_pit
Description : This module translates instruction codes from 4-bits to 2-bits
              and stores the translated codes for the extra cycles needed to 
              complete the instructions. The translation is combinational,
              the storing of the translated codes is sequential.
******************************************************************************/
module armazena_inst_pit(clk, enable, inst_in, inst_out);
	 input clk;
	 input enable;
    input [1:0]	inst_in;
    output[1:0]	inst_out;
	 
	 wire [1:0] inst_temp_variavel;
	 wire [1:0] inst_temp_registrado;
	 reg [1:0] inst_reg; 	
// Descrição da arquitetura
    
	assign inst_temp_registrado=inst_in;												
 		
	assign inst_out =
	  (enable) ? inst_in : inst_reg;
														
										
	always@(posedge clk) begin
       if (enable)
            inst_reg <= inst_in;   // 
   end	


														
endmodule