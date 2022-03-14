library ieee;
use ieee.std_logic_1164.all;

entity bcd_parallel_adder is port(
    cin: in std_logic;
    a: in std_logic_vector(15 downto 0);
    b: in std_logic_vector(15 downto 0);
    s: out std_logic_vector(15 downto 0);
    cout: out std_logic
);
end bcd_parallel_adder;

architecture structural of bcd_parallel_adder is

    component bcd_full_adder is port(
        cin: in std_logic;
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
    end component;
    
    signal bcd_fa1_s: std_logic_vector(3 downto 0);
    signal bcd_fa1_cout: std_logic;
    signal bcd_fa2_s: std_logic_vector(3 downto 0);
    signal bcd_fa2_cout: std_logic;
    signal bcd_fa3_s: std_logic_vector(3 downto 0);
    signal bcd_fa3_cout: std_logic;
    signal bcd_fa4_s: std_logic_vector(3 downto 0);
        
begin

    bcd_fa1: bcd_full_adder port map(
        cin => cin,
        a => a(3)&a(2)&a(1)&a(0),
        b => b(3)&b(2)&b(1)&b(0),
        s => bcd_fa1_s,
        cout => bcd_fa1_cout
    );
    
    bcd_fa2: bcd_full_adder port map(
        cin => bcd_fa1_cout,
        a => a(7)&a(6)&a(5)&a(4),
        b => b(7)&b(6)&b(5)&b(4),
        s => bcd_fa2_s,
        cout => bcd_fa2_cout
    );
    
    bcd_fa3: bcd_full_adder port map(
        cin => bcd_fa2_cout,
        a => a(11)&a(10)&a(9)&a(8),
        b => b(11)&b(10)&b(9)&b(8),
        s => bcd_fa3_s,
        cout => bcd_fa3_cout
    );
    
    bcd_fa4: bcd_full_adder port map(
        cin => bcd_fa3_cout,
        a => a(15)&a(14)&a(13)&a(12),
        b => b(15)&b(14)&b(13)&b(12),
        s => bcd_fa4_s,
        cout => cout
    );

    s <= bcd_fa4_s&bcd_fa3_s&bcd_fa2_s&bcd_fa1_s;
end structural;
