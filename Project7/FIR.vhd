library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity FIR is
    Port ( clk : in std_logic;
           A : in std_logic_vector (31 downto 0);
           B : out std_logic_vector (31 downto 0) 
        );
end FIR;

architecture structural of FIR is
    component CU is
    Port ( clk      : in  STD_LOGIC;
           rst      : in  STD_LOGIC;                                    --- operation enable
           mac_init : out STD_LOGIC;            -- memory address
           ram_addr : out  STD_LOGIC_VECTOR (2 downto 0);    -- output data
           rom_addr : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    component ROM is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;                --- operation enable
           addr : in  STD_LOGIC_VECTOR (2 downto 0);            -- memory address
           rom_out : out  STD_LOGIC_VECTOR (7 downto 0));    -- output data
    end component;
    component RAM is
    port (clk  : in std_logic;
          rst  : in std_logic;
          we   : in std_logic;                        --- memory write enable
          en   : in std_logic;                --- operation enable
          addr : in std_logic_vector(2 downto 0);            -- memory address
          di   : in std_logic_vector(7 downto 0);        -- input data
          do   : out std_logic_vector(7 downto 0));        -- output data
    end component;
    component MAC is
    Port ( clk      : in  STD_LOGIC;
           mac_init : in  STD_LOGIC;                --- operation enable
           rom_out : in  STD_LOGIC_VECTOR (7 downto 0);            -- memory address
           ram_out : in  STD_LOGIC_VECTOR (7 downto 0);
          -- sum     : out std_logic_vector (19 downto 0);    -- output data
           y       : out STD_LOGIC_VECTOR (19 downto 0)); 
    end component; 
    signal count : integer range 0 to 7 := 0;
    signal count1 : integer  range 0 to 8 := 0;
    signal macin  : std_logic;
    signal ramCU,romCU : std_logic_vector(2 downto 0);
    signal write,en: std_logic;
    signal rom_out,ram_out : std_logic_vector (7 downto 0);
    signal y1   : std_logic_vector (19 downto 0)  := (others => '0');
    signal macc : std_logic;
    signal x1   : std_logic_vector (7 downto 0)  := (others => '0');
    signal macc1:std_logic;
    signal valout : std_logic_vector (2 downto 0);
    signal validate : std_logic;
    signal count2 : std_logic;
begin
    CU1 : CU port map (clk => clk, rst => A(9) , mac_init => macin, ram_addr => ramCU, rom_addr => romCU);
    ROM1 : ROM port map (clk => clk, en => en , addr => romCU, rom_out => rom_out);
    RAM1 : RAM port map (clk => clk, rst => A(9), we => write, en => en, addr => ramCU, di => x1, do => ram_out);
    MAC1 : MAC port map (clk => clk, mac_init => macc1, rom_out => rom_out, ram_out=>ram_out, y => y1);
    process (clk)
    begin
        if (clk'event and clk = '0') then
            if (A(9) = '1') then
                count2 <= '1';
            end if;
            if(validate='1') then
                en <= '1';
                valout(0) <= '0';
                if (ramCU = "111") then 
                    valout(0) <= '1';
                    write <= '1';
                    count2 <= '1';
                else 
                    write <= '0';
                    en <='1';
                 end if;
            else
                valout(0) <= '0';
                if (ramCU = "111" and count2 = '1') then 
                    write <= '0';   --not valid input 
                    --valid_out <= '0';
                    valout(0) <= '1';
                    count2 <= '0';
                else 
                    write <= '0';
                end if;
            end if;
    end if;
    end process;
    
    process (clk) 
    begin
      if (clk'event  and clk = '0') then
        validate <= A(8);
      end if; end process;
 
    process (clk) 
    begin 
        if (clk'event and clk = '1') then
          macc <= macin;
            x1 <= A(7 downto 0);
            valout(1) <= valout(0);
       end if; end process;
    process (clk) 
       begin 
            if (clk'event and clk = '1') then
              macc1 <= macc;
              valout(2)<=valout(1);
          end if; end process;
    process (clk) 
             begin 
                  if (clk'event and clk = '1') then
                    macc1 <= macc;
                    B(20)<=valout(2);
                end if; end process;
  -- macinit <= macin;          
   B(19 downto 0) <= y1;  
   B(31 downto 21) <= "00000000000";
  -- wri <= write;          
 end structural;