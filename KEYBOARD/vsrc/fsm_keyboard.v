module fsm_keyboard(
    input clk, clrn, negedge_of_ps2,
    input is_valid_frame, is_break_code,
    output reg press_pulse,
    output reg key_released
);

reg [1:0] state;


localparam
    IDLE         = 2'b00,
    PRESS        = 2'b01,
    HOLD         = 2'b10,
    BREAK_PREFIX = 2'b11;

always @(posedge clk) begin
    if (!clrn) begin
        state <= IDLE;
    end else if (is_valid_frame && negedge_of_ps2) begin
       
        case (state)
            IDLE:
                state <= (!is_break_code) ? PRESS : IDLE;
            PRESS:
                state <= (is_break_code) ? BREAK_PREFIX : HOLD;
            HOLD:
                state <= (is_break_code) ? BREAK_PREFIX : HOLD;
            BREAK_PREFIX:
                state <= IDLE;
            default:
                state <= IDLE;
        endcase
    end
end

// press_pulse: 从 IDLE 进入 PRESS 时产生单周期脉冲
assign press_pulse = (state == PRESS) &&  is_valid_frame ;

// key_released: 从 BREAK_PREFIX 返回 IDLE 时产生单周期脉冲
assign key_released = (state == IDLE) &&  is_valid_frame ;

endmodule
