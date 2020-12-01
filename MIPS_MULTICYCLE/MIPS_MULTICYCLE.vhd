-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : MIPS_MULTICYCLE.vhd
-- Author     : Ziv
-- Created    : 16-08-2020
-- Last update: 21-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity MIPS_MULTICYCLE is
	port (
		  rst	: in  std_logic;
		  clk	: in  std_logic
	    );
end entity MIPS_MULTICYCLE;

architecture MIPS_MULTICYCLE of MIPS_MULTICYCLE is
	signal pc_next, pc_crnt, address, mem_data, mdr, i_reg       : std_logic_vector (31 downto 0);
	signal a, reg_a, b, reg_b, alu_result, alu_out, wr_data      : std_logic_vector (31 downto 0);
	signal sl2_out_j, sl2_out_b, se_out, alu_a, alu_b, j_address : std_logic_vector (31 downto 0);
	signal wr_reg : std_logic_vector (4 downto 0);
	signal zero   : std_logic;
	-- control signals
	signal pc_write_cond, pc_write, pc_ena, i_or_d, mem_read, mem_write : std_logic;
	signal mem_to_reg, ir_write, reg_dst, reg_write, alu_src_a          : std_logic;
	signal alu_src_b, alu_op, pc_source : std_logic_vector (1 downto 0);
	signal operation                    : std_logic_vector (3 downto 0);	
begin
	
	j_address(27 downto 0)  <= sl2_out_j(27 downto 0);
	j_address(31 downto 28) <= pc_crnt(31 downto 28);
	
	pc_ena <= (zero and pc_write_cond) or pc_write;
	
	control: entity work.CONTROL_UNIT
	port map (
			  pc_write_cond => pc_write_cond,
			  pc_write      => pc_write,
			  i_or_d        => i_or_d,
			  mem_read      => mem_read,
			  mem_write     => mem_write,
			  mem_to_reg    => mem_to_reg,
			  ir_write      => ir_write,
			  reg_dst       => reg_dst,
			  reg_write     => reg_write,
			  alu_src_a     => alu_src_a,
			  alu_src_b     => alu_src_b,
			  alu_op        => alu_op,
			  pc_source     => pc_source,
			  clk           => clk,
			  rst           => rst,
			  op            => i_reg(31 downto 26)
			);
			
	pc_reg: entity work.register32ena
	port map(
			input   => pc_next,
			ena     => pc_ena,
			clk     => clk,
			rst     => rst,
			output  => pc_crnt
			);
			
	mux_address: entity work.mux2to1
	port map(
			input0 => pc_crnt,
			input1 => alu_out,
			sel    => i_or_d,
			output => address
			);
			
	memory_file: entity work.memoryfile
	port map(
			address   => address,
			wr_data   => reg_b,
			mem_read  => mem_read,
			mem_write => mem_write,
			clk       => clk,
			mem_data  => mem_data
			);
	
	ins_reg: entity work.register32ena
	port map(
			input   => mem_data,
			ena     => ir_write,
			clk     => clk,
			rst     => rst,
			output  => i_reg
			);
	
	mdr_reg: entity work.register32ena
	port map(
			input   => mem_data,
			ena     => '1',
			clk     => clk,
			rst     => rst,
			output  => mdr
			);
			
	mux_w_reg: entity work.mux2to1reg
	port map(
			input0 => i_reg(20 downto 16), --rt
			input1 => i_reg(15 downto 11), --rd
			sel    => reg_dst,
			output => wr_reg
			);

	mux_w_data: entity work.mux2to1
	port map(
			input0 => alu_out,
			input1 => mdr,
			sel    => mem_to_reg,
			output => wr_data
			);
	
	registers_file: entity work.registersfile
	port map(
			 rd_reg1   => i_reg(25 downto 21), --rs
			 rd_reg2   => i_reg(20 downto 16), --rt
			 wr_reg    => wr_reg,
			 wr_data   => wr_data,
			 reg_write => reg_write,
			 clk       => clk,
			 rst       => rst,
			 rd_data1  => a,
			 rd_data2  => b
			);
	
	a_reg: entity work.register32ena
	port map(
			input   => a,
			ena     => '1',
			clk     => clk,
			rst     => rst,
			output  => reg_a
			);
	
	b_reg: entity work.register32ena
	port map(
			input   => b,
			ena     => '1',
			clk     => clk,
			rst     => rst,
			output  => reg_b
			);
	
	shiftLeft_j: entity work.shiftLeft2
	port map(
			a => i_reg,
			b => sl2_out_j
			);
			
	shiftLeft_b: entity work.shiftLeft2
	port map(
			a => se_out,
			b => sl2_out_b
			);
			
	SignExtend: entity work.SignEx
	port map(
			a => i_reg(15 downto 0),
			b => se_out
			);
	
	mux_alu_a: entity work.mux2to1
	port map(
			input0 => pc_crnt,
			input1 => reg_a,
			sel    => alu_src_a,
			output => alu_a
			);
	
	mux_alu_b: entity work.mux4to1
	port map(
			input0 => reg_b,
			input1 => x"00000004",
			input2 => se_out,
			input3 => sl2_out_b,
			sel    => alu_src_b,
			output => alu_b
			);
	
	alu_control: entity work.ALU_CONTROL
	port map(
			 F         => i_reg(5 downto 0),
			 ALUOp     => alu_op,
			 operation => operation
			);
	
	alu: entity work.ALU
	port map(
			 a            => alu_a,
			 b            => alu_b,
			 shamt        => i_reg(10 downto 6),
			 alu_control  => operation,
			 alu_result   => alu_result,
			 zero         => zero
			);

	alu_out_reg: entity work.register32ena
	port map(
			 input   => alu_result,
			 ena     => '1',
			 clk     => clk,
			 rst     => rst,
			 output  => alu_out
			);
	
	mux_pc_next: entity work.mux4to1
	port map(
			input0 => alu_result,
			input1 => alu_out,
			input2 => j_address,
			input3 => x"00000000", --no input here
			sel    => pc_source,
			output => pc_next
			);
			
end architecture MIPS_MULTICYCLE;