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

entity tb_PWM is
end tb_PWM;

architecture stimulus of tb_PWM is

-- COMPONENTS --
	component PWM
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			DATA		: in	std_logic_vector(7 downto 0);
			PWMOUT		: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal nRST		: std_logic;
	signal DATA		: std_logic_vector(7 downto 0);
	signal PWMOUT		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_PWM_0 : PWM
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			DATA		=> DATA,
			PWMOUT		=> PWMOUT
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
		DATA <= x"80";
		wait for 1000 ns;
		nRST <= '1';
		wait for 0.1 ms;
		DATA <= x"00";
		wait for 0.1 ms;
		DATA <= x"ff";
		wait for 0.1 ms;
		DATA <= x"fe";
		wait for 0.2 ms;
		DATA <= x"01";
		wait for 0.1 ms;
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
