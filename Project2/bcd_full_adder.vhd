library ieee;
use ieee.std_logic_1164.all;

entity bcd_full_adder is port(
    cin: in std_logic;
    a: in std_logic_vector(3 downto 0);
    b: in std_logic_vector(3 downto 0);
    s: out std_logic_vector(3 downto 0);
    cout: out std_logic
);
end bcd_full_adder;

architecture structural of bcd_full_adder is

    component bcd_half_adder is port(
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
    end component;

    signal bcd_ha1_a: std_logic_vector(3 downto 0);
    signal bcd_ha1_s: std_logic_vector(3 downto 0);
    signal bcd_ha1_cout: std_logic;
    signal bcd_ha2_cout: std_logic;
    
begin
    
    bcd_ha1_a <= "000"&cin;
    
    bcd_ha1: bcd_half_adder port map(
        a => bcd_ha1_a,
        b => a,
        s => bcd_ha1_s,
        cout => bcd_ha1_cout
    );
    
    bcd_ha2: bcd_half_adder port map(
        a => bcd_ha1_s,
        b => b,
        s => s,
        cout => bcd_ha2_cout
    );
    
    cout <= bcd_ha1_cout or bcd_ha2_cout;

end structural;