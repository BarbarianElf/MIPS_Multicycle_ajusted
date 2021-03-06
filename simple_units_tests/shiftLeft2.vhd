-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : shiftLeft2.vhd
-- Author     : Ziv
-- Created    : 05-08-2020
-- Last update: 05-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shiftLeft2 is
	port (
		  a : in  std_logic_vector (31 downto 0);
		  b : out std_logic_vector (31 downto 0)
	    );
end entity shiftLeft2;

architecture shiftLeft2 of shiftLeft2 is
begin
	b <= std_logic_vector(shift_left(signed(a),2));
end architecture shiftLeft2;