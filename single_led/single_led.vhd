----------------------------------------------------------------------------------
-- Turn on a single LED
----------------------------------------------------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity single_led is
	port(
		AN   : out std_logic_vector(0 to 3);  
		LED0 : out std_logic
	);
end single_led;

architecture led_on of single_led is
	
begin

	-- Make sure Mercury BaseBoard 7-Seg Display is disabled (anodes are pulled high)
	AN <= (others => '1');
	
	-- Turn on the LED
	LED0 <= '1';

end led_on;
