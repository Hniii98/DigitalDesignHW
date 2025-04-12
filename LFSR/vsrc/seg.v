module seg(
    input [7:0] lfsr_state,
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);
    localparam SEG_0   = 8'b0000_0011; // 0
    localparam SEG_1   = 8'b1001_1111; // 1

    function automatic [7:0] get_seg_value(input bit condition);
        get_seg_value = condition ? SEG_1 : SEG_0;
    endfunction

    assign seg0 = get_seg_value(lfsr_state[0]);
    assign seg1 = get_seg_value(lfsr_state[1]);  
    assign seg2 = get_seg_value(lfsr_state[2]);  
    assign seg3 = get_seg_value(lfsr_state[3]);  
    assign seg4 = get_seg_value(lfsr_state[4]);  
    assign seg5 = get_seg_value(lfsr_state[5]);  
    assign seg6 = get_seg_value(lfsr_state[6]);
    assign seg7 = get_seg_value(lfsr_state[7]);   
         
endmodule
