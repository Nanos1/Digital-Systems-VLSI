library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ex3_count3updown_tb is
end entity;

architecture bench of ex3_count3updown_tb is
 
    component ex3_count3updown is
        port ( clk : in STD_LOGIC;
               count_en : in STD_LOGIC;
               resetn : in STD_LOGIC;
               direction : in STD_LOGIC;
               cout : out STD_LOGIC;
               sum : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal count_en : STD_LOGIC := '0';
    signal resetn : STD_LOGIC := '0';
    signal direction : STD_LOGIC := '0';
    signal cout : STD_LOGIC;
    signal sum : STD_LOGIC_VECTOR (2 downto 0); 
    
    constant CLOCK_PERIOD : time := 10 ns;   
            
begin

    test : ex3_count3updown
        port map ( clk => clk,
                   count_en => count_en, 
                   resetn => resetn,
                   direction => direction,
                   cout => cout,
                   sum => sum
                   );
                   
     stimulus : process
     begin
        --Test reset=0
        count_en <= '1';
        resetn <= '0';
        clk <='1';
        direction <='1';
        for i in 0 to 9 loop
          clk <= not clk;
          wait for CLOCK_PERIOD;
        end loop;
        
        resetn <= '1';
        --Test count up
        for i in 0 to 19 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        
        count_en <= '0';
        --Test inactive count
        for i in 0 to 9 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;
        
        --Test count down
        direction <='0';
        count_en <= '1';
        
        for i in 0 to 23 loop
           clk <= not clk;
           wait for CLOCK_PERIOD;
        end loop;     
        
        direction <='1';  
        
        for i in 0 to 9 loop
             clk <= not clk;
             wait for CLOCK_PERIOD;
        end loop;       
                
        wait;
     end process;
  
end bench;
