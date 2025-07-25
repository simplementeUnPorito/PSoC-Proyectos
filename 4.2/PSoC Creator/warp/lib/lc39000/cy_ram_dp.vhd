--

--
-- CY_RAM_DP
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;
use cypress.lpmpkg.all;
entity cy_ram_dp is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := lpm_registered;
     lpm_address_control : regis_type := lpm_registered;
     lpm_outdata_a : regis_type := lpm_registered;
     lpm_outdata_b : regis_type := lpm_registered;
     lpm_file : string := "";
     lpm_hint : goal_type := speed);
    port (data_a : in std_logic_vector(lpm_width-1 downto 0);
     data_b : in std_logic_vector(lpm_width-1 downto 0);
     address_a : in std_logic_vector(lpm_widthad-1 downto 0);
     address_b : in std_logic_vector(lpm_widthad-1 downto 0);
     q_a : out std_logic_vector(lpm_width-1 downto 0);
     q_b : out std_logic_vector(lpm_width-1 downto 0);
     addr_matchb : out std_logic;
     wea : in std_logic;
     web : in std_logic;
     inclock_a : in std_logic := zero;
     inclock_b : in std_logic := zero;
     outclock_a : in std_logic := zero;
     outclock_b : in std_logic := zero;
     outrega_ar : in std_logic := zero;
     outregb_ar : in std_logic := zero);
end cy_ram_dp;

architecture c39k of cy_ram_dp is

    constant indata : boolean := registered(lpm_indata);
    constant addr_ctrl : boolean := registered(lpm_address_control);
    constant outdataa : boolean := registered(lpm_outdata_a);
    constant outdatab : boolean := registered(lpm_outdata_b);
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

    u1: cy_c39kdualport
    generic map(datawidth => lpm_width,
                addresswidth => lpm_widthad,
                indata_reg => indata,
                addr_ctrl_reg => addr_ctrl,
                outdataa_reg => outdataa,
                outdatab_reg => outdatab,
                filename => lpm_file_x)
    port map( din_a => data_a,
                din_b => data_b,
                addr_a => address_a,
                addr_b => address_b,
                wea => wea,
                web => web,
                inclk_a => inclock_a,
                outclk_a => outclock_a,
                inclk_b => inclock_b,
                outclk_b => outclock_b,
                dout_a => q_a,
                dout_b => q_b,
                addr_matchb => addr_matchb,
                outrega_ar => outrega_ar,
                outregb_ar => outregb_ar);
end c39k;
