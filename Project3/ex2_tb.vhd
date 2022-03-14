library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline_4bit_adder_tb is
end entity;

architecture bench of pipeline_4bit_adder_tb is

  component pipeline_4bit_adder is
    port (
        a : in  std_logic_vector(3 downto 0);
        b : in  std_logic_vector(3 downto 0);
        cin : in  std_logic;
        clk : in std_logic;
        rst : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
        );
  end component;

  component d_flipflop is
    port(
         d : in  std_logic;
         q : out  std_logic;
         clk : in std_logic;
         rst : in std_logic
        );
  end component;


  signal a: std_logic_vector(3 downto 0) := (others => '0');
  signal b: std_logic_vector(3 downto 0) := (others => '0');
  signal cin: std_logic;
  signal rst : std_logic;
  signal s: std_logic_vector(3 downto 0);
  signal cout: std_logic;
  signal clk: std_logic;
    
  constant CLOCK_PERIOD : time := 10 ns;

begin

   mapping : pipeline_4bit_adder
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
  
  rst <= '0';
  a <= "----";
  b <= "----";
  cin <= '0';
  wait for CLOCK_PERIOD/2;
  
  rst <= '1';  

    for i in 0 to 15 loop
       a <= std_logic_vector(to_unsigned(i, 4));
        for j in 0 to 15 loop
            b <= std_logic_vector(to_unsigned(j, 4));
            for k in std_logic range '0' to '1' loop
                cin <= k;
                wait for CLOCK_PERIOD;
            end loop;
        end loop;
    end loop;
    cin <= '0';
    a <= "0000";
    b <= "0000";
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

