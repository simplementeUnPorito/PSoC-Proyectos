--

--
-- MRAM_DQ
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mram_dq is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := LPM_REGISTERED;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     address : in std_logic_vector(lpm_widthad-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     we : in std_logic;
     outreg_ar : in std_logic := zero);
end mram_dq;

architecture archlpmstd of Mram_dq is

begin
    assert (FALSE)
        report "The MRAM_DQ component is not intended for use in this device."
        severity error;
end archlpmstd;
