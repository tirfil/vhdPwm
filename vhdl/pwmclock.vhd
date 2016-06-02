--###############################
--# Project Name : 
--# File         : 
--# Author       : 
--# Description  : 
--# Modification History
--#
--###############################

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PWMCLOCK is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		LDDATA		: out	std_logic;
		BITRATE		: out	std_logic
	);
end PWMCLOCK;

architecture rtl of PWMCLOCK is
	signal mcounter : std_logic_vector(7 downto 0);
	signal nextcounter : std_logic_vector(7 downto 0);
	signal rate : std_logic;
	signal cnt256  : std_logic_vector(8 downto 0);
	signal nextcnt256  : std_logic_vector(8 downto 0);
	signal det : std_logic;
	signal load : std_logic;
begin


	rate <= mcounter(3);
	nextcounter <= std_logic_vector(to_unsigned(to_integer(unsigned( mcounter )) + 1, 8));

	MCNT:process(MCLK,nRST)
	begin
		if (nRST = '0') then
			mcounter <= x"01";
		elsif (MCLK'event and MCLK='1') then
			if (rate = '1') then
				mcounter <= x"01";
			else
				mcounter <= nextcounter;
			end if;
		end if;
	end process MCNT;

	-- alignement with LDDATA
	RESY:process(MCLK,nRST)
	begin
		if (nRST = '0') then
			BITRATE <= '0';
		elsif (MCLK'event and MCLK='1') then
			BITRATE <= rate;
		end if;
	end process RESY;


	det <= cnt256(8);
	nextcnt256 <= std_logic_vector(to_unsigned(to_integer(unsigned( cnt256 )) + 1, 9));

	DIV256: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			cnt256 <= "0" & x"02";
			load <= '0';
		elsif (MCLK'event and MCLK='1') then
			if (rate = '1') then
				if (det = '1') then
					load <= '1';
					cnt256 <= "0" & x"02"; -- 255 steps (not 256)
				else
					cnt256 <= nextcnt256;
				end if;
			else
				load <= '0';
			end if;
		end if;
	end process DIV256;

	LDDATA <= load;	

end rtl;

