// `timescale  1ns/100ps
module Data_load_controller (
    func3,
    data_mem_in,
    data_out
);

input [2:0] func3;
input [31:0] data_mem_in;
output reg [31:0] data_out;
wire [31:0] lb,lbu,lh,lhu;

assign lb ={{24{data_mem_in[7]}},data_mem_in[7:0]};
assign lbu ={{24{1'b0}},data_mem_in[7:0]};
assign lh ={{16{data_mem_in[15]}},data_mem_in[15:0]};
assign lhu ={{16{1'b0}},data_mem_in[15:0]};


always @(*) begin
    case(func3)
        3'b000:begin
            data_out<=lb;
        end
        3'b001:begin
            data_out<=lh;
        end
        3'b010:begin
            data_out<=data_mem_in;
        end
        3'b100:begin
            data_out<=lbu;
        end
        3'b101:begin
            data_out<=lhu;
        end
		  default: begin
				data_out <= 32'd0;
			end
    endcase
end
    
endmodule