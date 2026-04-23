module dff(
    input d,
    input clk,
    input rst,
    input enable,
    output reg q
);
    initial begin
    q <= 0;
end
    always @(posedge clk, posedge rst) begin
    if (rst)
        q <= 0;
    else if (enable)
        q <= d;
end
endmodule