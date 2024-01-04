-------------------------------------------------------------------------------
--
-- Title       : FWD
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\data_forwarding_unit.vhd
-- Generated   : Tue Nov 28 15:36:37 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : FWD Unit for Processor.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity FWD is
	 port(
		 inst_buff : in STD_LOGIC_VECTOR(24 downto 0);	  		-- coming from ID/EXE buffer
		 rd_WB_addr : in STD_LOGIC_VECTOR(4 downto 0);			-- coming from EXE/WB buffer
		 
		 reset : in std_logic;
		 
		 mux_signal : out STD_LOGIC_VECTOR(1 downto 0)			-- towards Forwarding Muxes
	     );
end FWD;

architecture behavioral of FWD is

	signal inst_UUU : std_logic_vector(24 downto 0) := (others => 'U');

begin
	
	FWD : process(inst_buff, rd_WB_addr, reset) is
	begin	
		
		if reset = '0' or inst_buff = inst_UUU then
			mux_signal <= "00";	
			
		else
			if inst_buff(24) = '0' then
				if inst_buff(4 downto 0) = rd_WB_addr then		-- li instruction
					mux_signal <= "01";
				else
					mux_signal <= "00";
				end if;
			elsif inst_buff(9 downto 5) = rd_WB_addr then
				mux_signal <= "01";
			elsif inst_buff(14 downto 10) = rd_WB_addr then
				mux_signal <= "10";
			elsif inst_buff(19 downto 15) = rd_WB_addr and inst_buff(24 downto 23) = "10" then --R4 instruction data forwarding
				mux_signal <= "11";
			else
				mux_signal <= "00";
			end if;
		end if;
		
	end process FWD;
	
end behavioral;
