library verilog;
use verilog.vl_types.all;
entity cordic_test is
    generic(
        CLK100_SPEED    : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK100_SPEED : constant is 1;
end cordic_test;
