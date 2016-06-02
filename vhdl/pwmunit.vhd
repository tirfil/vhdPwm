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

entity PWMUNIT is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		BITRATE		: in	std_logic;
		LDDATA		: in	std_logic;
		DATA		: in	std_logic_vector(7 downto 0);
		PWM			: out	std_logic
	);
end PWMUNIT;

architecture rtl of PWMUNIT is
	signal cnt	: std_logic_vector(7 downto 0);
	signal level	: std_logic;
begin

	level <= '0' when (cnt = x"00") else '1';

	CC: process(MCLK, nRST)
	begin
		if (nRST = '0') then
			cnt <= (others=>'0');
		elsif (MCLK'event and MCLK = '1') then
			if (LDDATA = '1') then
				cnt <= DATA;
			elsif (BITRATE = '1') then
				if (level = '1') then
					cnt <= std_logic_vector(to_unsigned(to_integer(unsigned( cnt )) - 1, 8));
				end if;
			end if;
		end if;
			
	end process CC;

	PWM <= level;

end rtl;

