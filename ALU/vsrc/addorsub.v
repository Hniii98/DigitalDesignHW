module addorsub (
    input signed [3:0] in_x, in_y,
    input cin,   // 0 -> add  ,  1 -> sub
    output [3:0] out_s,
    output overflow, carry, zero    
);

    wire [3:0] t_add_cin = ({4{cin}}^in_y) + {3'b0, cin}; // when sub, do ~in_y+1. when add, nothing happen.
    assign {carry, out_s } = in_x + t_add_cin;
    assign overflow = (in_x[3] == in_y[3]) && (out_s[3] != in_x[3]); // sign bit flip means overflow
    assign zero = ~{|out_s};

endmodule
