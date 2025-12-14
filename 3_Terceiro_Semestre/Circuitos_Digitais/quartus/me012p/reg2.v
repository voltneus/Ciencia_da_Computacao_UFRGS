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