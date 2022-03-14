library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fulladder_tb is
end entity;

architecture bench of fulladder_tb is

  component full_adder is
    port (
        a: in std_logic;
        b: in std_logic;
        cin: in std_logic;
        s: out std_logic;
        rst : in std_logic;
        cout: out std_logic;
        clk: in std_logic
        );
  end component;

  signal a: std_logic;
  signal b: std_logic;
  signal cin: std_logic;
  signal rst : std_logic;
  signal s: std_logic;
  signal cout: std_logic;
  signal clk: std_logic;
    
  constant CLOCK_PERIOD : time := 10 ns;

begin

   mapping : full_adder
    port map (
              a => a,
              b => b,
              cin => cin,
              s => s,
              rst => rst,
              cout => cout,
              clk => clk
             );

  stimulus : process
  begin
  
  -- check disabled --
  
  rst <= '0';
  a <= '-';
  b <= '-';
  cin <= '-';
  wait for CLOCK_PERIOD;
  
  rst <= '1';
  
  -- test every possible value --
  
    for i in std_logic range '0' to '1' loop
       a <= i;
        for j in std_logic range '0' to '1' loop
            b <= j;
            for k in std_logic range '0' to '1' loop
                cin <= k;
                wait for CLOCK_PERIOD;
            end loop;
        end loop;
    end loop;
    wait;
  end process;
  
  generate_clock : process
   begin
     clk <= '1';
     wait for CLOCK_PERIOD/2;
     clk <= '0';
     wait for CLOCK_PERIOD/2;
   end process;
  
end architecture;

