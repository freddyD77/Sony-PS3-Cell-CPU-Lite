module tb_simpleFixed2();
    logic		clk, reset;
    //logic 		fowarded_data;
    //logic [31:0]	instructionIN, instructionOUT;
    logic [0:127]	ra, rb, rc; 
    logic [0:138]	the_output;
    logic [0:31]	word0, word1, word2, word3, raW0, raW1, raW2, raW3, rbW0, rbW1, rbW2, rbW3, rcW0, rcW1, rcW2, rcW3;
    logic [0:15]	hw1, hw2, hw3, hw4, hw5, hw6, hw7, hw0, raHW0, raHW1, raHW2, raHW3, raHW4, raHW5, raHW6, raHW7, rbHW0, rbHW1, rbHW2, rbHW3, rbHW4, rbHW5, rbHW6, rbHW7,
			rcHW0, rcHW1, rcHW2, rcHW3, rcHW4, rcHW5, rcHW6, rcHW7;
    logic [0:63]	long1, long2;
    logic [7:0]		instructionNUM;
    logic [0:6]			addr_rt;
    logic [0:10]		opcode11;
    logic [0:6]			immediate7;
    logic			wr;
    //logic real [31:0]		raw1short;

    SimpleFixed2 U0(
	.data_ra (ra),
	.data_rb (rb),
	.addr_rt (addr_rt),
	.opcode (opcode11),
	.out_data (the_output),
	.immediate (immediate7),
	.reset (reset),
	.clk (clk));


    initial clk = 0;
	

    always begin
	#1 clk = !clk;

	wr = the_output[131];

	word0 = the_output[0:31];
	word1 = the_output[32:63];
	word2 = the_output[64:95];
	word3 = the_output[96:127];
	hw0 = the_output[0:15];
	hw1 = the_output[16:31];
	hw2 = the_output[32:47];
	hw3 = the_output[48:63];
	hw4 = the_output[64:79];
	hw5 = the_output[80:95];
	hw6 = the_output[96:111];
	hw7 = the_output[112:127];
	long1 = the_output[0:63];
	long2 = the_output[64:127];

	raW0 = ra[0:31];
	raW1 = ra[32:63];
	raW2 = ra[64:95];
	raW3 = ra[96:127];

	rbW0 = rb[0:31];
	rbW1 = rb[32:63];
	rbW2 = rb[64:95];
	rbW3 = rb[96:127];

	raHW0 = ra[0:15];
	raHW1 = ra[16:31];
	raHW2 = ra[32:47];
	raHW3 = ra[48:63];
	raHW4 = ra[64:79];
	raHW5 = ra[80:95];
	raHW6 = ra[96:111];
	raHW7 = ra[112:127];

	rbHW0 = rb[0:15];
	rbHW1 = rb[16:31];
	rbHW2 = rb[32:47];
	rbHW3 = rb[48:63];
	rbHW4 = rb[64:79];
	rbHW5 = rb[80:95];
	rbHW6 = rb[96:111];
	rbHW7 = rb[112:127];

    end
    
    initial begin
	
	ra[0:31] = 		32'b00110111001001111100010110101100;//10.0_e-5;
	ra[32:63] = 	32'b01100001001011010111100011101100;//2.0_e20;
	ra[64:95] = 	32'b01010000000101010000001011111001;//1.0_e10;
	ra[96:127] = 0;

	rb[0:31] = 		-1;//32'b00011111011011000001111001000001;
	rb[32:63] = 	32'b00001110001101000100010100100010;//2.222e-30;
	rb[64:95] = 	32'b00100100000010100101100111000000;//-3.0e-17;
	rb[96:127] = 	32'b11000110110000110101000000000000;//-2.5e4;

	reset = 1;
	@(posedge clk); #1;
	reset = 0;

	@(posedge clk); #1;
	instructionNUM = 0;
	opcode11=11'b00001011111; addr_rt=0; immediate7=0;// shift left hw
	@(posedge clk); #1;
	instructionNUM = 1;
	opcode11=11'b00001011011; addr_rt=1; immediate7=1;// shift left w
	@(posedge clk); #1;
	instructionNUM = 2;
	opcode11=11'b00001011100; addr_rt=2; immediate7=2;// rotate hw
	@(posedge clk); #1;
	instructionNUM = 3;
	opcode11=11'b00001011000; addr_rt=3; immediate7=3;// rotate w
	@(posedge clk); #1;
	instructionNUM = 0;
	opcode11=11'b00001011101; addr_rt=5; immediate7=4;// rotate and mask hw
	@(posedge clk); #1;
	instructionNUM = 1;
	opcode11=11'b00001011001; addr_rt=6; immediate7=5;// rotate and mask w
	@(posedge clk); #1;
	instructionNUM = 2;
	opcode11=11'b00001111011; addr_rt=7; immediate7=6;// shift left hw imm
	@(posedge clk); #1;
	instructionNUM = 3;
	opcode11=11'b00001111100; addr_rt=8; immediate7=7;// shift left w imm



    end

    initial begin
	#45;
	$finish;
    end

endmodule
		







