library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg is
    port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           shft : in STD_LOGIC;
           si : in STD_LOGIC;
           en : in STD_LOGIC;
           pl : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (3 downto 0);
           so : out STD_LOGIC);
end shift_reg;

architecture behavioral of shift_reg is
    signal dff: std_logic_vector(3 downto 0);
begin
    edge: process (clk,rst)
    begin
        if rst='0' then
            dff<=(others=>'0');
        elsif clk'event and clk='1' then
            if pl='1' then
                dff<=din;
            elsif pl='0' and en='1' then
                case shft is
                    when '1' =>
                        dff<=si&dff(3 downto 1);
                    when '0' =>
                        dff<=dff(2 downto 0)&si;
                    when others =>
                        dff<=(others=>'-');
                end case;
            end if;
        end if;
    end process;
    -- Output signals
    so <= dff(0) when (rst='0' or pl='1' or shft='1') else dff(3);

end Behavioral;