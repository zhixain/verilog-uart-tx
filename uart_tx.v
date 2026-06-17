module uart_tx (
    input clk,
    input rst,
    input start,
    input [7:0] data,
    output reg tx,
    output reg busy
);

parameter IDLE  = 2'd0;
parameter START = 2'd1;
parameter DATA  = 2'd2;
parameter STOP  = 2'd3;

reg [1:0] state, next_state;
reg [2:0] bit_cnt;

always @(*) begin
    case(state)
        IDLE:  next_state = start ? START : IDLE;
        START: next_state = DATA;
        DATA:  next_state = (bit_cnt == 7) ? STOP : DATA;
        STOP:  next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state   <= IDLE;
        bit_cnt <= 0;
    end else begin
        state <= next_state;
        if (state == DATA)
            bit_cnt <= bit_cnt + 1;
        else
            bit_cnt <= 0;
    end
end

always @(*) begin
    case(state)
        IDLE:  begin tx = 1; busy = 0; end
        START: begin tx = 0; busy = 1; end
        DATA:  begin tx = data[bit_cnt]; busy = 1; end
        STOP:  begin tx = 1; busy = 1; end
        default: begin tx = 1; busy = 0; end
    endcase
end

endmodule
