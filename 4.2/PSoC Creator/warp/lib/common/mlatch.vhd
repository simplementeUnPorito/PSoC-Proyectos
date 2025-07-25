--

--
-- MLATCH
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_dsrlch;
use cypress.lpmpkg.all;
entity mlatch is
    generic(lpm_width : positive := 1;
     lpm_avalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     gate : in std_logic;
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := zero;
     aclr : in std_logic := zero);
end mlatch;

architecture archlpmstd of Mlatch is

    signal qtmp,async,set,clr : std_logic_vector(q'high downto 0);

begin

    async <= restring(lpm_avalue,lpm_width);

    G0: for j in q'range generate
        set(j) <= (aset AND async(j));
        clr(j) <= (aset AND NOT async(j)) OR aclr;
        UJ: cy_dsrlch port map (data(j), set(j), clr(j), gate, qtmp(j));
    end generate;

    q <= qtmp;

end archlpmstd;
