//---------VERILOG----------

module sc(a, b, cin, cout, s); 

input a, b, cin;
output cout, s;
wire [2:0] in;
wire m1, m2, m3, m4, m5, m6, m7, na, nb, ncin;


//s

or(s, m1, m2, m4, m7);

and(m1, na, nb, cin); 
and(m2, na, b, ncin); 
and(m4, a, nb, ncin); 


//cout

or(cout, m3, m5, m6, m7);

and(m3, na, b, cin); 
and(m5, a, nb, cin); 
and(m6, a, b, ncin); 


//mutual

and(m7, a, b, cin);

not(na, a); 
not(nb, b);
not(ncin, cin);

endmodule