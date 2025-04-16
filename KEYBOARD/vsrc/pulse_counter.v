module pulse_counter(
    input clk, clrn, negedge_of_ps2,
    input signal_pulse,
    output reg [6:0] count  // at least 7 bits to support 0~99
);
   
    always @(posedge clk) begin
        if(!clrn) count <= 0;

        else if (signal_pulse && negedge_of_ps2) begin
            if (count >= 7'd99) count <= 0;  // 0~99 循环
            else count <= count + 1;
        end
            
    end
endmodule


