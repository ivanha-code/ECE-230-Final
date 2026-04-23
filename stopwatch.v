//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output out,
    output [5:0] state     //6-bits to represent the highest number 59
);

   
    wire Q3, Q4, Q5;
    wire Q0, Q1, Q2;
    wire Cout0, Cout1, Cout2, Cout3, Cout4;
    wire D0,D1,D2;
    wire comp, temp_rst;
    
    assign comp = Q5 & Q4 & Q3 & ~Q2 & Q1 & Q0;
    assign temp_rst = rst | comp;
    
    assign state = {Q2,Q1,Q0,Q3,Q4,Q5}; 

  full_adder FA0(
      .A(Q0),
      .B(1'b1),
      .Cin(1'b0),
      .Y(D0),
      .Cout(Cout0)  
  );
  
  full_adder FA1(
      .A(Q1),
      .B(1'b0),
      .Cin(Cout0),
      .Y(D1), 
      .Cout(Cout1)
  );
  
  full_adder FA2(
      .A(Q2),
      .B(1'b0),
      .Cin(Cout1),
      .Y(D2), 
      .Cout(Cout2)
  );
    full_adder FA3(
      .A(Q3),
      .B(1'b1),
      .Cin(Cout2),
      .Y(D0),
      .Cout(Cout3)  
  );
  
  full_adder FA4(
      .A(Q4),
      .B(1'b0),
      .Cin(Cout3),
      .Y(D1), 
      .Cout(Cout4)
  );
  
  full_adder FA5(
      .A(Q5),
      .B(1'b0),
      .Cin(Cout4),
      .Y(D2), 
      .Cout()
  );
    
   dff FFD0(
    .clk(clk),
    .rst(temp_rst),
    .D(D0),
    .Q(Q0)
    
  );
  
  dff FFD1(
       .clk(clk),
        .rst(temp_rst),
        .D(D1),
        .Q(Q1)
  );

   dff FFD2(
      .clk(clk),
        .rst(temp_rst),
        .D(D2),
        .Q(Q2)
     ); 
     
   dff FFD3(
    .clk(clk),
    .rst(temp_rst),
    .D(D3),
    .Q(Q3)
    
  );
  
  dff FFD4(
       .clk(clk),
       .rst(temp_rst),
       .D(D4),
       .Q(Q4)
  );

   dff FFD5(
      .clk(clk),
      .rst(temp_rst),
      .D(D5),
      .Q(Q5)
     ); 
     
     
  dff outp(
      .clk(clk),
      .rst(rst),
      .D(comp ^ out),
        .Q(out)
     ); 
   
endmodule
   




