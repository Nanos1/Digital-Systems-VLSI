library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ex3_count3updown is
    Port ( clk : in STD_LOGIC;
           count_en : in STD_LOGIC;
           resetn : in STD_LOGIC;
           direction : in STD_LOGIC;
           cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (2 downto 0));
end ex3_count3updown;

architecture Behavioral of ex3_count3updown is
signal count: std_logic_vector(2 downto 0);
begin

    process(clk, resetn)
    begin
        if resetn='0' then
            -- Code for reset
            count <= (others=>'0');
        elsif clk'event and clk='1' then
            if count_en='1' then
                -- Count when count_en=1
                case direction is
                --0 for down, 1 for up
                    when '0'=>  count<=count-1;
                    when '1'=>  count<=count+1;
                    when others=>   count <= (others=>'0');
                end case;
            end if;
        end if;
    end process;
    -- Output signals
    sum <= count;
    cout <= '1' when count=7 and count_en='1' else '0';

end Behavioral;
