-------------------------------------------------------------------------------
--
-- Title       : instruction_buffer
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\instruction_buffer.vhd
-- Generated   : Tue Nov 28 14:29:47 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Instruction Buffer for Processor
--
-------------------------------------------------------------------------------

library IEEE;
library std;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;  
use work.inst_buf_array.all;
use std.textio.all;


entity instruction_buffer is
	port(
		clk : in std_logic;
		reset : in std_logic;
		
	 	inst_out : out std_logic_vector(24 downto 0)
	    );
end instruction_buffer;

architecture behavioral of instruction_buffer is

begin
	
	instruction_buffer : process(clk) is 
		variable PC : integer := 0;
	begin
	
		if reset = '0' then
		  	PC := 0;
		else 	
			if rising_edge(clk) then 
				
--				if PC > 63 then			 								-- stops at 64 cycles
--					std.env.finish;
--				end if;	
--				
--				inst_out <= sig_inst_buf(PC); 
--				PC := PC + 1;

	
				if PC > 63 then									 		-- keeps going
					null; 
				else 
					inst_out <= sig_inst_buf(PC); 
					PC := PC + 1;
				end if;	
	
				
			end if;
		end if;

	end process instruction_buffer;	

end behavioral;
