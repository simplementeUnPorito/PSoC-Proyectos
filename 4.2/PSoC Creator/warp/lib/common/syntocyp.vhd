--

--------------------------------------------------------------------------------
--
-- Ultragen std_logic_arith entities and architectures
--
--------------------------------------------------------------------------------
--
-- add
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;

entity add_gen is
    generic (goal : goal_type := speed;
             IsSigned : Boolean := false;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in std_logic_vector; ss : out std_logic_vector);
end add_gen;

architecture module of add_gen is
    signal a,b,s,c : std_logic_vector ((ss'length-1) downto 0);
    signal zero : std_logic := '0';
    signal one : std_logic := '1';
begin

    L0:if (aa'length /= ss'length) generate
        a <= resize(aa,ss'length);
    end generate;
    L1:if (aa'length = ss'length) generate
        a <= aa;
    end generate;
    L2:if (bb'length /= ss'length) generate
        b <= resize(bb,ss'length);
    end generate;
    L3:if (bb'length = ss'length) generate
        b <= bb;
    end generate;

    ss <= s;

    G0: if (NOT IsAStatic AND NOT IsBStatic) generate
        G1: if (IsSigned) generate
            U0: madd_sub generic map (ss'length,lpm_signed,lpm_add,goal)
                            port map (a,b,zero,one,s,open,open);
        end generate;
        G2: if (NOT IsSigned) generate
            U0: madd_sub generic map (ss'length,lpm_unsigned,lpm_add,goal)
                            port map (a,b,zero,one,s,open,open);
        end generate;
    end generate;

    G1: if (NOT IsAStatic AND IsBStatic) generate
        -- Const equal to 0 or too big
        Z0: if (lsbOne >= ss'length) generate
            s <= a;
        end generate;
        -- Const NOT equal to 0
        Z1: if (lsbOne < ss'length) generate
            A0: if (goal /= speed) generate
                -- Constant NOT equal to one
                G0: if (lsbOne /= 0) OR (msbOne /= 0) generate
                    G0: for i in a'reverse_range generate
                        G1: if (i = a'low) generate
                            s(i) <= (a(i) XOR b(i));
                            c(i) <= (a(i) AND b(i));
                        end generate;
                        G2: if (i /= a'low) generate
                            s(i) <= (a(i) XOR b(i)) XOR c(i-1);
                            c(i) <= (a(i) AND b(i)) OR
                                    (a(i) AND c(i-1)) OR
                                    (b(i) AND c(i-1));
                        end generate;
                    end generate;
                end generate;
                -- Const equal to 1
                G1: if (lsbOne = 0) AND (msbOne = 0) generate
                    U0: cinc generic map (ss'length) port map (a,s);
                end generate;
            end generate;

            S0: if (goal = speed) generate
                -- Const Not equal to 1
                G0: if (lsbOne /= 0) OR (msbOne /= 0) generate
                    U0: cadd generic map (ss'length,lsbOne,msbOne)
                                port map (a,b,s);
                end generate;

                -- Const equal to 1
                G1: if (lsbOne = 0) AND (msbOne = 0) generate
                    U0: finc generic map (ss'length) port map (a,one,s);
                end generate;
            end generate;
        end generate;
    end generate;

    G2: if (IsAStatic AND IsBStatic) generate
        G0: for i in a'reverse_range generate
            G1: if (i = a'low) generate
                s(i) <= (a(i) XOR b(i));
                c(i) <= (a(i) AND b(i));
            end generate;
            G2: if (i /= a'low) generate
                s(i) <= (a(i) XOR b(i)) XOR c(i-1);
                c(i) <= (a(i) AND b(i)) OR
                        (a(i) AND c(i-1)) OR
                        (b(i) AND c(i-1));
            end generate;
        end generate;
    end generate;

end module;

-- add_uu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_uu_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        s : out unsigned);
end add_uu_u;

architecture module of add_uu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ui_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ui_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in integer;
        s : out unsigned);
end add_ui_u;

architecture module of add_ui_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_iu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_iu_u is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in unsigned;
        s : out unsigned);
end add_iu_u;

architecture module of add_iu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ub_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ub_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in std_ulogic;
        s : out unsigned);
end add_ub_u;

architecture module of add_ub_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bu_u is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in unsigned;
        s : out unsigned);
end add_bu_u;

architecture module of add_bu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ss_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ss_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        s : out signed);
end add_ss_s;

architecture module of add_ss_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_us_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_us_s is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        s : out signed);
end add_us_s;

architecture module of add_us_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_su_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_su_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        s : out signed);
end add_su_s;

architecture module of add_su_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_si_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_si_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in integer;
        s : out signed);
end add_si_s;

architecture module of add_si_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_is_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_is_s is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in signed;
        s : out signed);
end add_is_s;

architecture module of add_is_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_sb_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_sb_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in std_ulogic;
        s : out signed);
end add_sb_s;

architecture module of add_sb_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bs_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bs_s is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in signed;
        s : out signed);
end add_bs_s;

architecture module of add_bs_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_uu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_uu_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        s : out std_logic_vector);
end add_uu_v;

architecture module of add_uu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ui_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ui_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in integer;
        s : out std_logic_vector);
end add_ui_v;

architecture module of add_ui_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_iu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_iu_v is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in unsigned;
        s : out std_logic_vector);
end add_iu_v;

architecture module of add_iu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ub_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ub_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in std_ulogic;
        s : out std_logic_vector);
end add_ub_v;

architecture module of add_ub_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bu_v is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in unsigned;
        s : out std_logic_vector);
end add_bu_v;

architecture module of add_bu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_ss_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_ss_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        s : out std_logic_vector);
end add_ss_v;

architecture module of add_ss_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_us_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_us_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        s : out std_logic_vector);
end add_us_v;

architecture module of add_us_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_su_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_su_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        s : out std_logic_vector);
end add_su_v;

architecture module of add_su_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_si_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_si_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in integer;
        s : out std_logic_vector);
end add_si_v;

architecture module of add_si_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_is_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_is_v is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in signed;
        s : out std_logic_vector);
end add_is_v;

architecture module of add_is_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_sb_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_sb_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in std_ulogic;
        s : out std_logic_vector);
end add_sb_v;

architecture module of add_sb_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bs_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bs_v is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in signed;
        s : out std_logic_vector);
end add_bs_v;

architecture module of add_bs_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vv_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_vv_v_us;

architecture module of add_vv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vi_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vi_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        s : out std_logic_vector);
end add_vi_v_us;

architecture module of add_vi_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_iv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_iv_v_us is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_iv_v_us;

architecture module of add_iv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vb_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vb_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_ulogic;
        s : out std_logic_vector);
end add_vb_v_us;

architecture module of add_vb_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bv_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_bv_v_us;

architecture module of add_bv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_vv_v_sg;

architecture module of add_vv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vi_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vi_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        s : out std_logic_vector);
end add_vi_v_sg;

architecture module of add_vi_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_iv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_iv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_iv_v_sg;

architecture module of add_iv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_vb_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_vb_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_ulogic;
        s : out std_logic_vector);
end add_vb_v_sg;

architecture module of add_vb_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

-- add_bv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity add_bv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in std_logic_vector;
        s : out std_logic_vector);
end add_bv_v_sg;

architecture module of add_bv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: add_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, ss);
    end generate;

end module;

--------------------------------------------------------------------------------
--
-- sub
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;

entity sub_gen is
    generic (goal : goal_type := speed;
             IsSigned : Boolean := false;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in std_logic_vector; ss : out std_logic_vector);
end sub_gen;

architecture module of sub_gen is
    signal a,b,d,c : std_logic_vector ((ss'length-1) downto 0);
    signal zero : std_logic := '0';
    signal one : std_logic := '1';
begin

    L0:if (aa'length /= ss'length) generate
        a <= resize(aa,ss'length);
    end generate;
    L1:if (aa'length = ss'length) generate
        a <= aa;
    end generate;
    L2:if (bb'length /= ss'length) generate
        b <= resize(bb,ss'length);
    end generate;
    L3:if (bb'length = ss'length) generate
        b <= bb;
    end generate;

    ss <= d;

    G0: if (NOT IsAStatic AND NOT IsBStatic) generate
        G1: if (IsSigned) generate
            U0: madd_sub generic map (ss'length,lpm_signed,lpm_sub,goal)
                            port map (a,b,one,zero,d,open,open);
        end generate;
        G2: if (NOT IsSigned) generate
            U0: madd_sub generic map (ss'length,lpm_unsigned,lpm_sub,goal)
                            port map (a,b,one,zero,d,open,open);
        end generate;
    end generate;

    G1: if (NOT IsAStatic AND IsBStatic) generate
        -- Const equal to 0 or too big
        Z0: if (lsbOne >= ss'length) generate
            d <= a;
        end generate;
        -- Const NOT equal to 0
        Z1: if (lsbOne < ss'length) generate
            A0: if (goal /= speed) generate
                -- Constant NOT equal to one
                G0: if (lsbOne /= 0) OR (msbOne /= 0) generate
                    G0: for i in a'reverse_range generate
                        G1: if (i = a'low) generate
                            d(i) <= NOT (NOT a(i) XOR b(i));
                            c(i) <= (NOT a(i) AND b(i));
                        end generate;
                        G2: if (i /= a'low) generate
                            d(i) <=NOT(NOT a(i) XOR b(i)) XOR c(i-1);
                            c(i) <= (NOT a(i) AND b(i)) OR
                                    (NOT a(i) AND c(i-1)) OR
                                        (b(i) AND c(i-1));
                        end generate;
                    end generate;
                end generate;

                -- Const equal to 1
                G1: if (lsbOne = 0) AND (msbOne = 0) generate
                    U0: cdec generic map (ss'length) port map (a,d);
                end generate;
            end generate;

            S0: if (goal = speed) generate
                -- Const Not equal to 1
                G0: if (lsbOne /= 0) OR (msbOne /= 0) generate
                    U0: csub generic map (ss'length,lsbOne,msbOne)
                                port map (a,b,d);
                end generate;

                -- Const equal to 1
                G1: if (lsbOne = 0) AND (msbOne = 0) generate
                    U0: fdec generic map (ss'length) port map (a,one,d);
                end generate;
            end generate;
        end generate;
    end generate;

    G2: if (IsAStatic AND IsBStatic) generate
        G0: for i in a'reverse_range generate
            G1: if (i = a'low) generate
                d(i) <= NOT(NOT a(i) XOR b(i));
                c(i) <= (NOT a(i) AND b(i));
            end generate;
            G2: if (i /= a'low) generate
                d(i) <= NOT(NOT a(i) XOR b(i)) XOR c(i-1);
                c(i) <= (NOT a(i) AND b(i)) OR
                        (NOT a(i) AND c(i-1)) OR
                            (b(i) AND c(i-1));
            end generate;
        end generate;
    end generate;

    G3: if (IsAStatic AND NOT IsBStatic) generate
        A0: if (goal /= speed) generate
            G0: for i in a'reverse_range generate
                G1: if (i = a'low) generate
                    d(i) <= NOT(NOT a(i) XOR b(i));
                    c(i) <= (NOT a(i) AND b(i));
                end generate;
                G2: if (i /= a'low) generate
                    d(i) <= NOT(NOT a(i) XOR b(i)) XOR c(i-1);
                    c(i) <= (NOT a(i) AND b(i)) OR
                            (NOT a(i) AND c(i-1)) OR
                                (b(i) AND c(i-1));
                end generate;
            end generate;
        end generate;
        S0: if (goal = speed) generate
            U0: csub generic map (ss'length,0,(ss'length-1))
                        port map (a,b,d);
        end generate;
    end generate;
end module;

-- sub_uu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_uu_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        s : out unsigned);
end sub_uu_u;

architecture module of sub_uu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ui_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ui_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in integer;
        s : out unsigned);
end sub_ui_u;

architecture module of sub_ui_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_iu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_iu_u is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in unsigned;
        s : out unsigned);
end sub_iu_u;

architecture module of sub_iu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ub_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ub_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in std_ulogic;
        s : out unsigned);
end sub_ub_u;

architecture module of sub_ub_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bu_u is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in unsigned;
        s : out unsigned);
end sub_bu_u;

architecture module of sub_bu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= unsigned(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ss_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ss_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        s : out signed);
end sub_ss_s;

architecture module of sub_ss_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_us_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_us_s is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        s : out signed);
end sub_us_s;

architecture module of sub_us_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_su_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_su_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        s : out signed);
end sub_su_s;

architecture module of sub_su_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_si_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_si_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in integer;
        s : out signed);
end sub_si_s;

architecture module of sub_si_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_is_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_is_s is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in signed;
        s : out signed);
end sub_is_s;

architecture module of sub_is_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_sb_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_sb_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in std_ulogic;
        s : out signed);
end sub_sb_s;

architecture module of sub_sb_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bs_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bs_s is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in signed;
        s : out signed);
end sub_bs_s;

architecture module of sub_bs_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= signed(ss);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_uu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_uu_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        s : out std_logic_vector);
end sub_uu_v;

architecture module of sub_uu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ui_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ui_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in integer;
        s : out std_logic_vector);
end sub_ui_v;

architecture module of sub_ui_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_iu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_iu_v is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in unsigned;
        s : out std_logic_vector);
end sub_iu_v;

architecture module of sub_iu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ub_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ub_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in std_ulogic;
        s : out std_logic_vector);
end sub_ub_v;

architecture module of sub_ub_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bu_v is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in unsigned;
        s : out std_logic_vector);
end sub_bu_v;

architecture module of sub_bu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_ss_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_ss_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        s : out std_logic_vector);
end sub_ss_v;

architecture module of sub_ss_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_us_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_us_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        s : out std_logic_vector);
end sub_us_v;

architecture module of sub_us_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_su_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_su_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        s : out std_logic_vector);
end sub_su_v;

architecture module of sub_su_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_si_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_si_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in integer;
        s : out std_logic_vector);
end sub_si_v;

architecture module of sub_si_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_is_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_is_v is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in signed;
        s : out std_logic_vector);
end sub_is_v;

architecture module of sub_is_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_sb_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_sb_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in std_ulogic;
        s : out std_logic_vector);
end sub_sb_v;

architecture module of sub_sb_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bs_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bs_v is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in signed;
        s : out std_logic_vector);
end sub_bs_v;

architecture module of sub_bs_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= std_logic_vector(b);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vv_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_vv_v_us;

architecture module of sub_vv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vi_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vi_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        s : out std_logic_vector);
end sub_vi_v_us;

architecture module of sub_vi_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_iv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_iv_v_us is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_iv_v_us;

architecture module of sub_iv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vb_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vb_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_ulogic;
        s : out std_logic_vector);
end sub_vb_v_us;

architecture module of sub_vb_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bv_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_bv_v_us;

architecture module of sub_bv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_vv_v_sg;

architecture module of sub_vv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vi_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vi_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        s : out std_logic_vector);
end sub_vi_v_sg;

architecture module of sub_vi_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(s'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb <= vectorize(b,s'length);
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_iv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_iv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_iv_v_sg;

architecture module of sub_iv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector(s'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= vectorize(a,s'length);
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_vb_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_vb_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_ulogic;
        s : out std_logic_vector);
end sub_vb_v_sg;

architecture module of sub_vb_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := 0;
    constant msbb : natural := 0;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector( 0 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa <= a;
    bb(0) <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

-- sub_bv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity sub_bv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_ulogic;
        b : in std_logic_vector;
        s : out std_logic_vector);
end sub_bv_v_sg;

architecture module of sub_bv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := 0;
    constant msba : natural := 0;
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal aa : std_logic_vector( 0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= a;
    bb <= b;
    s <= ss;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, ss);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, ss);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: sub_gen
  generic map(goal, IsSigned, true, false, lsba, msba)
  port map(aa, bb, ss);
    end generate;

end module;

--------------------------------------------------------------------------------
--
-- mul
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;

entity mul_gen is
    generic (goal : goal_type := speed;
             IsSigned : Boolean := false;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in std_logic_vector; pp : out std_logic_vector);
end mul_gen;

architecture module of mul_gen is
    signal nosum : std_logic_vector (-1 downto 0);
    signal a : std_logic_vector ((aa'length-1) downto 0);
    signal b : std_logic_vector ((bb'length-1) downto 0);

    signal p : std_logic_vector ((pp'length-1) downto 0);
begin

    a <= aa;
    b <= bb;
    pp <= p;

    G1: if (NOT IsAStatic AND NOT IsBStatic) generate
        G0: if (IsSigned) generate
            U0:mmult generic map(lpm_widthA => aa'length,
                                    lpm_widthB => bb'length,
                                    lpm_widthS => 0,
                                    lpm_widthP => p'length,
                                    lpm_representation => lpm_signed,
                                    lpm_hint => goal)
                         port map (a,b,nosum,p);
        end generate;
        G1: if (NOT IsSigned) generate
            U0:mmult generic map(lpm_widthA => aa'length,
                                    lpm_widthB => bb'length,
                                    lpm_widthS => 0,
                                    lpm_widthP => p'length,
                                    lpm_representation => lpm_unsigned,
                                    lpm_hint => goal)
                         port map (a,b,nosum,p);
        end generate;
    end generate;

    G2: if (IsAStatic OR IsBStatic) generate
        G0: if (lsbOne < aa'length) AND (lsbOne /= msbOne) generate
            -- Constant not equal to zero and not a power of 2
            G1: if (IsSigned) generate
                U0:mmultc generic map(lpm_widthA => aa'length,
                                    lpm_widthB => bb'length,
                                    lpm_widthS => 0,
                                    lpm_widthP => p'length,
                                    lpm_representation => lpm_signed,
                                    lpm_hint => goal)
                             port map (a,b,nosum,p);
            end generate;
            G2: if (NOT IsSigned) generate
                U0:mmultc generic map(lpm_widthA => aa'length,
                                    lpm_widthB => bb'length,
                                    lpm_widthS => 0,
                                    lpm_widthP => p'length,
                                    lpm_representation => lpm_unsigned,
                                    lpm_hint => goal)
                             port map (a,b,nosum,p);
            end generate;
        end generate;

        G1: if (lsbOne < aa'length) AND (lsbOne = msbOne) generate
            -- Constant not equal to zero and is a power of 2

            G2: for i in pp'reverse_range GENERATE
                I0: if (i >= lsbOne) AND
                    (i <= (lsbOne - 1 + aa'length)) generate
                    p(i) <= a(i - lsbOne);
                end generate;
                I1: if NOT((i >= lsbOne) AND
                    (i <= (lsbOne - 1 + aa'length))) generate
                    p(i) <= '0';
                end generate;
            end generate;

        end generate;

        -- Const equal to 0 or too big
        G2: if (lsbOne >= aa'length) generate
            p <= (others => '0');
        end generate;
    end generate;
end module;

-- mul_uu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_uu_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        p : out unsigned);
end mul_uu_u;

architecture module of mul_uu_u is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= unsigned(pp);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_ss_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_ss_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        p : out signed);
end mul_ss_s;

architecture module of mul_ss_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= signed(pp);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_su_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_su_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        p : out signed);
end mul_su_s;

architecture module of mul_su_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= signed(pp);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_us_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_us_s is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        p : out signed);
end mul_us_s;

architecture module of mul_us_s is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= signed(pp);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_uu_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_uu_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        p : out std_logic_vector);
end mul_uu_v;

architecture module of mul_uu_v is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_ss_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_ss_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        p : out std_logic_vector);
end mul_ss_v;

architecture module of mul_ss_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_su_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_su_v is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        p : out std_logic_vector);
end mul_su_v;

architecture module of mul_su_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_us_v
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_us_v is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        p : out std_logic_vector);
end mul_us_v;

architecture module of mul_us_v is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_vv_v_us
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_vv_v_us is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        p : out std_logic_vector);
end mul_vv_v_us;

architecture module of mul_vv_v_us is
    constant IsSigned : boolean := false;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

-- mul_vv_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity mul_vv_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        p : out std_logic_vector);
end mul_vv_v_sg;

architecture module of mul_vv_v_sg is
    constant IsSigned : boolean := true;
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal pp : std_logic_vector(p'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    p <= pp;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, true, true, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, false, 0, 0)
  port map(aa, bb, pp);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsbb, msbb)
  port map(aa, bb, pp);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: mul_gen
  generic map(goal, IsSigned, false, true, lsba, msba)
  port map(bb, aa, pp);
    end generate;

end module;

--------------------------------------------------------------------------------
--
-- cmp
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;

entity cmp_gen is
    generic (goal : goal_type := speed;
             IsSigned : Boolean := false;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false);
    port (a,b : in std_logic_vector; lt,lte,gt,gte,eq,neq: out Boolean);
end cmp_gen;

architecture module of cmp_gen is

    constant size : natural := max(a'length, b'length);
    signal dataA,dataB,eqa,lta,gta : std_logic_vector ((size - 1) downto 0);

    signal xlt,xlte,xgt,xgte,xeq,xneq : std_logic;

begin

    L0:if (a'length < b'length) generate
        dataA <= resize(a,b'length);
        dataB <= b;
    end generate;
    L1:if (a'length > b'length) generate
        dataA <= a;
        dataB <= resize(b,a'length);
    end generate;
    L2:if (a'length = b'length) generate
        dataA <= a;
        dataB <= b;
    end generate;

    GX: if (NOT IsAStatic AND NOT IsBStatic) generate
        G1: if (IsSigned) generate
            U0: mcompare generic map (dataA'length,lpm_signed,goal)
                            port map (dataA,dataB,xlt,xeq,xgt,xgte,xlte,xneq);
        end generate;
        G2: if (NOT IsSigned) generate
            U0: mcompare generic map (dataA'length,lpm_unsigned,goal)
                            port map (dataA,dataB,xlt,xeq,xgt,xgte,xlte,xneq);
        end generate;
        lt <= true when xlt = '1' else false;
        eq <= true when xeq = '1' else false;
        gt <= true when xgt = '1' else false;
        gte <= true when xgte = '1' else false;
        lte <= true when xlte = '1' else false;
        neq <= true when xneq = '1' else false;
    end generate;

    GK: if (IsAStatic OR IsBStatic) generate
        G0: if ((eq'port_state_att = ps_connected) OR
                (neq'port_state_att = ps_connected)) generate
            eqa(size-1) <= NOT (dataA(size-1) XOR dataB(size-1));
            G1: for h in (size-2) downto 0 generate
                eqa(h) <= NOT (dataA(h) XOR dataB(h)) AND eqa(h+1);
            end generate;
        end generate;

        G2: if ((lt'port_state_att = ps_connected) OR
                (lte'port_state_att = ps_connected) OR
                (gt'port_state_att = ps_connected) OR
                (gte'port_state_att = ps_connected)) generate

            lta(size-1) <= dataB(size-1) AND NOT
                          (dataA(size-1) AND
                           dataB(size-1));
            gta(size-1) <= dataA(size-1) AND NOT
                          (dataA(size-1) AND
                           dataB(size-1));

            G3: for h in (size-2) downto 0 generate
            lta(h) <= ((dataB(h) AND NOT (dataA(h) AND dataB(h)))
                                 AND NOT gta(h+1)) OR lta(h+1);
            gta(h) <= ((dataA(h) AND NOT (dataA(h) AND dataB(h)))
                                 AND NOT lta(h+1)) OR gta(h+1);
            end generate;
        end generate;

        G4: if (lt'port_state_att = ps_connected) generate
            lt <= true when (lta(0) = '1') else false;
        end generate;
        G5: if (lte'port_state_att = ps_connected) generate
            lte <= true when (gta(0) = '0') else false;
        end generate;
        G6: if (gt'port_state_att = ps_connected) generate
            gt <= true when (gta(0) = '1') else false;
        end generate;
        G7: if (gte'port_state_att = ps_connected) generate
            gte <= true when (lta(0) = '0') else false;
        end generate;
        G8: if (eq'port_state_att = ps_connected) generate
            eq <= true when (eqa(0) = '1') else false;
        end generate;
        G9: if (neq'port_state_att = ps_connected) generate
            neq <= true when (eqa(0) = '0') else false;
        end generate;
    end generate;
end module;

-- cmp_uu_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_uu_bl is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in unsigned;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_uu_bl;

architecture module of cmp_uu_bl is
    constant IsSigned : boolean := false;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_ss_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_ss_bl is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in signed;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_ss_bl;

architecture module of cmp_ss_bl is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_us_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_us_bl is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in signed;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_us_bl;

architecture module of cmp_us_bl is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_su_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_su_bl is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in unsigned;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_su_bl;

architecture module of cmp_su_bl is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_ui_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_ui_bl is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : in integer;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_ui_bl;

architecture module of cmp_ui_bl is
    constant IsSigned : boolean := false;
    constant x : integer := max(bits_needed(get_max(b)), a'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= std_logic_vector(resize(a,x));
    bb <= vectorize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_iu_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_iu_bl is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in unsigned;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_iu_bl;

architecture module of cmp_iu_bl is
    constant IsSigned : boolean := false;
    constant x : integer := max(bits_needed(get_max(a)), b'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= vectorize(a,x);
    bb <= std_logic_vector(resize(b,x));
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_si_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_si_bl is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : in integer;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_si_bl;

architecture module of cmp_si_bl is
    constant IsSigned : boolean := true;
    constant x : integer := max(bits_needed(get_max(b)), a'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= std_logic_vector(resize(a,x));
    bb <= vectorize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_is_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_is_bl is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in signed;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_is_bl;

architecture module of cmp_is_bl is
    constant IsSigned : boolean := true;
    constant x : integer := max(bits_needed(get_max(a)), b'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= vectorize(a,x);
    bb <= std_logic_vector(resize(b,x));
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_vv_us_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_vv_us_bl is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_vv_us_bl;

architecture module of cmp_vv_us_bl is
    constant IsSigned : boolean := false;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_vi_us_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_vi_us_bl is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_vi_us_bl;

architecture module of cmp_vi_us_bl is
    constant IsSigned : boolean := false;
    constant x : integer := max(bits_needed(get_max(b)), a'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= resize(a,x);
    bb <= vectorize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_iv_us_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_iv_us_bl is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_iv_us_bl;

architecture module of cmp_iv_us_bl is
    constant IsSigned : boolean := false;
    constant x : integer := max(bits_needed(get_max(a)), b'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= vectorize(a,x);
    bb <= resize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_vv_sg_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_vv_sg_bl is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in std_logic_vector;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_vv_sg_bl;

architecture module of cmp_vv_sg_bl is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
begin

    aa <= a;
    bb <= b;
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_vi_sg_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_vi_sg_bl is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : in integer;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_vi_sg_bl;

architecture module of cmp_vi_sg_bl is
    constant IsSigned : boolean := true;
    constant x : integer := max(bits_needed(get_max(b)), a'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= resize(a,x);
    bb <= vectorize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

-- cmp_iv_sg_bl
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity cmp_iv_sg_bl is
    generic (goal : goal_type := speed);
    port (a : in integer;
        b : in std_logic_vector;
        lt,lte,gt,gte,eq,neq : out boolean);
end cmp_iv_sg_bl;

architecture module of cmp_iv_sg_bl is
    constant IsSigned : boolean := true;
    constant x : integer := max(bits_needed(get_max(a)), b'length) ;
    signal aa : std_logic_vector(x-1 downto 0);
    signal bb : std_logic_vector(x-1 downto 0);
begin

    aa <= vectorize(a,x);
    bb <= resize(b,x);
    G0: if (a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, false, true)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
 A0: cmp_gen
  generic map(goal, IsSigned, true, false)
  port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

end module;

--------------------------------------------------------------------------------
--
-- Unary Operators
--
--------------------------------------------------------------------------------

-- uni_as_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity uni_as_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : out signed);
end uni_as_s;

architecture module of uni_as_s is
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(a'length-1 downto 0);
    signal ov : std_logic;
begin

    aa <= std_logic_vector(a);
    b <= signed(bb);

    A0: mabs generic map (a'length,goal) port map (aa, bb, ov);

end module;

-- uni_as_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity uni_as_v_sg is
    generic (goal : goal_type := speed);
    port (a : in std_logic_vector;
        b : out std_logic_vector);
end uni_as_v_sg;

architecture module of uni_as_v_sg is
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(a'length-1 downto 0);
    signal ov : std_logic;
begin

    aa <= a;
    b <= bb;

    A0: mabs generic map (a'length,goal) port map (aa, bb, ov);

end module;

-- uni_ms_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity uni_ms_s is
    generic (goal : goal_type := speed);
    port (b : in signed;
        s : out signed);
end uni_ms_s;

architecture module of uni_ms_s is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= '0';
    bb <= std_logic_vector(b);
    s <= signed(ss);

    A0: sub_gen generic map(goal,IsSigned,true,false,0,0) port map(aa, bb, ss);

end module;

-- uni_ms_v_sg
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;

entity uni_ms_v_sg is
    generic (goal : goal_type := speed);
    port (b : in std_logic_vector;
        s : out std_logic_vector);
end uni_ms_v_sg;

architecture module of uni_ms_v_sg is
    constant IsSigned : boolean := true;
    signal aa : std_logic_vector(0 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
begin

    aa(0) <= '0';
    bb <= b;
    s <= ss;

    A0: sub_gen generic map(goal,IsSigned,true,false,0,0) port map(aa, bb, ss);

end module;

-- shl_uu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity shl_uu_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : out unsigned;
        s : out unsigned);
end shl_uu_u;

architecture module of shl_uu_u is
    signal aa : std_logic_vector(b'length-1 downto 0);
    signal bb : std_logic_vector(a'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
    constant dir: std_logic := '1';
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);

    A0: mclshift generic map(a'length, b'length, lpm_logical, goal)
                port map(aa, bb, dir, ss);

end module;

-- shl_su_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity shl_su_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : out unsigned;
        s : out signed);
end shl_su_s;

architecture module of shl_su_s is
    signal aa : std_logic_vector(b'length-1 downto 0);
    signal bb : std_logic_vector(a'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
    constant dir: std_logic := '1';
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);

    A0: mclshift generic map(a'length, b'length, lpm_logical, goal)
                port map(aa, bb, dir, ss);

end module;

-- shr_uu_u
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity shr_uu_u is
    generic (goal : goal_type := speed);
    port (a : in unsigned;
        b : out unsigned;
        s : out unsigned);
end shr_uu_u;

architecture module of shr_uu_u is
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
    constant dir: std_logic := '0';
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= unsigned(ss);

    A0: mclshift generic map(a'length, b'length, lpm_logical, goal)
                port map(aa, bb, dir, ss);

end module;

-- shr_su_s
library ieee;
use ieee.std_logic_1164.all;
use ieee.ultragenpkg_sla.all;
library cypress;
use cypress.lpmpkg.all;

entity shr_su_s is
    generic (goal : goal_type := speed);
    port (a : in signed;
        b : out unsigned;
        s : out signed);
end shr_su_s;

architecture module of shr_su_s is
    signal aa : std_logic_vector(a'length-1 downto 0);
    signal bb : std_logic_vector(b'length-1 downto 0);
    signal ss : std_logic_vector(s'length-1 downto 0);
    constant dir: std_logic := '0';
begin

    aa <= std_logic_vector(a);
    bb <= std_logic_vector(b);
    s <= signed(ss);

    A0: mclshift generic map(a'length, b'length, lpm_logical, goal)
                port map(aa, bb, dir, ss);

end module;
