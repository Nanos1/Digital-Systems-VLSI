library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM is
	 generic (
		data_width : integer :=8  				--- width of data (bits)
	 );
    port (clk  : in std_logic;
          rst  : in std_logic;
          we   : in std_logic;						--- memory write enable
		  en   : in std_logic;				--- operation enable
          addr : in std_logic_vector(2 downto 0);			-- memory address
          di   : in std_logic_vector(data_width-1 downto 0);		-- input data
          do   : out std_logic_vector(data_width-1 downto 0));		-- output data
end RAM;
architecture Behavioral of RAM is

    type ram_type is array (7 downto 0) of std_logic_vector (data_width-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
	signal  do1   :  std_logic_vector(7 downto 0) := (others => '1');	 
begin
    process (clk,we)
    begin
        if (rst = '1') then
            RAM <= (others => (others => '0'));
        elsif (clk'event and clk = '1') then
            if en = '1' then
                if we = '1' then
                    --do <= RAM (conv_integer (addr) );			-- write operation
                    RAM(7 downto 1) <= RAM (6 downto 0);
                    RAM (0) <= di;
                    --do <= RAM (conv_integer (addr));-- " maybe it has to be after the shift"!!!!
               end if;						-- read operation
                    do1 <= RAM( conv_integer(addr));
            end if;
        end if;
    end process;
    do <= do1;

end Behavioral;

