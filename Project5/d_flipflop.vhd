library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flipflop is
    port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end d_flipflop;

architecture behavioural of d_flipflop is

begin
    delay : process(clk, rst)
    begin
        if rst = '1' then
            output <= (others=>'0');
        elsif clk'event and clk = '1' then
            output <= input;
        end if;
    end process;
end behavioural;
