module top(
    input [7:0] switches,
    input en,
    output [2:0] decode83_out,
    output [6:0] seg

);

    wire decoder_en;
    
    decode83 u_decoder (
        .in(switches),
        .out(decode83_out),
        .en(decoder_en)
    );

    wire final_en = decoder_en & en;

    bcd7seg u_seg7(
        .bin_in(decode83_out),
        .en(final_en),
        .seg_out(seg)

    );

    
endmodule
