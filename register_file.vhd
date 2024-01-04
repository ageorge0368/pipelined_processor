-------------------------------------------------------------------------------
--
-- Title       : register_file
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\register_file.vhd
-- Generated   : Fri Nov 24 14:39:02 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Register File for 4-Cycle Pipelined Processor. 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	 port(
	 	 val_out : in STD_LOGIC_VECTOR(127 downto 0);	 		-- value that we are writing to a register
	 	 write_enable : in std_logic;	  						-- writing binary signal 
		 write_addr : in std_logic_vector(4 downto 0);			-- address of write-back register (rd)
	 
	 	 inst : in std_logic_vector(24 downto 0);			-- IF/ID Reg (will pass inst to ALU)
		  
		 val_1 : out STD_LOGIC_VECTOR(127 downto 0);		-- val from rs1
		 val_2 : out STD_LOGIC_VECTOR(127 downto 0);		-- val from rs2
		 val_3 : out STD_LOGIC_VECTOR(127 downto 0)			-- val from rs3
	     );
end register_file;

--}} End of automatically maintained section

architecture behavioral of register_file is

	type reg_file is array (0 to 31) of std_logic_vector(127 downto 0);	  			-- reg_file array
	signal sig_reg_file : reg_file := (others => (others => '0'));		   			-- initializing all elements to 0

begin

	register_file : process(write_enable, inst, val_out) is
	begin 
		if write_enable = '1' then	   					
			sig_reg_file(to_integer(unsigned(write_addr))) <= val_out; -- writing to register file
		end if;
		

		if inst(24) = '0' then													   	-- li instruction
			val_1 <= sig_reg_file(to_integer(unsigned(inst(4 downto 0))));				-- rd
																	-- *** val_1 => rs1, val_1 => rd (in port_map to ALU)	
		else
			-- reading from register file
			val_1 <= sig_reg_file(to_integer(unsigned(inst(9 downto 5))));			-- rs1
			val_2 <= sig_reg_file(to_integer(unsigned(inst(14 downto 10))));		-- rs2
			val_3 <= sig_reg_file(to_integer(unsigned(inst(19 downto 15))));		-- rs3
			
		end if;
		
		if inst(9 downto 5) = write_addr then
			val_1 <= val_out;
		elsif inst(14 downto 10) = write_addr then
			val_2 <= val_out;
		elsif inst(19 downto 15) = write_addr and inst(24 downto 23) = "10" then
			val_3 <= val_out;
		end if;
		
	end process register_file;
	 

end behavioral;
