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

entity PWM is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		DATA		: in	std_logic_vector(7 downto 0);
		PWMOUT		: out	std_logic
	);
end PWM;

architecture struct of PWM is

-- COMPONENTS --
	component PWMCLOCK
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			LDDATA		: out	std_logic;
			BITRATE		: out	std_logic
		);
	end component;

	component PWMUNIT
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			BITRATE		: in	std_logic;
			LDDATA		: in	std_logic;
			DATA		: in	std_logic_vector(7 downto 0);
			PWM		: out	std_logic
		);
	end component;


--
-- SIGNALS --
	signal LDDATA		: std_logic;
	signal BITRATE		: std_logic;


begin

-- PORT MAP --
	I_PWMCLOCK_0 : PWMCLOCK
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			BITRATE		=> BITRATE
		);

	I_PWMUNIT_0 : PWMUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			BITRATE		=> BITRATE,
			LDDATA		=> LDDATA,
			DATA		=> DATA,
			PWM		=> PWMOUT
		);


end struct;

