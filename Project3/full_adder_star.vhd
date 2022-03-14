library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_star is
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
end full_adder_star;

architecture structural of full_adder_star is

  component full_adder is
    port(
        a: in std_logic;
        b: in std_logic;
        cin: in std_logic;
        s: out std_logic := '0';
        rst : in std_logic;
        cout: out std_logic := '0';
        clk : in std_logic
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

  component delay_2 is
    port(
       d : in  std_logic;
       q : out  std_logic;
       clk : in std_logic;
       rst : in std_logic
      );
  end component;


signal input : std_logic;
  begin
  
  input <= a_in and b_in;
  
    adder : full_adder
    port map (
        a => sin,
        b => input,
        cin => cin,
        cout => cout,
        rst => rst,
        clk => clk,
        s => sout
    );

    b_delay : d_flipflop
    port map (
        d => b_in,
        q => b_out,
        rst => rst,
        clk => clk
        );
        

    a_delay : delay_2
    port map (
        d => a_in,
        q => a_out,
        rst => rst,
        clk => clk
        );        

  end architecture;