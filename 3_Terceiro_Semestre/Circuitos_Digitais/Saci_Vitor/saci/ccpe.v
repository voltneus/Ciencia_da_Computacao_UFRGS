// -- ccpe -- 
module ccpe(i, ea, pe);

input  [1:0]  i;  // entrada
input  [2:0]  ea; //vai entrar pro reg3    
output [2:0]  pe; // proximo estado

//not das instruções 
wire [1:0] ni;
not(ni[0], i[0]);
not(ni[1], i[1]);

// not do ea
wire [2:0] nea;
not(nea[0], ea[0]);
not(nea[1], ea[1]);
not(nea[2], ea[2]);

// -- pe2 --
wire [2:0] pe2;

and(pe2[2], ni[1], i[0], nea[2], nea[1], ea[0]);
and(pe2[1], ea[2], ea[1]);
and(pe2[0], ea[2], ea[0]);

or(pe[2], pe2[2], pe2[1], pe2[0]);

// -- pe1 -- 
and(pe[1], i[1], nea[2], nea[1], ea[0]);

// -- pe0 --
wire [4:0] pe0;

and(pe0[4], i[1], i[0], nea[2], nea[1]);
and(pe0[3], i[0], nea[2], nea[1], nea[0]);
and(pe0[2], i[1], nea[2], nea[1], nea[0]);
and(pe0[1], ea[2], ea[1]);
and(pe0[0], ea[2], ea[0]);

or(pe[0], pe0[4], pe0[3], pe0[2], pe0[1], pe0[0]);

endmodule