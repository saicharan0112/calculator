module cordic (
    clock,
    angle,
    Xin,
    Yin,
    Xout,
    Yout
);

    parameter size = 16 ;

    localparam stage = size ;

    input clock ;
    input signed [31:0] angle ;
    input signed [size-1:0] Xin ;
    input signed [size-1:0] Yin ;
    output signed [size:0] Xout ;
    output signed [size:0] Yout ;

    wire signed [31:0] atan_table [0:30] ;
    // arctan table
    // values in the table is represented in a 32 bit format
    // atan(2^0) = 45 deg = 45/360 * 2^32
    // atan(2^1) = 26.565 deg = 26.565/360 * 2^32
    assign atan_table[0] = 32'b00100000000000000000000000000000 ;
    assign atan_table[1] = 32'b00010010111001000000010100011101 ;
    assign atan_table[2] = 32'b00001001111110110011100001011011 ;
    assign atan_table[3] = 32'b00000101000100010001000111010100 ;
    assign atan_table[4] = 32'b00000010100010110000110101000011 ;
    assign atan_table[5] = 32'b00000001010001011101011111100001 ;
    assign atan_table[6] = 32'b00000000101000101111011000011110 ;
    assign atan_table[7] = 32'b00000000010100010111110001010101 ;
    assign atan_table[8] = 32'b00000000001010001011111001010011 ;
    assign atan_table[9] = 32'b00000000000101000101111100101110 ;
    assign atan_table[10] = 32'b00000000000010100010111110011000 ;
    assign atan_table[11] = 32'b00000000000001010001011111001100 ;
    assign atan_table[12] = 32'b00000000000000101000101111100110 ;
    assign atan_table[13] = 32'b00000000000000010100010111110011 ;
    assign atan_table[14] = 32'b00000000000000001010001011111001 ;
    assign atan_table[15] = 32'b00000000000000000101000101111100 ;
    assign atan_table[16] = 32'b00000000000000000010100010111110 ;
    assign atan_table[17] = 32'b00000000000000000001010001011111 ;
    assign atan_table[18] = 32'b00000000000000000000101000101111 ;
    assign atan_table[19] = 32'b00000000000000000000010100010111 ;
    assign atan_table[20] = 32'b00000000000000000000001010001011 ;
    assign atan_table[21] = 32'b00000000000000000000000101000101 ;
    assign atan_table[22] = 32'b00000000000000000000000010100010 ;
    assign atan_table[23] = 32'b00000000000000000000000001010001 ;
    assign atan_table[24] = 32'b00000000000000000000000000101000 ;
    assign atan_table[25] = 32'b00000000000000000000000000010100 ;
    assign atan_table[26] = 32'b00000000000000000000000000001010 ;
    assign atan_table[27] = 32'b00000000000000000000000000000101 ;
    assign atan_table[28] = 32'b00000000000000000000000000000010 ;
    assign atan_table[29] = 32'b00000000000000000000000000000001 ;
    assign atan_table[30] = 32'b00000000000000000000000000000000 ;


    reg signed [size:0] X [0:stage-1] ;
    reg signed [size:0] Y [0:stage-1] ;
    reg signed [31:0] Z [0:stage-1] ;



    // Stage 0 

    wire [1:0] quadrant ;

    assign quadrant = angle[31:30] ;

    always @(posedge clock) 
    begin
        case (quadrant)
            2'b00,
            2'b11:
            begin
                X[0] <= Xin ;
                Y[0] <= Yin ;
                Z[0] <= angle ;
            end 

            2'b01:
            begin
                X[0] <= -Yin ;
                Y[0] <= Xin ;
                Z[0] <= {2'b00,angle[29:0]};
            end

            2'b10:
            begin
                X[0] <= Yin ;
                Y[0] <= -Xin ;
                Z[0] <= {2'b11,angle[29:0]};
            end
        endcase
    end

    // Stages 1 to stage - 1

    genvar i ;
    generate
        for (i = 0 ; i < (stage - 1) ; i = i + 1) 
        begin: XYZ
            wire                 Z_sign ;
            wire signed [size:0] X_shr, Y_shr ;

            assign X_shr = X[i] >>> i ;
            assign Y_shr = Y[i] >>> i ;

            assign Z_sign = Z[i][31] ; 

            always @(posedge clock) 
            begin
                X[i+1] <= Z_sign ? X[i] + Y_shr  : X[i] - Y_shr ;
                Y[i+1] <= Z_sign ? Y[i] - X_shr  : Y[i] + X_shr ;
                Z[i+1] <= Z_sign ? Z[i] + atan_table[i]  : Z[i] - atan_table[i] ;    
            end
        end
    endgenerate

    // Output

    assign Xout = X[stage - 1] ;
    assign Yout = Y[stage - 1] ;

endmodule