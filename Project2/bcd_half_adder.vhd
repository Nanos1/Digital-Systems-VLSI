library ieee;
use ieee.std_logic_1164.all;

entity bcd_half_adder is port(
    a: in std_logic_vector(3 downto 0);
    b: in std_logic_vector(3 downto 0);
    s: out std_logic_vector(3 downto 0);
    cout: out std_logic
);
end bcd_half_adder;

architecture structural of bcd_half_adder is

    component parallel_adder is port(
        cin: in std_logic;
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
    end component;

    signal pa1_s: std_logic_vector(3 downto 0);
    signal pa1_cout: std_logic;
    signal pa2_a: std_logic_vector(3 downto 0);
    signal cout_buf: std_logic;
    
begin

    pa1: parallel_adder port map(
        cin => '0',
        a => a,
        b => b,
        s => pa1_s,
        cout => pa1_cout
    );
    
    cout_buf <= pa1_cout or (pa1_s(3) and pa1_s(2)) or (pa1_s(3) and pa1_s(1));
    pa2_a <= '0'&cout_buf&cout_buf&'0';
    
    pa2: parallel_adder port map(
        cin => '0',
        a => pa2_a,
        b => pa1_s,
        s => s
    );
    
    cout <= cout_buf;

end structural;