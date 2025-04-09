module mux41 (
    input [1:0] X0, X1, X2, X3, // 输入
    input [1:0] Y, // 控制端
    output [1:0] F
);

MuxKeyWithDefault #(
    .NR_KEY(4), 
    .KEY_LEN(2),
    .DATA_LEN(2)
)i0(
    .out(F),
    .key(Y),
    .default_out(2'b00),
    .lut({
        2'b00, X0,  // key = 00, output x0
        2'b01, X1,
        2'b10, X2,
        2'b11, X3
    })

);


endmodule

