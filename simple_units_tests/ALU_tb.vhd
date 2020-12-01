library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ALU_tb is
end entity ALU_tb;

architecture ALU_tb of ALU_tb is

constant clock_period: time := 40 ns;

--input signals
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);
signal alu_control: std_logic_vector(3 downto 0);
signal shamt      : std_logic_vector(4 downto 0);
--output signals
signal alu_result: std_logic_vector (31 downto 0);
signal zero: std_logic;

begin
	t1: entity work.ALU
	port map (
			  a           => a,
	          b           => b,
			  shamt		  => shamt,
			  alu_control => alu_control,
			  alu_result  => alu_result,
			  zero        => zero
			);
	
	clk <= not clk after clock_period / 2;
	
	p1: process is
	begin
		a			<= x"00000008";
		b			<= x"0000000F";
		wait for 40 ns;
		-- alu_control for AND
		alu_control	<= x"0";
		wait for 40 ns;
		-- alu_control for OR
		alu_control	<= x"1";
		wait for 40 ns;
		-- alu_control for ADD
		alu_control	<= x"2";
		wait for 40 ns;
		-- alu_control for SUB
		alu_control	<= x"6";
		wait for 40 ns;
		-- alu_control for SLT
		alu_control	<= x"7";
		wait for 40 ns;
		-- alu_control for zero flag
		a			<= x"0000000F";
		b			<= x"0000000F";
		alu_control	<= x"6";
		wait for 40 ns;
		-- shift by 4
		shamt       <= "00100";
		-- alu_control for SLL
		-- A DON'T CARE
		b			<= x"000000F0";
		alu_control	<= x"A";
		wait for 40 ns;
		-- alu_control for SRR
		-- A DON'T CARE
		alu_control	<= x"E";
		wait;
	end process p1;
end architecture ALU_tb;