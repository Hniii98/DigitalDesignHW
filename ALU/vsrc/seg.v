module seg (
    input [3:0] in_res,
    input overflow,
    input zero,
    input carry,
    input [2:0]optype,
    output reg [7:0] seg0,
    output reg [7:0] seg1,
    output reg [7:0] seg2,
    output reg [7:0] seg3,
    output reg [7:0] seg4,
    output reg [7:0] seg5,
    output reg [7:0] seg6

    
);

localparam SEG_OFF = 8'b1111_1111; // all off
localparam SEG_0   = 8'b0000_0011; // 0
localparam SEG_1   = 8'b1001_1111; // 1

function automatic [7:0] get_seg_value(input bit condition);
    get_seg_value = condition ? SEG_1 : SEG_0;
endfunction

always @(*) begin
    {seg6, seg5, seg4, seg3, seg2, seg1, seg0} = {7{SEG_OFF}}; // off all seg
    case(optype)
        3'h0, 3'h1: begin   // add、sub, all number need to display in segs
            seg0 = get_seg_value(in_res[0]);
            seg1 = get_seg_value(in_res[1]);
            seg2 = get_seg_value(in_res[2]);
            seg3 = get_seg_value(in_res[3]);
            seg4 = get_seg_value(carry);
            seg5 = get_seg_value(zero);
            seg6 = get_seg_value(overflow);
        end
        3'h2, 3'h3, 3'h4, 3'h5: begin // logic op, don't need overflow and carry status
            seg0 = get_seg_value(in_res[0]);
            seg1 = get_seg_value(in_res[1]);
            seg2 = get_seg_value(in_res[2]);
            seg3 = get_seg_value(in_res[3]);
            seg4 = SEG_OFF;
            seg5 = get_seg_value(zero);
            seg6 = SEG_OFF;
        end
        3'h6, 3'h7: begin // compare, only need lsb of in_res
            seg0 = get_seg_value(in_res[0]);
            seg1 = SEG_OFF;
            seg2 = SEG_OFF;
            seg3 = SEG_OFF;
            seg4 = SEG_OFF;
            seg5 = SEG_OFF;
            seg6 = SEG_OFF;
        end
    endcase
end

endmodule
