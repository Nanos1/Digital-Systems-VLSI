library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity full_adder is port(
    a: in std_logic;
    b: in std_logic;
    cin: in std_logic;
    s: out std_logic := '0';
    cout: out std_logic := '0';
    rst : in std_logic;
    clk : in std_logic
);
end full_adder;

architecture behavioural of full_adder is    

signal internal_reg : std_logic_vector(1 downto 0) := (others => '0');
begin

    -- Simple full adder that produces output on clock edge --
    process(clk, rst)
    begin
        if rst = '0' then
            internal_reg <= "00";
        elsif rising_edge(clk) then
            internal_reg <= ('0' & a) + ('0' & b) + ('0' & cin);
        end if;
    end process;
    s <= internal_reg(0);
    cout <= internal_reg(1);
end behavioural;