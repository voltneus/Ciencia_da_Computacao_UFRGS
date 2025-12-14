//mux21_8b muxpc(.sel(), .e1(), .e0(), .saida(fio_pctem_1));
module mux21_8b_pit(sel, e1, e0, saida);
	
	 input	sel;
    input [7:0]	e1;
	 input [7:0]	e0;
    output[7:0]	saida;
	 
	 assign saida =(sel) ? e1 :  e0;
	 
	 
endmodule