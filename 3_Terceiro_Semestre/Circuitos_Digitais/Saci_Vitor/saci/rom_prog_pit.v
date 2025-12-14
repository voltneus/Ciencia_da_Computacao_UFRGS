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