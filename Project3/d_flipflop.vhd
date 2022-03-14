library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flipflop is
  port(
       d : in  std_logic;
       q : out  std_logic := '0';
       clk : in std_logic;
       rst : in std_logic
      );
end entity;

architecture behavioural of d_flipflop is  
begin
    process(clk, rst)
    begin
        if rst = '0' then
            q <= '0';
        elsif clk' event and clk = '1' then
            q <= d;
        end if;
    end process;
end behavioural;