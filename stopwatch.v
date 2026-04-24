module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state
);

    wire [5:0] Q;      
    wire [5:0] next;
// This code make the clock cycle increment by 1, then it goes back to 0 after reaching bit 59.
    assign next = (Q == 6'd59) ? 6'd0 : Q + 6'd1;

// These flipflops toggles every clock cycle when enabled, such as 2,4,6,8,16,32   
    dff FFD0 (
        .d(next[0]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[0]))
    ;
    dff FFD1 (
        .d(next[1]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[1]))
    ;
    dff FFD2 (
        .d(next[2]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[2]))
    ;
    dff FFD3 (
        .d(next[3]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[3]))
    ;
    dff FFD4 (
        .d(next[4]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[4]))
    ;
    dff FFD5 (
        .d(next[5]), 
        .clk(clk), 
        .rst(rst), 
        .enable(en), 
        .q(Q[5]))
    ;

    assign state = Q;  

endmodule