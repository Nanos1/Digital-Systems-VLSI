library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;

entity CU is
    Port ( clk      : in  STD_LOGIC;
	       rst      : in  STD_LOGIC;                    				--- operation enable
           mac_init : out STD_LOGIC;			-- memory address
           ram_addr : out  STD_LOGIC_VECTOR (2 downto 0);	-- output data
           rom_addr : out STD_LOGIC_VECTOR (2 downto 0));
end CU;

architecture Behavioral of CU is
signal count : integer range 0 to 8 := 0;
--signal macalt : std_logic := '0';
begin
    process (clk)
    begin
        if (rst = '1') then
            count <= 7;
            rom_addr <= "000";
            ram_addr <= "000";
        elsif (clk'event and clk = '1') then
            if (count = 7) then 
                --rom_addr <= std_logic_vector(to_unsigned(count,3));
                --ram_addr <= std_logic_vector(to_unsigned(count,3));
                mac_init <= '1';
                rom_addr <= std_logic_vector(to_unsigned(count,3));
                ram_addr <= std_logic_vector(to_unsigned(count,3));
                count <= 0;
            else 
                --if (count = ) then count <= 8 ; end if;
                mac_init <= '0';
                count <= count +1;
                rom_addr <= std_logic_vector(to_unsigned(count,3));
                ram_addr <= std_logic_vector(to_unsigned(count,3));
                --if (count = 8) then count <=0; end if;
            end if;
        end if;
    end process;			
end Behavioral;
