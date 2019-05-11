----------------------------------------------------------------------------------
-- Debounced pushbutton examples
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pushbutton is
	generic(
		counter_size : integer := 19           -- counter size (19 bits gives 10.5ms with 50MHz clock)
	);
	port(
		CLK    : in  std_logic;                -- input clock
		BTN    : in  std_logic_vector(0 to 3); -- input buttons
		AN     : out std_logic_vector(0 to 3); -- 7-segment digit anodes ports
		LED    : out std_logic_vector(0 to 3)  -- LEDs
	);
end pushbutton;

architecture pb of pushbutton is
  signal flipflops   : STD_LOGIC_VECTOR(1 downto 0);                               -- input flip flops
  signal counter_out : STD_LOGIC_VECTOR(counter_size downto 0) := (others => '0'); -- counter output
  signal result      : std_logic;                                                  -- debounced signal
  signal toggle      : std_logic;                                                  -- toggled signal
	
begin

	-- Make sure Mercury BaseBoard 7-Seg Display is disabled (anodes are pulled high)
	AN <= (others => '1');
	
	-- Provide sources for the other LEDs and sincs for the other 
	-- buttons so that we do not get compile warnings. 
	LED(0) <= toggle;
	LED(1) <= BTN(2);
	LED(2) <= BTN(1);
	LED(3) <= BTN(0);

	-- Debounce circuit
	process (CLK)
	begin
		if rising_edge(CLK) then
			flipflops(0) <= BTN(3);
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

	-- Toggle circuit
	process (result)
	begin
		if (result'event and result = '1') then
			toggle <= (not toggle);
		end if;
	end process;
	
end pb;
