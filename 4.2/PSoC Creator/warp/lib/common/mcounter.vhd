--

--
-- MCOUNTER
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_tsrff;

use cypress.rtlpkg.cy_buf;

use cypress.lpmpkg.all;
entity mcounter is
    generic(lpm_width : positive := 1;
     lpm_direction : ctdir_type := LPM_NO_DIR;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     clock : in std_logic;
     clk_en : in std_logic := one;
     cnt_en : in std_logic := one;
     updown : in std_logic := one;
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := zero;
     aclr : in std_logic := zero;
     aload : in std_logic := zero;
     sset : in std_logic := zero;
     sclr : in std_logic := zero;
     sload : in std_logic := zero;
     testenab : in std_logic := zero;
     testin : in std_logic := zero;
     testout : out std_logic);
end mcounter;

architecture archlpmstd of Mcounter is

    signal qtmp,t,en_up,en_dn,en,enu : std_logic_vector(q'high downto 0);
    signal async,sync,set,clr : std_logic_vector(q'high downto 0);
    constant PIM: integer := 36;
    constant N : integer := connects(aset,PIM);
    constant O : integer := connects(aclr,N);
    constant P : integer := connects(sset,O);
    constant R : integer := connects(sclr,P);
    constant S : integer := connects(sload,R);
    constant U : integer := connects(sload,S);
    constant V : integer := connects(testenab,U);
    constant W : integer := connects(clk_en,V);
    constant X : integer := connects(cnt_en,W);
    constant Y : integer := connects(updown,X);

    attribute ff_type of qtmp:signal is ff_t ;

begin

    async <= restring(lpm_avalue,lpm_width);
    sync <= restring(lpm_svalue,lpm_width);

    en_up(0) <= '1';
    en_dn(0) <= '1';
    en(0) <= enu(0);

    G0: for j in q'range generate
        G1:if (j /= 0) generate

            TU: if (((port_state(updown) = ps_tied_high)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_up)) generate
                en_up(j) <= (en(j-1) AND qtmp(j-1));
            end generate;
            TD: if (((port_state(updown) = ps_tied_low)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_down)) generate
                en_dn(j) <= (en(j-1) AND NOT qtmp(j-1));
            end generate;
            TB: if ((port_state(updown) = ps_connected)
                     AND (lpm_direction = lpm_no_dir)) generate
                en_up(j) <= (en(j-1) AND updown AND qtmp(j-1));
                en_dn(j) <= (en(j-1) AND NOT updown AND NOT qtmp(j-1));
            end generate;
        end generate;

        G2: if (((lpm_hint = AREA) AND ((j rem (Y-8)) /= 0)) OR
                ((lpm_hint /= AREA) AND ((j rem Y) /= 0))) generate
            TU: if (((port_state(updown) = ps_tied_high)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_up)) generate
                en(j) <= en_up(j);
            end generate;
            TD: if (((port_state(updown) = ps_tied_low)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_down)) generate
                en(j) <= en_dn(j);
            end generate;
            TB: if ((port_state(updown) = ps_connected)
                     AND (lpm_direction = lpm_no_dir)) generate
                en(j) <= en_up(j) OR en_dn(j);
            end generate;
        end generate;

        G3: if (((lpm_hint = AREA) AND ((j rem (Y-8)) = 0)) OR
                ((lpm_hint /= AREA) AND ((j rem Y) = 0))) generate
            TU: if (((port_state(updown) = ps_tied_high)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_up)) generate
                enu(j) <= en_up(j);
            end generate;
            TD: if (((port_state(updown) = ps_tied_low)
                      AND (lpm_direction = lpm_no_dir))
                       OR (lpm_direction = lpm_down)) generate
                enu(j) <= en_dn(j);
            end generate;
            TB: if ((port_state(updown) = ps_connected)
                     AND (lpm_direction = lpm_no_dir)) generate
                enu(j) <= en_up(j) OR en_dn(j);
            end generate;
            XB: if (j /= 0) generate
                BJ: cy_buf port map (enu(j), en(j));
            end generate;
        end generate;
        set(j) <= (aset AND async(j)) OR (aload AND data(j));
        clr(j) <= (aset AND NOT async(j)) OR (aload AND NOT data(j)) OR aclr;

        UJ: cy_tsrff port map(t(j),set(j),clr(j),clock,qtmp(j));

    end generate;

    process (sync,data,sset,sclr,sload,en,clk_en,cnt_en,testin,testenab,qtmp)
    begin
        if (testenab = '1') then
            t(0) <= testin XOR qtmp(0);
            if (lpm_width > 1) then
                t(q'high downto 1) <= qtmp(q'high downto 1) XOR
                                      qtmp((q'high - 1) downto 0);
            end if;
        elsif (sclr = '1' AND clk_en = '1') then
            t <= qtmp;
        elsif (sset = '1' AND clk_en = '1') then
            t <= sync XOR qtmp;
        elsif (sload = '1' AND clk_en = '1') then
            t <= data XOR qtmp;
        elsif (cnt_en = '1' AND clk_en = '1') then
            t <= en;
        else
            t <= (others => '0');
        end if;
    end process;

    testout <= qtmp(q'high);
    q <= qtmp;

end archlpmstd;
