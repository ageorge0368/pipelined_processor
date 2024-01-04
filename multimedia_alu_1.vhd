-------------------------------------------------------------------------------
--
-- Title       : multimedia_ALU
-- Design      : multimedia_ALU
-- Author      : Alan George and Matt Leo
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\multimedia_ALU.vhd
-- Generated   : Sun Oct 22 15:15:51 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Entire ALU computation for LI, R3 and R4 instructions. Takes in registers 
-- rs1, rs2, rs3, and rd as inputs, along with inst bit-vector for instruction representation.
-- Output is register rd; all registers are represented by 128-bit vector. 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {multimedia_ALU} architecture {behavior}}

library IEEE;
use IEEE.std_logic_1164.all;	 
use IEEE.numeric_std.all;

entity multimedia_ALU is
	 port(
		 rs1 : in std_logic_vector(127 downto 0) := (others => '0');
		 rs2 : in std_logic_vector(127 downto 0);
		 rs3 : in std_logic_vector(127 downto 0);
		 inst: in std_logic_vector(24 downto 0);
		 
		 rd : out std_logic_vector(127 downto 0)						-- should this be in/out?
	     );
end multimedia_ALU;

--}} End of automatically maintained section

architecture behavioral of multimedia_ALU is  
	
--	signal result : std_logic_vector(31 downto 0);
--	signal temp_reg : std_logic_vector(31 downto 0);	
	
--	signal long_result : std_logic_vector(63 downto 0) := (others => '0');
--	signal long_temp_reg : std_logic_vector(63 downto 0) := (others => '0');	
	
--	signal half_result : std_logic_vector(15 downto 0) := (others => '0');	  
	
--	signal xor_temp : std_logic_vector(15 downto 0) := (others => '0');
--	signal one : std_logic_vector(15 downto 0) := "0000000000000001";
begin

	behavior : process (rs1, rs2, rs3, inst) is
	-- any constants or variables? -- 
	variable count_0 : integer := 0;
	variable count_1 : integer := 0;
	variable count_2 : integer := 0;
	variable count_3 : integer := 0;
	variable count_4 : integer := 0;
	variable count_5 : integer := 0;
	variable count_6 : integer := 0;
	variable count_7 : integer := 0;	
	
	variable result : std_logic_vector(31 downto 0);
	variable temp_reg : std_logic_vector(31 downto 0);	
	
	variable long_result : std_logic_vector(63 downto 0) := (others => '0');
	variable long_temp_reg : std_logic_vector(63 downto 0) := (others => '0');	
	
	variable half_result : std_logic_vector(15 downto 0) := (others => '0');	  
	
	variable xor_temp : std_logic_vector(15 downto 0) := (others => '0');
	variable one : std_logic_vector(15 downto 0) := "0000000000000001";	
	
	variable inv : std_logic_vector(127 downto 0) := (others => '1');
	variable temp0 : std_logic_vector(31 downto 0) := (others => '0');
	variable temp1 : std_logic_vector(31 downto 0) := (others => '0');
	variable temp2 : std_logic_vector(31 downto 0) := (others => '0');
	variable temp3 : std_logic_vector(31 downto 0) := (others => '0');
	variable t0 : std_logic_vector(15 downto 0) := (others => '0');
	variable t1 : std_logic_vector(15 downto 0) := (others => '0');
	variable t2 : std_logic_vector(15 downto 0) := (others => '0');
	variable t3 : std_logic_vector(15 downto 0) := (others => '0');
	variable t4 : std_logic_vector(15 downto 0) := (others => '0');
	variable t5 : std_logic_vector(15 downto 0) := (others => '0');
	variable t6 : std_logic_vector(15 downto 0) := (others => '0');
	variable t7 : std_logic_vector(15 downto 0) := (others => '0');	  
	
--	variable long_max : std_logic_vector(63 downto 0) := "0111111111111111111111111111111111111111111111111111111111111111"; 
--	variable long_min : std_logic_vector(63 downto 0) := "1000000000000000000000000000000000000000000000000000000000000000";

	variable load_rs1 : std_logic_vector(127 downto 0) := (others => '0');

	begin
		-- first check last two bits to determine instruction type
		-- then do the computation
		if inst(24) = '0' then
			-- load immediate instruction --				
			
			load_rs1 := rs1; 

--			load_rs1 := (others => '0');
			
			if inst(23 downto 21) = "000" then		 		-- load index (do we read rd as an input?)
				load_rs1(15 downto 0) := inst(20 downto 5);  
			elsif inst(23 downto 21) = "001" then
				load_rs1(31 downto 16) := inst(20 downto 5);
			elsif inst(23 downto 21) = "010" then
				load_rs1(47 downto 32) := inst(20 downto 5);
			elsif inst(23 downto 21) = "011" then
				load_rs1(63 downto 48) := inst(20 downto 5);
			elsif inst(23 downto 21) = "100" then
				load_rs1(79 downto 64) := inst(20 downto 5);
			elsif inst(23 downto 21) = "101" then
				load_rs1(95 downto 80) := inst(20 downto 5);
			elsif inst(23 downto 21) = "110" then
				load_rs1(111 downto 96) := inst(20 downto 5);
			else 
				load_rs1(127 downto 112) := inst(20 downto 5);
			end if;	
			
			rd <= load_rs1;

			
		elsif inst(24 downto 23) = "10" then 
			-- R4 instructions --
			if inst(22 downto 20) = "000" then		--Signed Integer Multiply-Add Low with Saturation 		
				-- Multiply low 16-bit fields											-- SIMALwS 
				
				temp_reg := std_logic_vector(signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))); 
				result := std_logic_vector((signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))) + signed(rs1(31 downto 0))); 
				
				if (rs1(31) = '0' and temp_reg(31) = '0' and result(31) = '1') then	-- overflow
					rd(31 downto 0) <= "01111111111111111111111111111111";
				elsif ((rs1(31) = '1' and temp_reg(31) = '1' and result(31) = '0') or (rs1(31) = '1' and temp_reg(31) = '1' and result(31) = '1')) then -- underflow
					rd(31 downto 0) <= "10000000000000000000000000000000";
				else
					rd(31 downto 0) <= std_logic_vector((signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))) + signed(rs1(31 downto 0)));
--					result; 																								
				end if;
				
				
				temp_reg := std_logic_vector(signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))); 
				result := std_logic_vector((signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))) + signed(rs1(63 downto 32)));
				
				if (rs1(63) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(63 downto 32) <= "01111111111111111111111111111111";
				elsif ((rs1(63) = '1' and temp_reg(31) = '1' and result(31) = '0') or (rs1(63) = '1' and temp_reg(31) = '1' and result(31) = '1')) then
					rd(63 downto 32) <= "10000000000000000000000000000000";
				else
					rd(63 downto 32) <= std_logic_vector((signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))) + signed(rs1(63 downto 32))); 																								
				end if;
				
								
				temp_reg := std_logic_vector(signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))); 
				result := std_logic_vector((signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))) + signed(rs1(95 downto 64)));
				
				if (rs1(95) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(95 downto 64) <= "01111111111111111111111111111111";
				elsif ((rs1(95) = '1' and temp_reg(31) = '1' and result(31) = '0') or (rs1(95) = '1' and temp_reg(31) = '1' and result(31) = '1')) then
					rd(95 downto 64) <= "10000000000000000000000000000000";
				else
					rd(95 downto 64) <= std_logic_vector((signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))) + signed(rs1(95 downto 64))); 																								
				end if;
				
												
				temp_reg := std_logic_vector(signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))); 
				result := std_logic_vector((signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))) + signed(rs1(127 downto 96)));
				
				if (rs1(127) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(127 downto 96) <= "01111111111111111111111111111111";
				elsif ((rs1(127) = '1' and temp_reg(31) = '1' and result(31) = '0') or (rs1(127) = '1' and temp_reg(31) = '1' and result(31) = '1')) then
					rd(127 downto 96) <= "10000000000000000000000000000000";
				else
					rd(127 downto 96) <= std_logic_vector((signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))) + signed(rs1(127 downto 96))); 																								
				end if;
				
				
			elsif inst(22 downto 20) = "001" then	 --Signed Integer Multiply-Add High with Saturation 
				
				temp_reg := std_logic_vector(signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))); 
				result := std_logic_vector((signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))) + signed(rs1(31 downto 0))); 
				
				if (rs1(31) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(31 downto 0) <= "01111111111111111111111111111111";
				elsif (rs1(31) = '1' and temp_reg(31) = '1' and result(31) = '0') then
					rd(31 downto 0) <= "10000000000000000000000000000000";
				else
					rd(31 downto 0) <= std_logic_vector((signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))) + signed(rs1(31 downto 0))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))); 
				result := std_logic_vector((signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))) + signed(rs1(63 downto 32)));
				
				if (rs1(63) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(63 downto 32) <= "01111111111111111111111111111111";
				elsif (rs1(63) = '1' and temp_reg(31) = '1' and result(31) = '0') then
					rd(63 downto 32) <= "10000000000000000000000000000000";
				else
					rd(63 downto 32) <= std_logic_vector((signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))) + signed(rs1(63 downto 32))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))); 
				result := std_logic_vector((signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))) + signed(rs1(95 downto 64)));
				
				if (rs1(95) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(95 downto 64) <= "01111111111111111111111111111111";
				elsif (rs1(95) = '1' and temp_reg(31) = '1' and result(31) = '0') then
					rd(95 downto 64) <= "10000000000000000000000000000000";
				else
					rd(95 downto 64) <= std_logic_vector((signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))) + signed(rs1(95 downto 64))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))); 
				result := std_logic_vector((signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))) + signed(rs1(127 downto 96)));
				
				if (rs1(127) = '0' and temp_reg(31) = '0' and result(31) = '1') then
					rd(127 downto 96) <= "01111111111111111111111111111111";
				elsif (rs1(127) = '1' and temp_reg(31) = '1' and result(31) = '0') then
					rd(127 downto 96) <= "10000000000000000000000000000000";
				else
					rd(127 downto 96) <= std_logic_vector((signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))) + signed(rs1(127 downto 96))); 																								
				end if;
				
				
			elsif inst(22 downto 20) = "010" then	--Signed Integer Multiply-Subtract Low with Saturation
				
				temp_reg := std_logic_vector(signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))); 
				result := std_logic_vector((signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))) - signed(rs1(31 downto 0))); 
				
				if ((rs1(31) = '1' and temp_reg(31) = '0' and result(31) = '1') or (rs1(31) = '0' and temp_reg(31) = '1' and result(31) = '1')) then
					rd(31 downto 0) <= "01111111111111111111111111111111";
				elsif ((rs1(31) = '0' and temp_reg(31) = '1' and result(31) = '0') or (rs1(31) = '1' and temp_reg(31) = '0' and result(31) = '0')) then
					rd(31 downto 0) <= "10000000000000000000000000000000";
				else
					rd(31 downto 0) <= std_logic_vector((signed(rs3(15 downto 0)) * signed(rs2(15 downto 0))) - signed(rs1(31 downto 0))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))); 
				result := std_logic_vector((signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))) - signed(rs1(63 downto 32)));
				
				if (rs1(63) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(63) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(63 downto 32) <= "01111111111111111111111111111111";
				elsif (rs1(63) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(63) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(63 downto 32) <= "10000000000000000000000000000000";
				else
					rd(63 downto 32) <= std_logic_vector((signed(rs3(47 downto 32)) * signed(rs2(47 downto 32))) - signed(rs1(63 downto 32))); 																								
				end if;
				
								
				temp_reg := std_logic_vector(signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))); 
				result := std_logic_vector((signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))) - signed(rs1(95 downto 64)));
				
				if (rs1(95) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(95) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(95 downto 64) <= "01111111111111111111111111111111";
				elsif (rs1(95) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(95) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(95 downto 64) <= "10000000000000000000000000000000";
				else
					rd(95 downto 64) <= std_logic_vector((signed(rs3(79 downto 64)) * signed(rs2(79 downto 64))) - signed(rs1(95 downto 64))); 																								
				end if;
				
												
				temp_reg := std_logic_vector(signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))); 
				result := std_logic_vector((signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))) - signed(rs1(127 downto 96)));
				
				if (rs1(127) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(127) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(127 downto 96) <= "01111111111111111111111111111111";
				elsif (rs1(127) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(127) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(127 downto 96) <= "10000000000000000000000000000000";
				else
					rd(127 downto 96) <= std_logic_vector((signed(rs3(111 downto 96)) * signed(rs2(111 downto 96))) - signed(rs1(127 downto 96))); 																								
				end if;
				
				
			elsif inst(22 downto 20) = "011" then	--Signed Integer Multiply-Subtract High with Saturation
				
				temp_reg := std_logic_vector(signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))); 
				result := std_logic_vector((signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))) - signed(rs1(31 downto 0))); 
				
				if (rs1(31) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(31) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(31 downto 0) <= "01111111111111111111111111111111";
				elsif (rs1(31) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(31) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(31 downto 0) <= "10000000000000000000000000000000";
				else
					rd(31 downto 0) <= std_logic_vector((signed(rs3(31 downto 16)) * signed(rs2(31 downto 16))) - signed(rs1(31 downto 0))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))); 
				result := std_logic_vector((signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))) - signed(rs1(63 downto 32)));
				
				if (rs1(63) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(63) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(63 downto 32) <= "01111111111111111111111111111111";
				elsif (rs1(63) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(63) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(63 downto 32) <= "10000000000000000000000000000000";
				else
					rd(63 downto 32) <= std_logic_vector((signed(rs3(63 downto 48)) * signed(rs2(63 downto 48))) - signed(rs1(63 downto 32))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))); 
				result := std_logic_vector((signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))) - signed(rs1(95 downto 64)));
				
				if (rs1(95) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(95) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(95 downto 64) <= "01111111111111111111111111111111";
				elsif (rs1(95) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(95) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(95 downto 64) <= "10000000000000000000000000000000";
				else
					rd(95 downto 64) <= std_logic_vector((signed(rs3(95 downto 80)) * signed(rs2(95 downto 80))) - signed(rs1(95 downto 64))); 																								
				end if;
				
				temp_reg := std_logic_vector(signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))); 
				result := std_logic_vector((signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))) - signed(rs1(127 downto 96)));
				
				if (rs1(127) = '0' and temp_reg(31) = '1' and result(31) = '1') or (rs1(127) = '1' and temp_reg(31) = '0' and result(31) = '1') then
					rd(127 downto 96) <= "01111111111111111111111111111111";
				elsif (rs1(127) = '1' and temp_reg(31) = '0' and result(31) = '0') or (rs1(127) = '0' and temp_reg(31) = '1' and result(31) = '0') then
					rd(127 downto 96) <= "10000000000000000000000000000000";
				else
					rd(127 downto 96) <= std_logic_vector((signed(rs3(127 downto 112)) * signed(rs2(127 downto 112))) - signed(rs1(127 downto 96))); 																								
				end if;
				
				
			elsif inst(22 downto 20) = "100" then	--Signed Long Integer Multiply-Add Low with Saturation
				
				long_temp_reg := std_logic_vector(signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))); 
				long_result := std_logic_vector((signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))) + signed(rs1(63 downto 0))); 
				
				if (rs1(63) = '0' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(63 downto 0) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(63) = '1' and long_temp_reg(63) = '1' and long_result(63) = '0') or (rs1(63) = '1' and long_temp_reg(63) = '1' and long_result(63) = '1') then
					rd(63 downto 0) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(63 downto 0) <= std_logic_vector((signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))) + signed(rs1(63 downto 0))); 																								
				end if;
				
				
				long_temp_reg := std_logic_vector(signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))); 
				long_result := std_logic_vector((signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))) + signed(rs1(127 downto 64))); 
				
				if (rs1(127) = '0' and long_temp_reg(63) = '0' and long_result(63) = '1') or (rs1(127) = '0' and long_temp_reg(63) = '0' and to_integer(signed(rs1(127 downto 64))) > to_integer(signed(long_result))) then
					rd(127 downto 64) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(127) = '1' and long_temp_reg(63) = '1' and long_result(63) = '0') or (rs1(127) = '1' and long_temp_reg(63) = '1' and long_result(63) = '1')then
					rd(127 downto 64) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(127 downto 64) <= std_logic_vector((signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))) + signed(rs1(127 downto 64)));																							
				end if;	 
				
				
			elsif inst(22 downto 20) = "101" then	--Signed Long Integer Multiply-Add High with Saturation
				
				long_temp_reg := std_logic_vector(signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))); 
				long_result := std_logic_vector((signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))) + signed(rs1(63 downto 0))); 
				
				if (rs1(63) = '0' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(63 downto 0) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(63) = '1' and long_temp_reg(63) = '1' and long_result(63) = '0') or (rs1(63) = '1' and long_temp_reg(63) = '1' and long_result(63) = '1') then
					rd(63 downto 0) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(63 downto 0) <= std_logic_vector((signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))) + signed(rs1(63 downto 0))); 																								
				end if;
				
				
				long_temp_reg := std_logic_vector(signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))); 
				long_result := std_logic_vector((signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))) + signed(rs1(127 downto 64))); 
				
				if (rs1(127) = '0' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(127 downto 64) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(127) = '1' and long_temp_reg(63) = '1' and long_result(63) = '0') then
					rd(127 downto 64) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(127 downto 64) <= std_logic_vector((signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))) + signed(rs1(127 downto 64)));																							
				end if;
			
				
			elsif inst(22 downto 20) = "110" then	--Signed Long Integer Multiply-Subtract Low with Saturation
				
				long_temp_reg := std_logic_vector(signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))); 
				long_result := std_logic_vector((signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))) - signed(rs1(63 downto 0))); 
				
				if (rs1(63) = '1' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(63 downto 0) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(63) = '0' and long_temp_reg(63) = '1' and long_result(63) = '0') then
					rd(63 downto 0) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(63 downto 0) <= std_logic_vector((signed(rs3(31 downto 0)) * signed(rs2(31 downto 0))) - signed(rs1(63 downto 0))); 																								
				end if;	
				
				
				
				long_temp_reg := std_logic_vector(signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))); 
				long_result := std_logic_vector((signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))) - signed(rs1(127 downto 64))); 
				
				if (rs1(127) = '1' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(127 downto 64) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(127) = '0' and long_temp_reg(63) = '1' and long_result(63) = '0') then
					rd(127 downto 64) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(127 downto 64) <= std_logic_vector((signed(rs3(95 downto 64)) * signed(rs2(95 downto 64))) - signed(rs1(127 downto 64)));																							
				end if;	 	  
				
				
			else                                    --Signed Long Integer Multiply-Subtract High with Saturation
				
				long_temp_reg := std_logic_vector(signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))); 
				long_result := std_logic_vector((signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))) - signed(rs1(63 downto 0))); 
				
				if (rs1(63) = '1' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(63 downto 0) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(63) = '0' and long_temp_reg(63) = '1' and long_result(63) = '0') then
					rd(63 downto 0) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(63 downto 0) <= std_logic_vector((signed(rs3(63 downto 32)) * signed(rs2(63 downto 32))) - signed(rs1(63 downto 0))); 																								
				end if;
				
				
				long_temp_reg := std_logic_vector(signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))); 
				long_result := std_logic_vector((signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))) - signed(rs1(127 downto 64))); 
				
				if (rs1(127) = '1' and long_temp_reg(63) = '0' and long_result(63) = '1') then
					rd(127 downto 64) <= "0111111111111111111111111111111111111111111111111111111111111111";
				elsif (rs1(127) = '0' and long_temp_reg(63) = '1' and long_result(63) = '0') then
					rd(127 downto 64) <= "1000000000000000000000000000000000000000000000000000000000000000";
				else
					rd(127 downto 64) <= std_logic_vector((signed(rs3(127 downto 96)) * signed(rs2(127 downto 96))) - signed(rs1(127 downto 64)));																							
				end if;
				
			end if;
			
		elsif inst(24 downto 23) = "11" then
			-- R3 instructions --  
			if inst(18 downto 15) = "0001" then	 -- SHRHI	 
				
				t0 := rs1(15 downto 0);
				t1 := rs1(31 downto 16);
				t2 := rs1(47 downto 32);
				t3 := rs1(63 downto 48);
				t4 := rs1(79 downto 64);
				t5 := rs1(95 downto 80);
				t6 := rs1(111 downto 96);
				t7 := rs1(127 downto 112);
				
				for i in 1 to to_integer(unsigned(rs2(3 downto 0))) loop
					t0 := '0' &  t0(15 downto 1);			-- 8 times
					t1 := '0' &  t1(15 downto 1);
					t2 := '0' &  t2(15 downto 1);
					t3 := '0' &  t3(15 downto 1);
					t4 := '0' &  t4(15 downto 1);
					t5 := '0' &  t5(15 downto 1);					
					t6 := '0' &  t6(15 downto 1);
					t7 := '0' &  t7(15 downto 1);
				end loop;
				
				rd(15 downto 0) <= t0;		
				rd(31 downto 16) <= t1;
				rd(47 downto 32) <= t2;
				rd(63 downto 48) <= t3;
				rd(79 downto 64) <= t4;
				rd(95 downto 80) <= t5;					
				rd(111 downto 96) <= t6;
				rd(127 downto 112) <= t7;
			
			elsif inst(18 downto 15) = "0010" then	--AU
				
				rd(31 downto 0) <= std_logic_vector(unsigned(rs1(31 downto 0)) + unsigned(rs2(31 downto 0)));
				rd(63 downto 32) <= std_logic_vector(unsigned(rs1(63 downto 32)) + unsigned(rs2(63 downto 32)));
				rd(95 downto 64) <= std_logic_vector(unsigned(rs1(95 downto 64)) + unsigned(rs2(95 downto 64)));
				rd(127 downto 96) <= std_logic_vector(unsigned(rs1(127 downto 96)) + unsigned(rs2(127 downto 96)));
			
			elsif inst(18 downto 15) = "0011" then	--CNT1H	   
					
				for i in 0 to 15 loop
					if rs1(i) = '1' then
						count_0	:= count_0 + 1;
					end if;
				end loop;
				
				for i in 16 to 31 loop
					if rs1(i) = '1' then
						count_1	:= count_1 + 1;
					end if;
				end loop;
				
				for i in 32 to 47 loop
					if rs1(i) = '1' then
						count_2	:= count_2 + 1;
					end if;
				end loop;
				
				for i in 48 to 63 loop
					if rs1(i) = '1' then
						count_3	:= count_3 + 1;
					end if;
				end loop;
				
				for i in 64 to 79 loop
					if rs1(i) = '1' then
						count_4	:= count_4 + 1;
					end if;
				end loop;
				
				for i in 80 to 95 loop
					if rs1(i) = '1' then
						count_5	:= count_5 + 1;
					end if;
				end loop;
				
				for i in 96 to 111 loop
					if rs1(i) = '1' then
						count_6	:= count_6 + 1;
					end if;
				end loop;
				
				for i in 112 to 127 loop
					if rs1(i) = '1' then
						count_7	:= count_7 + 1;
					end if;
				end loop;	 
				
				rd(15 downto 0) <= std_logic_vector(to_unsigned(count_0, 16));
				rd(31 downto 16) <= std_logic_vector(to_unsigned(count_1, 16));
				rd(47 downto 32) <= std_logic_vector(to_unsigned(count_2, 16));
				rd(63 downto 48) <= std_logic_vector(to_unsigned(count_3, 16));
				rd(79 downto 64) <= std_logic_vector(to_unsigned(count_4, 16));
				rd(95 downto 80) <= std_logic_vector(to_unsigned(count_5, 16));
				rd(111 downto 96) <= std_logic_vector(to_unsigned(count_6, 16));
				rd(127 downto 112) <= std_logic_vector(to_unsigned(count_7, 16));
			
			elsif inst(18 downto 15) = "0100" then	-- AHS	
				
				half_result := std_logic_vector(signed(rs1(15 downto 0)) + signed(rs2(15 downto 0)));
				if (rs1(15) = '0' and rs2(15) = '0' and half_result(15) = '1') then
					rd(15 downto 0) <= "0111111111111111";
				elsif (rs1(15) = '1' and rs2(15) = '1' and half_result(15) = '0') then
					rd(15 downto 0) <= "1000000000000000";
				else
					rd(15 downto 0) <= std_logic_vector(signed(rs1(15 downto 0)) + signed(rs2(15 downto 0)));																								
				end if;
				
				
				half_result := std_logic_vector(signed(rs1(31 downto 16)) + signed(rs2(31 downto 16)));
				if (rs1(31) = '0' and rs2(31) = '0' and half_result(15) = '1') then
					rd(31 downto 16) <= "0111111111111111";
				elsif (rs1(31) = '1' and rs2(31) = '1' and half_result(15) = '0') then
					rd(31 downto 16) <= "1000000000000000";
				else
					rd(31 downto 16) <= std_logic_vector(signed(rs1(31 downto 16)) + signed(rs2(31 downto 16)));																								
				end if;
				
				
				half_result := std_logic_vector(signed(rs1(47 downto 32)) + signed(rs2(47 downto 32)));
				if (rs1(47) = '0' and rs2(47) = '0' and half_result(15) = '1') then
					rd(47 downto 32) <= "0111111111111111";
				elsif (rs1(47) = '1' and rs2(47) = '1' and half_result(15) = '0') then
					rd(47 downto 32) <= "1000000000000000";
				else
					rd(47 downto 32) <= std_logic_vector(signed(rs1(47 downto 32)) + signed(rs2(47 downto 32)));																							
				end if;	  
				
				
				half_result := std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));
				if (rs1(63) = '0' and rs2(63) = '0' and half_result(15) = '1') then
					rd(63 downto 48) <= "0111111111111111";
				elsif (rs1(47) = '1' and rs2(47) = '1' and half_result(15) = '0') then
					rd(63 downto 48) <= "1000000000000000";
				else
					rd(63 downto 48) <= std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));																							
				end if;	 
				
				
				half_result := std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));
				if (rs1(63) = '0' and rs2(63) = '0' and half_result(15) = '1') then
					rd(63 downto 48) <= "0111111111111111";
				elsif (rs1(47) = '1' and rs2(47) = '1' and half_result(15) = '0') then
					rd(63 downto 48) <= "1000000000000000";
				else
					rd(63 downto 48) <= std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));																							
				end if;	
				
				
				half_result := std_logic_vector(signed(rs1(79 downto 64)) + signed(rs2(79 downto 64)));
				if (rs1(79) = '0' and rs2(79) = '0' and half_result(15) = '1') then
					rd(79 downto 64) <= "0111111111111111";
				elsif (rs1(79) = '1' and rs2(79) = '1' and half_result(15) = '0') then
					rd(79 downto 64) <= "1000000000000000";
				else
					rd(79 downto 64) <= std_logic_vector(signed(rs1(79 downto 64)) + signed(rs2(79 downto 64)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs1(95 downto 80)) + signed(rs2(95 downto 80)));
				if (rs1(95) = '0' and rs2(95) = '0' and half_result(15) = '1') then
					rd(95 downto 80) <= "0111111111111111";
				elsif (rs1(95) = '1' and rs2(95) = '1' and half_result(15) = '0') then
					rd(95 downto 80) <= "1000000000000000";
				else
					rd(95 downto 80) <= std_logic_vector(signed(rs1(95 downto 80)) + signed(rs2(95 downto 80)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs1(111 downto 96)) + signed(rs2(111 downto 96)));
				if (rs1(111) = '0' and rs2(111) = '0' and half_result(15) = '1') then
					rd(111 downto 96) <= "0111111111111111";
				elsif (rs1(95) = '1' and rs2(95) = '1' and half_result(15) = '0') then
					rd(111 downto 96) <= "1000000000000000";
				else
					rd(111 downto 96) <= std_logic_vector(signed(rs1(111 downto 96)) + signed(rs2(111 downto 96)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs1(127 downto 112)) + signed(rs2(127 downto 112)));
				if (rs1(127) = '0' and rs2(127) = '0' and half_result(15) = '1') then
					rd(127 downto 112) <= "0111111111111111";
				elsif (rs1(127) = '1' and rs2(127) = '1' and half_result(15) = '0') then
					rd(127 downto 112) <= "1000000000000000";
				else
					rd(127 downto 112) <= std_logic_vector(signed(rs1(127 downto 112)) + signed(rs2(127 downto 112)));																					
				end if;
				
			
			elsif inst(18 downto 15) = "0101" then	-- OR
				rd <= rs1 or rs2;
				
			elsif inst(18 downto 15) = "0110" then	-- BCW
				rd(31 downto 0) <= rs1(31 downto 0);
				rd(63 downto 32) <= rs1(31 downto 0);
				rd(95 downto 64) <= rs1(31 downto 0);
				rd(127 downto 96) <= rs1(31 downto 0); 
				
			elsif inst(18 downto 15) = "0111" then	-- MAXWS
				if signed(rs1(31 downto 0)) > signed(rs2(31 downto 0)) then
					rd(31 downto 0) <= rs1(31 downto 0);
				else 
					rd(31 downto 0) <= rs2(31 downto 0);
				end if;
				
				if signed(rs1(63 downto 32)) > signed(rs2(63 downto 32)) then
					rd(63 downto 32) <= rs1(63 downto 32);
				else 
					rd(63 downto 32) <= rs2(63 downto 32);
				end if;
				
				if signed(rs1(95 downto 64)) > signed(rs2(95 downto 64)) then
					rd(95 downto 64) <= rs1(95 downto 64);
				else 
					rd(95 downto 64) <= rs2(95 downto 64);
				end if;
				
				if signed(rs1(127 downto 96)) > signed(rs2(127 downto 96)) then
					rd(127 downto 96) <= rs1(127 downto 96);
				else 
					rd(127 downto 96) <= rs2(127 downto 96);
				end if;
			
			elsif inst(18 downto 15) = "1000" then	-- MINWS	
			
				if signed(rs1(31 downto 0)) < signed(rs2(31 downto 0)) then
					rd(31 downto 0) <= rs1(31 downto 0);
				else 
					rd(31 downto 0) <= rs2(31 downto 0);
				end if;
				
				if signed(rs1(63 downto 32)) < signed(rs2(63 downto 32)) then
					rd(63 downto 32) <= rs1(63 downto 32);
				else 
					rd(63 downto 32) <= rs2(63 downto 32);
				end if;
				
				if signed(rs1(95 downto 64)) < signed(rs2(95 downto 64)) then
					rd(95 downto 64) <= rs1(95 downto 64);
				else 
					rd(95 downto 64) <= rs2(95 downto 64);
				end if;
				
				if signed(rs1(127 downto 96)) < signed(rs2(127 downto 96)) then
					rd(127 downto 96) <= rs1(127 downto 96);
				else 
					rd(127 downto 96) <= rs2(127 downto 96);
				end if;
			
			elsif inst(18 downto 15) = "1001" then	-- MLHU	
				
				rd(31 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) * unsigned(rs2(15 downto 0)));
				rd(63 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) * unsigned(rs2(47 downto 32)));
				rd(95 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) * unsigned(rs2(79 downto 64)));
				rd(127 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) * unsigned(rs2(111 downto 96)));
			
			elsif inst(18 downto 15) = "1010" then	-- MLHSS	 	
				
				for i in 0 to 7 loop
					xor_temp := std_logic_vector(rs1((i*16 + 15) downto i*16) xor inv((i*16 + 15) downto i*16));	-- flips bits
					half_result := std_logic_vector(signed(xor_temp) + signed(one));
					
					if rs2((i*16 + 15)) = '1' then 
						if xor_temp(15) = '0' and one(15) = '0' and half_result(15) = '1' then	   -- overflow
							rd((i*16 + 15) downto i*16) <= "0111111111111111";
						elsif xor_temp(15) = '1' and one(15) = '1' and half_result(15) = '0' then  -- underflow
							rd((i*16 + 15) downto i*16) <= "1000000000000000";
						else
							rd((i*16 + 15) downto i*16) <= half_result;
						end if;
					elsif rs2((i*16 + 15) downto i*16) = "0000000000000000" then
						rd((i*16 + 15) downto i*16) <= "0000000000000000";
					else
						rd((i*16 + 15) downto i*16) <= rs1((i*16 + 15) downto i*16);
					end if;	  
				end loop;
				
			elsif inst(18 downto 15) = "1011" then    -- AND

                rd <= rs1 and rs2;

            elsif inst(18 downto 15) = "1100" then    -- INVB

                rd <= rs1 xor inv;

            elsif inst(18 downto 15) = "1101" then    -- ROTW
				temp0 := rs1(31 downto 0);
				temp1 := rs1(63 downto 32);
				temp2 := rs1(95 downto 64);
				temp3 := rs1(127 downto 96);
				
                for i in 1 to to_integer(unsigned(rs2(4 downto 0))) loop
                    temp0 := temp0(0) & temp0(31 downto 1);
                end loop;  
				
				for i in 1 to to_integer(unsigned(rs2(36 downto 32))) loop
					temp1 := temp1(0) & temp1(31 downto 1);
                end loop;  
				
				for i in 1 to to_integer(unsigned(rs2(68 downto 64))) loop
					temp2 := temp2(0) & temp2(31 downto 1);
                end loop;  
				
				for i in 1 to to_integer(unsigned(rs2(100 downto 96))) loop
					temp3 := temp3(0) & temp3(31 downto 1);
                end loop;  
				
				rd(31 downto 0) <= temp0;
				rd(63 downto 32) <= temp1;
				rd(95 downto 64) <= temp2;
				rd(127 downto 96) <= temp3;
			
			elsif inst(18 downto 15) = "1110" then    -- SFWU	
				
				rd(31 downto 0) <= std_logic_vector(unsigned(rs2(31 downto 0)) - unsigned(rs1(31 downto 0))); 
				rd(63 downto 32) <= std_logic_vector(unsigned(rs2(63 downto 32)) - unsigned(rs1(63 downto 32)));
				rd(95 downto 64) <= std_logic_vector(unsigned(rs2(95 downto 64)) - unsigned(rs1(95 downto 64)));
				rd(127 downto 96) <= std_logic_vector(unsigned(rs2(127 downto 96)) - unsigned(rs1(127 downto 96)));
			
			elsif inst(18 downto 15) = "1111" then    -- SFHS	
				
				half_result := std_logic_vector(signed(rs2(15 downto 0)) - signed(rs1(15 downto 0)));
				if (rs1(15) = '1' and rs2(15) = '0' and half_result(15) = '1') then
					rd(15 downto 0) <= "0111111111111111";
				elsif (rs1(15) = '0' and rs2(15) = '1' and half_result(15) = '0') then
					rd(15 downto 0) <= "1000000000000000";
				else
					rd(15 downto 0) <= std_logic_vector(signed(rs2(15 downto 0)) - signed(rs1(15 downto 0)));																								
				end if;
				
				
				half_result := std_logic_vector(signed(rs2(31 downto 16)) - signed(rs1(31 downto 16)));
				if (rs1(31) = '1' and rs2(31) = '0' and half_result(15) = '1') then
					rd(31 downto 16) <= "0111111111111111";
				elsif (rs1(31) = '0' and rs2(31) = '1' and half_result(15) = '0') then
					rd(31 downto 16) <= "1000000000000000";
				else
					rd(31 downto 16) <= std_logic_vector(signed(rs2(31 downto 16)) - signed(rs1(31 downto 16)));																								
				end if;
				
				
				half_result := std_logic_vector(signed(rs2(47 downto 32)) - signed(rs1(47 downto 32)));
				if (rs1(47) = '1' and rs2(47) = '0' and half_result(15) = '1') then
					rd(47 downto 32) <= "0111111111111111";
				elsif (rs1(47) = '0' and rs2(47) = '1' and half_result(15) = '0') then
					rd(47 downto 32) <= "1000000000000000";
				else
					rd(47 downto 32) <= std_logic_vector(signed(rs2(47 downto 32)) - signed(rs1(47 downto 32)));																							
				end if;	  
				
				
				half_result := std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48)));
				if (rs1(63) = '1' and rs2(63) = '0' and half_result(15) = '1') then
					rd(63 downto 48) <= "0111111111111111";
				elsif (rs1(47) = '0' and rs2(47) = '1' and half_result(15) = '0') then
					rd(63 downto 48) <= "1000000000000000";
				else
					rd(63 downto 48) <= std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48)));																							
				end if;	 
				
				
				half_result := std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48)));
				if (rs1(63) = '1' and rs2(63) = '0' and half_result(15) = '1') then
					rd(63 downto 48) <= "0111111111111111";
				elsif (rs1(47) = '0' and rs2(47) = '1' and half_result(15) = '0') then
					rd(63 downto 48) <= "1000000000000000";
				else
					rd(63 downto 48) <= std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48)));																							
				end if;	
				
				
				half_result := std_logic_vector(signed(rs2(79 downto 64)) - signed(rs1(79 downto 64)));
				if (rs1(79) = '1' and rs2(79) = '0' and half_result(15) = '1') then
					rd(79 downto 64) <= "0111111111111111";
				elsif (rs1(79) = '0' and rs2(79) = '1' and half_result(15) = '0') then
					rd(79 downto 64) <= "1000000000000000";
				else
					rd(79 downto 64) <= std_logic_vector(signed(rs2(79 downto 64)) - signed(rs1(79 downto 64)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs2(95 downto 80)) - signed(rs1(95 downto 80)));
				if (rs1(95) = '1' and rs2(95) = '0' and half_result(15) = '1') then
					rd(95 downto 80) <= "0111111111111111";
				elsif (rs1(95) = '0' and rs2(95) = '1' and half_result(15) = '0') then
					rd(95 downto 80) <= "1000000000000000";
				else
					rd(95 downto 80) <= std_logic_vector(signed(rs2(95 downto 80)) - signed(rs1(95 downto 80)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs2(111 downto 96)) - signed(rs1(111 downto 96)));
				if (rs1(111) = '1' and rs2(111) = '0' and half_result(15) = '1') then
					rd(111 downto 96) <= "0111111111111111";
				elsif (rs1(95) = '0' and rs2(95) = '1' and half_result(15) = '0') then
					rd(111 downto 96) <= "1000000000000000";
				else
					rd(111 downto 96) <= std_logic_vector(signed(rs2(111 downto 96)) - signed(rs1(111 downto 96)));																						
				end if;
				
				
				half_result := std_logic_vector(signed(rs2(127 downto 112)) - signed(rs1(127 downto 112)));
				if (rs1(127) = '1' and rs2(127) = '0' and half_result(15) = '1') then
					rd(127 downto 112) <= "0111111111111111";
				elsif (rs1(127) = '0' and rs2(127) = '1' and half_result(15) = '0') then
					rd(127 downto 112) <= "1000000000000000";
				else
					rd(127 downto 112) <= std_logic_vector(signed(rs2(127 downto 112)) - signed(rs1(127 downto 112)));																					
				end if;
				
				
			else   	-- NOP
				
				null;
				
			end if;
			
		end if;	  
	
	end process behavior;
	 
end behavioral;
