-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : CONTROL_UNIT.vhd
-- Author     : Ziv
-- Created    : 09-08-2020
-- Last update: 21-08-2013
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity CONTROL_UNIT is
	port (
		  op			: in  std_logic_vector (5 downto 0);
		  rst			: in  std_logic;
		  clk			: in  std_logic;
		  pc_write_cond	: out std_logic;
		  pc_write		: out std_logic;
		  i_or_d		: out std_logic;
		  mem_read		: out std_logic;
		  mem_write		: out std_logic;
		  mem_to_reg	: out std_logic;
		  ir_write		: out std_logic;
		  reg_dst		: out std_logic;
		  reg_write		: out std_logic;
		  alu_src_a		: out std_logic;
		  alu_src_b		: out std_logic_vector (1 downto 0);
		  alu_op		: out std_logic_vector (1 downto 0);
		  pc_source		: out std_logic_vector (1 downto 0)
	    );
end entity CONTROL_UNIT;

architecture CONTROL_UNIT of CONTROL_UNIT is
	signal current_state : std_logic_vector (3 downto 0);
begin

	unsync: process(current_state)
	begin
		case current_state is
			-- decode and register fetch
			when "0001" =>
				pc_write_cond <= '0'; 
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '0';
				alu_src_b     <= "11";
				alu_op        <= "00";
				pc_source     <= "00";
			-- memory address computation
			when "0010" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '1';
				alu_src_b     <= "10";
				alu_op        <= "00";
				pc_source     <= "00";
			-- lw memory access
			when "0011" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '1';
				mem_read      <= '1';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '0';
				alu_src_b     <= "00";
				alu_op        <= "00";
				pc_source     <= "00";
			-- lw memory read completion step (write back)
			when "0100" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '1';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '1';
				alu_src_a     <= '0';
				alu_src_b     <= "00";
				alu_op        <= "00";
				pc_source     <= "00";
			-- sw memory access
			when "0101" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '1';
				mem_read      <= '0';
				mem_write     <= '1';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '0';
				alu_src_b     <= "00";
				alu_op        <= "00";
				pc_source     <= "00";
			-- R-type execution
			when "0110" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '1';
				alu_src_b     <= "00";
				alu_op        <= "10";
				pc_source     <= "00";
			-- R-type completion
			when "0111" =>
				pc_write_cond <= '0';
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '1';
				reg_write     <= '1';
				alu_src_a     <= '0';
				alu_src_b     <= "00";
				alu_op        <= "00";
				pc_source     <= "00";
			-- BEQ completion
			when "1000" =>
				pc_write_cond <= '1';
				pc_write      <= '0';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '1';
				alu_src_b     <= "00";
				alu_op        <= "01";
				pc_source     <= "01";
			-- Jump completion
			when "1001" =>
				pc_write_cond <= '0';
				pc_write      <= '1';
				i_or_d        <= '0';
				mem_read      <= '0';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '0';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '0';
				alu_src_b     <= "00";
				alu_op        <= "00";
				pc_source     <= "10";
			-- instruction fetch
			when others =>
				pc_write_cond <= '0';
				pc_write      <= '1';
				i_or_d        <= '0';
				mem_read      <= '1';
				mem_write     <= '0';
				mem_to_reg    <= '0';
				ir_write      <= '1';
				reg_dst       <= '0';
				reg_write     <= '0';
				alu_src_a     <= '0';
				alu_src_b     <= "01";
				alu_op        <= "00";
				pc_source     <= "00";
		end case;
	end process unsync;
	
	sync: process(clk, rst)
	begin
		if (rst = '0') then
			current_state <= (others => '0');
		elsif  rising_edge(clk) then
			case current_state is
				--if i-fetch (then 1)
				when "0000" =>
				current_state <= "0001";
				when "0001" =>
					--if lw/sw (then 2)
					if (op = "100011" or op = "101011") then
						current_state <= "0010";
					--if R-type (then 6)
					elsif (op = "000000") then
						current_state <= "0110";
					--if BEQ (then 8)
					elsif (op = "000100") then
						current_state <= "1000";
					--if Jump (then 9)
					elsif (op = "000010") then
						current_state <= "1001";
					end if;
				when "0010" =>
					--if lw (then 3)
					if (op = "100011") then
						current_state <= "0011";
					--if sw (then 5)
					elsif (op = "101011") then
						current_state <= "0101";
					end if;
				--if mem_acess of lw (if 3 then 4)
				when "0011" =>
					current_state <= "0100";
				--if exe of r-type (if 6 then 7)
				when "0110" =>
					current_state <= "0111";
				--if memroy read lw (if 4 then 0)
				--if mem_acess of sw (if 5 then 0)
				--if r-type completion (if 7 then 0)
				--if branch completion (if 8 then 0)
				--if jump completion (if 9 then 0)
				when others =>
					current_state <= "0000";
			end case;
		end if;
	end process sync;
end architecture CONTROL_UNIT;