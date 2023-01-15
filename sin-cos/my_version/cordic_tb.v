`timescale 1 ns/100 ps

module cordic_test ;

localparam sz = 16 ;

reg [sz-1:0] Xin, Yin;
reg [31:0] angle ;
wire [sz:0] Xout, Yout ;

reg clk_100mhz ;

localparam false = 1'b0 ;
localparam true = 1'b1 ;

localparam value = 32000 / 1.647;

reg signed [63:0] i ;
reg start ;

initial 
begin
    $dumpfile("cordic.vcd");
    $dumpvars(0,cordic_test);
    start = false ;
    clk_100mhz = 1'b0 ;
    angle = 0 ;
    Xin = value ;
    Yin = 1'd0 ;

    #1000;
    @(posedge clk_100mhz) ;
    start = true ;

    for (i = 0; i < 360; i = i+1) 
    begin
        @(posedge clk_100mhz) ;
        start = false ;
        angle = ((i << 32)*i)/360 ;    
    end

    #500
    $finish ;
    $stop ;
end

cordic sin_cos (clk_100mhz, angle, Xin, Yin, Xout, Yout) ;

parameter clk_100_speed = 10 ;

initial 
begin
    clk_100mhz = 1'b0 ; 
    #5 ;
    forever begin
        #(clk_100_speed/2) clk_100mhz = 1'b1 ;
        #(clk_100_speed/2) clk_100mhz = 1'b0 ;
    end    
end

endmodule