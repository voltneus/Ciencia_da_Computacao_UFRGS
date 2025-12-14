/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : saci_pitanga
Description : SACI microprocessor, made by instantiating different modules
******************************************************************************/
module saci_pitanga(clk, rst
//, OutAC, OutPC, OutREM
//, oselPC, oenPC, oselMEM, oenREM, owrite, oopULA, oenAC
//, oDregPC, oQregPC, oPCm1, oQrem
, oEndMem_7s, oEndMem_MS
//, oOutMem, oDregAC, oQregAC
, oMem128_7s
, oEA

);
    input       clk;        // relógio do sistema (clock)
    input       rst;        // reset
    
    //output      blk;        // saída de relógio (para piscar led)

// Sinais de Dados
    //output [7:0] OutAC;   // sair o valor do acumulador para debugar
	 //output [7:0] OutPC;   // sair o valor do PC para debugar
	 //output [7:0] OutREM;   // sair o valor do REM para debugar
    //output [7:0] resultado;   // resultado da memoria, para debugar
	 
	 //output	oselPC;
	 //output	oenPC;
	 //output	oselMEM;
	 //output	oenREM;
	 //output	owrite;
	 //output	oopULA;
	 //output	oenAC;
	 
	 output [2:0] oEA;
	 
	 //output [7:0] oDregPC; // entrada do PC
	 //output [7:0] oQregPC; // saida do PC
	 //output [7:0] oPCm1; // saida do incrementador
	 //output [7:0] oQrem; // saida do REM
	 output [6:0] oEndMem_7s; // endereço da memoria
	 output oEndMem_MS;
	 //output [7:0] oOutMem; // saida da memoria
	 //output [7:0] oDregAC; // entrada do AC
	 //output [7:0] oQregAC; // saida do AC
	 output [6:0] oMem128_7s; // O que foi escrito na memória
	 wire [7:0] wMem128;
	 
	 
    wire SelPC, EnPC, EnREM, SelMem, Write, OpULA, EnAC, z;
	 assign z=1'b0;
	 wire [7:0] DregPC; // entrada do PC
	 wire [7:0] QregPC; // saida do PC
	 wire [7:0] PCm1; // saida do incrementador
	 wire [7:0] Qrem; // saida do REM
	 wire [7:0] EndMem; // endereço da memoria
	 wire [7:0] OutMem; // saida da memoria
	 wire [7:0] DregAC; // entrada do AC
	 wire [7:0] QregAC; // saida do AC
	 
	 //assign OutAC=QregAC;
	 //assign OutPC=QregPC;
	 //assign OutREM=Qrem;
	 
	 display7seg disp_EndMem(.in(EndMem[3:0]), .out(oEndMem_7s));
	 display7seg disp_Mem128(.in(wMem128[3:0]), .out(oMem128_7s));
	 assign oEndMem_MS=EndMem[7];
	 
     mais_um_pit incrementapc(.a(QregPC), .s(PCm1));
     mux21_8b_pit muxpc(.sel(SelPC), .e1(PCm1), .e0(OutMem), .saida(DregPC));
     mux21_8b_pit muxmemoria(.sel(SelMem), .e1(QregPC), .e0(Qrem), .saida(EndMem));
     reg8_pit REM(.clk(clk), .rst(rst), .set(z), .cen(EnREM), .d(OutMem), .q(Qrem));
     reg8_pit PC(.clk(clk), .rst(rst), .set(z), .cen(EnPC), .d(DregPC), .q(QregPC));
     reg8_pit AC(.clk(clk), .rst(rst), .set(z), .cen(EnAC), .d(DregAC), .q(QregAC));
     memoria_pit memoria_saci(.write(Write), .clk(clk), .rst(rst), .address(EndMem), 
										.din(QregAC), .dout(OutMem), .oMem128(wMem128));
     ula_pit ula_saci(.a(OutMem), .b(QregAC), .op(OpULA), .s(DregAC));
     controle_saci_pit cs(.clk(clk), .rst(rst), .inst_in(OutMem[7:6]), 
									.selPC(SelPC), .enPC(EnPC), .selMEM(SelMem), .enREM(EnREM), 
									.write(Write), .opULA(OpULA), .enAC(EnAC), .oEA(oEA));
					
	

    //assign	oselPC=SelPC;
	 //assign	oenPC=EnPC;
	 //assign	oselMEM=SelMem;
	 //assign	oenREM=EnREM;
	 //assign	owrite=Write;
	 //assign	oopULA=OpULA;
	 //assign	oenAC=EnAC;	
	 
	 
	 //assign oDregPC=DregPC; // entrada do PC
	 //assign oQregPC=QregPC; // saida do PC
	 //assign oPCm1=PCm1; // saida do incrementador
	 //assign oQrem=Qrem; // saida do REM
	 //assign oEndMem=EndMem; // endereço da memoria
	 //assign oOutMem=OutMem; // saida da memoria
	 //assign oDregAC=DregAC; // entrada do AC
	 //assign oQregAC=QregAC; // saida do AC
	 
	 

     endmodule


	  
/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : mais_um_pit
Description : This module is a combinational circuit that increments a 8-bit
              value received as input
******************************************************************************/	  	  
//mais_um incrementapc(.a(), .s());
module mais_um_pit(a, s);
	
    input [7:0]	a;
    output[7:0]	s;
	 
	 assign s = a+1;
	 
	 
endmodule


/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : mux21_8b_pit
Description : This module is a 2-input multiplexer. Data is 8-bit wide.
              It is a combinational circuit. 
******************************************************************************/
//mux21_8b muxpc(.sel(), .e1(), .e0(), .saida(fio_pctem_1));
module mux21_8b_pit(sel, e1, e0, saida);
	
	 input	sel;
    input [7:0]	e1;
	 input [7:0]	e0;
    output[7:0]	saida;
	 
	 assign saida =(sel) ? e1 :  e0;
	 
	 
endmodule

	  
/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : reg8_pit
Description : This module is a 8-bit register. It is a sequential circuit.
******************************************************************************/	  
//reg8 REM(.clk(), .rst(), .set(), .cen(), .d(), .q());
module reg8_pit(clk, rst, set, cen, d, q);
    input clk, rst, set, cen;
	 input [7:0] d;
    output reg [7:0] q;

    always@(posedge clk, posedge rst) begin
        if(rst)
            q <= 8'b00000000;
        else if(set)
            q <= 8'b11111111;
        else if(cen)
            q <= d;
        else
            q <= q;
    end
endmodule
	  
	  
/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : memoria_pit
Description : 1) This module is partly combinational, partly sequential.
              2) The program ROM is combinational, it comes from module 
                 rom_prog_pit, which is instantiated.
              3) The program RAM is sequential, it is made by 
                 instantiating a 8-bit register defined in module reg8_pit
              4) The ROM and RAM are multiplexed by the highes bit in memory
                 address. This is done by instantiating mux21_8b_pit
******************************************************************************/	  
module memoria_pit(
    input write,
	 input clk,
	 input rst,
    input [7:0] address,      // 8-bit register input
	 input [7:0] din,
    output  [7:0] dout,
	 output  [7:0] oMem128
	 );   // 8-bit register output

	wire [7:0] saida_rom;
	wire [7:0] saida_ram;
	wire enable;
	wire zero, nrst;
	not (nrst, rst);
	and (zero, nrst, rst);
	and(enable, address[7], write);
   rom_prog_pit rp(.address(address), .content(saida_rom));
	reg8_pit r(.d(din), .q(saida_ram), .clk(clk), .rst(rst), .set(), .cen(enable));
	mux21_8b_pit m8b(.e0(saida_rom), .e1(saida_ram), .sel(address[7]), .saida(dout));
	
	assign oMem128 = saida_ram;
 
endmodule

/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : rom_prog_pit
Description : This is a ROM containing the program that adds 5+5 and stores 
              the result in position 128. It is a combinational circuit.
              It is made using minterms.
******************************************************************************/
module rom_prog_pit(
    
    input [7:0] address,      // 8-bit register input
    output  [7:0] content);   // 8-bit register output

  assign content =
                (address == 8'b00000000)  ?   8'b10000000: //LDA
                (address == 8'b00000001)  ?   8'b00000111: //endereco 7
                (address == 8'b00000010)  ?   8'b11000000: //ADD
                (address == 8'b00000011)  ?   8'b00000111: //endereco 7
					 
                (address == 8'b00000100)  ?   8'b01000000: //STA
                (address == 8'b00000101)  ?   8'b10000000: //endereco 128
                (address == 8'b00000110)  ?   8'b00000000: //HLT
                (address == 8'b00000111)  ?   8'b00000101: //valor 5
					 
                (address == 8'b00001000)  ?   8'b00000000: //valor 0
                (address == 8'b00001001)  ?   8'b00000000: //valor 0
                (address == 8'b00001010)  ?   8'b00000000: //valor 0
                (address == 8'b00001011)  ?   8'b00000000: //valor 0
					 
                (address == 8'b00001100)  ?   8'b00000000: //valor 0
                (address == 8'b00001101)  ?   8'b00000000: //valor 0
                (address == 8'b00001110)  ?   8'b00000000: //valor 0
                                              8'b00000000; //valor 0  

  
endmodule


/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : ula_pit
Description : This is a ULA that makes only two operations. It is a 
              combinational circuit. The operations are s=a+b when op=1
              and s=a when op=0
******************************************************************************/
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


// --- REG3 --- 
module reg3(d, q, ck, reset);
input   ck, reset;
input  [2:0]     d; //entrada
output [2:0]     q; //saida

wire nreset;
not(nreset, reset);
meu_ff bit2(.d(d[2]), .ck(ck), .prn(1'b1), .ena(1'b1), .clrn(nreset), .q(q[2]));
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


module controle_saci_pit(clk, rst, inst_in, selPC, enPC, selMEM, enREM, write, opULA, enAC, oEA);
     input clk;
     input rst;
    input [1:0] inst_in;
    output  selPC;
     output enPC;
     output selMEM;
     output enREM;
     output write;
     output opULA;
     output enAC;
     output  [2:0] oEA;
     
     wire enable;
     wire [1:0] i;
	 wire [2:0] ea;
     wire [2:0] PE;
     reg [2:0] EA;
     
     //instancia do tradutor: não mexe que estraga: inicio
     nor (enable, EA[2], EA[1], EA[0]);
     wire [1:0] inst_temp;
     //armazena instrução: não mexe que estraga: meio
     armazena_inst_pit armazenador(.clk(clk), .enable(enable), .inst_in(inst_in), .inst_out(inst_temp));
     //instancia do tradutor: não mexe que estraga: fim
     
     
     //vetor concatenado para dar tabelas iguais aos slides
     assign i[1:0] = inst_temp;
     assign ea[2:0] = EA;
     assign oEA=EA;
     

// ccpe
ccpe CCPE(.i(i), .ea(ea), .pe(PE));
  
//ccsaida de mealy
ccSaidaMealy SAIDAMEALY(.i(i), .ea(ea), .enPC(enPC));

wire [5:0] saidas;

//ccsaida de moore
ccSaidaMoore SAIDAMOORE(.ea(ea), .saidas(saidas));


//atribui as saidas, talvez parte do ccsaida
buf(selPC, saidas[5]);
buf(selMEM, saidas[4]);
buf(enREM, saidas[3]);
buf(write, saidas[2]);
buf(opULA, saidas[1]);
buf(enAC, saidas[0]);
   
// reg3
reg3 REG3(.d(PE), .q(EA), .ck(clk), .reset(rst));

endmodule



/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : trad_inst_pit
Description : This module translates instruction codes from 4-bits to 2-bits
              and stores the translated codes for the extra cycles needed to 
              complete the instructions. The translation is combinational,
              the storing of the translated codes is sequential.
******************************************************************************/
module armazena_inst_pit(clk, enable, inst_in, inst_out);
	 input clk;
	 input enable;
    input [1:0]	inst_in;
    output[1:0]	inst_out;
	 
	 wire [1:0] inst_temp_variavel;
	 wire [1:0] inst_temp_registrado;
	 reg [1:0] inst_reg; 	
// Descrição da arquitetura
    
	assign inst_temp_registrado=inst_in;												
 		
	assign inst_out =
	  (enable) ? inst_in : inst_reg;
														
										
	always@(posedge clk) begin
       if (enable)
            inst_reg <= inst_in;   // 
   end	


														
endmodule




/****************************************************************************** 
(c) 2023, 2024, 2025 Andre Reis - UFRGS - InPlace 
Module name : display7seg
Description : Converts 4-bits values to be shown as hexa in the 7-segments 
              display. It is a combinational circuit.
******************************************************************************/	  
module display7seg(in, out);
    input [3:0]	in;
    output[6:0]	out;
// Descrição da arquitetura
    assign out =
                (in == 4'b0000)  ?   7'b1111110:
                (in == 4'b0001)  ?   7'b0110000:
                (in == 4'b0010)  ?   7'b1101101:
                (in == 4'b0011)  ?   7'b1111001:
					 
                (in == 4'b0100)  ?   7'b0110011:
                (in == 4'b0101)  ?   7'b1011011:
                (in == 4'b0110)  ?   7'b1011111:
                (in == 4'b0111)  ?   7'b1110000:
					 
                (in == 4'b1000)  ?   7'b1111111:
                (in == 4'b1001)  ?   7'b1111011:
                (in == 4'b1010)  ?   7'b1110111:
                (in == 4'b1011)  ?   7'b0011111:
					 
                (in == 4'b1100)  ?   7'b1001110:
                (in == 4'b1101)  ?   7'b0111101:
                (in == 4'b1110)  ?   7'b1001111:
                                     7'b1000111;
					 
					 
endmodule
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  