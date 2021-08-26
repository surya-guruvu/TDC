module tb_Vernier6;
 reg start,stop,reset;
 wire [5:0] A;
 wire start2,stop2,start1,stop1,s000,s111,s222,s333,c000,c111,c222,c333;
 Vernier6bit V(.s000(s000),.s111(s111),.s222(s222),.s333(s333),.c000(c000),.c111(c111),.c222(c222),.c333(c333),.start1(start1),.stop1(stop1),.start2(start2),.stop2(stop2),.A(A),.start(start), .stop(stop), .reset(reset));
 initial begin
    $dumpfile("Vernier6bit.vcd");
    $dumpvars(0, tb_Vernier6);
    $monitor($time," A=%b", A);
    start=0;stop=0;reset=1'b1;
    #1 reset=1'b0;
    #50 start=~start;
    #61 stop= ~stop;
    #200 $finish;
 end



endmodule