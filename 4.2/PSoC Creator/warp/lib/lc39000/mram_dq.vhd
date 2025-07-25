--

--
-- LPM_MRAM_DQ
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;
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

architecture c39k of mram_dq is

    constant indata : boolean := registered(lpm_indata);
    constant addr_ctrl : boolean := registered(lpm_address_control);
    constant outdata : boolean := registered(lpm_outdata);
    constant size : integer := 2**lpm_widthad;
    constant longstrlen : integer := 1000;

    function same_string (inp : string) return string is
        variable v : string(1 to longstrlen);
    begin
        if (inp'length > 0) then
            v(1 to inp'length) := inp;
        end if;
        return v;
    end same_string;

    constant lpm_file_x : string(1 to longstrlen) := same_string(lpm_file);

begin

    assert ((lpm_numwords = size) OR (lpm_numwords = 0))
    report "Lpm_widthad and lpm_numwords don't agree, lpm_widthad being used."
    severity note;

    u1: cy_C39KSINGLEPORT generic map(
                datawidth => lpm_width,
                addresswidth => lpm_widthad,
                indata_reg => indata,
                addr_ctrl_reg => addr_ctrl,
                outdata_reg => outdata,
                fileName => lpm_file_x)
        port map(
                Din => Data,
                Addr => Address,
                WE => WE,
                InClk => InClock,
                OutClk => OutClock,
                outreg_AR => OutReg_AR,
                DOut => Q);
end c39k;
