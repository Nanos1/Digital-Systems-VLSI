library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_tb is
end full_adder_tb;

architecture bench of full_adder_tb is

    component full_adder is port (
        bits: in std_logic_vector(1 downto 0);
        cin: in std_logic;
        s: out std_logic;
        cout: out std_logic
    );
    end component;
    
    signal bits: std_logic_vector(1 downto 0) := "00";
    signal cin: std_logic := '0';
    signal s: std_logic;
    signal cout: std_logic;
    
    constant CLOCK_PERIOD: time := 10 ns;
    
begin
    
    test: full_adder port map (
        bits  => bits,
        cin => cin,
        s  => s,
        cout  => cout
    );
             
    stimulus: process
    begin
        for i in 0 to 3 loop
            bits <= std_logic_vector(to_unsigned(i, 2));
            cin <= '0';
            wait for CLOCK_PERIOD;
            cin <= '1';
            wait for CLOCK_PERIOD;
        end loop;
        bits <= (others => '0');
        cin <= '0';
        wait;
    end process;

end bench;