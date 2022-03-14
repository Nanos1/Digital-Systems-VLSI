library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder3to8_tb is
end entity;

architecture bench of decoder3to8_tb is

  component decoder3to8 is
    port (
        enc: in std_logic_vector(2 downto 0);
        dec: out std_logic_vector(7 downto 0)
         );
  end component;

  signal enc  : std_logic_vector(2 downto 0) := (others => '0');
  signal dec  : std_logic_vector(7 downto 0);

  constant CLOCK_PERIOD : time := 10 ns;

begin

  test : decoder3to8
    port map (
              enc  => enc,
              dec => dec
             );

  stimulus : process
  begin
    ----- Stimulus example -----
    for i in 0 to 7 loop -- enc loop
        enc <= std_logic_vector(to_unsigned(i, 3));
        wait for CLOCK_PERIOD;
    end loop;
    enc <= (others => '0');
    wait;
  end process;


end architecture;
