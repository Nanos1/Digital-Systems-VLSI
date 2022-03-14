library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder3to8 is
  port(
      enc: in std_logic_vector(2 downto 0);
      dec: out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavioral of decoder3to8 is

begin

  process(enc)
  begin
    case enc is
      when "000" =>
        dec <= "00000001";
      when "001" =>
        dec <= "00000010";
      when "010" =>
        dec <= "00000100";
      when "011" =>
        dec <= "00001000";
      when "100" =>
        dec <= "00010000";
      when "101" =>
        dec <= "00100000";
      when "110" =>
        dec <= "01000000";
      when "111" =>
        dec <= "10000000";
      when others =>
        dec <=  (others  => '-');
    end case;
  end process;

end architecture; -- arch