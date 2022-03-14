library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Pseudo_Coder is
    port (
        inputi: in std_logic_vector (15 downto 0);
        outputi: out std_logic_vector(4 downto 0)
        );	
end Pseudo_Coder;

architecture Dataflo of Pseudo_Coder is
	
--	signal is10_7: std_logic;
--	signal is12_11: std_logic;
--    signal is8_7: std_logic;
--    signal is4_3: std_logic;
--    signal pair15_14: std_logic;
--    signal pair13_12: std_logic;
--    signal pair11_10: std_logic;
--    signal pair9_8: std_logic;
--    signal pair7_6: std_logic;
--    signal pair5_4: std_logic;
--    signal pair3_2: std_logic;
--    signal pair1_0: std_logic;	 
begin
   
    find_L: process(inputi)
    begin
        if inputi(15)='1' then
            outputi <= "10000";
        elsif inputi(14)='1' then
            outputi <= "01111";
        elsif inputi(13)='1' then
            outputi <= "01110";
        elsif inputi(12)='1' then
            outputi <= "01101";
        elsif inputi(11)='1' then
            outputi <= "01100";
        elsif inputi(10)='1' then
            outputi <= "01011";
        elsif inputi(9)='1' then
            outputi <= "01010";
        elsif inputi(8)='1' then
            outputi <= "01001";
        elsif inputi(7)='1' then
            outputi <= "01000";
        elsif inputi(6)='1' then
            outputi <= "00111";
        elsif inputi(5)='1' then
            outputi <= "00110";
        elsif inputi(4)='1' then
            outputi <= "00101";
        elsif inputi(3)='1' then
            outputi <= "00100";
        elsif inputi(2)='1' then
            outputi <= "00011";
        elsif inputi(1)='1' then
            outputi <= "00010";
        --elsif inputi(0)='1' then
        else
            outputi <= "00001";
        end if;
    end process;
    
    
        
--	is10_7 <= not (inputi(10) or inputi(9) or inputi(8) or inputi(7));
--    is12_11 <= not (inputi(12) or inputi(11));
--    is8_7 <= not (is12_11 and inputi(8) or inputi(7));
--    is4_3 <= not (inputi(4) or inputi(3));
--    pair15_14 <= not inputi(15) and inputi(14);
--    pair13_12 <= not (inputi(15) or inputi(13)) and inputi(12);
--    pair11_10 <= not (inputi(15) or inputi(13) or inputi(11)) and inputi(10);
--    pair9_8 <= not (inputi(15) or inputi(13) or inputi(11) or inputi(9)) and inputi(8);
--    pair7_6 <= not (inputi(15) or inputi(13) or inputi(11) or inputi(9) or inputi(7)) and inputi(6);
--    pair5_4 <= not (inputi(15) or inputi(13) or inputi(11) or inputi(9) or inputi(7) or inputi(5)) and inputi(4);
--    pair3_2 <= not (inputi(15) or inputi(13) or inputi(11) or inputi(9) or inputi(7) or inputi(5) or inputi(3)) and inputi(2);
--    pair1_0 <= not (inputi(15) or inputi(13) or inputi(11) or inputi(9) or inputi(7) or inputi(5) or inputi(3) or inputi(1)) and inputi(0);

--    outputi(4) <= inputi(15);
--    outputi(3) <= (not inputi(15)) and (inputi(14) or inputi(13) or inputi(12) or inputi(11) or inputi(10) or inputi(9) or inputi(8) or inputi(7));
--    outputi(2) <= (not inputi(15)) and ((inputi(14) or inputi(13) or inputi(12) or inputi(11)) or (is10_7 and (inputi(6) or inputi(5) or inputi(4) or inputi(3)))); 
--    outputi(1) <= (not inputi(15)) and ((inputi(14) or inputi(13)) or (is12_11 and (inputi(10) or inputi(9))) or (is8_7 and (inputi(6) or inputi(5))) or (is4_3 and (inputi(2) or inputi(1)))); 
--    outputi(0) <= pair15_14 or pair13_12 or pair11_10 or pair9_8 or pair7_6 or pair5_4 or pair3_2 or pair1_0;
end Dataflo;