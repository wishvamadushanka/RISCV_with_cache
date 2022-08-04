module mux6x1 (
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
    input [31:0]in4,
    input [31:0]in5,
	 input [31:0]in6,
	 input [31:0]in7,
    input [2:0]select,
    output reg [15:0] out
);

always @(*) begin
    case (select)
        3'b000:begin
            out<=in1[15:0];
        end
        3'b001:begin
            out<=in2[15:0];
        end
        3'b010:begin
            out<=in3[15:0];
        end
        3'b011:begin
            out<=in4[15:0];
        end
        3'b100:begin
            out<=in5[15:0];
        end
		  3'b101:begin
            out<=in6[15:0];
        end
		  3'b110:begin
            out<=in7[15:0];
        end
		  default: begin
				out<=in7[15:0];
		  end
    endcase
end
    
endmodule