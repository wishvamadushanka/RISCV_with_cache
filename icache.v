// `timescale 1ns/100ps

// `include "./imem_for_icache.v"

module icache (clock,
    reset,
    address_tmp,
    instruction,
	busywait,
    valid_out
    );

    input reset,clock;
    // input [31:0] address;
    wire [31:0] address;
    input [7:0] address_tmp;

    output reg busywait;
    output reg [31:0] instruction;
    

    wire valid,mem_busywait;
    output valid_out;
    // wire mem_busywait;
    // output reg valid;

    wire [1:0] offset;
    wire [2:0] index;
	 wire [24:0] tag;
    wire [127:0] mem_readdata;

    reg hit,mem_read,write_from_mem;
    reg valid_bits[0:7];
    reg [24:0] tags[0:7];
    reg [31:0] word[0:7][0:3];
    reg [27:0] mem_address;
    
    assign address = {24'd0,address_tmp};
    assign valid_out = valid;
    
    /*
    Combinational part for indexing, tag comparison for hit deciding, etc.
    ...
    ...
    */
    Instruction_memory my_i_memory(reset,clock,mem_read,mem_address,mem_readdata,mem_busywait);

    
    assign valid=1;//valid_bits[address[6:4]];
    assign tag=tags[address[6:4]];
    assign index=address[6:4];
    assign offset=address[3:2];

    always @(*) begin //extrac the data from word 

        if(valid)begin
            instruction <= address; //word[index][offset];
        end
    end

    always @(*) begin //check wheather hit or miss
        
        if ((tag == address[31:7]) && valid) begin
            hit <= 1'b1;
        end
        else begin
            hit <= 1'b0;
        end
    end

   
    always @(*) begin
        if(reset)begin
			for (i =0 ;i<8 ;i = i+1 ) begin
                valid_bits[i] <= 1'b0;
            end
		  end
        if (write_from_mem) begin //write data get from instruction memory
            valid_bits[index] <= 1;
            tags[index] <= address[31:7];
            {word[index][3],word[index][2],word[index][1],word[index][0]} <= mem_readdata;
        end

    end
    

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001,CACHE_WRITE=3'b011;
    reg [2:0] state, next_state;
    reg active_cache_w,strt_mem_r;

    // always @ (negedge mem_busywait, posedge busywait)
    // begin
    //     if (busywait)
    //     begin
    //         active_cache_w = 1;
    //     end
    //     if (mem_busywait)
    //     begin
            
    //     end
    // end

    // always @ (posedge mem_read, posedge busywait)
    // begin
    //     if (mem_read)
    //     begin
    //         strt_mem_r = 1;
    //     end 
    //     if (busywait) begin
    //         strt_mem_r = 0;
    //     end
    // end

    always @ (posedge mem_read, posedge mem_busywait)
    begin
        if (mem_read)
        begin
            strt_mem_r = 1;
        end 
        if (mem_busywait) begin
            strt_mem_r = 0;
        end
    end
    // combinational next state logic
    always @(*)
    begin
        case (state)
            // #1
            IDLE: //normal state
                if ( !hit & !reset)  
                    next_state <= MEM_READ;
                else
                    next_state <= IDLE;
            
            MEM_READ: //memory read state
                if ((!strt_mem_r && !mem_busywait) & !reset)
                    next_state <= CACHE_WRITE;
                else    
                    next_state <= MEM_READ;
            CACHE_WRITE: //chache write state
                    next_state <= IDLE;

        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)

            IDLE:
            begin
                mem_read <= 0;
                mem_address <= 28'dx;
                busywait <= 0;
                write_from_mem <= 0;  
            end
         
            MEM_READ: 
            begin
                mem_read <= 1;
                mem_address <= address[31:4];
                busywait <= 1;
                write_from_mem <= 0;
            end
            CACHE_WRITE:
            begin
                mem_read <= 0;
                mem_address <= 28'dx;
                busywait <= 1;
                write_from_mem <= 1;//this signal assert when data block is come from memoey in this state
            end
        endcase
    end

    // sequential logic for state transitioning 
    integer i;
    always @(posedge clock, posedge reset)
    begin
        
        if(reset)begin
            state=IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    /* Cache Controller FSM End */

endmodule