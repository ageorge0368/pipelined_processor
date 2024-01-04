-------------------------------------------------------------------------------
--
-- Title       : IF_ID_reg
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\IF_ID_reg.vhd
-- Generated   : Tue Nov 28 14:53:57 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  IF/ID Buffer for Processor.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID_reg is
	 port(
		 inst_in : in STD_LOGIC_VECTOR(24 downto 0);
		 clk : in STD_LOGIC;
		 reset : in std_logic;
		 
		 inst_out : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end IF_ID_reg;

--}} End of automatically maintained section

architecture behavioral of IF_ID_reg is
begin

	if_id_buffer : process(clk)	is
	begin
		if reset = '1' then
			if (rising_edge(clk)) then
				inst_out <= inst_in;
			end if;	
		end if;
	end process if_id_buffer;

end behavioral;
