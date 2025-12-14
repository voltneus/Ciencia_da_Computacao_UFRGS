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