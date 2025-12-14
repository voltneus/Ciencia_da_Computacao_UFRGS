// -- ccSaidaMoore -- 
module ccSaidaMoore(ea, saidas);
    input  [2:0]     ea;  // estado atual de 3 bits       
    output [5:0]     saidas; // saida de 6 bits        

// not do ea
wire [2:0] nea;
not(nea[0], ea[0]);
not(nea[1], ea[1]);
not(nea[2], ea[2]);


wire s5;
and(s5, ea[2], nea[1], nea[0]);
or(saidas[5], s5, nea[2]);

and(saidas[4], nea[2], nea[1]);
and(saidas[3], nea[2], nea[1], ea[0]);
and(saidas[2], ea[2], nea[1], nea[0]);
and(saidas[1], nea[2], ea[1], ea[0]);
and(saidas[0], nea[2], ea[1]);

endmodule