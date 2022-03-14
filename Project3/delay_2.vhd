library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay_2 is
    port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
       );
end delay_2;

architecture structural of delay_2 is

    component d_flipflop is
        port(
          d : in  std_logic;
          q : out  std_logic;
          clk : in std_logic;
          rst : in std_logic
         );
        end component;

signal buffer_bit : std_logic;

  begin
    delay1 : d_flipflop 
    port map (
        d => d,
        q => buffer_bit,
        clk => clk,
        rst => rst
    );

    delay2 : d_flipflop 
    port map (
        d => buffer_bit,
        q => q,
        clk => clk,
        rst => rst
    );
    
    end architecture;