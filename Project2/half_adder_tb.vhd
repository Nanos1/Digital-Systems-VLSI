library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder_tb is
end half_adder_tb;

architecture bench of half_adder_tb is
    
    component half_adder is port (
        bits: in std_logic_vector(1 downto 0);
        s: out std_logic;
        c: out std_logic
    );
    end component;
    
    signal bits: std_logic_vector(1 downto 0) := "00";
    signal s: std_logic;
    signal c: std_logic;
    
    constant CLOCK_PERIOD: time := 10 ns;

begin
    
    test: half_adder port map (
        bits  => bits,
        s  => s,
        c  => c
    );
             
    stimulus: process
    begin
        for i in 0 to 3 loop
            bits <= std_logic_vector(to_unsigned(i, 2));
            wait for CLOCK_PERIOD;
        end loop;
        bits <= (others => '0');
        wait;
    end process;
    
end bench;