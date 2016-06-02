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

entity I2CPWM4 is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		SDA		: inout	std_logic;
		SCL		: inout	std_logic;
		PWM0		: out	std_logic;
		PWM1		: out	std_logic;
		PWM2		: out	std_logic;
		PWM3		: out	std_logic
	);
end I2CPWM4;

architecture struct of I2CPWM4 is
-- COMPONENTS --
	component PWM4
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
	end component;

	component I2CSLAVE
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			SDA_IN		: in	std_logic;
			SCL_IN		: in	std_logic;
			SDA_OUT		: out	std_logic;
			SCL_OUT		: out	std_logic;
			ADDRESS		: out	std_logic_vector(7 downto 0);
			DATA_OUT	: out	std_logic_vector(7 downto 0);
			DATA_IN		: in	std_logic_vector(7 downto 0);
			WR		: out	std_logic;
			RD		: out	std_logic
		);
	end component;

--
-- SIGNALS --

	signal DIN		: std_logic_vector(7 downto 0);
	signal DOUT		: std_logic_vector(7 downto 0);
	signal WE		: std_logic;
	signal RD		: std_logic;
	signal ADDRESS		: std_logic_vector(7 downto 0);
	signal CS		: std_logic;
	signal SDA_IN		: std_logic;
	signal SCL_IN		: std_logic;
	signal SDA_OUT		: std_logic;
	signal SCL_OUT		: std_logic;
	
	-- USE 74HCT04 INVERTER
	signal S0		: std_logic;
	signal S1		: std_logic;
	signal S2		: std_logic;
	signal S3		: std_logic;


begin

-- PORT MAP --
	I_PWM4_0 : PWM4
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			DIN		=> DIN,
			DOUT		=> DOUT,
			WE		=> WE,
			RD		=> RD,
			ADR		=> ADDRESS(1 downto 0),
			CS		=> CS,
			PWM0		=> S0,
			PWM1		=> S1,
			PWM2		=> S2,
			PWM3		=> S3
		);

	I_I2CSLAVE_0 : I2CSLAVE
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			SDA_IN		=> SDA_IN,
			SCL_IN		=> SCL_IN,
			SDA_OUT		=> SDA_OUT,
			SCL_OUT		=> SCL_OUT,
			ADDRESS		=> ADDRESS,
			DATA_OUT	=> DIN,
			DATA_IN		=> DOUT,
			WR		=> WE,
			RD		=> RD
		);

	--  open drain PAD pull up 1.5K needed
	SCL <= 'Z' when SCL_OUT='1' else '0';
	SCL_IN <= to_UX01(SCL);
	SDA <= 'Z' when SDA_OUT='1' else '0';
	SDA_IN <= to_UX01(SDA);

	CS <= '1';

	-- USE 74HCT04 INVERTER
	PWM0 <= not(S0);
	PWM1 <= not(S1);
	PWM2 <= not(S2);
	PWM3 <= not(S3);
	
end struct;

