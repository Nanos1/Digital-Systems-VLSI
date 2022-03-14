library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control_unit is
    port (
        clk: in std_logic;
        rst: in std_logic;
        valid_in: in std_logic;
        rom_addr: out std_logic_vector(2 downto 0);
        ram_addr: out std_logic_vector(2 downto 0);
        mac_init: out std_logic := '0';
        valid_out: out std_logic
    );
end control_unit;

architecture Behavioural of control_unit is
    signal counter: std_logic_vector(2 downto 0) := (others=>'0');
    signal prev_counter: std_logic_vector(2 downto 0) := (others=>'0');

begin
    
    ovehflo: process (counter)
    begin
        if prev_counter = "000" and counter = "001" then
                valid_out <= '1';
        else
                valid_out <= '0';  
        end if;     
    end process; 
    
    edge: process(clk,rst)
    begin
        if rst='1' then
            counter <= (others=>'0');
        elsif clk'event and clk='1' then
            if valid_in='1' then
                prev_counter <= counter;
                counter <= "001";
            else
                prev_counter <= counter;
                counter <= counter+1;
            end if;
        
            case counter is
            when "000" =>
                mac_init <= '1';
            when others => 
                mac_init <= '0';
            end case;
        end if;
    end process;
    
    ram_addr <= counter;
    rom_addr <= counter;
    

end Behavioural;
