library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rom is
    generic (
        coeff_width: integer := 8       -- width of coefficients (bits)
    );
    port (
        clk: in  std_logic;             -- clock
        en: in  std_logic;              -- operation enable
        rom_addr: in  std_logic_vector(2 downto 0);             -- memory address
        rom_out: out  std_logic_vector(coeff_width-1 downto 0) := (others=>'0')	-- output data
        );
end rom;

architecture Behavioural of rom is

    type rom_type is array(7 downto 0) of std_logic_vector(coeff_width-1 downto 0);
    signal rom: rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                                 "00000001");   -- initialization of rom with user data
--        signal rom: rom_type:= ("00000001", "00000001", "00000001", "00000001", "00000001", "00000001", "00000001",
--                             "00000001");
    signal rdata: std_logic_vector(coeff_width-1 downto 0) := (others=>'0');
    
begin

    rdata <= rom(conv_integer(rom_addr));

    process (clk)
    begin
        if (clk'event and clk='1') then
            if (en='1') then
                rom_out <= rdata;
            end if;
        end if;
    end process;			

end Behavioural;
