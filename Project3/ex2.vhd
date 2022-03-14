library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline_4bit_adder is
  port(
       a : in  std_logic_vector(3 downto 0);
       b : in  std_logic_vector(3 downto 0);
       cin : in  std_logic;
       clk : in std_logic;
       rst : in std_logic;
       s : out std_logic_vector(3 downto 0);
       cout : out std_logic
      );
end pipeline_4bit_adder;

architecture structural of pipeline_4bit_adder is

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

  component delay_3 is
      port(
        d : in  std_logic;
        q : out  std_logic;
        clk : in std_logic;
        rst : in std_logic
        );
    end component;
  
  signal sum_reg : std_logic_vector(3 downto 0);
  
  signal carry_vec : std_logic_vector(4 downto 0);  
  signal fa_s : std_logic_vector(3 downto 0);
  signal fa_a : std_logic_vector(3 downto 0);
  signal fa_b : std_logic_vector(3 downto 0);     

begin
  
  fa_a(0) <= a(0);
  fa_b(0) <= b(0);
  carry_vec(0) <= cin;
  
  generate_adders: for i in 0 to 3 generate
  fa: full_adder
   port map (
        a => fa_a(i),
        b => fa_b(i),
        cin => carry_vec(i),
        cout => carry_vec(i+1),
        clk => clk,
        rst => rst,
        s => fa_s(i)
        );
   end generate;
    
  delay_s0_3 : delay_3
    port map (
      d => fa_s(0),
      q => sum_reg(0),
      clk => clk,
      rst => rst
      );
      
  delay_s1_2 : delay_2
  port map (
    d => fa_s(1),
    q => sum_reg(1),
    clk => clk,
    rst => rst
    ); 

  delay_s2_1 : d_flipflop
  port map (
    d => fa_s(2),
    q => sum_reg(2),
    clk => clk,
    rst => rst
    ); 
    
    delay_a1_1 : d_flipflop
    port map (
      d => a(1),
      q => fa_a(1),
      clk => clk,
      rst => rst
      ); 

   delay_a2_2 : delay_2
    port map (
      d => a(2),
      q => fa_a(2),
      clk => clk,
      rst => rst
      ); 

   delay_a3_3 : delay_3
    port map (
      d => a(3),
      q => fa_a(3),
      clk => clk,
      rst => rst
      ); 

      delay_b1_1 : d_flipflop
    port map (
      d => b(1),
      q => fa_b(1),
      clk => clk,
      rst => rst
      ); 

   delay_b2_2 : delay_2
    port map (
      d => b(2),
      q => fa_b(2),
      clk => clk,
      rst => rst
      ); 

   delay_b3_3 : delay_3
    port map (
      d => b(3),
      q => fa_b(3),
      clk => clk,
      rst => rst
      ); 
    sum_reg(3) <= fa_s(3);
    s <= sum_reg;      
    cout <= carry_vec(4);

end architecture ; -- arch