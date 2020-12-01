library IEEE;
use IEEE.std_logic_1164.all;

entity mux4to1_tb is
end entity mux4to1_tb;

architecture mux4to1_tb of mux4to1_tb is
signal input0: std_logic_vector (31 downto 0);
signal input1: std_logic_vector (31 downto 0);
signal input2: std_logic_vector (31 downto 0);
signal input3: std_logic_vector (31 downto 0);
signal output: std_logic_vector (31 downto 0);
signal sel   : std_logic_vector (1 downto 0);
begin
	t1: entity work.mux4to1
	port map (
			  input0 => input0,
			  input1 => input1,
			  input2 => input2,
			  input3 => input3,
			  sel    => sel,
			  output => output
			);
			
	p1: process is
	begin
		input0 <= x"00000001";
		input1 <= x"00000002";
		input2 <= x"00000003";
		input3 <= x"00000004";
		sel <= "00";
		wait for 40 ns;
		sel <= "11";
		wait for 40 ns;
		sel <= "01";
		wait for 40 ns;
		sel <= "10";
		wait for 40 ns;
		wait;
	end process p1;
end architecture mux4to1_tb;