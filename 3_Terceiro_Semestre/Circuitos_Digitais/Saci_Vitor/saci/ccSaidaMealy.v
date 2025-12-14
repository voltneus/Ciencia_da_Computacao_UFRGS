// -- ccSaidaMealy -- 
module ccSaidaMealy(i, ea, enPC);
  input  [1:0]  i;  // instrução de 2 bits
  input  [2:0]  ea;  // estado atual de 3 bits       
  output   enPC; // saida de 1 bits        

//not das instruções 
wire [1:0] ni;
not(ni[0], i[0]);
not(ni[1], i[1]);

// not do ea
wire [2:0] nea;
not(nea[0], ea[0]);
not(nea[1], ea[1]);
not(nea[2], ea[2]);

wire s1, s0;

and(s1, i[0], nea[2], nea[1]);
and(s0, i[1], nea[2], nea[1]);

or(enPC, s1, s0);

endmodule