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
     wire [2:0] EA;
     
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