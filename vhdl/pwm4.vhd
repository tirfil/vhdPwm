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

entity PWM4 is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		DIN		: in	std_logic_vector(7 downto 0);
		DOUT		: out	std_logic_vector(7 downto 0);
		WE		: in	std_logic;
		RD		: in	std_logic;
		ADR		: in	std_logic_vector(1 downto 0);
		CS		: in	std_logic;
		PWM0		: out	std_logic;
		PWM1		: out	std_logic;
		PWM2		: out	std_logic;
		PWM3		: out	std_logic
	);
end PWM4;

architecture mixed of PWM4 is
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
	signal reg0	: std_logic_vector(7 downto 0);
	signal reg1	: std_logic_vector(7 downto 0);
	signal reg2	: std_logic_vector(7 downto 0);
	signal reg3	: std_logic_vector(7 downto 0);


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
			DATA		=> reg0,
			PWM		=> PWM0
		);

	I_PWMUNIT_1 : PWMUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			BITRATE		=> BITRATE,
			LDDATA		=> LDDATA,
			DATA		=> reg1,
			PWM		=> PWM1
		);

	I_PWMUNIT_2 : PWMUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			BITRATE		=> BITRATE,
			LDDATA		=> LDDATA,
			DATA		=> reg2,
			PWM		=> PWM2
		);

	I_PWMUNIT_3 : PWMUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			BITRATE		=> BITRATE,
			LDDATA		=> LDDATA,
			DATA		=> reg3,
			PWM		=> PWM3
		);


	RWRITE:process(MCLK,nRST)
	begin
		if (nRST='0') then
			reg0 <= (others=>'0');
			reg1 <= (others=>'0');
			reg2 <= (others=>'0');
			reg3 <= (others=>'0');
		elsif (MCLK'event and MCLK='1') then
			if (CS='1' and WE='1') then
				case ADR is
					when "00" 	=> reg0 <= DIN;
					when "01" 	=> reg1 <= DIN;
					when "10" 	=> reg2 <= DIN;
					when others => reg3 <= DIN;
				end case;
			end if;
		end if;
	end process RWRITE;

	DOUT <= reg0 when ADR="00" else
			reg1 when ADR="01" else
			reg2 when ADR="10" else reg3;


end mixed;

