--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
package modcnstpkg is
    component cinc
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                sum : out std_logic_vector(width-1 downto 0));
    end component;

    component finc
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                cin : in std_logic;
                sum : out std_logic_vector(width-1 downto 0));
    end component;

    component cadd
        generic(width : natural;
                firstOne: natural;
                lastOne : natural);
        port( A,K : in std_logic_vector(width-1 downto 0);
                sum : out std_logic_vector(width-1 downto 0));
    end component;

    component cdec
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                dif : out std_logic_vector(width-1 downto 0));
    end component;

    component fdec
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                bin : in std_logic;
                dif : out std_logic_vector(width-1 downto 0));
    end component;

    component csub
        generic(width : natural;
                firstOne: natural;
                lastOne : natural);
        port( A,K : in std_logic_vector(width-1 downto 0);
                dif : out std_logic_vector(width-1 downto 0));
    end component;

    component Mmultc
        generic(lpm_widthA : positive;
                lpm_widthB : positive;
                lpm_widthS : natural := 0;
                lpm_widthP : positive;
                lpm_representation : repre_type := lpm_unsigned;
                lpm_hint : goal_type := speed);
        port( dataA : in std_logic_vector(lpm_widthA-1 downto 0);
                dataB : in std_logic_vector(lpm_widthB-1 downto 0);
                sum : in std_logic_vector(lpm_widthS-1 downto 0)
                                                         := (others => '0');
                result : out std_logic_vector(lpm_widthP-1 downto 0));
    end component;
end modcnstpkg;

--
-- Module for a INCrementor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_buf;

entity cinc is
    generic(width : natural);
    port(dataA : in std_logic_vector((width-1) downto 0);
        sum : out std_logic_vector((width-1) downto 0));
end cinc;

architecture archcinc of cinc is

    constant K : integer := 24;
    signal c,b : std_logic_vector(dataA'range);

begin

    GS: for i in dataA'range generate

        G1: if ((i REM K) /= 0) generate
            c(i) <= dataA(i-1) AND c(i-1);
        end generate;

        G2: if ((i REM K) = 0) generate
            b(i) <= (dataA(i-1) AND c(i-1)) when (i /= 0) else '1';
            G3: if i /= 0 generate
                UB: cy_buf port map (b(i),c(i));
            end generate;
            G4: if i = 0 generate
                c(i) <= b(i);
            end generate;
        end generate;

        sum(i) <= c(i) XOR dataA(i);

    end generate;

end archcinc;

--
-- Module for a INCrementor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_buf;

entity finc is
    generic(width : natural);
    port(dataA : in std_logic_vector((width-1) downto 0);
        cin : in std_logic;
        sum : out std_logic_vector((width-1) downto 0));
end finc;

architecture archFINC of finc is

    constant K : integer := 32;
    signal c,b : std_logic_vector(dataA'range);

begin

    GS: for i in dataA'range generate

        G1: if ((i REM K) /= 0) generate
            c(i) <= dataA(i-1) AND c(i-1);
        end generate;

        G2: if ((i REM K) = 0) generate
            b(i) <= (dataA(i-1) AND c(i-1)) when (i /= 0) else cin;
            G3: if i /= 0 generate
                UB: cy_buf port map (b(i),c(i));
            end generate;
            G4: if i = 0 generate
                c(i) <= b(i);
            end generate;
        end generate;

        sum(i) <= c(i) XOR dataA(i);

    end generate;

end archFINC;

--
-- Module for a DECrementor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_buf;

entity cdec is
    generic(width : natural);
    port(dataA : in std_logic_vector((width-1) downto 0);
        dif : out std_logic_vector((width-1) downto 0));
end cdec;

architecture archCDEC of cdec is

    constant K : integer := 24;
    signal c,b : std_logic_vector(dataA'range);

begin

    GS: for i in dataA'range generate

        G1: if ((i REM K) /= 0) generate
            c(i) <= NOT dataA(i-1) AND c(i-1);
        end generate;

        G2: if ((i REM K) = 0) generate
            b(i) <= (NOT dataA(i-1) AND c(i-1)) when (i /= 0) else '1';
            G3: if i /= 0 generate
                UB: cy_buf port map (b(i),c(i));
            end generate;
            G4: if i = 0 generate
                c(i) <= b(i);
            end generate;
        end generate;

        dif(i) <= c(i) XOR dataA(i);

    end generate;

end archCDEC;

--
-- Module for a DECrementor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_buf;

entity fdec is
    generic(width : natural);
    port(dataA : in std_logic_vector((width-1) downto 0);
        bin : in std_logic;
        dif : out std_logic_vector((width-1) downto 0));
end fdec;

architecture archFDEC of fdec is

    constant K : integer := 32;
    signal c,b : std_logic_vector(dataA'range);

begin

    GS: for i in dataA'range generate

        G1: if ((i REM K) /= 0) generate
            c(i) <= NOT dataA(i-1) AND c(i-1);
        end generate;

        G2: if ((i REM K) = 0) generate
            b(i) <= (NOT dataA(i-1) AND c(i-1)) when (i /= 0) else bin;
            G3: if i /= 0 generate
                UB: cy_buf port map (b(i),c(i));
            end generate;
            G4: if i = 0 generate
                c(i) <= b(i);
            end generate;
        end generate;

        dif(i) <= c(i) XOR dataA(i);

    end generate;

end archFDEC;

--
-- Module for an ADDer
--
library ieee;
use ieee.std_logic_1164.all;
entity cadd is
    generic(width : natural;
            firstone : natural;
            lastone : natural);
    port(A,K : in std_logic_vector((width-1) downto 0);
        sum : out std_logic_vector((width-1) downto 0));
end cadd;

architecture archCADD of cadd is

    signal c : std_logic_vector(A'range);
    constant d : integer := 3;

begin

    sum(0) <= A(0) XOR K(0);
    c(0) <= A(0) AND K(0);

    GS: for i in (A'low+1) to A'high generate
        sum(i) <= k(i) when (a(i) = c(i-1)) else NOT k(i);
        GC1: if ((i rem d) = 1) generate
            c(i) <= (A(i) AND K(i)) OR
                    (A(i) AND c(i-1)) OR
                    (K(i) AND c(i-1));
        end generate;
        GC2: if ((i rem d) = 2) generate
            c(i) <= (A(i) AND K(i)) OR
                    (A(i) AND ((A(i-1) AND K(i-1)) OR
                                (A(i-1) AND c(i-2)) OR
                                (K(i-1) AND c(i-2)))) OR
                    (K(i) AND ((A(i-1) AND K(i-1)) OR
                                (A(i-1) AND c(i-2)) OR
                                (K(i-1) AND c(i-2))));
        end generate;
        GC3: if ((i rem d) = 0) generate
            c(i) <= (A(i) AND K(i)) OR
                    (A(i) AND ((A(i-1) AND K(i-1)) OR
                                (A(i-1) AND ((A(i-2) AND K(i-2)) OR
                                             (A(i-2) AND c(i-3)) OR
                                             (K(i-2) AND c(i-3)))) OR
                                (K(i-1) AND ((A(i-2) AND K(i-2)) OR
                                             (A(i-2) AND c(i-3)) OR
                                             (K(i-2) AND c(i-3)))))) OR
                    (K(i) AND ((A(i-1) AND K(i-1)) OR
                                (A(i-1) AND ((A(i-2) AND K(i-2)) OR
                                             (A(i-2) AND c(i-3)) OR
                                             (K(i-2) AND c(i-3)))) OR
                                (K(i-1) AND ((A(i-2) AND K(i-2)) OR
                                             (A(i-2) AND c(i-3)) OR
                                             (K(i-2) AND c(i-3))))));

        end generate;
    end generate;
end archCADD;

--
-- Module for an SUBtractor
--
library ieee;
use ieee.std_logic_1164.all;
entity csub is
    generic(width : natural;
            firstone : natural;
            lastone : natural);
    port(A,K : in std_logic_vector((width-1) downto 0);
        dif : out std_logic_vector((width-1) downto 0));
end csub;

architecture archcsub of csub is

    signal b : std_logic_vector(A'range);
    constant d : integer := 3;

begin

    dif(0) <= A(0) XOR K(0);
    b(0) <= NOT (NOT A(0) AND K(0));

    GS: for i in (A'low+1) to A'high generate
        dif(i) <= k(i) when (a(i) /= b(i-1)) else NOT k(i);
        GC1: if ((i rem d) = 1) generate
            b(i) <= NOT ((NOT A(i) AND K(i)) OR
                    (NOT A(i) AND NOT b(i-1)) OR
                    (K(i) AND NOT b(i-1)));
        end generate;
        GC2: if ((i rem d) = 2) generate
            b(i) <= NOT ((NOT A(i) AND K(i)) OR
                    (NOT A(i) AND ((NOT A(i-1) AND K(i-1)) OR
                                (NOT A(i-1) AND NOT b(i-2)) OR
                                (K(i-1) AND NOT b(i-2)))) OR
                    (K(i) AND ((NOT A(i-1) AND K(i-1)) OR
                                (NOT A(i-1) AND NOT b(i-2)) OR
                                (K(i-1) AND NOT b(i-2)))));
        end generate;
        GC3: if ((i rem d) = 0) generate
            b(i) <= NOT ((NOT A(i) AND K(i)) OR
                    (NOT A(i) AND ((NOT A(i-1) AND K(i-1)) OR
                                (NOT A(i-1) AND ((NOT A(i-2) AND K(i-2)) OR
                                             (NOT A(i-2) AND NOT b(i-3)) OR
                                             (K(i-2) AND NOT b(i-3)))) OR
                                (K(i-1) AND ((NOT A(i-2) AND K(i-2)) OR
                                             (NOT A(i-2) AND NOT b(i-3)) OR
                                             (K(i-2) AND NOT b(i-3)))))) OR
                    (K(i) AND ((NOT A(i-1) AND K(i-1)) OR
                                (NOT A(i-1) AND ((NOT A(i-2) AND K(i-2)) OR
                                             (NOT A(i-2) AND NOT b(i-3)) OR
                                             (K(i-2) AND NOT b(i-3)))) OR
                                (K(i-1) AND ((NOT A(i-2) AND K(i-2)) OR
                                             (NOT A(i-2) AND NOT b(i-3)) OR
                                             (K(i-2) AND NOT b(i-3)))))));

        end generate;
    end generate;
end archcsub;

--
-- MMULTC
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;

entity Mmultc is
    generic(lpm_widthA : positive;
            lpm_widthB : positive;
            lpm_widthS : natural := 0;
            lpm_widthP : positive;
            lpm_representation : repre_type := lpm_unsigned;
            lpm_hint : goal_type := speed);
    port( dataA : in std_logic_vector((lpm_widthA-1) downto 0);
            dataB : in std_logic_vector((lpm_widthB-1) downto 0);
            sum : in std_logic_vector((lpm_widthS-1) downto 0);
            result : out std_logic_vector((lpm_widthP-1) downto 0));
end Mmultc;

architecture archlpmstd of Mmultc is

    type bvm is array (integer range <>,integer range <>) of std_logic;
    constant psize : natural := max(lpm_widthA,lpm_widthB);
    constant asize : natural := max((lpm_widthA+lpm_widthB),lpm_widthS);
    signal a,b : std_logic_vector ((psize-1) downto 0);
    signal I,c,s : bvm (a'range,b'range);
    signal p : std_logic_vector (((psize*2)-1) downto 0);
    signal a0,b0,x : std_logic_vector ((asize-1) downto 0);
    signal Imax : std_logic;
    signal Ic,Ix : std_logic;
    signal one : std_logic := '1';
    signal zero : std_logic := '0';

begin

    -- Make the multiplier symmetrical.

    R0: if (lpm_widthA > lpm_widthB) generate
        SG: if (lpm_representation = lpm_signed) generate
            b((psize-1) downto lpm_widthB) <= (OTHERS => dataB(dataB'high));
        end generate;
        UN: if (lpm_representation = lpm_unsigned) generate
            b((psize-1) downto lpm_widthB) <= (OTHERS => '0');
        end generate;
        b((lpm_widthB - 1) downto 0) <= dataB;
        a <= dataA;
    end generate;
    R1: if (lpm_widthA < lpm_widthB) generate
        SG: if (lpm_representation = lpm_signed) generate
            a((psize-1) downto lpm_widthA) <= (OTHERS => dataA(dataA'high));
        end generate;
        UN: if (lpm_representation = lpm_unsigned) generate
            a((psize-1) downto lpm_widthA) <= (OTHERS => '0');
        end generate;
        a((lpm_widthA - 1) downto 0) <= dataA;
        b <= dataB;
    end generate;
    R2: if (lpm_widthA = lpm_widthB) generate
        a <= dataA;
        b <= dataB;
    end generate;

    I0: for j in 0 to (psize-1) generate
        I1: for k in 0 to (psize-1) generate
            SG: if (lpm_representation = lpm_signed) generate
                I0: if ((k /= psize-1) and (j /= psize-1)) generate
                    I(j,k) <= a(j) and b(k);
                end generate;
                I1: if ((k /= psize-1) and (j = psize-1)) generate
                    I(j,k) <= a(j) and not b(k);
                end generate;
                I2: if ((k = psize-1) and (j /= psize-1)) generate
                    I(j,k) <= not a(j) and b(k);
                end generate;
                I3: if ((k = psize-1) and (j = psize-1)) generate
                    I(j,k) <= a(j) and b(k);
                end generate;
            end generate;
            NG: if (lpm_representation = lpm_unsigned) generate
                I(j,k) <= a(j) and b(k);
            end generate;
        end generate;
    end generate;
    SG: if (lpm_representation = lpm_signed) generate
        Imax <= I(psize-1,psize-1) xor a(psize-1) xor b(psize-1);
        Ic <= (I(psize-1,psize-1) and not a(psize-1)) or
               (I(psize-1,psize-1) and not b(psize-1)) or
                   (not a(psize-1) and not b(psize-1));
        Ix <= (s(0,psize-2) and a(psize-1)) or
               (s(0,psize-2) and b(psize-1)) or
                 (a(psize-1) and b(psize-1));
    end generate;
    NG: if (lpm_representation = lpm_unsigned) generate
        Imax <= I((psize-1),(psize-1));
        Ic <= '1';
        Ix <= '0';
    end generate;

    CL: for l in 0 to (psize-2) generate
        CM: for m in 0 to (psize-1) generate
        -- Column 0 of the array.
            C0: if (m = 0) generate
                s(l,m) <= I(m,l+1) xor I(m+1,l);
                c(l,m) <= I(m,l+1) and I(m+1,l);
            end generate;
        -- Column 1 through m-1 of the array.
            C1: if ((m > 0) and (m < (psize-1))) generate
                C2: if (l < (psize-2)) generate
                s(l,m) <= (s(l+1,m-1) xor c(l,m-1) xor I(m+1,l));
                c(l,m) <= (s(l+1,m-1) and c(l,m-1)) or
                           (s(l+1,m-1) and I(m+1,l)) or
                           (c(l,m-1) and I(m+1,l));
                end generate;
                C3: if (l = (psize-2)) generate
                s(l,m) <= (I(m,l+1) xor c(l,m-1) xor I(m+1,l));
                c(l,m) <= (I(m,l+1) and c(l,m-1)) or
                           (I(m,l+1) and I(m+1,l)) or
                           (c(l,m-1) and I(m+1,l));
                end generate;
            end generate;
        -- Column m of the array.
            C4: if (m = (psize-1)) generate
        -- Special case the 2x2 multiplier.
                GS: if ((psize-1) <= 1) generate
                    s(l,m) <= (Imax xor c(l,m-1)) xor Ix;
                    c(l,m) <= (Imax and c(l,m-1)) or
                               (Imax and Ix) or (c(l,m-1) and Ix);
                end generate;
                GL: if ((psize-1) > 1) generate
                    C5: if (l = 0) generate
                        s(l,m) <= s(l+1,m-1) xor c(l,m-1) xor Ix;
                        c(l,m) <= (s(l+1,m-1) and c(l,m-1)) or
                                   (s(l+1,m-1) and Ix) or
                                   (c(l,m-1) and Ix);
                    end generate;
                    C6: if ((l > 0) and (l < (psize-2))) generate
                        s(l,m) <= s(l+1,m-1) xor c(l,m-1) xor c(l-1,m);
                        c(l,m) <= (s(l+1,m-1) and c(l,m-1)) or
                                   (s(l+1,m-1) and c(l-1,m)) or
                                   (c(l,m-1) and c(l-1,m));
                    end generate;
                    C7: if (l = (psize-2)) generate
                        s(l,m) <= (Imax xor c(l,m-1) xor c(l-1,m));
                        c(l,m) <= (Imax and c(l,m-1)) or
                                   (Imax and c(l-1,m)) or
                                   (c(l,m-1) and c(l-1,m));
                    end generate;
                end generate;
            end generate;
        end generate;
    end generate;

    -- Gather the product.

    p(0) <= I(0,0);
    G0: for l in 1 to (psize-1) generate
        SG: if (lpm_representation = lpm_signed) generate
            P1: if (l /= psize-1) generate
                p(l) <= s(0,l-1);
            end generate;
            P2: if (l = psize-1) generate
                p(l) <= s(0,l-1) xor (a(psize-1) xor b(psize-1));
            end generate;
        end generate;
        NG: if (lpm_representation = lpm_unsigned) generate
            p(l) <= s(0,l-1);
        end generate;
    end generate;
    G1: for l in psize to ((psize*2)-2) generate
        p(l) <= s((l-psize),(psize-1));
    end generate;
    G2: if (psize*2 = 2) generate
        p(1) <= '0';
    end generate;
    G3: if (psize*2 > 2) generate
        p(p'high) <= c(psize-2,(psize-1)) xor not Ic;
    end generate;

    -- Align the product and the partial sum.

    GA:if (lpm_widthS > 0) generate
        G4: if (lpm_widthA+lpm_widthB < lpm_widthS) generate
            a0((asize-1) downto (lpm_widthA+lpm_widthB)) <= (OTHERS => '0');
            a0((lpm_widthA+lpm_widthB-1) downto 0) <=
                                        p((lpm_widthA+lpm_widthB-1) downto 0);
            b0 <= sum;
        end generate;
        G5: if (lpm_widthA+lpm_widthB > lpm_widthS) generate
            a0 <= p;
            b0((asize-1) downto (lpm_widthS)) <= (OTHERS => '0');
            b0(sum'range) <= sum;
        end generate;
        G6: if (lpm_widthA+lpm_widthB = lpm_widthS) generate
            a0 <= p((lpm_widthA+lpm_widthB-1) downto 0);
            b0 <= sum;
        end generate;

        U0: madd_sub generic map (asize,lpm_unsigned,lpm_add,lpm_hint)
                        port map (a0,b0,zero,one,x,open,open);
    end generate;

    -- No partial sum.

    GN:if (lpm_widthS = 0) generate
            x <= p((asize-1) downto 0);
    end generate;

    -- Align the result with the MSB of the product.

    G7: if (lpm_widthP > asize) generate
        result((lpm_widthP-1) downto asize) <= (OTHERS => '0');
        result((asize-1) downto 0) <= x;
    end generate;
    G8: if (lpm_widthP < asize) generate
        result <= x((asize-1) downto (asize-lpm_widthP));
    end generate;
    G9: if (lpm_widthP = asize) generate
        result <= x;
    end generate;

end archlpmstd;
