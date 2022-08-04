`timescale 1ns/100ps

`include "./icache.v"

// reset,
//     address,
//     instruction,
// 	busywait
//     );

//     input reset,clock;
//     input [31:0] address;

//     output reg busywait;
//     output reg [31:0] instruction;

module icacheTestbench; 

    reg CLK, RESET;
    wire [31:0] instruction;
    wire busywait;
    reg [31:0] address;

    //instruction,instruction_mem_busywait,

    icache myicache(CLK,RESET,address,instruction,busywait);

    always
        #5 CLK = ~CLK;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("icache_wavedata.vcd");
		$dumpvars(0, icacheTestbench);
		
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
		// RESET = 1'b1;
		#2
		RESET = 1'b1;
		#4
		RESET = 1'b0;
		
        address = 32'd0;
        
        // finish simulation after some time
        #6000
        $finish;
        
    end
        

endmodule