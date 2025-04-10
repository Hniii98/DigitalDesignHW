module top (
    input  [10:0] switches,  // [10:8] optype, [7:4] b, [3:0] a
    output [10:0] leds,    // [10] overflow, [9] zero, [8] carry, [7:4] b, [3:0] a
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);


wire [3:0] in_a, in_b;
wire [2:0] in_optype;
wire [3:0] alu_res;
wire overflow, zero, carry;


// cutting for computing in alu
assign in_a = switches[3:0], in_b = switches[7:4], in_optype = switches[10:8];
assign leds[10] = overflow, leds[9] = 0, leds[8] = carry;
assign leds[7:4] = in_b, leds[3:0] = in_a;

// unused seg
assign seg7 = 8'b1111_1111;

alu u_alu(
    .a        	(in_a         ),
    .b        	(in_b         ),
    .opcode   	(in_optype    ),
    .result   	(alu_res   ),
    .overflow 	(overflow  ),
    .zero     	(zero     ),
    .carry    	(carry     )
);



seg u_seg(
    .in_res   	(alu_res    ),
    .overflow 	(overflow  ),
    .zero     	(zero      ),
    .carry    	(carry     ),
    .optype   	(in_optype    ),
    .seg0     	(seg0      ),
    .seg1     	(seg1      ),
    .seg2     	(seg2      ),
    .seg3     	(seg3      ),
    .seg4     	(seg4      ),
    .seg5     	(seg5      ),
    .seg6     	(seg6      )
);






endmodule
