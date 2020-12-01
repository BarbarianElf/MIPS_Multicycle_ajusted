library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ALU_CONTROL_tb is
end entity ALU_CONTROL_tb;

architecture ALU_CONTROL_tb of ALU_CONTROL_tb is
--input signals
signal F: std_logic_vector(5 downto 0);
signal ALUOp: std_logic_vector(1 downto 0);
--output signals
signal operation: std_logic_vector (3 downto 0);

begin
	t1: entity work.ALU_CONTROL
	port map (
			  F         => F,
	          ALUOp     => ALUOp,
			  operation => operation
			);
			  
	p1: process is
	begin
		-- ALUOp for R-type commands
		ALUOp <= "10";
		-- for AND is 36
		F     <= "100100";
		wait for 40 ns;
		-- for OR is 37
		F     <= "100101";
		wait for 40 ns;
		-- for ADD is 32
		F     <= "100000";
		wait for 40 ns;
		-- for SUB is 34
		F     <= "100010";
		wait for 40 ns;
		-- for SLT is 42
		F     <= "101010";
		wait for 40 ns;
		-- for SLL is 0
		F     <= "000000";
		wait for 40 ns;
		-- for SRL is 2
		F     <= "000010";
		wait for 40 ns;
		-- ALUOp for I-type commands
		-- F DON'T CARE!
		-- LW/SW
		ALUOp <= "00";  -- ADD
		wait for 40 ns;
		-- BEQ
		ALUOp <= "01";  -- SUB
		wait for 40 ns;
		wait;
	end process p1;
end architecture ALU_CONTROL_tb;