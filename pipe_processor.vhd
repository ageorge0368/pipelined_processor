-------------------------------------------------------------------------------
--
-- Title       : processor
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\pipe_processor.vhd
-- Generated   : Wed Nov 29 12:17:56 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------		

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;  
use work.inst_buf_array.all; 
use std.textio.all;

entity processor is	
	port (
		clk_1 : in std_logic;			-- clk signal
		
		reset_bar : in std_logic		-- reset signal for data forwarding unit
		
		-- what are the outputs?
	);
end processor;


architecture structural of processor is

	-- instruction buffer output (inst_out)	  
	signal inst_output_1 : std_logic_vector(24 downto 0);
	
	-- IF/ID register output (inst_out)	  
	signal inst_output_2 : std_logic_vector(24 downto 0);
	
	-- register file
	-- val_out										
	signal val_out_2 : std_logic_vector(127 downto 0);				-- register file input
	
	signal write_addr : std_logic_vector(4 downto 0);
	
	signal rs1 : std_logic_vector(127 downto 0);
	signal rs2 : std_logic_vector(127 downto 0);
	signal rs3 : std_logic_vector(127 downto 0);   
	
	-- ID/EXE register							   
	signal inst_output_3 : std_logic_vector(24 downto 0);
	
	signal rs1_id_ex : std_logic_vector(127 downto 0);
	signal rs2_id_ex : std_logic_vector(127 downto 0);
	signal rs3_id_ex : std_logic_vector(127 downto 0); 
	
	-- forwarding muxes
	signal mux_signal : std_logic_vector(1 downto 0);
	
	signal rs1_FWD_mux : std_logic_vector(127 downto 0) := (others => '0');
	signal rs2_FWD_mux : std_logic_vector(127 downto 0);
	signal rs3_FWD_mux : std_logic_vector(127 downto 0); 		 
	
	-- ALU
	signal rd_ALU : std_logic_vector(127 downto 0);	 
	
	-- EX/WB register
	signal write_enable_WB : std_logic;
	
	file results_file : text;
	
begin					
	
	results_pro : process(clk_1) is
	   	variable cycle_num : integer := 1;
		variable results_line : line;  
		variable new_line : line;
	begin
		
		if falling_edge(clk_1) then 
			file_open(results_file, "../results.txt", append_mode);
			
			--report to results file
			write(results_line, "Cycle #: " & integer'image(cycle_num));
			cycle_num := cycle_num + 1;
			writeline(results_file, results_line);		
		
			write(results_line, "IF: ");
			write(results_line, inst_output_1);
			writeline(results_file, results_line);
			
			write(results_line, "ID: ");
			write(results_line, inst_output_2);
			writeline(results_file, results_line);	
			
			write(results_line, "EX: ");
			write(results_line, inst_output_3);	
			writeline(results_file, results_line);
			
			write(results_line, "     rs1: ");
			write(results_line, rs1_FWD_mux);
			writeline(results_file, results_line);
			
			write(results_line, "     rs2: ");
			write(results_line, rs2_FWD_mux);
			writeline(results_file, results_line);
			
			write(results_line, "     rs3: ");
			write(results_line, rs3_FWD_mux);
			writeline(results_file, results_line);
			
			write(results_line, "     rd: ");
			write(results_line, rd_ALU);
			writeline(results_file, results_line);
			
			write(results_line, "     Mux Signal (00 -> no forwarding): ");
			write(results_line, mux_signal);
			writeline(results_file, results_line);
			
			write(results_line, "WB: ");
			write(results_line, write_addr);
			writeline(results_file, results_line);
			
			write(results_line, "Write Enable: ");
			write(results_line, write_enable_WB);
			writeline(results_file, results_line);
			
			write(results_line, "Val Out: ");
			write(results_line, val_out_2);
			writeline(results_file, results_line);
			writeline(results_file, new_line);
			
			writeline(results_file, new_line);
			file_close(results_file);
		end if;
		
	end process results_pro;
	
	-- instruction buffer
	u1 : entity instruction_buffer port map (clk => clk_1, reset => reset_bar, inst_out => inst_output_1); 	-- output comes from a signal
	
	-- IF/ID register	
	u2 : entity IF_ID_reg port map (inst_in => inst_output_1, clk => clk_1, reset => reset_bar, inst_out => inst_output_2);	 
		
	-- register file
	u3 : entity register_file port map (val_out => val_out_2, write_enable => write_enable_WB, write_addr => write_addr, inst => inst_output_2, val_1 => rs1, val_2 => rs2, val_3 => rs3);
	
	-- ID/EX register
	u4 : entity ID_EX_reg port map (clk => clk_1, reset => reset_bar, inst_in => inst_output_2, val_1 => rs1, val_2 => rs2, val_3 => rs3, inst_out => inst_output_3, val_1_out => rs1_id_ex, val_2_out => rs2_id_ex, val_3_out => rs3_id_ex);
	
	-- forwarding muxes
	u5 : entity FWD_mux port map (val_1 => rs1_id_ex, val_2 => rs2_id_ex, val_3 => rs3_id_ex, val_out => val_out_2, mux_signal => mux_signal, rs1 => rs1_FWD_mux, rs2 => rs2_FWD_mux, rs3 => rs3_FWD_mux);
		
	-- data forwarding unit
	u6 : entity FWD port map (inst_buff => inst_output_3, rd_WB_addr => write_addr, reset => reset_bar, mux_signal => mux_signal);	 
		
	-- ALU
	u7 : entity	multimedia_ALU port map (rs1 => rs1_FWD_mux, rs2 => rs2_FWD_mux, rs3 => rs3_FWD_mux, inst => inst_output_3, rd => rd_ALU);	
		
	-- EX/WB register
	u8 : entity EX_WB_reg port map (clk => clk_1, reset => reset_bar, inst => inst_output_3, rd_in => rd_ALU, write_addr => write_addr, write_enable => write_enable_WB, rd_out => val_out_2);
								   
end structural;																	 
