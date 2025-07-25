--

--
-- MMULT
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;
use cypress.lpmpkg.all;
entity mmult is
    generic(lpm_widtha : positive := 1;
     lpm_widthb : positive := 1;
     lpm_widths : natural := 0;
     lpm_widthp : positive := 2;
     lpm_representation : repre_type := LPM_UNSIGNED;
     lpm_hint : goal_type := SPEED;
     lpm_avalue : std_logic_vector := "");
    port (dataa : in std_logic_vector(lpm_widtha-1 downto 0);
     datab : in std_logic_vector(lpm_widthb-1 downto 0);
     sum : in std_logic_vector(lpm_widths-1 downto 0) := (others => zero);
     result : out std_logic_vector(lpm_widthp-1 downto 0));
end mmult;

architecture c39k of mmult is

    function typ(T : repre_type) return BOOLEAN is
    begin
        if (T = lpm_unsigned) then
            return(FALSE);
        elsif (T = lpm_signed) then
            return(TRUE);
        else
            assert FALSE
            report "Type should be lpm_signed or lpm_unsigned"
            severity ERROR ;
            return (true);
        end if;
    end typ;

    function getPsize (a, b : natural) return natural is
    begin
        if ((a = 1) OR (b = 1)) then
            return max(a,b);
        end if;
        return a + b;
    end getPsize;

    function getSsize (a, b : natural) return natural is
    begin
        if (b <= 0) then
            return a;
        end if;
        if (a >= b) then
            return a + 1;
        end if;
        return b + 1;
    end getSsize;

    function mask (a:std_logic ; b:std_logic_vector) return std_logic_vector is
        variable tmp : std_logic_vector(b'range) := (others => a);
    begin
        return (b AND tmp);
    end mask;

    constant mtype : boolean := typ(lpm_representation);
    constant isize : natural := max(lpm_widtha,lpm_widthb);
    constant psize : natural := getPsize(lpm_widtha,lpm_widthb);
    constant ssize : natural := getSsize(psize,lpm_widths);
    constant osize : natural := max(psize,lpm_widths);
    signal az,bz,pp : std_logic_vector(psize-1 downto 0);
    signal a0,b0,x : std_logic_vector(ssize-1 downto 0);
    signal sgnxtnd : std_logic;
    signal one : std_logic := '1';
    signal ZeRo : std_logic := '0';

begin

    -- multiply by a single Bit

    G1: if (lpm_widtha = 1 OR lpm_widthb = 1) generate
        ug: if (lpm_representation = lpm_unsigned) generate
            A: if (lpm_widtha = 1) generate
                pp <= mask(dataA(0),dataB);
            end generate;
            B: if (lpm_widtha /= 1) generate
                pp <= mask(dataB(0),dataA);
            end generate;
        end generate;

        sg: if (lpm_representation = lpm_signed) generate
            assert (false)
            report "Signed multiply with input lengths of 1 are not legal."
            severity failure;
        end generate;
    end generate;

    -- multiply by 2 Bits

    G2: if (lpm_widtha = 2 AND lpm_widthb > 1) OR
           (lpm_widtha > 1 AND lpm_widthb = 2) generate
        ug: if (lpm_representation = lpm_unsigned) generate
            A: if (lpm_widtha = 2) generate
                az(psize-1 downto isize) <= (others => '0');
                az(isize-1 downto 0) <= mask(dataA(0),dataB);
                bz(psize-1 downto isize+1) <= (others => '0');
                bz(isize downto 1) <= mask(dataA(1),dataB);
                bz(0) <= '0';
            end generate;
            B: if (lpm_widtha /= 2) generate
                az(psize-1 downto isize) <= (others => '0');
                az(isize-1 downto 0) <= mask(dataB(0),dataA);
                bz(psize-1 downto isize+1) <= (others => '0');
                bz(isize downto 1) <= mask(dataB(1),dataA);
                bz(0) <= '0';
            end generate;
            U1: madd_sub generic map(lpm_width=>psize,
                                    lpm_representation=>lpm_unsigned,
                                    lpm_direction=>lpm_add)
                            port map(dataA=>az,dataB=>bz,cin=>ZeRo,result=>pp,
                                    add_sub=>one);
        end generate;

        sg: if (lpm_representation = lpm_signed) generate
            A: if (lpm_widtha = 2) generate
                sgnxtnd <= dataB(dataB'high);
                az(psize-1 downto isize) <= (others => sgnxtnd AND dataA(0));
                az(isize-1 downto 0) <= mask(dataA(0),dataB);
                bz(psize-1 downto isize+1) <= (others => sgnxtnd AND dataA(1));
                bz(isize downto 1) <= mask(dataA(1),dataB);
                bz(0) <= '0';
            end generate;
            B: if (lpm_widtha /= 2) generate
                sgnxtnd <= dataA(dataA'high);
                az(psize-1 downto isize) <= (others => sgnxtnd AND dataB(0));
                az(isize-1 downto 0) <= mask(dataB(0),dataA);
                bz(psize-1 downto isize+1) <= (others => sgnxtnd AND dataB(1));
                bz(isize downto 1) <= mask(dataB(1),dataA);
                bz(0) <= '0';
            end generate;
            U1: madd_sub generic map(lpm_width=>psize,
                                    lpm_representation=>lpm_signed,
                                    lpm_direction=>lpm_sub)
                            port map(dataA=>az,dataB=>bz,cin=>one,result=>pp,
                                    add_sub=>ZeRo);
        end generate;
    end generate;

    -- if both A and B are bigger than 2 Bits, call the atomic multiplier

    tc: if (lpm_widtha > 2 AND lpm_widthb > 2) generate
            i1: cy_c39Kmultiply generic map(IsSigned=> mtype,
                                     DataWidthA=>lpm_widtha,
                                     DataWidthB=>lpm_widthb,
                                     DataWidthP=>psize,
                                     Hint=>lpm_hint)
                             port map(Data_A => dataA,
                                      Data_B => dataB,
                                      Product => pp);
    end generate;

    -- Align the product and the partial sum.

    GA:if (lpm_widthS > 0) generate

        a0((ssize-1) downto psize) <= (OTHERS => '0');
        a0((psize-1) downto 0) <= pp;
        b0((ssize-1) downto lpm_widthS) <= (OTHERS => '0');
        b0((lpm_widthS-1) downto 0) <= sum;

        U0: Madd_sub generic map (ssize,lpm_unsigned,lpm_add,lpm_hint)
                        port map (a0,b0,ZeRo,One,x,open,open);
    end generate;

    -- No partial sum.

    GN:if (lpm_widthS = 0) generate
        x <= pp((ssize-1) downto 0);
    end generate;

    -- Align the result with the MSB of the product.

    rl: if (lpm_widthP > osize) generate
        ug: if (lpm_representation = lpm_unsigned) generate
            result((lpm_widthP-1) downto osize) <= (OTHERS => '0');
        end generate;
        sg: if (lpm_representation = lpm_signed) generate
            result((lpm_widthP-1) downto osize) <= (OTHERS => x(x'high));
        end generate;
        result((osize-1) downto 0) <= x(osize-1 downto 0);
    end generate;

    pl: if (lpm_widthP < osize) generate
        result <= x((osize-1) downto (osize-lpm_widthP));
    end generate;

    pe: if (lpm_widthP = osize) generate
        result <= x(osize-1 downto 0);
    end generate;
end c39k;
