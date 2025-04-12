module top(
    input clk,
    input rst, 
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);

wire [7:0] lfsr_state;

lfsr u_lfsr(
    .clk        	(clk         ),
    .rst        	(rst         ),
    .lfsr_state 	(lfsr_state  )
);

seg u_seg(
    .lfsr_state (lfsr_state       ),
    .seg0     	(seg0      ),
    .seg1     	(seg1      ),
    .seg2     	(seg2      ),
    .seg3     	(seg3      ),
    .seg4     	(seg4      ),
    .seg5     	(seg5      ),
    .seg6     	(seg6      ),
    .seg7       (seg7             )
);




endmodule
