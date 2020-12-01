library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signEx_tb is
end entity signEx_tb;


architecture signEx_tb of signEx_tb is
signal a: std_logic_vector(15 downto 0);
signal b: std_logic_vector(31 downto 0);
begin
	t1: entity work.signEx
	port map (
			  a => a,
			  b => b
			);
			
	p1: process is
	begin
		a <= x"0000";
		wait for 40 ns;
		a <= x"00AA";
		wait for 40 ns;
		a <= x"F000";
		wait for 40 ns;
		wait;
	end process p1;
end architecture signEx_tb;