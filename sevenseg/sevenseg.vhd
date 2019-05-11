----------------------------------------------------------------------------------
-- Seven segment test
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenseg is
	port (
		SW     : in  std_logic_vector(3 downto 0);
		A_TO_G : out std_logic_vector(6 downto 0);
		AN     : out std_logic_vector(3 downto 0);
		DOT	 : out std_logic
	);
end sevenseg;

architecture sseg of sevenseg is
	signal LED_BYTE : std_logic_vector(0 to 3);

begin

	AN(3 downto 0) <= "1110";
	DOT            <= '1';
	
	LED_BYTE <= SW(3 downto 0);

	process(LED_BYTE)
	begin
		case LED_BYTE is
			when "0000" => A_TO_G <= "0000001"; -- "0"
			when "0001" => A_TO_G <= "1001111"; -- "1"
			when "0010" => A_TO_G <= "0010010"; -- "2"
			when "0011" => A_TO_G <= "0000110"; -- "3"
			when "0100" => A_TO_G <= "1001100"; -- "4"
			when "0101" => A_TO_G <= "0100100"; -- "5"
			when "0110" => A_TO_G <= "0100000"; -- "6"
			when "0111" => A_TO_G <= "0001111"; -- "7"
			when "1000" => A_TO_G <= "0000000"; -- "8"
			when "1001" => A_TO_G <= "0000100"; -- "9"
			when "1010" => A_TO_G <= "0001000"; -- A
			when "1011" => A_TO_G <= "1100000"; -- b
			when "1100" => A_TO_G <= "0110001"; -- C
			when "1101" => A_TO_G <= "1000010"; -- d
			when "1110" => A_TO_G <= "0110000"; -- E
			when "1111" => A_TO_G <= "0111000"; -- F
			when others => A_TO_G <= "1111111";
		end case;
	end process;

end sseg;

