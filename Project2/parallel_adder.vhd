library ieee;
use ieee.std_logic_1164.all;

entity parallel_adder is port(
    cin: in std_logic;
    a: in std_logic_vector(3 downto 0);
    b: in std_logic_vector(3 downto 0);
    s: out std_logic_vector(3 downto 0);
    cout: out std_logic
);
end parallel_adder;

architecture structural of parallel_adder is

    component full_adder is port(
        bits: in std_logic_vector(1 downto 0);
        cin: in std_logic;
        s: out std_logic;
        cout: out std_logic
    );
    end component;
    
    signal fa1_s: std_logic;
    signal fa1_cout: std_logic;
    signal fa2_s: std_logic;
    signal fa2_cout: std_logic;
    signal fa3_s: std_logic;
    signal fa3_cout: std_logic;
    signal fa4_s: std_logic;
    
begin
    
    fa1: full_adder port map(
        cin => cin,
        bits(0) => a(0),
        bits(1) => b(0),
        s => fa1_s,
        cout => fa1_cout
    );
    
    fa2: full_adder port map(
        cin => fa1_cout,
        bits(0) => a(1),
        bits(1) => b(1),
        s => fa2_s,
        cout => fa2_cout
    );
            
    fa3: full_adder port map(
        cin => fa2_cout,
        bits(0) => a(2),
        bits(1) => b(2),
        s => fa3_s,
        cout => fa3_cout
    );
                    
    fa4: full_adder port map(
        cin => fa3_cout,
        bits(0) => a(3),
        bits(1) => b(3),
        s => fa4_s,
        cout => cout
    );
    
    s <= fa4_s&fa3_s&fa2_s&fa1_s;

end structural;