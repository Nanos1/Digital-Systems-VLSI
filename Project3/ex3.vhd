library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline_4bit_mult is
  port(
       a : in  std_logic_vector(3 downto 0);
       b : in  std_logic_vector(3 downto 0);
       clk : in std_logic;
       rst : in std_logic;
       p : out std_logic_vector(7 downto 0)
      );
end pipeline_4bit_mult;

architecture structural of pipeline_4bit_mult is

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

-- a input signal transmit vectors --
type a_array is array(4 downto 0) of std_logic_vector(4 downto 0);
signal a_signals : a_array := (others => (others => 'X'));

-- b input signal transmit vectors --
type b_array is array(4 downto 0) of std_logic_vector(4 downto 0);
signal b_signals : b_array := (others => (others => 'X'));

-- carries of each level --
type cout_array is array(3 downto 0) of std_logic_vector(4 downto 0);
signal cout_signals : cout_array := (others => (others => '0'));

-- output of each level (cout & s) --
-- last level is shorter as the last to values are put directly as output p --
type s_array is array(4 downto 0) of std_logic_vector(4 downto 0);
signal s_signals : s_array := (others => (others => '0'));


signal buffered_output1 : std_logic;
signal buffered_output2_vec : std_logic_vector(1 downto 0);
signal buffered_output3_vec : std_logic_vector(2 downto 0);

signal b2_delayed_2 : std_logic;
signal b3_delayed_3 : std_logic;


begin
    
    a_signals(0)(0) <= a(0);
    b_signals(0)(0) <= b(0);

    g_loop : for i in 0 to 3 generate
        generate_fa : for j in 0 to 3 generate
        fa : full_adder_star
            port map (
                a_in => a_signals(i)(j),
                a_out => a_signals(i+1)(j),
                b_in => b_signals(i)(j),
                b_out => b_signals(i)(j + 1),
                sin => s_signals(i)(j+1),
                sout => s_signals(i+1)(j),
                cin => cout_signals(i)(j),
                cout => cout_signals(i)(j+1), 
                clk => clk,
                rst => rst
            );
        end generate;
    end generate g_loop;
    
    generate_delay : for i in 0 to 2 generate
        delay1 : d_flipflop
            port map (
                d => cout_signals(i)(4),
                q => s_signals(i+1)(4),
                clk => clk,
                rst => rst
            );
    
    end generate;

    delay_p0_1 : delay_2
    port map (
        d => s_signals(1)(0),
        q => buffered_output1,
        clk => clk,
        rst => rst
    );

    delay_p0_2 : delay_2
    port map (
        d => buffered_output1,
        q => buffered_output2_vec(0),
        clk => clk,
        rst => rst
    );

    delay_p1_2 : delay_2
    port map (
        d => s_signals(2)(0),
        q => buffered_output2_vec(1),
        clk => clk,
        rst => rst
    );    

    delay_p0_3 : delay_2
    port map (
        d => buffered_output2_vec(0),
        q => buffered_output3_vec(0),
        clk => clk,
        rst => rst
    );

    delay_p1_3 : delay_2
    port map (
        d => buffered_output2_vec(1),
        q => buffered_output3_vec(1),
        clk => clk,
        rst => rst
    );

    delay_p2_3 : delay_2
    port map (
        d => s_signals(3)(0),
        q => buffered_output3_vec(2),
        clk => clk,
        rst => rst
    );

    delay_p0_4 : delay_3
    port map (
        d => buffered_output3_vec(0),
        q => p(0),
        clk => clk,
        rst => rst
    );

    delay_p1_4 : delay_3
    port map (
        d => buffered_output3_vec(1),
        q => p(1),
        clk => clk,
        rst => rst
    );

    delay_p2_4 : delay_3
    port map (
        d => buffered_output3_vec(2),
        q => p(2),
        clk => clk,
        rst => rst
    );
    
    delay_p3_4 : delay_3
        port map (
            d => s_signals(4)(0),
            q => p(3),
            clk => clk,
            rst => rst
        );

    delay_p4_4 : delay_2
        port map (
            d => s_signals(4)(1),
            q => p(4),
            clk => clk,
            rst => rst
        );


    delay_p5_4 : d_flipflop
        port map (
            d => s_signals(4)(2),
            q => p(5),
            clk => clk,
            rst => rst
        );
        
     delay_b1_2 : delay_2
        port map (
            d => b(1),
            q => b_signals(1)(0),
            clk => clk,
            rst => rst
            );     

     delay_b2_2 : delay_2
        port map (
            d => b(2),
            q => b2_delayed_2,
            clk => clk,
            rst => rst
            ); 

    delay_b2_4 : delay_2
        port map(
            d => b2_delayed_2,
            q => b_signals(2)(0),
            clk => clk,
            rst => rst
        ); 
        
     delay_b3_3 : delay_3
        port map (
            d => b(3),
            q => b3_delayed_3,
            clk => clk,
            rst => rst
            ); 

    delay_b3_6 : delay_3
        port map(
            d => b3_delayed_3,
            q => b_signals(3)(0),
            clk => clk,
            rst => rst
        );

    delay_a1_1 : d_flipflop
        port map(
            d => a(1),
            q => a_signals(0)(1),
            clk => clk,
            rst => rst
        ); 
        
        
    delay_a2_2 : delay_2
        port map(
            d => a(2),
            q => a_signals(0)(2),
            clk => clk,
            rst => rst
        ); 


    delay_a3_3 : delay_3
        port map(
            d => a(3),
            q => a_signals(0)(3),
            clk => clk,
            rst => rst
        ); 
    
    p(6) <= s_signals(4)(3);
    P(7) <= cout_signals(3)(4);
        
end architecture ;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    