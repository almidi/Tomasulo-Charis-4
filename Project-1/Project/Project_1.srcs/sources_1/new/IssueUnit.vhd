library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity IssueUnit is
	Port ( 
		IssueIn : in STD_LOGIC;
		FUType : in STD_LOGIC_VECTOR (1 downto 0);
		Fop : in STD_LOGIC_VECTOR (1 downto 0);
		Ri : in STD_LOGIC_VECTOR (4 downto 0);
		Rj : in STD_LOGIC_VECTOR (4 downto 0);
		Rk : in STD_LOGIC_VECTOR (4 downto 0);
		RFReadAddr1: out STD_LOGIC_VECTOR (4 downto 0);
		RFReadAddr2: out STD_LOGIC_VECTOR (4 downto 0);
		RFTag: out STD_LOGIC_VECTOR (4 downto 0);
		RFAddrW: out STD_LOGIC_VECTOR (4 downto 0);
		RFWrEn: out STD_LOGIC;
		Accepted : out STD_LOGIC;
		OpOut : out STD_LOGIC_VECTOR (1 downto 0);
		ArithmeticAvailable : in STD_LOGIC_VECTOR (2 downto 0);
		ArithmeticIssue : out STD_LOGIC;
		LogicalAvailable : in STD_LOGIC_VECTOR (2 downto 0);
		LogicalIssue : out STD_LOGIC;
		Clk: in STD_LOGIC;
		Rst: in STD_LOGIC);   
end IssueUnit;
architecture Behavioral of IssueUnit is
begin
	OpOut<=Fop;
	RFReadAddr1<=Rj;
	RFReadAddr2<=Rk;
	
	process(Clk, Rst)
	begin
		if Rst='1' then
			LogicalIssue<='0';
			LogicalIssue<='0';
			RFTag<=std_logic_vector(to_unsigned(0,5));
			RFAddrW<=std_logic_vector(to_unsigned(0,5));
			RFWrEn<='0';
			Accepted<='0';
		elsif rising_edge(Clk) then
			if IssueIn='1' then
				if FUType="00" then 
					if LogicalAvailable/="000" then 
						LogicalIssue<='1';
						RFTag<=FUType & LogicalAvailable;
						RFAddrW<=Ri;
						RFWrEn<='1';
						Accepted<='1';
					else
						LogicalIssue<='0';
						RFTag<=std_logic_vector(to_unsigned(0,5));
						RFAddrW<=std_logic_vector(to_unsigned(0,5));
						RFWrEn<='0';
						Accepted<='0';
					end if;
				elsif FUType="01" then
					if ArithmeticAvailable/="000" then 
						ArithmeticIssue<='1';
						RFTag<=FUType & ArithmeticAvailable;
						RFAddrW<=Ri;
						RFWrEn<='1';
						Accepted<='1';
					else
						ArithmeticIssue<='0';
						RFTag<=std_logic_vector(to_unsigned(0,5));
						RFAddrW<=std_logic_vector(to_unsigned(0,5));
						RFWrEn<='0';
						Accepted<='0';
					end if;
				else
					LogicalIssue<='0';
					LogicalIssue<='0';
					RFTag<=std_logic_vector(to_unsigned(0,5));
					RFAddrW<=std_logic_vector(to_unsigned(0,5));
					RFWrEn<='0';
					Accepted<='0';
				end if;
			else
				LogicalIssue<='0';
				LogicalIssue<='0';
				RFTag<=std_logic_vector(to_unsigned(0,5));
				RFAddrW<=std_logic_vector(to_unsigned(0,5));
				RFWrEn<='0';
				Accepted<='0';
			end if;
		end if;
	end process;
end Behavioral;