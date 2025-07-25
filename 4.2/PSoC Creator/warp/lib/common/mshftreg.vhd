--

--
-- MSHIFTREG
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_dsrff;
use cypress.lpmpkg.all;
entity mshiftreg is
    generic(lpm_width : positive := 1;
     lpm_direction : shdir_type:= LPM_LEFT;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     clock : in std_logic;
     enable : in std_logic := one;
     shiftin : in std_logic := zero;
     load : in std_logic := zero;
     q : out std_logic_vector(lpm_width-1 downto 0);
     shiftout : out std_logic;
     aset : in std_logic := zero;
     aclr : in std_logic := zero;
     sset : in std_logic := zero;
     sclr : in std_logic := zero;
     testenab : in std_logic := zero;
     testin : in std_logic := zero;
     testout : out std_logic);
end mshiftreg;

architecture archlpmstd of Mshiftreg is

    signal qtmp,d,set,clr : std_logic_vector(q'high downto 0);
    signal async,sync : std_logic_vector(q'high downto 0);

begin

    async <= restring(lpm_avalue,lpm_width);
    sync <= restring(lpm_svalue,lpm_width);

    -- Determine the value of the Input to the register
    process (data,sync,sset,sclr,load,enable,shiftin,testin,testenab,qtmp)
    begin
        if (testenab = '1') then
            d(0) <= testin;
            if (lpm_width > 1) then
                d(q'high downto 1) <= qtmp((qtmp'high - 1) downto 0);
            end if;
        elsif (sclr = '1' AND enable = '1') then
            d <= (others => '0');
        elsif (sset = '1' AND enable = '1') then
            d <= sync;
        elsif (load = '1' AND enable = '1') then
            d <= data;
        elsif (enable = '1') then
            if (lpm_direction = lpm_left) then
                d(0) <= shiftin;
                if (lpm_width > 1) then
                    d(q'high downto 1) <= qtmp((qtmp'high - 1) downto 0);
                end if;
            else
                d(q'high) <= shiftin;
                if (lpm_width > 1) then
                    d(q'high - 1 downto 0) <= qtmp(qtmp'high downto 1);
                end if;
            end if;
        else
            d <= qtmp;
        end if;
    end process;

    G0: for j in q'range generate
        set(j) <= (aset AND async(j));
        clr(j) <= (aset AND NOT async(j)) OR aclr;

        UJ:cy_dsrff port map (d(j), set(j), clr(j), clock, qtmp(j));
    end generate;

    shiftout <= qtmp(qtmp'high) when (lpm_direction = lpm_left) else
                qtmp(qtmp'low);
    testout <= qtmp(qtmp'high);
    q <= qtmp;

end archlpmstd;
