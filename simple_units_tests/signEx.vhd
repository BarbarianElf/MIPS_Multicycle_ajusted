-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : signEx.vhd
-- Author     : Ziv
-- Created    : 05-08-2020
-- Last update: 05-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signEx is
	port (
		  a : in   std_logic_vector (15 downto 0);
		  b : out  std_logic_vector (31 downto 0)
	    );
end entity signEx;

architecture signEx of signEx is
begin
	b <= std_logic_vector(resize(signed(a), b'length));
end architecture signEx;