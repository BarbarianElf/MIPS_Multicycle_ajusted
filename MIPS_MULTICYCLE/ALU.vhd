-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : ALU.vhd
-- Author     : Ziv
-- Created    : 07-08-2020
-- Last update: 21-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
	port (
		  a            : in  std_logic_vector (31 downto 0);
		  b            : in  std_logic_vector (31 downto 0);
		  shamt        : in  std_logic_vector (4 downto 0);
		  alu_control  : in  std_logic_vector (3 downto 0);
		  alu_result   : out std_logic_vector (31 downto 0);
		  zero         : out std_logic
	    );
end entity ALU;

architecture ALU of ALU is
	signal result : std_logic_vector (31 downto 0);
	--signal shift : unsigned (4 downto 0);
	
begin

	unsync: process (a, b, alu_control)
	begin
		case alu_control is
				-- Bitwise and
			when "0000" =>
				result <= a AND b;
				-- Bitwise or
			when "0001" =>
				result <= a OR b;
				-- addition
			when "0010" =>
				result <= std_logic_vector(signed(a) + signed(b));
				-- subtract
			when "0110" =>
				result <= std_logic_vector(signed(a) - signed(b));
				-- set less than
			when "0111" =>
				if (signed(a) < signed(b)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
				-- shift left logical
			when "1010" =>
				result <= std_logic_vector(shift_left(signed(b),to_integer(unsigned(shamt))));
				-- shift right logical
			when "1110" =>
				result <= std_logic_vector(shift_right(signed(b),to_integer(unsigned(shamt))));
			when others => NULL;
			result <= x"00000000";
		end case;
	end process unsync;
	
	-- concurrent code
	alu_result <= result;
	zero <= '1' when result = x"00000000" else
	        '0';
end architecture ALU;