-------------------------------------------------------------------------------
--
-- Title       : testbench
-- Design      : multimedia_ALU
-- Author      : ageorge0368@gmail.com
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\ageor\Desktop\COLLEGE WORK\JUNIOR YEAR 2023-24\ESE 345\VHDL Project\VHDL_Project\multimedia_ALU\src\processor_TB.vhd
-- Generated   : Wed Nov 29 12:53:32 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for whole processor.
--
-------------------------------------------------------------------------------

-- Package for Reading and Placing Machine Code to sig_inst_buf array
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.textio.all;

package inst_buf_array is
    type inst_buf is array (0 to 63) of std_logic_vector(24 downto 0);	  	-- inst_buff array input
    shared variable sig_inst_buf : inst_buf;				-- ALL 64 instructions in instruction buffer
		
	-- File shenanigans
	file MC_file : text;
    shared variable MC_line : line;
    shared variable MC_string : string(1 to 25);
	
	-- File procedures
    procedure read_inst; 

	-- string to std_logic_vector function
	function string_to_slv (temp_MC_string : string) return std_logic_vector;
	
end package inst_buf_array;	

package body inst_buf_array is

	function string_to_slv (temp_MC_string : string) return std_logic_vector is
        variable MC_slv : std_logic_vector(24 downto 0);
    begin
        for i in 1 to 25 loop
			if temp_MC_string(i) = '1' then
				MC_slv(24 - (i-1)) := '1';
			else 
				MC_slv(24 - (i-1)) := '0';
			end if;
			
        end loop;
        return MC_slv;
    end function string_to_slv;

    procedure read_inst is 
		variable MC_slv_result : std_logic_vector(24 downto 0);
    begin
		file_open(MC_file, "input.txt", read_mode);
		
        for i in 0 to 63 loop
            readline(MC_file, MC_line);
            read(MC_line, MC_string); 						-- read line type and convert to string
            
		   MC_slv_result := string_to_slv(MC_string);		-- slv_result from string_to_slv
			
	        sig_inst_buf(i) := MC_slv_result;
        end loop;
		
		file_close(MC_file);
    end procedure read_inst; 
	
end package body inst_buf_array;	


-- Testbench of Pipelined Processor
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.inst_buf_array.all;
use work.all;

entity testbench is
end testbench;

architecture behavioral of testbench is

	signal clk : std_logic := '0';		-- clk signal
	constant period : time := 1 us;					 
	
	signal reset : std_logic;			-- reset signal
	
begin
	
	processor_UUT : entity processor
	port map (
		clk_1 => clk,
		reset_bar => reset
	);
	
	reset <= '0', '1' after 2 * period;			-- reset signal
	
	clock: process				-- system clock
	begin
		
		read_inst;					-- read a new instruction from the input text file
		
		for i in 0 to (2**16) loop
			wait for period/2;
			clk <= not clk;	
		end loop;
		std.env.finish;
	end process; 
				   
end behavioral;
