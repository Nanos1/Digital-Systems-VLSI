library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_parallel_adder_tb is
end bcd_parallel_adder_tb;

architecture bench of bcd_parallel_adder_tb is

    component bcd_parallel_adder is port (
        cin: in std_logic;
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(15 downto 0);
        s: out std_logic_vector(15 downto 0);
        cout: out std_logic
    );
    end component;
    
    signal cin: std_logic := '0';
    signal a: std_logic_vector(15 downto 0) := (others => '0');
    signal b: std_logic_vector(15 downto 0) := (others => '0');
    signal s: std_logic_vector(15 downto 0);
    signal cout: std_logic;
    
    constant CLOCK_PERIOD: time := 10 ns;
    
begin
    
    test: bcd_parallel_adder port map (
        cin => cin,
        a => a,
        b => b,
        s  => s,
        cout  => cout
    );
         
    stimulus: process
    begin
        a <= "0000"&"0000"&"0000"&"0000";
        b <= "0000"&"0000"&"0000"&"0000";
        cin <= '0';
        wait for CLOCK_PERIOD;   
        cin <= '1';      
        wait for CLOCK_PERIOD;
        
        a <= "0000"&"0000"&"0000"&"1000";
        b <= "0000"&"0000"&"0000"&"0010";
        cin <= '0';
        wait for CLOCK_PERIOD;   
        cin <= '1';      
        wait for CLOCK_PERIOD;
        
        a <= "0000"&"0000"&"0000"&"0000";
        b <= "1001"&"1001"&"1001"&"1001";
        cin <= '0';
        wait for CLOCK_PERIOD;   
        cin <= '1';      
        wait for CLOCK_PERIOD;        
        
        a <= (others => '0');
        b <= (others => '0');
        cin <= '0';
        wait;
    end process;

end bench;