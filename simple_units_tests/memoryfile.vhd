library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity memoryfile is
	port (
		  address  : in  std_logic_vector (31 downto 0);
		  wr_data  : in  std_logic_vector (31 downto 0);
		  mem_read : in  std_logic;
		  mem_write: in  std_logic;
		  clk      : in  std_logic;
		  mem_data : out std_logic_vector (31 downto 0)
	    );
end entity memoryfile;

architecture memoryfile of memoryfile is
	type reg_file is array (natural range <>) of std_logic_vector(31 downto 0);
	
	signal memory      : reg_file(0 to 255):=
	(0  => x"00084780", -- sll $8, $8, 30
	 1  => x"0128502A", -- slt $10, $9, $8 (START OF loop1)
	 2  => x"11400002", -- beq $10, $0 , loop2
	 3  => x"00084082", -- srl $8, $8, 2
	 4  => x"08000001", -- j to loop1
	 5  => x"1100000A", -- beq $8, $0, end (START OF loop2)
	 6  => x"01885820", -- add $11, $12, $8
	 7  => x"012B502A", -- slt $10, $9, $11
	 8  => x"11400002", -- beq $10, $0, else
	 9  => x"000C6042", -- srl $12, $12, 1
	 10 => x"0800000E", -- j to loopEnd
	 11 => x"012B4822", -- sub $9, $9, $11 (START OF else)
	 12 => x"000C6042", -- srl $12, $12, 1
	 13 => x"01886020", -- add $12, $12, $8
	 14 => x"00084082", -- srl $8, $8, 2 (START OF loopEnd)
	 15 => x"08000005", -- j to loop2
	 16 => x"00211020", -- add $2, $1, $1 (just for add)
	 others=> x"0000000a");
	
begin
	usync: process(mem_read, address)
	begin
		if (mem_read = '1') then
			mem_data <= memory(conv_integer(address(9 downto 2)));
		else
			mem_data <= (others => '0');
		end if;
	end process usync;
	
	sync: process(clk, mem_write)
	begin
		if  rising_edge(clk) and (mem_write = '1') then
			memory(conv_integer(address(9 downto 2))) <= wr_data;
		end if;
	end process sync;
end architecture memoryfile;