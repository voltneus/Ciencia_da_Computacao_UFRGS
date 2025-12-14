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