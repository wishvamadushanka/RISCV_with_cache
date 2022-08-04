`timescale 1ns/100ps

`include "./cpu.v"

module cpuTestbench; 

    reg CLK, RESET, instruction_mem_busywait;
    wire [31:0] out_reg [6:0];
    reg [31:0] instruction;

    //seperated cache
    reg [31:0] instruction_from_icache;
    reg busywait_from_icache;
    wire [31:0] address_to_icache;


    //instruction,instruction_mem_busywait,

    cpu mycpu(CLK,RESET,instruction_from_icache,busywait_from_icache,address_to_icache,out_reg[0],out_reg[1],out_reg[2],out_reg[3],out_reg[4],out_reg[5],out_reg[6]);

    always
        #5 CLK = ~CLK;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpuTestbench);

        // input [31:0] instruction_from_icache,
        // input busywait_from_icache,
        // // input ,
        // // input instruction_mem_busywait,
        // output [31:0] address_to_icache;
		
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
		// RESET = 1'b1;
		#2
		RESET = 1'b1;
		#4
		RESET = 1'b0;
        instruction_from_icache = 32'b00000000000100001000000010010011;
        busywait_from_icache = 1'b0;

		// #4
		// RESET = 1'b0;
        // instruction = 32'b00000000000100001000000010010011;
        // instruction_mem_busywait = 0;

        // #10
        // instruction = 32'b00000000001100001000000100010011;
        // instruction_mem_busywait = 0;
        
        // finish simulation after some time
        #6000
        $finish;
        
    end
        

endmodule