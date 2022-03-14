library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mac is
	generic (
        coeff_width: integer := 8;      -- width of coefficients (bits)
        data_width: integer := 8        -- width of data (bits)
    );
    port ( 
        clk: in std_logic;
        mac_init: in std_logic;
        rom_out: in std_logic_vector(coeff_width-1 downto 0);
        ram_out: in std_logic_vector(data_width-1 downto 0);
        y: out std_logic_vector(15 downto 0) := (others=>'0')
    );
end mac;

architecture Behavioural of mac is

    signal y_buf: std_logic_vector(15 downto 0) := (others=>'0');

begin

    apply_filter: process(clk)
    begin
        if clk'event and clk='1' then
            if mac_init='1' then
                y_buf <= rom_out*ram_out;
            else
                -- mporei kai na mhn douleuei
                y_buf <= y_buf+rom_out*ram_out;
            end if;
        end if;
    end process;
    
    y <= y_buf;
    
end Behavioural;
