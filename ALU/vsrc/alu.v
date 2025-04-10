module alu (
    input signed [3:0] a,b,
    input [2:0] opcode,
    output reg [3:0] result,
    output reg overflow, zero, carry
);


reg [3:0] add_result, sub_result;
wire  add_overflow, add_zero, add_carry;
wire  sub_overflow, sub_zero, sub_carry;


addorsub u_adder(
    .in_x (a),
    .in_y (b),
    .cin (0),
    .out_s (add_result),
    .overflow (add_overflow),
    .carry (add_carry),
    .zero (add_zero)
);

addorsub u_subtractor(
    .in_x (a),
    .in_y (b),
    .cin (1),
    .out_s (sub_result),
    .overflow (sub_overflow),
    .carry (sub_carry),  // 1 -> a>=b 0 -> a<b
    .zero (sub_zero)
);

always @(*) begin
    overflow = 1'b0;
    zero = 1'b0;
    carry = 1'b0;

    case(opcode) 
        3'h0: begin 
            result = add_result;
            overflow = add_overflow;
            zero = add_zero;
            carry = add_carry;
        end
        3'h1: begin 
            result = sub_result;
            overflow = sub_overflow;
            zero = sub_zero;
            carry = sub_carry;
        end
        3'h2: result = ~a;
        3'h3: result = a & b;
        3'h4: result = a | b;
        3'h5: result = a ^ b;
        3'h6: result = {3'b000, ~sub_carry}; // a<b, out = 1
        3'h7: result = {3'b000, sub_zero};  // a==b, out = 1
        default: result = 4'b0000;
    endcase
end

endmodule
