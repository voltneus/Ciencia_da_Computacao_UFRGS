module ccsaida(ea, saida);
    input  [1:0]     ea;        
    output [6:0]     saida;  

wire [1:0]     nea;
not(nea[0], ea[0]);
not(nea[1], ea[1]);     

buf(saida[6], ea[1]);
xnor(saida[5], ea[0], ea[1]);
or(saida[4], ea[1], nea[0]);
not(saida[3], ea[0]);
not(saida[2], ea[1]);
buf(saida[1], 1'b1);
or(saida[0], ea[1], nea[0]); 

endmodule