library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_filter is
    generic (
        data_width : integer := 8;      -- width of data (bits)
        coeff_width : integer := 8      -- width of coefficients (bits)
    );
    port (
        clk: in std_logic;
        rst: in std_logic;
        valid_in: in std_logic;
        x: in std_logic_vector(7 downto 0);
        y: out std_logic_vector(15 downto 0);
        valid_out: out std_logic;
        L: out std_logic_vector(4 downto 0)
    );
end fir_filter;

architecture Structural of fir_filter is
   
    component Moufa_Coder is
        port (
        inputi: in std_logic_vector (15 downto 0);
        outputi: out std_logic_vector(4 downto 0)
        );
    end component;    
    
    component control_unit is
        port (
            clk: in std_logic;
            rst: in std_logic;
            valid_in: in std_logic;
            rom_addr: out std_logic_vector(2 downto 0);
            ram_addr: out std_logic_vector(2 downto 0);
            mac_init: out std_logic;
            valid_out: out std_logic
        );
    end component;
    
    component ram is 
        port (
            clk: in std_logic;
            rst: in std_logic;    
            we: in std_logic;
            en: in std_logic;
            ram_addr: in std_logic_vector(2 downto 0);
            data_input: in std_logic_vector(data_width-1 downto 0);
            ram_out: out std_logic_vector(data_width-1 downto 0)
        );
    end component;
    
    component rom is 
        port (
            clk: in  std_logic;
            en: in  std_logic;      -- operation enable
            rom_addr: in  std_logic_vector(2 downto 0);     -- memory address
            rom_out: out  std_logic_vector(coeff_width-1 downto 0)  -- output data
        );
    end component;
    
    component mac is
        port (
            clk: in std_logic;
            rom_out: in std_logic_vector (coeff_width-1 downto 0);
            mac_init: in std_logic;
            ram_out: in std_logic_vector (data_width-1 downto 0);
            y: out std_logic_vector (15 downto 0) := (others => '0')
        );
    end component;
    
    signal ram_addr: std_logic_vector(2 downto 0);
    signal rom_addr: std_logic_vector(2 downto 0);
    signal mac_init: std_logic;
    signal rom_out: std_logic_vector(7 downto 0);
    signal ram_out: std_logic_vector(7 downto 0);
    signal Moufa: std_logic_vector(15 downto 0);

begin
    
    moufa_coder_p: Moufa_Coder
    port map (
        inputi => Moufa,
        outputi => L
        );
            
    control_unit_p: control_unit
    port map (
        clk => clk,
        rst => rst,
        valid_in => valid_in,
        ram_addr => ram_addr,
        rom_addr => rom_addr,
        mac_init => mac_init,
        valid_out => valid_out
    );

    rom_p: rom
    port map (
        clk => clk,
        en => '1',
        rom_addr => rom_addr,
        rom_out => rom_out
    );
  
    ram_p : ram
    port map (
        clk => clk,
        rst => rst,
        we => valid_in,
        en => '1',
        data_input => x,
        ram_addr => ram_addr,
        ram_out => ram_out
    );
        
    mac_p: mac
    port map (
        clk => clk,
        mac_init => mac_init,
        rom_out => rom_out,
        ram_out => ram_out,
        y => Moufa
    );
    
    y <= Moufa;

end Structural;
