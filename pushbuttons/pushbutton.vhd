----------------------------------------------------------------------------------
-- Debounced pushbutton examples
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity pushbutton is
	generic(
		counter_size : integer := 19           -- left bound of debounce counters
	);
	port(
		clk    : in  std_logic;                -- input clock
		btn    : in  std_logic_vector(0 to 3); -- input buttons
		an     : out std_logic_vector(0 to 3); -- 7-segment digit anodes ports
		led    : out std_logic_vector(0 to 3)  -- LEDs
	);
end entity pushbutton;

architecture pb of pushbutton is

	subtype st_buttons is std_logic_vector(0 to 3);
	
	type t_flipflops is array (0 to 1) of st_buttons;
	type t_counter   is array (0 to 3) of unsigned(counter_size downto 0);

   signal  flipflops  : t_flipflops;
   signal  counter_out: t_counter := (others => (others => '0'));
	signal  counter_set: std_logic_vector(0 to 3);

begin
		
	an <= (others => '1');
	
	counter_set <= flipflops(0) xor flipflops(1);
		
	process (clk)
	begin
		if rising_edge (clk) then
			flipflops(0) <= btn;
			flipflops(1) <= flipflops(0);
			for i in 0 to 3 loop
				if counter_set(i) = '1' then
					counter_out(i) <= (others => '0');
				elsif counter_out(i)(counter_size) = '0' then
					counter_out(i) <= counter_out(i) + 1;
				else
					led(i) <= flipflops(1)(i);
				end if;
			end loop;
		end if;
	end process;
end architecture pb;
