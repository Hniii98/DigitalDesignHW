module decode83 (
    input [7:0] in,
    output reg [2:0] out,
    output reg en
);
    always @(*) begin
        casez (in)
            8'b1???????: {out, en} = {3'b111, 1'b1};
            8'b01??????: {out, en} = {3'b110, 1'b1};
            8'b001?????: {out, en} = {3'b101, 1'b1}; 
            8'b0001????: {out, en} = {3'b100, 1'b1};        
            8'b00001???: {out, en} = {3'b011, 1'b1};
            8'b000001??: {out, en} = {3'b010, 1'b1};
            8'b0000001?: {out, en} = {3'b001, 1'b1};         
            8'b00000001: {out, en} = {3'b000, 1'b1}; 
            default:     {out, en} = {3'b000, 1'b0};
        endcase
    end
endmodule
