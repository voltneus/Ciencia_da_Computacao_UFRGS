module me012p(p, ck, reset, saida, saida2);
input   p, ck, reset;        
output [6:0]     saida;
output [1:0]     saida2;

wire [1:0] ea;
wire [1:0] pe;



//soma 1 no estado atual (ea) para obter o próximo estado
ccpe Xaubet(.p(p), .ea(ea), .pe(pe));
//copia o pe no ea (na borda de subida) e guarda o ea
reg2 Feijo(.d(pe), .q(ea), .ck(ck), .reset(reset));
//liga o ea direto na saída
ccsaida Rigo(.ea(ea), .saida(saida));

buf(saida2[0], ea[0]);
buf(saida2[1], ea[1]);

endmodule



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

module reg2(d, q, ck, reset);
input   ck, reset;
input  [1:0]     d;        
output [1:0]     q;

wire nreset;
not(nreset, reset);
meu_ff bit1(.d(d[1]), .ck(ck), .prn(1'b1), .ena(1'b1), .clrn(nreset), .q(q[1]));
meu_ff bit0(.d(d[0]), .ck(ck), .prn(1'b1), .ena(1'b1), .clrn(nreset), .q(q[0]));
endmodule


/****************************************** (c) 2025 inPlace Design Automation
  Módulo    : meu_ff
  Descrição : ff tipo D similar ao Quartus
******************************************************************************/

module meu_ff(d, ck, prn, ena, clrn, q);
//Não precisa entender, é só usar como caixinha
    input       d;     // entrada de dados  
    input       ck;    // sinal de relógio  
    input       prn;   // set síncrono (ocorre na borda de subida do clock)    
    input       ena;   // sinal de hablita
    input       clrn;  // reset assíncrono (ocorre imediatamente)      
    output      reg q; // saida memorizada q  

    always@(posedge ck or negedge clrn) begin
        if(!clrn)
            q <= 1'b0; // reseta q=0 se clrn=0
        else if(!prn)
            q <= 1'b1; // seta q=1 se prn=0
        else if (ena)
            q <= d;   // copia d para q se ena = 1
    end
endmodule

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