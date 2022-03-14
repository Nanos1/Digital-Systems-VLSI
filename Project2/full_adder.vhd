library ieee;
use ieee.std_logic_1164.all;

entity full_adder is port(
    bits: in std_logic_vector(1 downto 0);
    cin: in std_logic;
    s: out std_logic;
    cout: out std_logic
);
end full_adder;

architecture structural of full_adder is
    
    component half_adder is port(
        bits: in std_logic_vector(1 downto 0);
        s: out std_logic;
        c: out std_logic
    );
    end component;
    
    signal ha1_s: std_logic;
    signal ha1_c: std_logic;
    signal ha2_bits: std_logic_vector(1 downto 0);
    signal ha2_c: std_logic;

begin

    ha1: half_adder port map(
        bits => bits,
        s => ha1_s,
        c => ha1_c
    );
    
    ha2_bits <= ha1_s&cin;
    
    ha2: half_adder port map(
        bits => ha2_bits,
        s => s,
        c => ha2_c
    );
    
    cout <= ha1_c or ha2_c;

end structural;