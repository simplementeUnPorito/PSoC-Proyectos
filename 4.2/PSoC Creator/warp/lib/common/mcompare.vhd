--

--
-- MCOMPARE
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;

use cypress.rtlpkg.cy_buf;

use cypress.lpmpkg.all;
entity mcompare is
    generic(lpm_width : positive := 1;
     lpm_representation : repre_type := LPM_UNSIGNED;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port ( dataa : in std_logic_vector(lpm_width-1 downto 0);
     datab : in std_logic_vector(lpm_width-1 downto 0);
     alb : out std_logic;
     aeb : out std_logic;
     agb : out std_logic;
     ageb : out std_logic;
     aleb : out std_logic;
     aneb : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end mcompare;

architecture archlpmstd of Mcompare is

    constant C : integer := 8;
    constant K : integer := 3;
    signal a,b,xnor_array,lt,eq,gt : std_logic_vector(dataA'high downto 0);
    signal eqi : std_logic_vector((dataA'high/C) downto 0);
    signal aeqb : std_logic_vector(((dataA'high/C) + 1) downto 0);
    signal lti, gti : std_logic_vector((dataA'high/K) downto 0);
    signal albi,agbi : std_logic_vector(((dataA'high/K) + 1) downto 0);

begin

    GU: if (lpm_representation = lpm_unsigned) generate
        a <= dataA;
        b <= dataB;
    end generate;
    GS: if (lpm_representation = lpm_signed) generate
        GZ: if (lpm_width = 1) generate
            a <= dataB;
            b <= dataA;
        end generate;
        GN: if (lpm_width /= 1) generate
            a <= dataB(dataB'high) & dataA(dataA'high-1 downto 0);
            b <= dataA(dataA'high) & dataB(dataB'high-1 downto 0);
        end generate;
    end generate;

    xnor_array <= NOT(a XOR b);

    aeqb(0) <= '1';
    GEQ: for j in 0 to ((lpm_width-1)/C) generate
        eq(j*C) <= xnor_array(j*C);
        C1: for i in ((j*C)+1) to ((j*C)+(C-1)) generate
            C2: if (i < lpm_width) generate
                eq(i) <= eq(i-1) AND xnor_array(i);
            end generate;
        end generate;
        C3: if (j /= ((lpm_width-1)/C)) generate

            U1: cy_buf port map (eq((j*C)+(C-1)),eqi(j));

        end generate;
        C4: if (j = ((lpm_width-1)/C)) generate
            C5: if (((lpm_width-1) rem C) < (C-j)) generate
                eqi(j) <= eq(xnor_array'high);
            end generate;
            C6: if (((lpm_width-1) rem C) >= (C-j)) generate

                U1: cy_buf port map (eq(lpm_width-1),eqi(j));

            end generate;
        end generate;
        aeqb(j+1) <= aeqb(j) AND eqi(j);
    end generate;

    albi(albi'high) <= '0';
    agbi(agbi'high) <= '0';
    GNE: for j in ((lpm_width-1)/K) downto 0 generate
        lt(j*K) <= b(j*K) AND NOT (a(j*K) AND b(j*K));
        gt(j*K) <= a(j*K) AND NOT (a(j*K) AND b(j*K));
        C1: for i in ((j*K)+1) to ((j*K)+(K-1)) generate
            C2: if (i < lpm_width) generate
                lt(i) <= (b(i) AND NOT (a(i) AND b(i))) OR
                            (lt(i-1) AND xnor_array(i));
                gt(i) <= (a(i) AND NOT (a(i) AND b(i))) OR
                            (gt(i-1) AND xnor_array(i));
            end generate;
        end generate;
        C3: if (j /= ((lpm_width-1)/K)) generate

            U1: cy_buf port map (lt((j*K)+(K-1)),lti(j));
            U2: cy_buf port map (gt((j*K)+(K-1)),gti(j));

        end generate;
        C4: if (j = ((lpm_width-1)/K)) generate
            C5: if (((lpm_width-1) rem K) < (K-j)) generate
                lti(j) <= lt(lpm_width-1);
                gti(j) <= gt(lpm_width-1);
            end generate;
            C6: if (((lpm_width-1) rem K) >= (K-j)) generate

                U1: cy_buf port map (lt(lpm_width-1),lti(j));
                U2: cy_buf port map (gt(lpm_width-1),gti(j));

            end generate;
        end generate;
        albi(j) <= albi(j+1) OR (lti(j) AND NOT agbi(j+1));
        agbi(j) <= agbi(j+1) OR (gti(j) AND NOT albi(j+1));
    end generate;
    assert (lpm_pipeline <= 0)
    report "Mcompare pipeline not allowed for this device.  Disabling pipe."
    severity note;

    aeb <= aeqb(aeqb'high);
    aneb <= NOT aeqb(aeqb'high);
    alb <= albi(0);
    aleb <= NOT agbi(0);
    agb <= agbi(0);
    ageb <= NOT albi(0);

end archlpmstd;
