library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CompareModule is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           DOUT : out  STD_LOGIC);
end CompareModule;

architecture Behavioral of CompareModule is

--signal helpSig: std_logic;

begin
--helpsig <= (In1=In0) AND In1 /="00000";
	DOUT <= '1' when ((In1=In0) AND In1 /="00000")
				 else '0';

end Behavioral;

