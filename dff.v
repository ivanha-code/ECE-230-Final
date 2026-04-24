module dff(
    input d,
    input clk,
    input rst,
    input enable,
    output reg q
);
test
initial q = 0;

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 0;
    else if (enable)
        q <= d;
    else
        q <= q;
end

endmodule
