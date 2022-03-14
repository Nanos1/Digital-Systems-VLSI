library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline_4bit_mult_tb is
end entity;

architecture bench of pipeline_4bit_mult_tb is

  component pipeline_4bit_mult is
    port (
     a : in  std_logic_vector(3 downto 0);
     b : in  std_logic_vector(3 downto 0);
     clk : in std_logic;
     rst : in std_logic;
     p : out std_logic_vector(7 downto 0)
    );
  end component;

    component full_adder_star is
        port(
            a_in : in  std_logic;
             a_out: out std_logic;
             b_in : in  std_logic;
             b_out : out std_logic;
             sin : in std_logic;
             cin : in  std_logic;
             clk : in std_logic;
             rst : in std_logic;
             sout : out std_logic;
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

    component delay_3 is
        port(
            d : in  std_logic;
            q : out  std_logic;
            clk : in std_logic;
            rst : in std_logic
            );
        end component;  

    component delay_2 is
        port(
            d : in  std_logic;
            q : out  std_logic;
            clk : in std_logic;
            rst : in std_logic
            );
        end component;    

  signal a: std_logic_vector(3 downto 0) := (others => '0');
  signal b: std_logic_vector(3 downto 0) := (others => '0');
  signal rst : std_logic;
  signal p: std_logic_vector(7 downto 0);
  signal clk: std_logic;
    
  constant CLOCK_PERIOD : time := 10 ns;

begin

   mapping : pipeline_4bit_mult
    port map (
              a => a,
              b => b,
              p => p,
              rst => rst,
              clk => clk
             );

  stimulus : process
  begin
  
  rst <= '0';
  a <= "----";
  b <= "----";
  wait for CLOCK_PERIOD;
  
  rst <= '1';  

--    for i in 0 to 15 loop
--       a <= std_logic_vector(to_unsigned(i, 4));
--        for j in 0 to 15 loop
--            b <= std_logic_vector(to_unsigned(j, 4));
--        end loop;
--    end loop;

    a <= "0001";
    b <= "0001";
    wait for CLOCK_PERIOD;
 
    
    a <= "0010";
    b <= "0001";
    wait for CLOCK_PERIOD;
 
    a <= "1010";
    b <= "1001";
    wait for CLOCK_PERIOD;
    
    a <= "1111";
        b <= "1111";
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

