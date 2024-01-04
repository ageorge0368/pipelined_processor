-------------------------------------------------------------------------------
--
-- Title       : FWD_mux
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\forwarding_mux.vhd
-- Generated   : Tue Nov 28 15:43:38 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  Forwarding muxes for Processor. 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity FWD_mux is
	 port(
		 val_1 : in STD_LOGIC_VECTOR(127 downto 0);
		 val_2 : in STD_LOGIC_VECTOR(127 downto 0);
		 val_3 : in STD_LOGIC_VECTOR(127 downto 0);
		 val_out : in STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
		 
		 mux_signal : in STD_LOGIC_VECTOR(1 downto 0) := "00";
		 
		 rs1 : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : out STD_LOGIC_VECTOR(127 downto 0);
		 rd : out std_logic_vector(127 downto 0)
	     );
end FWD_mux;

architecture behavioral of FWD_mux is
begin
	
	FWD_mux : process(mux_signal, val_out) is
	begin	
		
		if mux_signal = "01" then
			rs1 <= val_out;
			rs2 <= val_2;
			rs3 <= val_3;
		elsif mux_signal = "10" then
			rs1 <= val_1;
			rs2 <= val_out;
			rs3 <= val_3; 
		elsif mux_signal = "11" then
			rs1 <= val_1;
			rs2 <= val_2;
			rs3 <= val_out;
		else
			rs1 <= val_1;
			rs2 <= val_2;
			rs3 <= val_3;
		end if;
		
	end process FWD_mux;

end behavioral;
