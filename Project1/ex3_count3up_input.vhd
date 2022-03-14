library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ex3_count3up_input is
    Port ( clk : in STD_LOGIC;
           count_en : in STD_LOGIC;
           resetn : in STD_LOGIC;
           paral_input : in STD_LOGIC_VECTOR (2 downto 0);
           cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (2 downto 0));
end ex3_count3up_input;

architecture Behavioral of ex3_count3up_input is
signal count: std_logic_vector(2 downto 0);
begin

    process(clk, resetn)
    begin
        if resetn='0' then
            -- Code for reset
            count <= (others=>'0');
        elsif clk'event and clk='1' then
            if count_en='1' then
                -- Count up when count_en = 1
                if count/=paral_input then
                -- Increase counter only when not equal to input
                count<=count+1;
                else 
                --Else zero
                count<=(others=>'0');
                end if;
            end if;
        end if;
    end process;
    -- Output signals
    sum <= count;
    cout <= '1' when count=paral_input and count_en='1' else '0';

end Behavioral;
