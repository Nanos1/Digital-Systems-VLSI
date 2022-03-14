library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_filter_tb is
end fir_filter_tb;

architecture bench of fir_filter_tb is
    
    component fir_filter is 
    port (
        clk: in std_logic;
        rst: in std_logic;
        valid_in: in std_logic;
        x: in std_logic_vector(7 downto 0);
        y: out std_logic_vector(15 downto 0);
        L: out std_logic_vector(4 downto 0);
        valid_out: out std_logic
    );
    end component;
    
    signal clk: std_logic;
    signal rst: std_logic;
    signal valid_in: std_logic;
    signal valid_out: std_logic;
    signal x: std_logic_vector (7 downto 0);
    signal L: std_logic_vector (4 downto 0);
    signal y: std_logic_vector (15 downto 0);
    
    constant CLOCK_PERIOD : time := 5 ns;

    type input_type is array(19 downto 0) of integer;
    signal input_sig: input_type := (90, 212, 149, 140, 234, 73, 193, 192, 97, 145, 19, 13, 135, 199, 239, 33, 145, 120, 3, 86);


begin
    
    filter: fir_filter
    port map (
         clk => clk,
         rst => rst,
         valid_in => valid_in,
         x => x,
         y => y,
         L => L,
         valid_out => valid_out 
     );
    
    simulation : process
    begin
        rst <= '0';

        for i in 19 downto 0 loop
            valid_in <= '1';
            x <= std_logic_vector(to_unsigned(input_sig(i), 8));
            wait for CLOCK_PERIOD;
            valid_in <= '0';
            wait for 7*CLOCK_PERIOD;
        end loop;    
        
        for i in 0 to 7 loop
            valid_in <= '1';
            x <= std_logic_vector(to_unsigned(0, 8));
            wait for CLOCK_PERIOD;
            valid_in <= '0';
            wait for 7*CLOCK_PERIOD;
        end loop;     
        
                valid_in <= '1';
                x <= "00000010";
                wait for CLOCK_PERIOD;
                valid_in <= '0';
                wait for 3*CLOCK_PERIOD;
                valid_in <= '1';
                wait for CLOCK_PERIOD;        
                valid_in <= '0';
                wait for CLOCK_PERIOD;
                
                for i in 1 to 8 loop
                    valid_in <= '1';
                    x <= std_logic_vector(to_unsigned(i, 8));
                    wait for CLOCK_PERIOD;
                    valid_in <= '0';
                    wait for 7*CLOCK_PERIOD;
                end loop;
                
                wait for 7*CLOCK_PERIOD;        
                
                
--                for i in 246 to 255 loop
--                    valid_in <= '1';
--                    x <= std_logic_vector(to_unsigned(i, 8));
--                    wait for CLOCK_PERIOD;
--                    valid_in <= '0';
--                    wait for 7*CLOCK_PERIOD;
--                end loop;        
                    
--                wait for 20*CLOCK_PERIOD;  
                
--                rst <= '1';
--                wait for 5*CLOCK_PERIOD;    
--                rst <= '0';
--                wait for 11*CLOCK_PERIOD;
--                valid_in <= '1';
--                x <= std_logic_vector(to_unsigned(16, 8));
--                wait for CLOCK_PERIOD;
--                valid_in <= '0';
                
        
        
        
        
        wait;
    end process;
        
    generate_clock : process
    begin
         clk <= '0';
         wait for CLOCK_PERIOD/2;
         clk <= '1';
         wait for CLOCK_PERIOD/2;
    end process;
             
end bench;
