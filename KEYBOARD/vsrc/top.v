module top (
    input clk, clrn, ps2_clk, ps2_data,
    output reg overflow, ready, sampling,
    output reg [7:0] seg0,     // 数码管0（LSB）
    output reg [7:0] seg1,     // 数码管1
    output reg [7:0] seg2,     // 数码管2
    output reg [7:0] seg3,     // 数码管3
    output reg [7:0] seg4,     // 数码管4
    output reg [7:0] seg5,     // 数码管5
    // import for turning off
    output reg [7:0] seg6,
    output reg [7:0] seg7  
);

wire [7:0] scan_code;

wire is_valid_frame;
wire is_break_code;
wire negedge_of_ps2;

assign sampling = negedge_of_ps2;



ps2_keyboard u_ps2_keyboard(
    .clk            	(clk             ),
    .clrn           	(clrn            ),
    .ps2_clk        	(ps2_clk         ),
    .ps2_data       	(ps2_data        ),
    .nextdata_n     	(0      ),
    .data           	(scan_code       ),
    .ready          	(ready           ),
    .overflow       	(overflow        ),
    .is_valid_frame 	(is_valid_frame  ),
    .is_break_code  	(is_break_code   ),
    .negedge_of_ps2 	(negedge_of_ps2  )
);

wire press_pulse, key_released;

fsm_keyboard u_fsm_keyboard(
    .clk            	(clk             ),
    .clrn           	(clrn            ),
    .negedge_of_ps2     (negedge_of_ps2  ),
    .is_valid_frame 	(is_valid_frame  ),
    .is_break_code  	(is_break_code   ),
    .press_pulse    	(press_pulse     ),
    .key_released   	(key_released    )
);
wire [6:0] count;

pulse_counter u_pulse_counter(
    .clk            	(clk             ),
    .clrn           	(clrn            ),
    .negedge_of_ps2 	(negedge_of_ps2  ),
    .signal_pulse   	(press_pulse    ),
    .count          	(count           )

);

wire [7:0] ascii_code ;

scan_to_ascii u_scan_to_ascii(
    .scan_code  	(scan_code   ),
    .ascii_code 	(ascii_code  )
);


display_ctl u_display_ctl(
    .clk          	(clk           ),
    .clrn         	(clrn          ),
    .count        	(count         ),
    .key_released 	(key_released  ),
    .scan_code    	(scan_code     ),
    .ascii_code   	(ascii_code    ),
    .negedge_of_ps2 (negedge_of_ps2),
    .seg0         	(seg0          ),
    .seg1         	(seg1          ),
    .seg2         	(seg2          ),
    .seg3         	(seg3          ),
    .seg4         	(seg4          ),
    .seg5         	(seg5          )
   
);

assign seg6 = 8'b1111_1111;
assign seg7 = 8'b1111_1111;

endmodule
