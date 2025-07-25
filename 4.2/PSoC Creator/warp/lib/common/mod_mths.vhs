--

--------------------------------------------------------------------------------
--
-- Ultragen Component Package
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
package ultragenpkg_gs is

    TYPE signed is array (natural range <>) of std_logic;

    constant noWarning : boolean := false;
    constant null_vect : signed (0 downto 1) := (others => '0');

    function vectorize (a, size : natural) RETURN signed;
    function resize (x : signed; size : natural) return signed;
    function lsb1 (a : signed; maxsize : natural) return natural;
    function lsb1 (a : integer; maxsize : natural) return natural;
    function msb1 (a : signed; maxsize : natural) return natural;
    function msb1 (a : integer; maxsize : natural) return natural;
    function get_max (x : integer) return integer;
    function bits_needed (val : natural) return natural;

    component add_gs
        generic (goal : goal_type := speed;
                 IsAStatic : Boolean := false;
                 IsBStatic : Boolean := false;
                 lsbOne : natural;
                 msbOne : natural);
        port (aa,bb : in signed; ss : out signed);
    end component;

    component add_vv_gs

        generic (goal : goal_type := speed);

        port (a,b : in signed; s : out signed);
    end component;

    component add_vi_gs

        generic (goal : goal_type := speed);

        port (a : in signed; i : in integer; s : out signed);
    end component;

    component add_iv_gs

        generic (goal : goal_type := speed);

        port (i: in integer; b : in signed; s : out signed);
    end component;

    component sub_gs
        generic (goal : goal_type := speed;
                 IsAStatic : Boolean := false;
                 IsBStatic : Boolean := false;
                 lsbOne : natural;
                 msbOne : natural);
        port (aa,bb : in signed; ss : out signed);
    end component;

    component sub_vv_gs

        generic (goal : goal_type := speed);

        port (a,b : in signed; s : out signed);
    end component;

    component sub_vi_gs

        generic (goal : goal_type := speed);

        port (a : in signed; i : in integer; s : out signed);
    end component;

    component sub_iv_gs

        generic (goal : goal_type := speed);

        port (i: in integer; b : in signed; s : out signed);
    end component;

    component cmp_gs
        generic (goal : goal_type := speed;

                 IsAStatic : Boolean := false;
                 IsBStatic : Boolean := false);
        port (a,b : in signed; lt,lte,gt,gte,eq,neq: out Boolean);
    end component;

    component cmp_vv_gs

        generic (goal : goal_type := speed);

        port (a,b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_vi_gs

        generic (goal : goal_type := speed);

        port (a : in signed; i : in integer; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iv_gs

        generic (goal : goal_type := speed);

        port (i: in integer; b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component mul_gs
        generic (goal : goal_type := speed;

                 IsAStatic : Boolean := false;
                 IsBStatic : Boolean := false;
                 lsbOne : natural;
                 msbOne : natural);
        port (aa,bb : in signed; pp : out signed);
    end component;

    component mul_vv_gs

        generic (goal : goal_type := speed);

        port (a,b : in signed; p : out signed);
    end component;

    component mul_vi_gs

        generic (goal : goal_type := speed);

        port (a : in signed; i : in integer; p : out signed);
    end component;

    component mul_iv_gs

        generic (goal : goal_type := speed);

        port (i: in integer; b : in signed; p : out signed);
    end component;
end package ultragenpkg_gs;

--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
package body ultragenpkg_gs is

    function vectorize (a, size : natural) return signed is
        variable result : signed(size-1 downto 0) := (others => '0');
        variable tmp : signed(size-1 downto 0) := (others => '0');
        variable b : natural;
        variable carry : std_logic;
        variable newsize : integer := size;
    begin
        if (newsize > 32) then
            newsize := 32;
        end if;

        if (a < 0) then
            b := -a;
        else
            b := a;
        end if;

        if (newsize <= 31) then
            for i in result'reverse_range loop
                if ((b/(2**i)) mod 2) = 1 then
                    result(i) := '1';
                end if;
            end loop;
        end if;
        if (newsize = 32) then
            if ((b mod 2) = 1) then
                result(result'low) := '1';
            end if;
            b := b/2;
            for i in 0 to (newsize-2) loop
                if ((b/(2**i)) mod 2) = 1 then
                    result(i+1) := '1';
                end if;
            end loop;
        end if;

-- Do a 2's complement if a is less than 0.
        if (a < 0) then
            tmp := NOT result;
            result(0) := NOT tmp(0);
            carry := tmp(0);
            for i in 1 to size-1 loop
                result(i) := tmp(i) XOR carry;
                carry := tmp(i) AND carry;
            end loop;
        end if;

        return result;
    end vectorize;

    function resize (x : signed; size : natural) return signed is
        variable a : signed ((x'length-1) downto 0) := x;
        variable result : signed((size - 1) downto 0) := (others => '0');
    begin
        if (size < 1 ) then return null_vect; end if;
        if a'length < size then

            result((result'high) downto a'length) := (others => a(a'high));

            result((a'length - 1) downto 0) := a;
        else
            result := a((size-1) downto 0);
        end if;
        return result;
    end resize;

    -- Returns first least significant std_logic position less than maxsize
    -- or return maxsize
    function lsb1 (a : signed; maxsize : natural) return natural is
        variable val : signed (a'length-1 downto 0) := a;
        variable indx : natural := 0;
    begin
        for i in val'reverse_range loop
            IF (indx >= maxsize) OR (val(i) = '1') then
                return indx;
            end IF;
            indx := indx + 1;
        end loop;
        return maxsize;
    end lsb1;

    function lsb1 (a : integer; maxsize : natural) return natural is
        variable indx : natural := 0;
        variable v : integer := a;
    begin
        while (( indx <= 31 ) AND (indx <= maxsize)) loop
            if (v mod 2) = 1 then
                return indx;
            end if;
            v := v / 2;
            indx := indx + 1;
        end loop;
        return maxsize;
    end lsb1;

    -- Returns first most significant std_logic position less than maxsize
    -- or return maxsize
    function msb1 (a : signed; maxsize : natural) return natural is
        variable val : signed (a'length-1 downto 0) := a;
        variable indx : natural := val'length-1;
    begin
        for i in val'range loop
            IF ((indx < maxsize) AND (val(i) = '1')) then
                return indx;
            end IF;
            indx := indx - 1;
        end loop;
        return maxsize;
    end msb1;

    function msb1 (a : integer; maxsize : natural) return natural is
        variable indx : natural := 31;
    begin
        if (maxsize < indx) then
            indx := maxsize;
        end if;
        if (indx = 31) then
            indx := 30;
            if ((a/2) mod (2**30)) = 1 then
                return 31;
            end if;
        end if;
        while ( indx >= 0 ) loop
            if ((a / (2**indx)) mod 2) = 1 then
                return indx;
            end if;
            indx := indx - 1;
        end loop;
        return maxsize;
    end msb1;

    function get_max (x : integer) return integer IS
    begin
        if (x'globally_static) then
            return x ;
        else
            return x'high ;
        end if ;
    end get_max ;

    function bits_needed (val : natural) return natural IS
        variable tmp : natural := val;
        variable sval : natural;
    begin
        if (val = 0) then
            return 1 ;
        end if ;
        sval := 0;
        while tmp > 0 loop
            sval := sval + 1;
            tmp := tmp / 2;
        end loop;
        return sval;
    end bits_needed;
end ultragenpkg_gs;

--------------------------------------------------------------------------------
--
-- add
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;
use work.ultragenpkg_gs.all;

entity add_gs is
    generic (goal : goal_type := speed;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in signed; ss : out signed);
end add_gs;

architecture module of add_gs is

    signal a,b,s,c : std_logic_vector ((ss'length-1) downto 0);
    signal zero : std_logic := '0';
    signal one : std_logic := '1';

begin

    L0:if (aa'length /= ss'length) generate
        a <= std_logic_vector(resize(aa,ss'length));
    end generate;
    L1:if (aa'length = ss'length) generate
        a <= std_logic_vector(aa);
    end generate;
    L2:if (bb'length /= ss'length) generate
        b <= std_logic_vector(resize(bb,ss'length));
    end generate;
    L3:if (bb'length = ss'length) generate
        b <= std_logic_vector(bb);
    end generate;

    ss <= signed(s);

    G0: if (NOT IsAStatic AND NOT IsBStatic) generate
        U0: madd_sub generic map (ss'length,lpm_unsigned,lpm_add,goal)
                        port map (a,b,zero,one,s,open,open);
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
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity add_vv_gs is

    generic (goal : goal_type := speed);

    port (a,b : in signed; s : out signed);
end add_vv_gs;

architecture module of add_vv_gs is

    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);

begin

    G0: if (a'globally_static AND b'globally_static) generate
        A0: add_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
        A0: add_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsba, msba)
                port map(b, a, s);
    end generate;
end module;

--
-- add with integers
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity add_vi_gs is

    generic (goal : goal_type := speed);

    port (a : in signed; i : in integer; s : out signed);
end add_vi_gs;

architecture module of add_vi_gs is

    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(i,s'length);
    constant msbb : natural := msb1(i,s'length);
    signal b : signed (s'length-1 downto 0);

begin

    b <= vectorize(i,s'length);

    G0: if (a'globally_static AND i'globally_static) generate
        A0: add_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT a'globally_static AND NOT i'globally_static) generate
        A0: add_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT a'globally_static AND i'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (a'globally_static AND NOT i'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsba, msba)
                port map(b, a, s);
    end generate;
end module;
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity add_iv_gs is

    generic (goal : goal_type := speed);

    port (i: in integer; b : in signed; s : out signed);
end add_iv_gs;

architecture module of add_iv_gs is

    constant lsba : natural := lsb1(i,s'length);
    constant msba : natural := msb1(i,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal a : signed (s'length-1 downto 0);

begin

    a <= vectorize(i,s'length);

    G0: if (i'globally_static AND b'globally_static) generate
        A0: add_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT i'globally_static AND NOT b'globally_static) generate
        A0: add_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT i'globally_static AND b'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (i'globally_static AND NOT b'globally_static) generate
        A0: add_gs
                generic map(goal, false, true, lsba, msba)
                port map(b, a, s);
    end generate;
end module;

--
-- sub
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;
use work.ultragenpkg_gs.all;

entity sub_gs is
    generic (goal : goal_type := speed;
             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in signed; ss : out signed);
end sub_gs;

architecture module of sub_gs is

    signal a,b,d,c : std_logic_vector ((ss'length-1) downto 0);
    signal zero : std_logic := '0';
    signal one : std_logic := '1';

begin

    L0:if (aa'length /= ss'length) generate
        a <= std_logic_vector(resize(aa,ss'length));
    end generate;
    L1:if (aa'length = ss'length) generate
        a <= std_logic_vector(aa);
    end generate;
    L2:if (bb'length /= ss'length) generate
        b <= std_logic_vector(resize(bb,ss'length));
    end generate;
    L3:if (bb'length = ss'length) generate
        b <= std_logic_vector(bb);
    end generate;

    ss <= signed(d);

    G0: if (NOT IsAStatic AND NOT IsBStatic) generate
        U0: madd_sub generic map (ss'length,lpm_unsigned,lpm_sub,goal)
                        port map (a,b,one,zero,d,open,open);
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
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity sub_vv_gs is

    generic (goal : goal_type := speed);

    port (a,b : in signed; s : out signed);
end sub_vv_gs;

architecture module of sub_vv_gs is

    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);

begin

    G0: if (a'globally_static AND b'globally_static) generate
        A0: sub_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
        A0: sub_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
        A0: sub_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
        A0: sub_gs
                generic map(goal, true, false, lsba, msba)
                port map(a, b, s);
    end generate;
end module;

--
-- sub with integers
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity sub_vi_gs is

    generic (goal : goal_type := speed);

    port (a : in signed; i : in integer; s : out signed);
end sub_vi_gs;

architecture module of sub_vi_gs is

    constant lsba : natural := lsb1(a,s'length);
    constant msba : natural := msb1(a,s'length);
    constant lsbb : natural := lsb1(i,s'length);
    constant msbb : natural := msb1(i,s'length);
    signal b : signed (s'length-1 downto 0);

begin

    b <= vectorize(i,s'length);

    G0: if (a'globally_static AND i'globally_static) generate
        A0: sub_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT a'globally_static AND NOT i'globally_static) generate
        A0: sub_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT a'globally_static AND i'globally_static) generate
        A0: sub_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (a'globally_static AND NOT i'globally_static) generate
        A0: sub_gs
                generic map(goal, true, false, lsba, msba)
                port map(a, b, s);
    end generate;
end module;
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity sub_iv_gs is

    generic (goal : goal_type := speed);

    port (i: in integer; b : in signed; s : out signed);
end sub_iv_gs;

architecture module of sub_iv_gs is

    constant lsba : natural := lsb1(i,s'length);
    constant msba : natural := msb1(i,s'length);
    constant lsbb : natural := lsb1(b,s'length);
    constant msbb : natural := msb1(b,s'length);
    signal a : signed (s'length-1 downto 0);

begin

    a <= vectorize(i,s'length);

    G0: if (i'globally_static AND b'globally_static) generate
        A0: sub_gs
                generic map(goal, true, true, 0, 0)
                port map(a, b, s);
    end generate;

    G1: if (NOT i'globally_static AND NOT b'globally_static) generate
        A0: sub_gs
                generic map(goal, false, false, 0, 0)
                port map(a, b, s);
    end generate;

    G2: if (NOT i'globally_static AND b'globally_static) generate
        A0: sub_gs
                generic map(goal, false, true, lsbb, msbb)
                port map(a, b, s);
    end generate;

    G3: if (i'globally_static AND NOT b'globally_static) generate
        A0: sub_gs
                generic map(goal, true, false, lsba, msba)
                port map(a, b, s);
    end generate;
end module;

--
-- cmp
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity cmp_gs is
    generic (goal : goal_type := speed;

             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false);
    port (a,b : in signed; lt,lte,gt,gte,eq,neq: out Boolean);
end cmp_gs;

architecture module of cmp_gs is

    function max (a,b : natural) return natural is
    begin
        if (a < b) then return b; else return a; end if;
    end max;

    constant size : natural := max(a'length, b'length);
    signal dataA,dataB,eqa,lta,gta : std_logic_vector ((size - 1) downto 0);

    signal newA,newB : std_logic_vector ((size - 1) downto 0);

    signal xlt,xlte,xgt,xgte,xeq,xneq : std_logic;

begin
    L0:if (a'length < b'length) generate
        newA <= std_logic_vector(resize(a,b'length));
        newB <= std_logic_vector(b);
    end generate;
    L1:if (a'length > b'length) generate
        newA <= std_logic_vector(a);
        newB <= std_logic_vector(resize(b,a'length));
    end generate;
    L2:if (a'length = b'length) generate
        newA <= std_logic_vector(a);
        newB <= std_logic_vector(b);
    end generate;
    dataA(size-2 downto 0) <= newA(size-2 downto 0);
    dataA(size-1) <= newB(size-1);
    dataB(size-2 downto 0) <= newB(size-2 downto 0);
    dataB(size-1) <= newA(size-1);

    GX: if (NOT IsAStatic AND NOT IsBStatic) generate
        U0: mcompare generic map (dataA'length,lpm_unsigned,goal)
                        port map (dataA,dataB,xlt,xeq,xgt,xgte,xlte,xneq);
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
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity cmp_vv_gs is

    generic (goal : goal_type := speed);

    port (a,b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
end cmp_vv_gs;

architecture module of cmp_vv_gs is
begin

    G0: if (a'globally_static AND b'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, true)

                port map(a, b, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, false)

                port map(a, b, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, true)

                port map(a, b, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, false)

                port map(a, b, lt,lte,gt,gte,eq,neq);
    end generate;
end module;

--
-- cmp with integers
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity cmp_vi_gs is

    generic (goal : goal_type := speed);

    port (a : in signed; i : in integer; lt,lte,gt,gte,eq,neq :out boolean);
end cmp_vi_gs;

architecture module of cmp_vi_gs is

    constant x : integer := max(bits_needed(get_max(i)), a'length) ;
    signal aa : signed (x-1 downto 0) ;
    signal bb : signed (x-1 downto 0) ;

begin

    aa <= resize(a, x) ;
    bb <= vectorize(i, x);

    G0: if (a'globally_static AND i'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, true)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT a'globally_static AND NOT i'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, false)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT a'globally_static AND i'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, true)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (a'globally_static AND NOT i'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, false)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;
end module;
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity cmp_iv_gs is

    generic (goal : goal_type := speed);

    port (i: in integer; b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
end cmp_iv_gs;

architecture module of cmp_iv_gs is

    constant x : integer := max(bits_needed(get_max(i)), b'length) ;
    signal aa : signed (x-1 downto 0) ;
    signal bb : signed (x-1 downto 0) ;

begin

    aa <= vectorize(i, x);
    bb <= resize(b, x) ;

    G0: if (i'globally_static AND b'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, true)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G1: if (NOT i'globally_static AND NOT b'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, false)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G2: if (NOT i'globally_static AND b'globally_static) generate
        A0: cmp_gs

                generic map(goal, false, true)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;

    G3: if (i'globally_static AND NOT b'globally_static) generate
        A0: cmp_gs

                generic map(goal, true, false)

                port map(aa, bb, lt,lte,gt,gte,eq,neq);
    end generate;
end module;

--
-- mul
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.modcnstpkg.all;
use work.ultragenpkg_gs.all;

entity mul_gs is
    generic (goal : goal_type := speed;

             IsAStatic : Boolean := false;
             IsBStatic : Boolean := false;
             lsbOne : natural;
             msbOne : natural);
    port (aa,bb : in signed; pp : out signed);
end mul_gs;

architecture module of mul_gs is

    signal nosum: std_logic_vector (-1 downto 0);
    signal a : std_logic_vector ((aa'length-1) downto 0);
    signal b : std_logic_vector ((bb'length-1) downto 0);
    signal p : std_logic_vector ((aa'length+bb'length-1) downto 0);
    signal tpp : std_logic_vector (pp'length-1 downto 0);

begin

    a <= std_logic_vector(aa);
    b <= std_logic_vector(bb);

    -- Size the output from the multiplier to match the module output
    G1A: if (pp'length <= p'length) generate
        tpp <= p(pp'length-1 downto 0);
    end generate;
    G1B: if (pp'length > p'length) generate
        tpp(p'length-1 downto 0) <= p;
        tpp(pp'length-1 downto p'length) <= (others => '0');
    end generate;

    pp <= signed(tpp);
    G1: if (NOT IsAStatic AND NOT IsBStatic) generate
        U0:mmult generic map(lpm_widthA => aa'length,
                                lpm_widthB => bb'length,
                                lpm_widthS => 0,
                                lpm_widthP => p'length,

                                lpm_representation => lpm_signed,

                                lpm_hint => goal)
                     port map (a,b,nosum,p);
    end generate;
    G2: if (NOT IsAStatic AND IsBStatic) generate
        G0: if (lsbOne < aa'length) AND (lsbOne /= msbOne) generate
            -- Constant not equal to zero and not a power of 2
            U0:mmultc generic map(lpm_widthA => aa'length,
                                lpm_widthB => bb'length,
                                lpm_widthS => 0,
                                lpm_widthP => p'length,

                                lpm_representation => lpm_signed,

                                lpm_hint => goal)
                         port map (a,b,nosum,p);
        end generate;

        G1: if (lsbOne < aa'length) AND (lsbOne = msbOne) generate
            -- Constant not equal to zero and is a power of 2
            U0:mmultc generic map(lpm_widthA => aa'length,
                                lpm_widthB => bb'length,
                                lpm_widthS => 0,
                                lpm_widthP => p'length,
                                lpm_representation => lpm_signed,
                                lpm_hint => goal)
                         port map (a,b,nosum,p);

        end generate;

        -- Const equal to 0 or too big
        G2: if (lsbOne >= aa'length) generate
            p <= (others => '0');
        end generate;
    end generate;

    G3: if (IsAStatic AND IsBStatic) generate
        U0:mmult generic map(lpm_widthA => aa'length,
                                lpm_widthB => bb'length,
                                lpm_widthS => 0,
                                lpm_widthP => p'length,

                                lpm_representation => lpm_signed,

                                lpm_hint => goal)
                     port map (a,b,nosum,p);

    end generate;
end module;
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity mul_vv_gs is

    generic (goal : goal_type := speed);

    port (a,b : in signed; p : out signed);
end mul_vv_gs;

architecture module of mul_vv_gs is

    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);

begin

    G0: if (a'globally_static AND b'globally_static) generate
        A0: mul_gs

                generic map(goal, true, true, 0, 0)

                port map(a, b, p);
    end generate;

    G1: if (NOT a'globally_static AND NOT b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, false, 0, 0)

                port map(a, b, p);
    end generate;

    G2: if (NOT a'globally_static AND b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsbb, msbb)

                port map(a, b, p);
    end generate;

    G3: if (a'globally_static AND NOT b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsba, msba)

                port map(b, a, p);
    end generate;
end module;

--
-- mul with integers
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity mul_vi_gs is

    generic (goal : goal_type := speed);

    port (a : in signed; i : in integer; p : out signed);
end mul_vi_gs;

architecture module of mul_vi_gs is
    constant lsba : natural := lsb1(a,a'length);
    constant msba : natural := msb1(a,a'length);
    constant lsbb : natural := lsb1(i,p'length-a'length);
    constant msbb : natural := msb1(i,p'length-a'length);
    signal b : signed (p'length-a'length-1 downto 0);

begin

    b <= vectorize(i,p'length-a'length);

    G0: if (a'globally_static AND i'globally_static) generate
        A0: mul_gs

                generic map(goal, true, true, 0, 0)

                port map(a, b, p);
    end generate;

    G1: if (NOT a'globally_static AND NOT i'globally_static) generate
        A0: mul_gs

                generic map(goal, false, false, 0, 0)

                port map(a, b, p);
    end generate;

    G2: if (NOT a'globally_static AND i'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsbb, msbb)

                port map(a, b, p);
    end generate;

    G3: if (a'globally_static AND NOT i'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsba, msba)

                port map(b, a, p);
    end generate;
end module;
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.ultragenpkg_gs.all;

entity mul_iv_gs is

    generic (goal : goal_type := speed);

    port (i: in integer; b : in signed; p : out signed);
end mul_iv_gs;

architecture module of mul_iv_gs is
    constant lsba : natural := lsb1(i,p'length-b'length);
    constant msba : natural := msb1(i,p'length-b'length);
    constant lsbb : natural := lsb1(b,b'length);
    constant msbb : natural := msb1(b,b'length);
    signal a : signed (p'length-b'length-1 downto 0);

begin

    a <= vectorize(i,p'length-b'length);

    G0: if (i'globally_static AND b'globally_static) generate
        A0: mul_gs

                generic map(goal, true, true, 0, 0)

                port map(a, b, p);
    end generate;

    G1: if (NOT i'globally_static AND NOT b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, false, 0, 0)

                port map(a, b, p);
    end generate;

    G2: if (NOT i'globally_static AND b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsbb, msbb)

                port map(a, b, p);
    end generate;

    G3: if (i'globally_static AND NOT b'globally_static) generate
        A0: mul_gs

                generic map(goal, false, true, lsba, msba)

                port map(b, a, p);
    end generate;
end module;
