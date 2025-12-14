//ula ula_saci(.a(), .b(), .op(), .s());
module ula_pit(a, b, op, s);
	
    input [7:0]	a;
	 input [7:0]	b;
	 input 	op;
    output[7:0]	s;
	 
	 wire [7:0]	soma;
	 assign soma = a+b;
	 
	 assign s =(op) ? soma :  a;
	 
endmodule