-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : register32ena.vhd
-- Author     : Ziv
-- Created    : 04-08-2020
-- Last update: 04-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity register32ena is
	port (
		  input  : in  std_logic_vector (31 downto 0);
		  ena    : in  std_logic;
		  clk    : in  std_logic;
		  rst    : in  std_logic;
		  output : out std_logic_vector (31 downto 0)
	    );
end entity register32ena;

architecture register32ena of register32ena is
begin
	sync: process(clk, rst)
	begin
		if (rst = '0') then
			output <= (others => '0');
		elsif  rising_edge(clk) then
			if (ena = '1') then
				output <= input;
			end if;
		end if;
	end process sync;
end architecture register32ena;