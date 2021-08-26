module D_ff(input wire D,clk,reset,output reg q,q_bar);
initial begin
    q=0;q_bar=0;
end
always @(posedge clk) begin
if (reset) begin
q<=1'b0;
q_bar<= 1'b1;
end else begin
q<=D;
q_bar<= ~D;
end
end
endmodule

module selector (input s0,s1,s2,s3,c0,c1,c2,c3,A1,A0,output reg s,c);
    initial begin
        s=0;c=0;
    end
    always @(s0,s1,s2,s3,c0,c1,c2,c3,A1,A0) begin
    case({A1,A0})
    {1'b0,1'b0}: begin s=s0;c=c0; end
    {1'b0,1'b1}: begin s=s1;c=c1; end
    {1'b1,1'b0}: begin s=s2;c=c2; end
    {1'b1,1'b1}: begin s=s3;c=c3; end
    endcase
    end
endmodule

module delay(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #1 A;
    end
endmodule
module delay1(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #17 A;
    end
endmodule
module delay4(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
         B<= #17 A;
    end
endmodule
module delay2(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        #5 B<= A;
    end
endmodule
module delay3(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        #2 B<= A;
    end
endmodule
module delay5(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        #5 B<= A;
    end
endmodule

module Vernier6bit(output s000,s111,s222,s333,c000,c111,c222,c333,start1,stop1,start2,stop2,output [5:0] A ,input start,stop,reset);
    delay1 d1(start,s1);
    delay1 d2(s1,s2);
    delay1 d3(s2,s3);
    delay  d4(stop,c1);
    delay  d5(c1,c2);
    delay  d6(c2,c3);
    D_ff df1(s1,c1,reset,q1,qb1);
    D_ff df2(s2,c2,reset,q2,qb2);
    D_ff df3(s3,c3,reset,q3,qb3);
    delay4 f1(start,s00);
    delay4 f2(s1,s11);
    delay4 f3(s2,s22);
    delay4 f4(s3,s33);
    delay4 f5(stop,c00);
    delay4 f6(c1,c11);
    delay4 f7(c2,c22);
    delay4 f8(c3,c33);
    assign A[4]= (q1 & qb2)| q3;
    assign A[5]= (q2);
    selector k1(s00,s11,s22,s33,c00,c11,c22,c33,A[5],A[4],start1,stop1);
    delay2 d7(start1,s4);
    delay2 d8(s4,s5);
    delay2 d9(s5,s6);
    delay  d10(stop1,c4);
    delay  d11(c4,c5);
    delay  d12(c5,c6);
    D_ff df4(s4,c4,reset,q4,qb4);
    D_ff df5(s5,c5,reset,q5,qb5);
    D_ff df6(s6,c6,reset,q6,qb6);
    assign A[2]= (q4 & qb5)| q6;
    assign A[3]= (q5);
    delay5 f9(start1,s000);
    delay5 f10(s4,s111);
    delay5 f11(s5,s222);
    delay5 f12(s6,s333);
    delay5 f13(stop1,c000);
    delay5 f14(c4,c111);
    delay5 f15(c5,c222);
    delay5 f16(c6,c333);
    selector k2(s000,s111,s222,s333,c000,c111,c222,c333,A[3],A[2],start2,stop2);
    delay3 d13(start2,s7);
    delay3 d14(s7,s8);
    delay3 d15(s8,s9);
    delay  d16(stop2,c7);
    delay  d17(c7,c8);
    delay  d18(c8,c9);
    D_ff df7(s7,c7,reset,q7,qb7);
    D_ff df8(s8,c8,reset,q8,qb8);
    D_ff df9(s9,c9,reset,q9,qb9);
    assign A[0]= (q7 & qb8)| q9;
    assign A[1]= (q8);
endmodule