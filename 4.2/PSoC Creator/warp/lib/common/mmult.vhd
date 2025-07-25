--

--
-- MMULT
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;

use cypress.rtlpkg.cy_buf;

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

architecture archlpmstd of Mmult is

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

    type bvm is array (integer range <>,integer range <>) of std_logic;
    constant isize : natural := max(lpm_widthA,lpm_widthB);
    constant psize : natural := getPsize(lpm_widtha,lpm_widthb);
    constant ssize : natural := getSsize(psize,lpm_widthS);
    constant osize : natural := max(psize,lpm_widthS);
    signal a,b : std_logic_vector (isize-1 downto 0);
    signal I,c,s,ci,si : bvm (a'range,b'range);
    signal p : std_logic_vector (psize-1 downto 0);
    signal a0,b0,x : std_logic_vector (ssize-1 downto 0);
    signal Imax,Isg : std_logic;
    signal Icg,Ixg,Itmp : std_logic;
    signal One : std_logic := '1';
    signal Zero : std_logic := '0';

begin

    SGW: if (lpm_representation = lpm_signed) generate
        assert ((lpm_widthA >= 2) AND (lpm_widthB >= 2))
        report "Signed multiply with input lengths of 1 are illegal."
        severity failure;
    end generate;

    -- Make the multiplier symmetrical.

    R0: if (lpm_widthA > lpm_widthB) generate
        SG: if (lpm_representation = lpm_signed) generate
            b((isize-1) downto lpm_widthB) <= (OTHERS => dataB(dataB'high));
        end generate;
        UN: if (lpm_representation = lpm_unsigned) generate
            b((isize-1) downto lpm_widthB) <= (OTHERS => '0');
        end generate;
        b((lpm_widthB - 1) downto 0) <= dataB;
        a <= dataA;
    end generate;
    R1: if (lpm_widthA < lpm_widthB) generate
        SG: if (lpm_representation = lpm_signed) generate
            a((isize-1) downto lpm_widthA) <= (OTHERS => dataA(dataA'high));
        end generate;
        UN: if (lpm_representation = lpm_unsigned) generate
            a((isize-1) downto lpm_widthA) <= (OTHERS => '0');
        end generate;
        a((lpm_widthA - 1) downto 0) <= dataA;
        b <= dataB;
    end generate;
    R2: if (lpm_widthA = lpm_widthB) generate
        a <= dataA;
        b <= dataB;
    end generate;

    I0: for j in 0 to (isize-1) generate
        I1: for k in 0 to (isize-1) generate
            SG: if (lpm_representation = lpm_signed) generate
                I0: if ((k /= isize-1) and (j /= isize-1)) generate
                    I(j,k) <= a(j) and b(k);
                end generate;
                I1: if ((k /= isize-1) and (j = isize-1)) generate
                    I(j,k) <= a(j) and not b(k);
                end generate;
                I2: if ((k = isize-1) and (j /= isize-1)) generate
                    I(j,k) <= not a(j) and b(k);
                end generate;
                I3: if ((k = isize-1) and (j = isize-1)) generate
                    I(j,k) <= a(j) and b(k);
                end generate;
            end generate;
            NG: if (lpm_representation = lpm_unsigned) generate
                I(j,k) <= a(j) and b(k);
            end generate;
        end generate;
    end generate;
    SG: if (lpm_representation = lpm_signed) generate
        Isg <= I(isize-1,isize-1) xor a(isize-1) xor b(isize-1);
        Icg <= (I(isize-1,isize-1) and not a(isize-1)) or
               (I(isize-1,isize-1) and not b(isize-1)) or
                   (not a(isize-1) and not b(isize-1));

        Itmp <= (s(0,isize-2) and a(isize-1)) or
                 (s(0,isize-2) and b(isize-1)) or
                 (a(isize-1) and b(isize-1));
        U0: cy_buf port map (Itmp,Ixg);

    end generate;
    NG: if (lpm_representation = lpm_unsigned) generate
        Isg <= I((isize-1),(isize-1));
        Icg <= '1';
        Ixg <= '0';
    end generate;

    NB: if ((isize-1) <= 1) generate
        Imax <= Isg;
    end generate;
    BF: if ((isize-1) > 1) generate
        U0: cy_buf port map (Isg,Imax);
    end generate;

    CL: for col in 0 to (isize-2) generate
        CM: for row in 0 to (isize-1) generate
        -- Row 0 of the array.
            C0: if (row = 0) generate
                si(col,row) <= I(row,col+1) xor I(row+1,col);
                ci(col,row) <= I(row,col+1) and I(row+1,col);
                s(col,row) <= si(col,row);
                c(col,row) <= ci(col,row);
            end generate;
        -- Row 1 through max-1 of the array.
            C1: if ((row > 0) and (row < (isize-1))) generate
                C2: if (col < (isize-2)) generate
                si(col,row) <= (s(col+1,row-1) xor c(col,row-1) xor
                                I(row+1,col));
                ci(col,row) <= (s(col+1,row-1) and c(col,row-1)) or
                                (s(col+1,row-1) and I(row+1,col)) or
                                (c(col,row-1) and I(row+1,col));
                end generate;
                C3: if (col = (isize-2)) generate
                si(col,row) <= (I(row,col+1) xor c(col,row-1) xor
                                I(row+1,col));
                ci(col,row) <= (I(row,col+1) and c(col,row-1)) or
                                (I(row,col+1) and I(row+1,col)) or
                                (c(col,row-1) and I(row+1,col));
                end generate;

                BS: cy_buf port map (si(col,row),s(col,row));
                BC: cy_buf port map (ci(col,row),c(col,row));

            end generate;
        -- last row of the array.
            C4: if (row = (isize-1)) generate
        -- Special case the 2x2 multiplier.
                GS: if ((isize-1) <= 1) generate
                    si(col,row) <= (Imax xor c(col,row-1)) xor Ixg;
                    ci(col,row) <= (Imax and c(col,row-1)) or
                                    (Imax and Ixg) or (c(col,row-1) and Ixg);
                end generate;
                GL: if ((isize-1) > 1) generate
                    C5: if (col = 0) generate
                        si(col,row) <= s(col+1,row-1) xor c(col,row-1) xor Ixg;
                        ci(col,row) <= (s(col+1,row-1) and c(col,row-1)) or
                                        (s(col+1,row-1) and Ixg) or
                                        (c(col,row-1) and Ixg);
                    end generate;
                    C6: if ((col > 0) and (col < (isize-2))) generate
                        si(col,row) <= s(col+1,row-1) xor c(col,row-1) xor
                                        c(col-1,row);
                        ci(col,row) <= (s(col+1,row-1) and c(col,row-1)) or
                                        (s(col+1,row-1) and c(col-1,row)) or
                                        (c(col,row-1) and c(col-1,row));
                    end generate;

                    -- ci is used here rather than c to force the last
                    -- cell to "try and fit" without an extra pass.
                    -- It prevents the buffer that may be a carry in from
                    -- the next to last cell in the chain.
                    C7: if (col = (isize-2)) generate
                        si(col,row) <= Imax xor c(col,row-1) xor ci(col-1,row);
                        ci(col,row) <= (Imax and c(col,row-1)) or
                                        (Imax and ci(col-1,row)) or
                                        (c(col,row-1) and ci(col-1,row));
                    end generate;
                end generate;
                C8: if ((col rem 2) = 0) generate
                    BH: if (col /= (isize-2)) generate
                        c(col,row) <= ci(col,row);
                    end generate;
                    NH: if (col = (isize-2)) generate
                        BC: cy_buf port map (ci(col,row),c(col,row));
                    end generate;
                end generate;
                C9: if ((col rem 2) /= 0) generate
                    BC: cy_buf port map (ci(col,row),c(col,row));
                end generate;
                BS: cy_buf port map (si(col,row),s(col,row));
            end generate;
        end generate;
    end generate;

    -- Gather the product.

    p(0) <= I(0,0);
    G0: for l in 1 to (isize-1) generate
        SG: if (lpm_representation = lpm_signed) generate
            P1: if (l /= isize-1) generate
                p(l) <= s(0,l-1);
            end generate;
            P2: if (l = isize-1) generate
                p(l) <= s(0,l-1) xor (a(isize-1) xor b(isize-1));
            end generate;
        end generate;
        NG: if (lpm_representation = lpm_unsigned) generate
            p(l) <= s(0,l-1);
        end generate;
    end generate;
    G1: if (isize <= psize-2) generate
        G1: for l in isize to (psize-2) generate
            p(l) <= s((l-isize),(isize-1));
        end generate;
    end generate;

    -- Get the MSB of the product

    G3: if (psize > 2) generate
        G4: if ((((lpm_widthA = 1) OR (lpm_widthB = 1)) AND
                  ((lpm_widthA = lpm_widthB + 1) OR
                   (lpm_widthB = lpm_widthA + 1))) OR
                   (lpm_widthA = lpm_widthB)) generate
            p(psize-1) <= c(isize-2,(isize-1)) xor not Icg;
        end generate;
        G5:if ((lpm_widthA /= 1) AND (lpm_widthB /= 1) AND
                (lpm_widthA /= lpm_widthB)) generate
            p(psize-1) <= s((psize-isize-1),(isize-1));
        end generate;
    end generate;

    -- No partial sum.

    GN:if (lpm_widthS = 0) generate
            x <= p((ssize-1) downto 0);
    end generate;

    -- Align the product and the partial sum.

    GA:if (lpm_widthS > 0) generate
        GS: if (lpm_representation = lpm_signed) generate
            a0((ssize-1) downto psize) <= (OTHERS => p(p'high));
            b0((ssize-1) downto lpm_widthS) <= (OTHERS => p(p'high));
        end generate;
        GU: if (lpm_representation = lpm_unsigned) generate
            a0((ssize-1) downto psize) <= (OTHERS => '0');
            b0((ssize-1) downto lpm_widthS) <= (OTHERS => '0');
        end generate;
        a0((psize-1) downto 0) <= p;
        b0((lpm_widthS-1) downto 0) <= sum;

        U0: Madd_sub generic map (ssize,lpm_representation,lpm_add,lpm_hint)
                        port map (a0,b0,Zero,One,x,open,open);
    end generate;

    -- Align the result with the MSB of the product.

    G7: if (lpm_widthP > osize) generate
        NG: if (lpm_representation = lpm_unsigned) generate
            result((lpm_widthP-1) downto osize) <= (OTHERS => '0');
        end generate;
        SG: if (lpm_representation = lpm_signed) generate
            result((lpm_widthP-1) downto osize) <= (OTHERS => x(x'high));
        end generate;
        result((osize-1) downto 0) <= x(osize-1 downto 0);
    end generate;
    G8: if (lpm_widthP < osize) generate
        result <= x((osize-1) downto (osize-lpm_widthP));
    end generate;
    G9: if (lpm_widthP = osize) generate
        result <= x(osize-1 downto 0);
    end generate;

end archlpmstd;
