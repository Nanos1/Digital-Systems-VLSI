library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ram is
    generic (
        data_width: integer :=8     -- width of data (bits)
    );
    port (
        clk: in std_logic;
        rst: in std_logic;    
        we: in std_logic;           -- memory write enable
        en: in std_logic;           -- operation enable
        ram_addr: in std_logic_vector(2 downto 0);              -- memory address
        data_input: in std_logic_vector(data_width-1 downto 0);	-- input data
        ram_out: out std_logic_vector(data_width-1 downto 0) := (others=>'0')
        );	-- output data
end ram;

architecture Behavioural of ram is

    type ram_type is array(7 downto 0) of std_logic_vector(data_width-1 downto 0);
    signal ram: ram_type := (others=>(others=>'0'));
	 
begin

    process (clk, rst)
    begin
        if rst='1' then
            ram <= (others=>(others=>'0'));
        elsif clk'event and clk='1' then
            if en='1' then
                if we='1' then				-- write operation
                    ram(7 downto 1) <= ram(6 downto 0);
                    ram(0) <= data_input;
                    ram_out <= data_input;
                else						-- read operation
                    ram_out <= ram(conv_integer(ram_addr));
                end if;
            end if;
        end if;
    end process;

end Behavioural;
