module top(
    input [7:0] switches,
    input en,
    output [2:0] decode83_out, 
    output [6:0] seg0,
    output [7:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7

);

    wire decoder_en;
    
    // off all rest seg
    assign seg1 = 8'b11111111;
    assign seg2 = 8'b11111111;
    assign seg3 = 8'b11111111;
    assign seg4 = 8'b11111111;
    assign seg5 = 8'b11111111;
    assign seg6 = 8'b11111111;
    assign seg7 = 8'b11111111;

    decode83 u_decoder (
        .in(switches),
        .out(decode83_out),
        .en(decoder_en)
    );

    wire final_en = decoder_en & en;

    bcd7seg u_seg7(
        .bin_in(decode83_out),
        .en(final_en),
        .seg_out(seg0)

    );

    
endmodule
