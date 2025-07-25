--

--
-- MCOMPARE
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.cy_buf;
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

architecture c39k of mcompare is

    function gtz (val : natural) return natural is
    begin
        if (val >= 0 ) then return val; else return 0; end if;
    end gtz;
    constant tmplength : natural := gtz(lpm_pipeline-2);
    constant C : integer := 8;
    signal a,b : std_logic_vector( dataA'high downto 0);
    signal xor_array,neq: std_logic_vector( dataA'high downto 0);
    signal neqi, tmpneqi: std_logic_vector(( dataA'high/C) downto 0);
    signal aeqb : std_logic_vector(((dataA'high/C)+1) downto 0);
    signal tmpeq, tmpne : std_logic_vector( tmplength downto 0);
    signal Gtb,Ltb : std_logic;
    signal zErO : std_logic := '0' ;
    signal OnE : std_logic := '1' ;

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

    xor_array <= a XOR b;

    aeqb(0) <= '1';
    GEQ: for j in 0 to ((lpm_width-1)/C) generate
        neq(j*C) <= xor_array(j*C);
        C1: for i in ((j*C)+1) to ((j*C)+(C-1)) generate
            C2: if (i < lpm_width) generate
                neq(i) <= neq(i-1) OR xor_array(i);
            end generate;
        end generate;
        C3: if (j /= ((lpm_width-1)/C)) generate
            U1: cy_buf port map (neq((j*C)+(C-1)),neqi(j));
        end generate;
        C4: if (j = ((lpm_width-1)/C)) generate
            C5: if (((lpm_width-1) rem C) < (C-j)) generate
                neqi(j) <= neq(xor_array'high);
            end generate;
            C6: if (((lpm_width-1) rem C) >= (C-j)) generate
                U1: cy_buf port map (neq(lpm_width-1),neqi(j));
            end generate;
        end generate;

        RA: if (lpm_pipeline > 0) generate
            process (clock, aclr)
            begin
                if (aclr = '1') then
                    tmpneqi(j) <= '0';
                elsif (clock'event AND clock = '1') then
                    tmpneqi(j) <= neqi(j);
                end if;
            end process;
        end generate;
        RN: if (lpm_pipeline = 0) generate
            tmpneqi(j) <= neqi(j);
        end generate;

        aeqb(j+1) <= aeqb(j) AND NOT(tmpneqi(j));
    end generate;

    -- ASSUME: Pipeline registers are placed:
    -- 1 - between NEQ and AEQB.
    -- 2 to N - at the outputs.

    RN: if (lpm_pipeline <= 1) generate
        aeb <= aeqb(aeqb'high);
        aneb <= NOT aeqb(aeqb'high);
    end generate;
    RA: if (lpm_pipeline > 1) generate
        G0: for i in tmplength downto 0 generate
            process (clock, aclr)
            begin
                if (aclr = '1') then
                    tmpeq(i) <= '0';
                    tmpne(i) <= '0';

                elsif (rising_edge(clock)) then

                    if (i = 0) then
                        tmpeq(0) <= aeqb(aeqb'high);
                        tmpne(0) <= NOT aeqb(aeqb'high);
                    else
                        tmpeq(i) <= tmpeq(i-1);
                        tmpne(i) <= tmpne(i-1);
                    end if;
                end if;
            end process;
        end generate;
        aeb <= tmpeq(tmpeq'high);
        aneb <= tmpne(tmpne'high);
    end generate;

    -- The magnitude compares are pipelined in the add_sub component.
    AS1: madd_sub
     generic map(lpm_width => lpm_width, lpm_representation => lpm_unsigned,
                 lpm_pipeline => lpm_pipeline)
        port map( a, b, OnE, zErO, open, Ltb, open, clock, aclr);
    AS2: madd_sub
     generic map(lpm_width => lpm_width, lpm_representation => lpm_unsigned,
                 lpm_pipeline => lpm_pipeline)
        port map( b, a, OnE, zErO, open, Gtb, open, clock, aclr);

    agb <= NOT Gtb;
    alb <= NOT Ltb;
    ageb <= Ltb;
    aleb <= Gtb;

end c39k;
