library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1_tb is
end entity mux2to1_tb;

architecture mux2to1_tb of mux2to1_tb is
signal input0: std_logic_vector (31 downto 0);
signal input1: std_logic_vector (31 downto 0);
signal output: std_logic_vector (31 downto 0);
signal sel   : std_logic;
begin
	t1: entity work.mux2to1
	port map (
			  input0 => input0,
			  input1 => input1,
			  sel    => sel,
			  output => output
			);
			
	p1: process is
	begin
		input0 <= x"0000ffff";
		input1 <= x"0000A00F";
		sel <= '0';
		wait for 40 ns;
		sel <= '1';
		wait for 40 ns;
		wait;
	end process p1;
end architecture mux2to1_tb;