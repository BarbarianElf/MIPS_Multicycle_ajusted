library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MIPS_MULTICYCLE_tb is
end entity MIPS_MULTICYCLE_tb;

architecture MIPS_MULTICYCLE_tb of MIPS_MULTICYCLE_tb is

constant clock_period: time := 40 ns;

--sync signals
signal clk: std_logic := '0';
signal rst: std_logic := '1';
		  
begin
	t1: entity work.MIPS_MULTICYCLE
	port map (
			  clk => clk,
			  rst => rst
			);
	
	clk <= not clk after clock_period / 2;
	
	p1: process is
	begin
		rst <= '0';
		wait for 10 ns;
		rst <= '1';
		-- sll $8, $8, 30
		-- slt $10, $9, $8 (START OF loop1)
		-- beq $10, $0 , loop2
		-- srl $8, $8, 2
		-- j to loop1
		-- beq $8, $0, end (START OF loop2)
		-- add $11, $12, $8
		-- slt $10, $9, $11
		-- beq $10, $0, else
		-- srl $12, $12, 1
		-- j to loopEnd
		-- sub $9, $9, $11 (START OF else)
		-- srl $12, $12, 1
		-- add $12, $12, $8
		-- srl $8, $8, 2 (START OF loopEnd)
		-- j to loop2
		-- add $2, $1, $1 (just for add)
		wait;
	end process p1;
end architecture MIPS_MULTICYCLE_tb;