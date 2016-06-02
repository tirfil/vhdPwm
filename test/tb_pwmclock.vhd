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

entity tb_PWMCLOCK is
end tb_PWMCLOCK;

architecture stimulus of tb_PWMCLOCK is

-- COMPONENTS --
	component PWMCLOCK
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			LDDATA		: out	std_logic;
			BITRATE		: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal nRST		: std_logic;
	signal LDDATA		: std_logic;
	signal BITRATE		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_PWMCLOCK_0 : PWMCLOCK
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			BITRATE		=> BITRATE
		);

--
	CLOCK: process
	begin
		while (RUNNING = '1') loop
			MCLK <= '1';
			wait for 10 ns;
			MCLK <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process CLOCK;

	GO: process
	begin
		nRST <= '0';
		wait for 1000 ns;
		nRST <= '1';
		wait until (LDDATA'event and LDDATA = '0');
		wait until (LDDATA'event and LDDATA = '0');
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
