--

--
-- LPM_RAM_IO
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.rtlpkg.all;
library ieee;
use ieee.std_logic_1164.all;
entity mram_io is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := LPM_REGISTERED;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (dio : inout std_logic_vector(lpm_width-1 downto 0);
     address : in std_logic_vector(lpm_widthad-1 downto 0);
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     memenab : in std_logic := one;
     outenab : in std_logic := zero;
     we : in std_logic := one;
     outreg_ar : in std_logic := zero);
end mram_io;

architecture c39k of mram_io is

    signal data : std_logic_vector(lpm_width-1 downto 0);
    signal q : std_logic_vector(lpm_width-1 downto 0);
    signal mr : std_logic;
    signal mw : std_logic;

begin

    mw <= memenab AND (we AND NOT outenab);
    mr <= memenab AND NOT(we AND NOT outenab);

    u1: mram_dq generic map(
                lpm_width => lpm_width,
                lpm_widthad => lpm_widthad,
                lpm_numwords => lpm_numwords,
                lpm_indata => lpm_indata,
                lpm_address_control => lpm_address_control,
                lpm_outdata => lpm_outdata,
                lpm_file => lpm_file,
                lpm_hint => lpm_hint)
        port map(
                data => data,
                address => address,
                q => q,
                inclock => inclock,
                outclock => outclock,
                we => mw,
                outreg_ar => outreg_ar);

    f1: for i in lpm_width - 1 downto 0 generate
        u2: cy_bufoe port map(x=>q(i), oe=>mr, y=>dio(i), yfb=>data(i));
    end generate;
end c39k;
