// `timescale  1ns/100ps

// `include "./Data_store_controller.v"
// `include "./Data_load_controller.v"
// `include "./dcache.v"

module memory_access_unit (
    input clock,reset,
    input mem_read_signal,mem_write_signal,mux5signal,
    input [31:0] mux4_out_result,data2,
    input [2:0] func3,
    output data_memory_busywait,
    output [31:0] mux5_out_write_data
);
    wire [31:0] load_data,store_data;
    wire [31:0] from_data_cache_out;
    //reg data_memory_busywait;

    assign from_data_cache_out = 32'd0;
    assign data_memory_busywait = 1'b0;

    Data_store_controller dsc(func3,store_data,data2);
    Data_load_controller dlc(func3,from_data_cache_out,load_data);
    // dcache mydcache(clock,reset,mem_read_signal,mem_write_signal,mux4_out_result,store_data,from_data_cache_out,data_memory_busywait);
    mux2x1 mux5(load_data,mux4_out_result,mux5signal,mux5_out_write_data);

endmodule