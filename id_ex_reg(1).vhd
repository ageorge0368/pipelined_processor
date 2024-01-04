-------------------------------------------------------------------------------
--
-- Title       : ID_EX_reg
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\ID_EX_reg.vhd
-- Generated   : Tue Nov 28 15:05:24 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : ID/EXE Buffer for Processor.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity ID_EX_reg is
	 port(
	 	 clk : in std_logic;
	 	 
		 reset : in std_logic;
		  
	 	 inst_in : in STD_LOGIC_VECTOR(24 downto 0);
		 val_1 : in STD_LOGIC_VECTOR(127 downto 0);
		 val_2 : in STD_LOGIC_VECTOR(127 downto 0);
		 val_3 : in STD_LOGIC_VECTOR(127 downto 0);		 
		 
		 inst_out : out STD_LOGIC_VECTOR(24 downto 0);
		 val_1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 val_2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 val_3_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ID_EX_reg;

architecture behavioral of ID_EX_reg is	 

begin

	id_ex_buffer : process(clk)	is	
		variable results_line : line;
	
	begin
		if reset = '1' then
			if (rising_edge(clk)) then
				inst_out <= inst_in;
				val_1_out <= val_1;
				val_2_out <= val_2;
				val_3_out <= val_3;
			
			end if;	
		end if;
	end process id_ex_buffer;	

end behavioral;
