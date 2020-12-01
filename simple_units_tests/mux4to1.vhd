-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : mux4to1.vhd
-- Author     : Ziv
-- Created    : 04-08-2020
-- Last update: 04-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4to1 is
	port (
		  input0 : in  std_logic_vector (31 downto 0);
		  input1 : in  std_logic_vector (31 downto 0);
		  input2 : in  std_logic_vector (31 downto 0);
		  input3 : in  std_logic_vector (31 downto 0);
		  sel    : in  std_logic_vector (1 downto 0);
		  output : out std_logic_vector (31 downto 0)
		);
end entity mux4to1;

architecture mux4to1 of mux4to1 is
begin
	process (sel, input0, input1, input2, input3)
	begin
		case sel is
			when "00" =>
				output <= input0;
			when "01" =>
				output <= input1;
			when "10" =>
				output <= input2;
			when "11" =>
				output <= input3;
			when others => NULL;
		end case;
	end process;
end architecture mux4to1;