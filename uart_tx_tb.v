module uart_tx_tb;

reg clk, rst, start;
reg [7:0] data;
wire tx, busy;

uart_tx uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data(data),
    .tx(tx),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    clk   = 0;
    rst   = 1;
    start = 0;
    data  = 8'b0;
    
    #20 rst = 0;
    
    #10 data = 8'h55;
        start = 1;
    #10 start = 0;  
  
    wait(busy == 0);
    #20;
    
    #10 data = 8'hA3;
        start = 1;
    #10 start = 0;
    
    wait(busy == 0);
    #20;
    
    $display("Simulation done!");
    $finish;
end

initial begin
    $dumpfile("uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);
end

endmodule
