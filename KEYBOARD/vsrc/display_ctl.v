module display_ctl(
    input clk, clrn,
    input [6:0] count,         
    input key_released,
    input negedge_of_ps2,       
    input [7:0] scan_code,     
    input [7:0] ascii_code,    
    output reg [7:0] seg0,     // 数码管0（LSB）
    output reg [7:0] seg1,    
    output reg [7:0] seg2,   
    output reg [7:0] seg3,     
    output reg [7:0] seg4,     
    output reg [7:0] seg5   
 
);

    localparam [7:0] SEG_TABLE [0:15] = '{
        // 0~9
        8'b0000_0011, 8'b1001_1111, 8'b0010_0101, 8'b0000_1101,
        8'b1001_1001, 8'b0100_1001, 8'b0100_0001, 8'b0001_1111,
        8'b0000_0001, 8'b0000_1001, 
        // A~F
        8'b0001_0001, 8'b1100_0001,8'b0110_0011, 8'b1000_0101, 
        8'b0110_0001, 8'b0111_0001
    };

    wire [3:0] tens, units;
    wire [6:0] div_result = count / 7'd10;  // intermediate variable, used only for tens [3:0]
    assign tens = div_result[3:0]; 
    wire [6:0] mod_result = count % 7'd10 ;  // intermediate variable, used only for units [3:0]
    assign units = mod_result[3:0]; 
  

   


    always @(posedge clk) begin

        if(!clrn)
             {seg0, seg1, seg2, seg3, seg4, seg5} <= {8'b1111_1111, 8'b1111_1111, 
                                                      8'b1111_1111, 8'b1111_1111,
                                                      8'b1111_1111, 8'b1111_1111};
        else begin 
            if(negedge_of_ps2)begin
                if(key_released) begin
                // off 
                {seg0, seg1, seg2, seg3} <= {8'b1111_1111, 8'b1111_1111, 
                                            8'b1111_1111, 8'b1111_1111};
                end else begin
                seg0 <= SEG_TABLE[scan_code[3:0]];  
                seg1 <= SEG_TABLE[scan_code[7:4]];  
                seg2 <= SEG_TABLE[ascii_code[3:0]]; 
                seg3 <= SEG_TABLE[ascii_code[7:4]];  
                end  
                // always show  
            end     
                seg4 <= SEG_TABLE[units];   
                seg5 <= SEG_TABLE[tens];                               
        end  
    end
endmodule
