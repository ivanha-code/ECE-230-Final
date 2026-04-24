module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state
);

wire [5:0] Q;        // current state
wire [5:0] SUM;      // Q + 1 result
wire [5:0] D;        // next state input
wire [4:0] C;        // carry chain
wire wrap;

// -----------------------------
// 1. ADDER: Q + 1
// -----------------------------
full_adder FA0(.A(Q[0]), .B(1'b1), .Cin(1'b0), .Y(SUM[0]), .Cout(C[0]));
full_adder FA1(.A(Q[1]), .B(1'b0), .Cin(C[0]), .Y(SUM[1]), .Cout(C[1]));
full_adder FA2(.A(Q[2]), .B(1'b0), .Cin(C[1]), .Y(SUM[2]), .Cout(C[2]));
full_adder FA3(.A(Q[3]), .B(1'b0), .Cin(C[2]), .Y(SUM[3]), .Cout(C[3]));
full_adder FA4(.A(Q[4]), .B(1'b0), .Cin(C[3]), .Y(SUM[4]), .Cout(C[4]));
full_adder FA5(.A(Q[5]), .B(1'b0), .Cin(C[4]), .Y(SUM[5]), .Cout());

// -----------------------------
// 2. DETECT 59 (111011)
// -----------------------------
assign wrap = (Q == 6'd59);

// -----------------------------
// 3. NEXT STATE LOGIC
// -----------------------------
// If wrap → go to 0
// else → SUM (Q+1)
wire [5:0] next_count = wrap ? 6'd0 : SUM;

// Enable control (pause or run)
assign D = en ? next_count : Q;

// -----------------------------
// 4. FLIP FLOPS
// -----------------------------
dff d0(.clk(clk), .rst(rst), .enable(1'b1), .d(D[0]), .q(Q[0]));
dff d1(.clk(clk), .rst(rst), .enable(1'b1), .d(D[1]), .q(Q[1]));
dff d2(.clk(clk), .rst(rst), .enable(1'b1), .d(D[2]), .q(Q[2]));
dff d3(.clk(clk), .rst(rst), .enable(1'b1), .d(D[3]), .q(Q[3]));
dff d4(.clk(clk), .rst(rst), .enable(1'b1), .d(D[4]), .q(Q[4]));
dff d5(.clk(clk), .rst(rst), .enable(1'b1), .d(D[5]), .q(Q[5]));

// -----------------------------
// 5. OUTPUT
// -----------------------------
assign state = Q;

endmodule