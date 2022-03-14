library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity game_tb is
end entity;

architecture bench of game_tb is

  component game is
    port (
        p1: in std_logic;
        p2: in std_logic;
        p: in std_logic;
        r: in std_logic;
        s: in std_logic;
        clk125Mhz: in std_logic;
        leds: out std_logic_vector(3 downto 0)
    );
  end component;

  component freq_divider is
    port(  clk: in std_logic;      -- clock of input frequency (100 MHz)
           rst: in std_logic;      -- negative reset
--           max_count: in std_logic_vector;
           clk_out: out std_logic  -- clock of output (desired) frequency (25 MHz)
        );
    end component;
    
  signal p1: std_logic;
  signal p2 : std_logic;
  signal p: std_logic;
  signal r: std_logic;
  signal s: std_logic;
  signal clk125Mhz: std_logic;
  signal leds: std_logic_vector(3 downto 0);
    
  constant CLOCK_PERIOD : time := 40 ns;
  constant game_CLOCK_PERIOD : time := 160 ns;

begin

   gamer : game
    port map (
              p1 => p1,
              p2 => p2,
              p => p,
              r => r,
              s => s,
              clk125Mhz => clk125Mhz,
              leds => leds
             );
             
  
  stimulus : process
  begin
  
  r <= '0';
  p <= '0';
  p1 <= '0';
  p2 <= '0';
  
  s <= '0';
  wait for 5*game_CLOCK_PERIOD/2;
  
  s <= '1';
  wait for 5*game_CLOCK_PERIOD/2;
  r <= '1';
  wait for 3*game_CLOCK_PERIOD/4;
  p1 <= '1';
  wait for game_CLOCK_PERIOD;
  p1 <= '0'; 
  wait for 5*game_CLOCK_PERIOD/4;
  p2 <= '1';
  wait for 2*game_CLOCK_PERIOD;
  p2 <= '0';  
  p1 <= '1';
  wait for game_CLOCK_PERIOD;
  p1 <= '0'; 
  wait for game_CLOCK_PERIOD;
  p2 <= '1';
  wait for 2*game_CLOCK_PERIOD;
  p2 <= '0';  
  p1 <= '1';
  wait for game_CLOCK_PERIOD;
  p1 <= '0'; 
  wait for game_CLOCK_PERIOD;
  p2 <= '1';
  wait for 2*game_CLOCK_PERIOD;
  p2 <= '0';  
  p <= '1';
  wait for 2*game_CLOCK_PERIOD;
  p <= '0';
  wait for game_CLOCK_PERIOD;
  r <= '0';
  wait for game_CLOCK_PERIOD;
  s <= '0';
  
  wait for 100*CLOCK_PERIOD/3;
  wait;
  end process;
  
  generate_clock : process
   begin
     clk125Mhz <= '0';
     wait for CLOCK_PERIOD/2;
     clk125Mhz <= '1';
     wait for CLOCK_PERIOD/2;
   end process;
  
end architecture;
