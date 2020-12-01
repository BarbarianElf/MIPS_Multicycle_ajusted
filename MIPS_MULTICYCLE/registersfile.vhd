-------------------------------------------------------------------------------
---- Project    : MIPS Multicycle 32bit
-------------------------------------------------------------------------------
-- File       : registersfile.vhd
-- Author     : Ziv
-- Created    : 08-08-2020
-- Last update: 20-08-2020
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity registersfile is
	port (
		  rd_reg1  : in  std_logic_vector (4 downto 0);
		  rd_reg2  : in  std_logic_vector (4 downto 0);
		  wr_reg   : in  std_logic_vector (4 downto 0);
		  wr_data  : in  std_logic_vector (31 downto 0);
		  reg_write: in  std_logic;
		  clk      : in  std_logic;
		  rst      : in  std_logic;
		  rd_data1 : out std_logic_vector (31 downto 0);
		  rd_data2 : out std_logic_vector (31 downto 0)
	    );
end entity registersfile;

architecture registersfile of registersfile is
	type reg_file is array (natural range <>) of std_logic_vector(31 downto 0);
	
	signal bor : reg_file(0 to 31);
	
begin
	--concurrnet code
	rd_data1 <= bor(conv_integer(rd_reg1));
	rd_data2 <= bor(conv_integer(rd_reg2));
	
	sync: process(clk, rst)
	begin
		if (rst = '0') then
			bor <= (
					1      => x"00000001",
					8      => x"00000001",
					9      => x"00000064",
					others => x"00000000");
		elsif  rising_edge(clk) then
			if (reg_write = '1') then
				bor(conv_integer(wr_reg)) <= wr_data;
			end if;
		end if;
	end process sync;
	
end architecture registersfile;