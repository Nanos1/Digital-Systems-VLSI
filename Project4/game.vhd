-- library declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- entity
entity game is port(
    p1: in std_logic;
    p2: in std_logic;
    p: in std_logic;
    r: in std_logic;
    s: in std_logic;
    clk125Mhz: in std_logic;
    leds: out std_logic_vector(3 downto 0) := (others => '0')
);
end game;

-- architecture
architecture Behavioural of game is
-- stc(s clear), sts(s posedge), stm(moving leds), stg(led on goal), ste(end)
    type state_type is (stc, sts, stm1, stm2, stg, ste);
    signal game_clk: std_logic := '0';
    signal ps: state_type := sts;
    signal ns: state_type;
-- ps: previous state, ns: next state
    signal set: std_logic_vector (2 downto 0);
    signal round: unsigned (1 downto 0);
    signal dir: std_logic := '0';
    signal leds_buf: std_logic_vector(3 downto 0);
    
--    flags apokroushs twn 2 paiktwn
    signal buff_s1: std_logic := '0';
    signal buff_s2: std_logic := '0';
    signal flag_enabler: std_logic := '0';
    signal game_clk_rst: std_logic := '0';
    component freq_divider is
    port(  clk: in std_logic;      -- clock of input frequency (100 MHz)
           rst: in std_logic;      -- negative reset
           sec_mode: in std_logic_vector;
           clk_out: out std_logic  -- clock of output (desired) frequency (25 MHz)
        );
    end component;
begin

    frequency_divider: freq_divider
    port map(
        clk => clk125Mhz,
        clk_out => game_clk,
        rst => '0',
        sec_mode => set
 );
    leds <= leds_buf;    
    
    apokroush1 : process(p1, flag_enabler)
    begin
        if p1 = '1' and ((ps = sts) or (ps = stg and leds_buf = "1000")) then
         buff_s1 <= '1';
        else
         buff_s1 <= '0';
        end if;
    end process;
    
   apokroush2 : process(p2, flag_enabler)
     begin    
         if p2 = '1' and  ps = stg and leds_buf = "0001" then
            buff_s2 <= '1';
         else
            buff_s2 <= '0';          
         end if;
    end process;
    
    sync_proc: process(s, r, p, buff_s1, buff_s2, game_clk)
    begin
        -- take care of the asynchronous input
        if s = '0' then
            dir <= '0';
            ps <= stc;
        elsif (r = '0' or ps = stc) then
           ps <= sts;
           round <= "00";
           flag_enabler <= '1';
--           dir <= '0'; 
        elsif p = '1' then
            ps <= ps;
        elsif (buff_s1 = '1' and flag_enabler = '1') then 
            ps <= stm1;
            round <= round+1;
--            flag_enabler <= '0';
--            game_clk_rst <= '1';
            dir <= '0';            
        elsif (buff_s2 = '1' and flag_enabler = '1') then
            ps <= stm2;
            round <= round+1;
--            flag_enabler <= '0';
--            game_clk_rst <= '1';
            dir <= '1'; 
        -- clock led 
        elsif rising_edge(game_clk) then
            ps <= ns;
            flag_enabler <= '1';
--            game_clk_rst <= '0';
        end if;
--        if game_clk_rst = '1' then
--            game_clk_rst <= '0';
--        end if;
    end process sync_proc;
       
    
    
    comb_proc: process(ps)
    begin
        case ps is
            when stc =>
                leds_buf <= "0000";
                ns <= stc;
            when sts =>
                leds_buf <= "1000";
                set <= "001";
                ns <= sts;
            when stm1 =>
                leds_buf <= "0100";
                case dir is
                    when '0' =>
                        ns <= stm2;
                    when '1' =>
                        ns <= stg;
                    when others =>
                        leds_buf <= "1011";
                end case;
            when stm2 =>
                    leds_buf <= "0010";
                    case dir is
                        when '0' =>
                            ns <= stg;
                        when '1' =>
                            ns <= stm1;
                        when others =>
                            leds_buf <= "1101";
                    end case;
            when stg =>
                case dir is
                    when '0' =>
                        leds_buf <= "0001";
                    when '1' => 
                        leds_buf <= "1000";
                    when others =>
                        leds_buf <= "1001";   
                    end case;       
                ns <= ste;
                
                if (round = "11") and not(set = "110") then
                    set <= set+1;
                    round <= "01";
                end if;
            when ste =>
                case dir is
                    when '0' =>
                        leds_buf <= "1100";
                    when '1' =>
                        leds_buf <= "0011";
                    when others =>
                        leds_buf <= "1111";
                end case;
                ns <= ste;
            when others =>
                leds_buf <= "0110";
--                ns <= stc;
        end case;
        
    end process comb_proc;
    
end Behavioural;
--architecture dat of game is
-- signal game_clk : std_logic;
-- signal led_buff : std_logic_vector (3 downto 0) := "1010";
-- type state_type is (stc, sts, stm, stg, ste);
-- signal ps: state_type := sts;
-- signal ns: state_type;
--     component freq_divider is
--     port(  clk: in std_logic;      -- clock of input frequency (100 MHz)
--            rst: in std_logic;      -- negative reset
-- --           max_count: in std_logic_vector;
--            clk_out: out std_logic  -- clock of output (desired) frequency (25 MHz)
--         );
--     end component;    
--begin
--    frequency_divider: freq_divider
--    port map(
--        clk => clk125Mhz,
--        clk_out => game_clk,
--        rst => r
----        max_count
-- );    
    
--    process(game_clk)
--    begin
--    if s = '1' then
--        ps <= sts;
--    elsif p = '1' then
--        ps <= stm;
--    else
--       ps <= ste;    
--    end if;
--    end process;
    
--    process(game_clk, ps)
--        begin
--        case ps is
--        when sts =>
--            led_buff <= "0101";
--        when stm =>
--            led_buff <= '1' & led_buff(3 downto 1);
--        when ste =>
--            led_buff <= '0' & led_buff(3 downto 1);
--        when others =>
--                     if rising_edge(game_clk) then

--                led_buff <= "0110";
--        end if;

--            end case;
--    end process;
--    leds <= led_buff;

--end architecture;