// `timescale  1ns/100ps
// `include "./instruction_fetch_unit.v"
// `include "./IF.v"
// `include "./instruction_decode_unit.v"
// `include "./ID.v"

// `include "./instruction_execute_unit.v"
// `include "./EX.v"
// `include "./memory_access_unit.v"


module cpu(
    input clk,
    input reset,
    input [31:0] instruction_from_icache,
    input busywait_from_icache,
    // input ,
    // input instruction_mem_busywait,
    output [31:0] address_to_icache,
    output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output
  );

  // wire [31:0] instruction;
  // wire instruction_mem_busywait;

  // always @ (posedge clk,posedge reset)
  // begin
  //   if(reset)begin
  //     instruction = 32'b00000000000100001000000010010011;
  //   end
  //   else begin
  //     #1 instruction = 32'd0;
  //   end
  // end

  // assign instruction = 32'b00000000000100001000000010010011;
  // assign instruction_mem_busywait = 1'b0;
  assign address_to_icache = pc_instruction_fetch_unit_out;

  wire d_mem_r_id_unit_out, d_mem_w_id_unit_out,branch_id_unit_out,jump_id_unit_out,write_reg_en_id_unit_out,mux_d_mem_id_unit_out,mux_inp_2_id_unit_out,mux_complmnt_id_unit_out,mux_inp_1_id_unit_out, rotate_signal_id_unit_out;
  wire branch_or_jump_signal,data_memory_busywait,busywait;
  wire [31:0] pc_instruction_fetch_unit_out,pc_4_instruction_fetch_unit_out,branch_jump_addres;
  wire [31:0]instruction_instruction_fetch_unit_out,pc_if_reg_out, pc_4_if_reg_out, instration_if_reg_out;
  wire [31:0] write_data,data_1_id_unit_out,data_2_id_unit_out,mux_1_out_id_unit_out;
  wire [4:0] write_address_for_current_instruction_id_unit_out;
  wire [1:0]mux_result_id_unit_out;
  wire [2:0] alu_op_id_unit_out,fun_3_id_unit_out,alu_op_id_reg_out,fun_3_id_reg_out,fun_3_ex_reg_out;
  wire rotate_signal_id_reg_out,mux_complmnt_id_reg_out,mux_inp_2_id_reg_out,mux_inp_1_id_reg_out,mux_d_mem_id_reg_out,write_reg_en_id_reg_out,d_mem_r_id_reg_out,d_mem_w_id_reg_out,branch_id_reg_out,jump_id_reg_out;
  wire [31:0] pc_4_id_reg_out,pc_id_reg_out,data_1_id_reg_out,data_2_id_reg_out,mux_1_out_id_reg_out;
  wire [1:0] mux_result_id_reg_out;
  wire [4:0] write_address_id_reg_out,write_address_ex_reg_out;
  wire [31:0]result_iex_unit_out,data_2_ex_reg_out,result_mux_4_ex_reg_out;
  wire mux_d_mem_ex_reg_out,write_reg_en_ex_reg_out,d_mem_r_ex_reg_out,d_mem_w_ex_reg_out;
  wire [31:0] Register_value_output_wires [31:0];

  instruction_fetch_unit if_unit(
    branch_jump_addres, 
    branch_or_jump_signal, 
    data_memory_busywait, 
    reset, 
    clk, 
    busywait_from_icache,
    pc_instruction_fetch_unit_out, 
    pc_4_instruction_fetch_unit_out,
    busywait
    );
  
  IF if_reg(
    pc_instruction_fetch_unit_out, 
    pc_4_instruction_fetch_unit_out, 
    instruction_from_icache, 
    reset, 
    clk,
    busywait,
    branch_or_jump_signal,
    pc_if_reg_out, 
    pc_4_if_reg_out, 
    instration_if_reg_out
    );

  instruction_decode_unit id_unit(
    reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
    write_address_for_current_instruction_id_unit_out,
    rotate_signal_id_unit_out,
    d_mem_r_id_unit_out, 
    d_mem_w_id_unit_out,
    branch_id_unit_out,
    jump_id_unit_out,
    write_reg_en_id_unit_out,
    mux_d_mem_id_unit_out,
    mux_result_id_unit_out,
    mux_inp_2_id_unit_out, 
    mux_complmnt_id_unit_out,
    mux_inp_1_id_unit_out,
    alu_op_id_unit_out,
    fun_3_id_unit_out,
    data_1_id_unit_out,
    data_2_id_unit_out,
    mux_1_out_id_unit_out,
    instration_if_reg_out,
    write_data,
    write_reg_en_ex_reg_out,
    write_address_ex_reg_out,
    clk, 
    reset
    );

  ID id_reg(
  rotate_signal_id_unit_out,
  d_mem_r_id_unit_out, 
	d_mem_w_id_unit_out,
  branch_id_unit_out,
  jump_id_unit_out,
  write_reg_en_id_unit_out,
  mux_d_mem_id_unit_out,
	mux_result_id_unit_out,
	mux_inp_2_id_unit_out, 
  mux_complmnt_id_unit_out,
	mux_inp_1_id_unit_out,
  alu_op_id_unit_out,
  fun_3_id_unit_out,
  write_address_for_current_instruction_id_unit_out,
  data_1_id_unit_out,
  data_2_id_unit_out,
  mux_1_out_id_unit_out,
  pc_if_reg_out,
  pc_4_if_reg_out,
  reset,
  clk,
  busywait,
  branch_or_jump_signal,
  rotate_signal_id_reg_out, 
  mux_complmnt_id_reg_out, 
  mux_inp_2_id_reg_out, 
  mux_inp_1_id_reg_out, 
  mux_d_mem_id_reg_out, 
  write_reg_en_id_reg_out,
  d_mem_r_id_reg_out, 
  d_mem_w_id_reg_out, 
  branch_id_reg_out, 
  jump_id_reg_out,
  pc_4_id_reg_out, 
  pc_id_reg_out, 
  data_1_id_reg_out, 
  data_2_id_reg_out, 
  mux_1_out_id_reg_out,
  mux_result_id_reg_out,
  write_address_id_reg_out,
  alu_op_id_reg_out, 
  fun_3_id_reg_out
  );

  

  instruction_execute_unit iex_unit(
    data_1_id_reg_out,
    data_2_id_reg_out,
    pc_id_reg_out,
    pc_4_id_reg_out,
    mux_1_out_id_reg_out,
    mux_result_id_reg_out,
    mux_inp_1_id_reg_out,
    mux_inp_2_id_reg_out,
    mux_complmnt_id_reg_out,
    rotate_signal_id_reg_out,
    branch_id_reg_out,
    jump_id_reg_out,
    fun_3_id_reg_out,
    alu_op_id_reg_out,
    branch_jump_addres,
    result_iex_unit_out,
    branch_or_jump_signal
  );

  EX ex_reg(
    d_mem_r_id_reg_out, 
	  d_mem_w_id_reg_out,
    mux_d_mem_id_reg_out,
    write_reg_en_id_reg_out,
    write_address_id_reg_out,
    fun_3_id_reg_out,
    data_2_id_reg_out,
    result_iex_unit_out,
    reset,
    clk,
    busywait,
    data_2_ex_reg_out, 
    result_mux_4_ex_reg_out,
    mux_d_mem_ex_reg_out, 
    write_reg_en_ex_reg_out, 
    d_mem_r_ex_reg_out, 
    d_mem_w_ex_reg_out,
    fun_3_ex_reg_out,
    write_address_ex_reg_out
  );


  memory_access_unit mem_access_unit(
    clk,
    reset,
    d_mem_r_ex_reg_out,
    d_mem_w_ex_reg_out,
    mux_d_mem_ex_reg_out,
    result_mux_4_ex_reg_out,
    data_2_ex_reg_out,
    fun_3_ex_reg_out,
    data_memory_busywait,
    write_data
    );

endmodule
