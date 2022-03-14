-- Module Name: frequency divider
-- Functionality: produces a clock frequency by reducing the input clock frequency
-- Description:
--   - in_freq     -> input frequency 
--   - out_freq    -> output (desired) frequency 
--   - scal_factor -> = in_freq/out_freq
--   - count       -> signal that counts until scal_factor/2-1 to generate delay
--   - new_clk     -> signal that toggles itself when count == scal_factor/2-1
-- Example: 
--   - in_freq = 100 MHz
--   - out_freq = 25 MHz
--   - scal_factor = 4
--   - count -> counts until 1
--   - new_clk -> toggles itself when count == 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
  
entity freq_divider is
port(  clk: in std_logic;      -- clock of input frequency (100 MHz)
	   rst: in std_logic;      -- negative reset
       sec_mode: in std_logic_vector;
       clk_out: out std_logic  -- clock of output (desired) frequency (25 MHz)
    );
end freq_divider;
  
architecture behavioural of freq_divider is
  
  signal count : integer range 0 to 62499999 := 0;        
  signal new_clk : std_logic := '0';
--  signal reset_enable : std_logic := '1';  
  signal max_count : integer range 0 to 62499999 := 62499999;
begin
  
  
  
  
  process(clk, rst)
  begin
    case sec_mode is
    when "001" =>
        max_count <= 62499999;
    when "010" =>
        max_count <= 499999999;
    when "011" =>
            max_count <= 37499999;
    when "100" =>
            max_count <= 24999999;
    when "101" =>
            max_count <= 124999999;
    when others =>
            max_count <= 124999999;
    end case;
    if (rst = '1' ) then
--      reset_enable <= '0';
      count <= 0;
      new_clk <= '0';
    elsif clk'event and clk = '1' then
      if count = max_count  then        
        new_clk <= not new_clk;  -- toggle 
        count <= 0;              -- count reset
--        reset_enable <= '1';
      else
        count <= count + 1;     
      end if;
    end if;
  end process;
  
  clk_out <= new_clk;

end behavioural;

-- count      0    0     1     0     1 
--            __    __    __    __
-- clk          |__|  |__|  |__|  |__|
--            ___________           
-- clk_out               |___________|           