library ieee;
use ieee.std_logic_1164.all;

entity half_adder is port(
    bits: in std_logic_vector(1 downto 0);
    s: out std_logic;
    c: out std_logic
);
end half_adder;

architecture dataflow of half_adder is
begin
    s <= bits(0) xor bits(1);
    c <= bits(0) and bits(1);
end dataflow;