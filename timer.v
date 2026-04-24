module timer(
    input clk,
    input rst,
    input en,
    input load,
    input [5:0] load_value,
    output [5:0] state
);

    wire [5:0] Q;  
    wire [5:0] next;

    assign next = load ? load_value : (Q == 6'd0) ? 6'd0 : Q - 6'd1 ;

    wire dff_en = load | en;
   
    dff FFD0 (
        .d(next[0]), 
        .clk(clk), 
        .rst(rst), 
        .enable(dff_en), 
        .q(Q[0]))
    ;
    dff FFD1 (
        .d(next[1]), 
        .clk(clk), 
        .rst(rst), 
        .enable(dff_en), 
        .q(Q[1]))
    ;
    dff FFD2 (
        .d(next[2]), 
        .clk(clk), 
        .rst(rst), 
        .enable(dff_en), 
        .q(Q[2]))
    ;
    dff FFD3 (
        .d(next[3]), 
        .clk(clk), 
        .rst(rst), 
        .enable(dff_en), 
        .q(Q[3]))
    ;
    dff FFD4 (
        .d(next[4]), 
        .clk(clk),
        .rst(rst),
        .enable(dff_en),
        .q(Q[4]))
    ;
    dff FFD5 (
        .d(next[5]), 
        .clk(clk), 
        .rst(rst), 
        .enable(dff_en), 
        .q(Q[5]))
    ;

    assign state = Q;  
endmodule