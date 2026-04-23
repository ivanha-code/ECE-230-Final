module timer(
    input clk,               // 1Hz clock from the clock divider
    input rst,               // Asynchronous reset from btnC
    input en,                // Run/Pause control from sw[1]
    input load,              // Load control from sw[2]
    input [5:0] load_value,  // 6-bit starting value from sw[15:10]
    output [5:0] state       // 6-bit output to LEDs and 7-segment display
);

// Internal wire declarations to connect structural components
wire [5:0] Q;           // Current state stored in the Flip-Flops
wire [5:0] D_sub;       // Result of the subtraction logic (Q - 1)
wire [5:0] D_final;     // Result after deciding between 'Load' or 'Decrement'
wire [4:0] C;           // Carry wires to chain the Full Adders together
wire is_zero;           // Status wire: High if the timer has reached 0
wire update_en;         // Master enable: Logic to decide if DFFs should change

assign is_zero = (Q == 6'b000000);

full_adder FA0(
    .A(Q[0]), 
    .B(1'b1), 
    .Cin(1'b0), 
    .Y(D_sub[0]), 
    .Cout(C[0])); 
full_adder FA1(
    .A(Q[1]), 
    .B(1'b1), 
    .Cin(C[0]), 
    .Y(D_sub[1]), 
    .Cout(C[1])); 
full_adder FA2(
    .A(Q[2]), 
    .B(1'b1), 
    .Cin(C[1]), 
    .Y(D_sub[2]), 
    .Cout(C[2]));
full_adder FA3(
    .A(Q[3]), 
    .B(1'b1), 
    .Cin(C[2]), 
    .Y(D_sub[3]), 
    .Cout(C[3]));
full_adder FA4(
    .A(Q[4]), 
    .B(1'b1), 
    .Cin(C[3]), 
    .Y(D_sub[4]), 
    .Cout(C[4]));
full_adder FA5(
    .A(Q[5]), 
    .B(1'b1), 
    .Cin(C[4]), 
    .Y(D_sub[5]), 
    .Cout());
// If 'load' is high, the D-input of the flip-flops gets the value from switches.
// If 'load' is low, the D-input gets the subtracted value (Q - 1).
assign D_final = (load) ? load_value : D_sub;

// 4. ENABLE CONTROL LOGIC
// We only want the Flip-Flops to update state if:
// A) The user is trying to 'load' a new value, OR
// B) 'en' is high AND the timer hasn't hit zero yet.
assign update_en = load | (en & ~is_zero);

dff t0 (
    .clk(clk), 
    .rst(rst), 
    .enable(update_en), 
    .d(D_final[0]), 
    .q(Q[0]));
dff t1 (
    .clk(clk), 
    .rst(rst),
    .enable(update_en), 
    .d(D_final[1]), 
    .q(Q[1]));
dff t2 (
    .clk(clk), 
    .rst(rst), 
    .enable(update_en), 
    .d(D_final[2]), 
    .q(Q[2]));
dff t3 (
    .clk(clk), 
    .rst(rst), 
    .enable(update_en), 
    .d(D_final[3]), .q(Q[3]));
dff t4 (
    .clk(clk), 
    .rst(rst), 
    .enable(update_en), 
    .d(D_final[4]), 
    .q(Q[4]));
dff t5 (
    .clk(clk), 
    .rst(rst), 
    .enable(update_en), 
    .d(D_final[5]), 
    .q(Q[5]));


assign state = Q;

endmodule
