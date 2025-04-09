module bcd7seg (
    input [2:0] bin_in,
    input en,
    output reg [6:0] seg_out

);
    always @(*) begin
        if(!en) seg_out = 7'b1111111; // en = 0, seg_out disable
        else begin
            case (bin_in)
            3'h0: seg_out = 7'b1000000;
            3'h1: seg_out = 7'b1111001;
            3'h2: seg_out = 7'b0100100;
            3'h3: seg_out = 7'b0110000;
            3'h4: seg_out = 7'b0011001;
            3'h5: seg_out = 7'b0010010;
            3'h6: seg_out = 7'b0000010;
            3'h7: seg_out = 7'b1111000;
            default: seg_out = 7'b0000000;  
            endcase
        end     
    end
    
endmodule
