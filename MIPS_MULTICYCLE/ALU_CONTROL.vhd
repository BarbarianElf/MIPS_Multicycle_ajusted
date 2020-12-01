library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ALU_CONTROL is
	port (
		  F         : in  std_logic_vector (5 downto 0);
		  ALUOp     : in  std_logic_vector (1 downto 0);
		  operation : out std_logic_vector (3 downto 0)
	    );
end entity ALU_CONTROL;

architecture ALU_CONTROL of ALU_CONTROL is
	
begin
	operation(3) <= not F(5) and  ALUOp(1);
	operation(2) <= ALUOp(0) or (ALUOp(1) and F(1));
	operation(1) <= not ALUOp(1) or not F(2);
	operation(0) <= (F(3) or F(0)) and ALUOp(1);
end architecture ALU_CONTROL;