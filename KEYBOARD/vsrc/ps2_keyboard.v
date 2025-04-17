module ps2_keyboard(
    input clk,clrn,ps2_clk,ps2_data,
    input nextdata_n,
    output [7:0] data,
    output reg ready,
    output reg overflow,     // fifo overflow
    output reg is_valid_frame,  
    output reg is_break_code,
    output reg negedge_of_ps2

);
    // internal signal, for test
    reg [9:0] buffer;        // ps2_data bits
    reg [7:0] fifo[7:0];     // data fifo
    reg [2:0] w_ptr,r_ptr;   // fifo write and read pointers
    reg [3:0] count;  // count ps2_data bits

    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;

    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0], ps2_clk};  // syn
    end

    assign negedge_of_ps2 = (ps2_clk_sync[2:1] == 2'b10);
    wire sampling = negedge_of_ps2;
    
    integer i;

    always @(posedge clk) begin
        if (clrn == 0) begin // reset
            count <= 0; w_ptr <= 0; r_ptr <= 0; overflow <= 0; ready<= 0;
            is_valid_frame <=0; is_break_code<=0;
            for(i = 0; i < 8; i = i+1) fifo[i] <= 8'h0;   // initial fifo to zero

        end
        else begin
            //  there is available data to request,  setr ready to 1.
            //  other module request data, set nextdata_n to 1.
            if (ready && !nextdata_n) begin // if ready and needed
                    r_ptr <= (r_ptr + 3'b1) & 3'b111; // read ptr move on, mod it
                    overflow <= 1'b0;
                    if(w_ptr==((r_ptr + 1'b1) & 3'b111)) //empty
                        ready <= 1'b0;
               
            end
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])   &&  // odd  parity
                    !overflow)begin     
                    fifo[w_ptr] <= buffer[8:1];  // kbd scan code
                    w_ptr <= (w_ptr + 3'b1) & 3'b111; // mod
                    ready <= 1'b1;
                    is_valid_frame <= 1;
                    is_break_code <= (buffer[8:1] == 8'hF0);
                    overflow <= overflow | (r_ptr == ((w_ptr + 3'b1) & 3'b111));
                end else begin
                    is_valid_frame <= 0;    
                end
                count <= 0;     // for next frame
              end else begin
                buffer[count] <= ps2_data;  // store ps2_data in buffer
                count <= count + 3'b1;
              end
            end
        end
    end

    assign data = fifo[r_ptr]; //always set output data which r_ptr point to.

endmodule

