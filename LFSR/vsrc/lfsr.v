module lfsr (
    input clk,
    input rst,
    output reg [7:0] lfsr_state
);

    wire feedback = lfsr_state[4] ^ lfsr_state[3] ^ lfsr_state[2] ^ lfsr_state[0];
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            lfsr_state <= {8'b1111_1111};
        end 
        else begin
            if(lfsr_state == {8'b0000_0000}) begin
                lfsr_state <= 8'b1000_0000;
            end
            else begin
                lfsr_state <= {feedback, lfsr_state[7:1]};
            end
        end        
    end
endmodule
