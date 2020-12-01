-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : shiftLeft2_tb.vhd
-- Author     : Ziv
-- Created    : 05-08-2020
-- Last update: 05-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shiftLeft2_tb is
end entity shiftLeft2_tb;


architecture shiftLeft2_tb of shiftLeft2_tb is
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);
begin
	t1: entity work.shiftLeft2
	port map (
			  a => a,
			  b => b
			);
			
	p1: process is
	begin
		a <= x"0000F000";
		wait for 40 ns;
		a <= x"0000A00F";
		wait for 40 ns;
		a <= x"0000FFFF";
		wait for 40 ns;
		a <= x"FFFF0000";
		wait for 40 ns;
		wait;
	end process p1;
end architecture shiftLeft2_tb;