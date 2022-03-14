library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg_tb is
end entity;

architecture bench of shift_reg_tb is

  component shift_reg is
    port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           shft : in STD_LOGIC;
           si : in STD_LOGIC;
           en : in STD_LOGIC;
           pl : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (3 downto 0);
           so : out STD_LOGIC);
  end component;

  signal clk  : std_logic;
  signal rst  : std_logic := '0';
  signal shft : std_logic := '0';
  signal si : std_logic := '0';
  signal en : std_logic := '0';
  signal pl : std_logic := '0';
  signal din : std_logic_vector(3 downto 0) := (others => '0');
  signal so : std_logic;

  constant CLOCK_PERIOD : time := 10 ns;

begin

  test : shift_reg 
    port map (clk => clk,
           rst => rst,
           shft => shft,
           si => si,
           en => en,
           pl => pl,
           din => din,
           so => so
);

  stimulus : process
  begin
    ----- Stimulus example -----
  -- Reset everything --
  rst <= '0';
  din <= (others => '-');
  shft <= '-';
  si <= '-';
  en <= '-';
  pl <= '-';
  wait for CLOCK_PERIOD;


 -- Reset disabled, parallel load --
  rst <= '1';
  pl <= '1';
  shft <= '-';
  si <= '-';
  en <= '-';
    
  for i in 0 to 15 loop
	din <= std_logic_vector(to_unsigned(i, 4));
	wait for CLOCK_PERIOD;
  end loop;
  
-- Load 0101 to test right shift --  
  din <= "0101";
  
  wait for CLOCK_PERIOD;
  
  -- expect to get 1 0 1 0  and to load 1111 --
  pl <= '0';
  en <= '1';
  shft <= '1';
  si<='1';
  for i in 0 to 3 loop
	wait for CLOCK_PERIOD;
  end loop;

-- Load 0101 to test left shift --  

  pl <= '1';
  din <= "0101";
  wait for CLOCK_PERIOD;

  pl <= '0';
  shft <= '0';
  -- expect to get 1 0 1 1 and to load 1111 --

  for i in 0 to 3 loop
	wait for CLOCK_PERIOD;
  end loop;


  -- disable everything --
  en <= '0';

  wait for CLOCK_PERIOD;

  wait;
  end process;

  generate_clock : process
  begin
    clk <= '0';
    wait for CLOCK_PERIOD/2;
    clk <= '1';
    wait for CLOCK_PERIOD/2;
  end process;

end architecture;