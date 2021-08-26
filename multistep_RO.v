module RO(input start,output s1,s2,s3);

    nand #18 a(s1,start,s3);
    not #18 b(s2,s1);
    not #18 c(s3,s2);

endmodule
module RO1(input stop,output c1,c2,c3);

    nand #2 a(c1,stop,c3);
    not  #2 b(c2,c1);
    not  #2 c(c3,c2);
endmodule 
module RO2(input start,output s1,s2,s3);

    nand #6 a(s1,start,s3);
    not #6 b(s2,s1);
    not #6 c(s3,s2);

endmodule
module RO3(input stop,output c1,c2,c3);

    nand #3 a(c1,stop,c3);
    not  #3 b(c2,c1);
    not  #3 c(c3,c2);
endmodule 

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

module D_ff1(input wire D,clk,reset,output reg q,q_bar);

initial begin
    q=0;q_bar=0;
end

always @(negedge clk) begin

if (reset) begin
q<=1'b0;
q_bar<= 1'b1;
 
end else begin
q<=D;
q_bar<= ~D;
end
end
endmodule
module d_latch (input d,en,reset,output reg q);    //active low latch
    initial begin
        q=0;
    end
    always @ (en or reset or d)  
        if (reset)  
            q <= 0;  
        else  
            if (!en)  
                q <= d;  
endmodule 

module delay1(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #18 A;
    end
endmodule

module delay2(input A,output reg B);
    reg C;
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #36 A;
    end
endmodule

module delay3(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #54 A;
    end
endmodule

module delay4(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #6 A;
    end
endmodule

module delay5(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #12 A;
    end
endmodule

module delay6(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #3 A;
    end
endmodule

module delay7(input A,output reg B);
    initial begin
        B=1'b0;
    end
    always @(A) begin
        B<= #9 A;
    end
endmodule

module selective_delay (output reg start1,input s, A1,A0,En);
    initial begin
        start1=1'b0;
    end
    always @(s,A1,A0) begin
        if (!En) begin
            start1=0;
        end else begin
            case({A1,A0})
            {1'b0,1'b0}: begin start1<=s; end
            {1'b0,1'b1}: begin start1<= #16 s; end
            {1'b1,1'b0}: begin start1<= #32 s; end
            {1'b1,1'b1}: begin start1<= #48 s; end
            endcase
        end
    end
    
endmodule

module selective_delay1 (output reg start1,input s, A1,A0,En);
    initial begin
        start1=1'b0;
    end
    always @(s,A1,A0) begin
        if (!En) begin
            start1=0;
        end else begin
            case({A1,A0})
            {1'b0,1'b0}: begin start1<=s; end
            {1'b0,1'b1}: begin start1<= #4 s; end
            {1'b1,1'b0}: begin start1<= #8 s; end
            {1'b1,1'b1}: begin start1<= #12 s; end
            endcase
        end
    end
    
endmodule
module multistep_RO (output [5:0] A,input start, stop);
    //step-1
    RO r1(start,s1,s2a,s3);
    RO1 r2(stop,c1,c2,c3);
    assign s2= ~s2a;
    D_ff1 d1(s1,c1,1'b0,q1,qb1);
    D_ff d2(s2,c2,1'b0,q2,qb2);
    D_ff1 d3(s3,c3,1'b0,q3,qb3);
    delay1 p1(start,z1);
    delay2 p2(start,z2);
    delay3 p3(start,z3);
    d_latch l1(q1,z1,1'b0,Q1);
    d_latch l2(q2,z2,1'b0,Q2);
    d_latch l3(q3,z3,1'b0,Q3);
    delay3 p4 (stop,stop1);
    assign A[4]= (~Q1 & Q2)| ~Q3;
    assign A[5]= (~Q2);
    selective_delay k1(start1,z3,A[5],A[4],z3);

    //step-2
    RO2 r3(start1,s4,s5a,s6);
    RO1 r4(stop1,c4,c5,c6);
    assign s5= ~s5a;
    D_ff1 d4(s4,c4,1'b0,q4,qb4);
    D_ff d5(s5,c5,1'b0,q5,qb5);
    D_ff1 d6(s6,c6,1'b0,q6,qb6);
    delay4 p5(start1,z4);
    delay5 p6(start1,z5);
    delay1 p7(start1,z6);
    d_latch l4(q4,z4,1'b0,Q4);
    d_latch l5(q5,z5,1'b0,Q5);
    d_latch l6(q6,z6,1'b0,Q6);
    delay1 p8 (stop1,stop2);
    assign A[2]= (~Q4 & Q5)| ~Q6;
    assign A[3]= (~Q5);
    selective_delay1 k2(start2,z6,A[3],A[2],z6);

    //step-3
    RO3 r5(start2,s7,s8a,s9);
    RO1 r6(stop2,c7,c8,c9);
    assign s8= ~s8a;
    D_ff1 d7(s7,c7,1'b0,q7,qb7);
    D_ff d8(s8,c8,1'b0,q8,qb8);
    D_ff1 d9(s9,c9,1'b0,q9,qb9);
    delay6 p9(start2,z7);
    delay4 p10(start2,z8);
    delay7 p11(start2,z9);
    d_latch l7(q7,z7,1'b0,Q7);
    d_latch l8(q8,z8,1'b0,Q8);
    d_latch l9(q9,z9,1'b0,Q9);
    assign A[0]= (~Q7 & Q8)| ~Q9;
    assign A[1]= (~Q8);
endmodule



module dff_behavioral(d,clk,reset,q,qbar); 
input d, clk, reset; 
output reg q, qbar; 
always@(posedge clk or posedge reset) 
begin
if(reset== 1) begin
q <= 0;
qbar <= 1;
end else begin
q <= d; 
qbar <= ~d; 
end 
end
endmodule