module tb_multistepRO;
    wire start1,stop1,z3,s1,s2,s3,c1,c2,c3;
    reg start,stop;
    wire [5:0] A;
    multistep_RO a(.A(A),.start(start),.stop(stop));
    initial begin
        $dumpfile("RO.vcd");
        $dumpvars(0, tb_multistepRO);
        $monitor($time," A=%b", A );
        start=0;stop=0;
        #60 start=~start;
        #37 stop =~stop;

        #200 $finish;
    end
endmodule