----------------------------------------------------------------------------------
-- Debounced slideswitch
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slideswitch is
	generic(
		counter_size : integer := 19           -- counter size (19 bits gives 10.5ms with 50MHz clock)
	);
	port(
		CLK    : in  std_logic;                -- input clock
		SW0    : in  std_logic; -- side switches
		AN     : out std_logic_vector(0 to 3); -- 7-segment digit anodes ports
		LED0   : out std_logic;  -- LEDs
		LED1   : out std_logic
	);
end slideswitch;

architecture Behavioral of slideswitch is
  signal flipflops   : STD_LOGIC_VECTOR(1 downto 0);                               -- input flip flops
  signal counter_out : STD_LOGIC_VECTOR(counter_size downto 0) := (others => '0'); -- counter output
  signal button      : std_logic;                                                  -- debounce input
  signal result      : std_logic;                                                  -- debounced signal
	
begin

	-- Make sure Mercury BaseBoard 7-Seg Display is disabled (anodes are pulled high)
	AN <= (others => '1');
	
	-- Feed switch 1 into debouncer
	button <= SW0;
	
	-- Feed LED from the debounce circuitry
	LED0 <= result;
	LED1 <= not result;

	-- Debounce circuit
	process (CLK)
	begin
		if rising_edge (CLK) then
			flipflops(0) <= button;
			flipflops(1) <= flipflops(0);
			if ((flipflops(0) xor flipflops(1)) = '1') then -- reset counter because input is changing
				counter_out <= (others => '0');
			elsif (counter_out(counter_size) = '0') then    -- stable input time is not yet met
				counter_out <= counter_out + 1;
			else                                            -- stable input time is met
				result <= flipflops(1);
			end if;
		end if;
	end process;
		
end Behavioral;
