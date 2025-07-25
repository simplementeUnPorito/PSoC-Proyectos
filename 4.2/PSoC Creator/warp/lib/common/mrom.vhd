--

--
-- MROM
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
library ieee;
use ieee.std_logic_1164.all;
entity mrom is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (address : in std_logic_vector(lpm_widthad-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     memenab : in std_logic := one;
     outreg_AR : in std_logic := zero);
end mrom;

architecture archlpmstd of mrom is

begin
    assert (FALSE)
        report "The mrom component is not intended for use in this device."
        severity failure;
end archlpmstd;
