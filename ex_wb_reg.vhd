-------------------------------------------------------------------------------
--
-- Title       : EX_WB_reg
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\EX_WB_reg.vhd
-- Generated   : Tue Nov 28 15:15:55 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : EX/WB Buffer for Processor.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_WB_reg is
	 port(
	 	 clk : in std_logic;
	 	 
		 reset : in std_logic; 
		  
		 inst : in STD_LOGIC_VECTOR(24 downto 0);
		 rd_in : in STD_LOGIC_VECTOR(127 downto 0);
		 
		 write_addr : out STD_LOGIC_VECTOR(4 downto 0);
		 write_enable : out STD_LOGIC;
		 rd_out : out STD_LOGIC_VECTOR(127 downto 0) := (others => '0')
	     );
end EX_WB_reg;


architecture behavioral of EX_WB_reg is

	signal inst_UUU : std_logic_vector(24 downto 0) := (others => 'U');

begin

	ex_wb_buffer : process(clk)	is 
	begin 
		if reset = '0' then
			write_enable <= '0';
		
		elsif (rising_edge(clk)) then
			if inst(24 downto 23) = "11" and inst(18 downto 15) = "0000" then
				write_enable <= '0';						-- nop case
				
			elsif inst = inst_UUU then
				write_enable <= '0';
				
			else	
				write_enable <= '1';						-- everything else	
				rd_out <= rd_in;
				write_addr <= inst(4 downto 0);
			end if;
		end if;

	end process ex_wb_buffer;		

end behavioral;
