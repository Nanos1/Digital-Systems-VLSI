library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_half_adder_tb is
end bcd_half_adder_tb;

architecture bench of bcd_half_adder_tb is

    component bcd_half_adder is port (
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
    end component;
    
    signal a: std_logic_vector(3 downto 0) := "0000";
    signal b: std_logic_vector(3 downto 0) := "0000";
    signal s: std_logic_vector(3 downto 0);
    signal cout: std_logic;
    
    constant CLOCK_PERIOD: time := 10 ns;
    
begin
    
    test: bcd_half_adder port map (
        a => a,
        b => b,
        s  => s,
        cout  => cout
    );
             
    stimulus: process
    begin
        for i in 0 to 9 loop
            a <= std_logic_vector(to_unsigned(i, 4));
            for j in 0 to 9 loop
                b <= std_logic_vector(to_unsigned(j, 4));
                wait for CLOCK_PERIOD;
            end loop;
        end loop;
        a <= (others => '0');
        b <= (others => '0');
        wait;
    end process;

end bench;