library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1reg is
	port (
		  input0 : in  std_logic_vector (4 downto 0);
		  input1 : in  std_logic_vector (4 downto 0);
		  sel    : in  std_logic;
		  output : out std_logic_vector (4 downto 0)
		);
end entity mux2to1reg;

architecture mux2to1reg of mux2to1reg is
begin
	process (sel, input0, input1)
	begin
		case sel is
			when '0' =>
				output <= input0;
			when '1' =>
				output <= input1;
			when others => NULL;
		end case;
	end process;
end architecture mux2to1reg;