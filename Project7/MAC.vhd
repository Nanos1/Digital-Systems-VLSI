library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;

entity MAC is
    Port ( clk      : in  STD_LOGIC;
	       mac_init : in  STD_LOGIC;				--- operation enable
           rom_out : in  STD_LOGIC_VECTOR (7 downto 0);			-- memory address
           ram_out : in  STD_LOGIC_VECTOR (7 downto 0);	-- output data
           --sum     : out std_logic_vector (19 downto 0);
           y       : out STD_LOGIC_VECTOR (19 downto 0));
end MAC;

architecture Behavioral of MAC is
signal sum_cur :  STD_LOGIC_VECTOR (19 downto 0) := (others => '0');
begin
    process (clk)
    begin
        if (clk'event and clk='1') then
            if (mac_init = '1') then 
                y <= sum_cur;
                sum_cur <= std_logic_vector(to_unsigned(conv_integer(ram_out)*conv_integer(rom_out),20));  
            else
                sum_cur <= std_logic_vector(to_unsigned(conv_integer(sum_cur)+conv_integer(ram_out)*conv_integer(rom_out),20));
            end if;                   
       end if;
    end process;			
   -- sum <= sum_cur;

end Behavioral;
