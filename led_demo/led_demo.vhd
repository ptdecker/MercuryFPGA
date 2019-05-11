----------------------------------------------------------------------------------
-- Blink all four LEDs on Mercury Board
----------------------------------------------------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity led_demo is
	port(
		AN  : out std_logic_vector(0 to 3);
		CLK : in std_logic;
		LED : out std_logic_vector(0 to 3)
	);
end led_demo;

architecture rtl of led_demo is
	signal count : integer range 0 to 49999999 := 0;
	signal pulse : std_logic := '0';

begin

	-- Force the 7-segment displays off
	AN <= (others => '1');

	process(CLK)
	begin
		if rising_edge (clk) then
			if count = 49999999 then
				count <= 0;
				pulse <= not pulse;
			else
				count <= count + 1;
			end if;
		end if;
	end process;

	LED(0 to 3) <= (others => pulse);

end rtl;