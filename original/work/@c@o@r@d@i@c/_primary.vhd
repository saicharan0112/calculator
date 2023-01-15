library verilog;
use verilog.vl_types.all;
entity CORDIC is
    generic(
        XY_SZ           : integer := 16
    );
    port(
        clock           : in     vl_logic;
        angle           : in     vl_logic_vector(31 downto 0);
        Xin             : in     vl_logic_vector;
        Yin             : in     vl_logic_vector;
        Xout            : out    vl_logic_vector;
        Yout            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of XY_SZ : constant is 1;
end CORDIC;
