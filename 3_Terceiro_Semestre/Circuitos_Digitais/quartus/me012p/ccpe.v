module ccpe(p, ea, pe);
//b virou a constante 1 (0001), para ficar sempre somando 1
input p; //p
input  [1:0]     ea; //estado atual 
output [1:0]     pe; //proximo estado
wire [1:0]     nea;
wire np;

not(nea[0], ea[0]);
not(nea[1], ea[1]);
not(np, p);

wire p0, p1;

and(p0, ea[0], np, nea[1]);
and(p1, nea[0], np, nea[1]);

or(pe[1], p0, p);
or(pe[0], p1, p);

endmodule