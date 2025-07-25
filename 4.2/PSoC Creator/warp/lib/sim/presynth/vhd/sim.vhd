--
-- MXOR
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mxor is
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end mxor;

architecture archlpmstd of Mxor is

    signal d_pol : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    signal r_pol : std_logic_vector(result'range);

begin

    d_pol <= restring(lpm_data_pol,lpm_width*lpm_size);
    r_pol <= restring(lpm_result_pol,lpm_width);

    process (data, d_pol, r_pol)
        variable tmp : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    begin
        for n in 0 to lpm_width-1 loop
            tmp(n*lpm_size) := data(n) XOR NOT d_pol(n);
            for m in 1 to lpm_size-1 loop
                tmp((n*lpm_size)+m) := tmp((n*lpm_size)+m-1) XOR
                    (data((m*lpm_width)+n) XOR NOT d_pol((m*lpm_width)+n));
            end loop;
            result(n) <= tmp(((n+1)*lpm_size)-1) XOR NOT r_pol(n);
        end loop;
    end process;

end archlpmstd;

--
-- MOR
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mor is
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end mor;

architecture archlpmstd of Mor is

    signal d_pol : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    signal r_pol : std_logic_vector(result'range);

begin

    d_pol <= restring(lpm_data_pol,lpm_width*lpm_size);
    r_pol <= restring(lpm_result_pol,lpm_width);

    process (data, d_pol, r_pol)
        variable tmp : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    begin
        for n in 0 to lpm_width-1 loop
            tmp(n*lpm_size) := data(n) XOR NOT d_pol(n);
            for m in 1 to lpm_size-1 loop
                tmp((n*lpm_size)+m) := tmp((n*lpm_size)+m-1) OR
                    (data((m*lpm_width)+n) XOR NOT d_pol((m*lpm_width)+n));
            end loop;
            result(n) <= tmp(((n+1)*lpm_size)-1) XOR NOT r_pol(n);
        end loop;
    end process;

end archlpmstd;

--
-- Expandable VCC
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mvcc is
    generic(lpm_width : positive := 1);
    port (x : out std_logic_vector(lpm_width-1 downto 0));
end mvcc;

architecture archbit of mvcc is
begin

    X <= (OTHERS => '1');

end archbit;

--
-- MINV
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity minv is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end minv;

architecture archlpmstd of Minv is
begin

    result <= NOT data;

end archlpmstd;

--
-- Expandable GND
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mgnd is
    generic(lpm_width : positive := 1);
    port (x : out std_logic_vector(lpm_width-1 downto 0));
end mgnd;

architecture archbit of mgnd is
begin

    X <= (OTHERS => '0');

end archbit;

--
-- Mcnstnt
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mcnstnt is
    generic(lpm_width : positive := 1;
     lpm_cvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED;
     lpm_strength: stgth_type := LPM_NO_STRENGTH);
    port (result : out std_logic_vector(lpm_width-1 downto 0));
end mcnstnt;

architecture archlpmstd of Mcnstnt is
begin

    result <= restring(lpm_cvalue,lpm_width);

end archlpmstd;

--
-- MAND
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mand is
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end mand;

architecture archlpmstd of Mand is

    signal d_pol : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    signal r_pol : std_logic_vector(result'range);

begin

    d_pol <= restring(lpm_data_pol,lpm_width*lpm_size);
    r_pol <= restring(lpm_result_pol,lpm_width);

    process (data, d_pol, r_pol)
        variable tmp : std_logic_vector(((lpm_width*lpm_size)-1) downto 0);
    begin
        for n in 0 to lpm_width-1 loop
            tmp(n*lpm_size) := data(n) XOR NOT d_pol(n);
            for m in 1 to lpm_size-1 loop
                tmp((n*lpm_size)+m) := tmp((n*lpm_size)+m-1) AND
                    (data((m*lpm_width)+n) XOR NOT d_pol((m*lpm_width)+n));
            end loop;
            result(n) <= tmp(((n+1)*lpm_size)-1) XOR NOT r_pol(n);
        end loop;
    end process;

end archlpmstd;

--
-- MDECODE
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mdecode is
    generic(lpm_width : positive := 1;
     lpm_decodes : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     enable : in std_logic := '1';
     eq : out std_logic_vector(lpm_decodes-1 downto 0));
end mdecode;

architecture archlpmstd of Mdecode is
begin

    G0: for i in 0 to lpm_decodes-1 generate
        eq(i) <= '1' when
            ((enable = '1') AND (vectorize(i,data'length) = data))
        else '0';
    end generate;

end archlpmstd;

--
-- MMUX
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mmux is
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_widths : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     sel : in std_logic_vector(lpm_widths-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end mmux;

architecture archlpmstd of Mmux is

    function min (a,b : natural) return natural is
    begin
        if (a > b) then return b; else return a; end if;
    end min;

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

    constant limit : integer := min(bits_needed(lpm_size), lpm_widths);

begin

    process (data,sel)
        variable tmp : std_logic_vector((lpm_width-1) downto 0);
    begin
        tmp := (others => '0');
        for selval in 0 to ((2 ** limit)-1) loop
            if (((lpm_width*(selval+1))-1) <= data'high) AND
               (vectorize(selval, limit) = sel(limit-1 downto 0)) then
                tmp:=data(((lpm_width*(selval+1))-1) downto (lpm_width*selval));
            end if;
        end loop;
        result <= tmp;
    end process;

end archlpmstd;

--
-- MBUF
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_buf;
use cypress.lpmpkg.all;
entity mbuf is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end mbuf;

architecture archlpmstd of Mbuf is
begin

    B: for i in data'range generate
        U: cy_buf port map (data(i), result(i));
    end generate;

end archlpmstd;

--
-- MFF
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_dsrff;
use cypress.rtlpkg.cy_tsrff;
use cypress.lpmpkg.all;
entity mff is
    generic(lpm_width : positive := 1;
     lpm_fftype : fflop_type := LPM_DFF;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => '0');
     clock : in std_logic;
     enable : in std_logic := '1';
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := '0';
     aclr : in std_logic := '0';
     aload : in std_logic := '0';
     sset : in std_logic := '0';
     sclr : in std_logic := '0';
     sload : in std_logic := '0';
     testenab : in std_logic := '0';
     testin : in std_logic := '0';
     testout : out std_logic);
end mff;

architecture archlpmstd of Mff is

    signal qtmp,d,t : std_logic_vector(q'range);
    signal set,clr : std_logic_vector(q'range);
    signal async,sync: std_logic_vector(q'range);

begin

    async <= restring(lpm_avalue,lpm_width);
    sync <= restring(lpm_svalue,lpm_width);

    -- Determine the value of the Input to the register
    process (data,sync,sset,sclr,sload,enable,testin,testenab,qtmp)
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
        elsif (sload = '1' AND enable = '1') then
            d <= data;
        elsif (enable = '1') then
            if (lpm_fftype = lpm_tff) then
                d <= data XOR qtmp;
            else
                d <= data;
            end if;
        else
            d <= qtmp;
        end if;
    end process;

    G0: for j in q'range generate
        set(j) <= (aset AND async(j)) OR (aload AND data(j));
        clr(j) <= (aset AND NOT async(j)) OR (aload AND NOT data(j)) OR aclr;

        D0: if (lpm_fftype = lpm_dff) generate
            U0: cy_dsrff port map (d(j), set(j), clr(j), clock, qtmp(j));
        end generate;

        T0: if (lpm_fftype = lpm_tff) generate
            t(j) <= d(j) XOR qtmp(j);
            U0: cy_tsrff port map (t(j), set(j), clr(j), clock, qtmp(j));
        end generate;
    end generate;

    testout <= qtmp(q'high);
    q <= qtmp;

end archlpmstd;

--
-- MBUSTRI
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_bufoe;
use cypress.rtlpkg.cy_triout;
use cypress.lpmpkg.all;
entity mbustri is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (tridata : inout std_logic_vector(lpm_width-1 downto 0);
     data : in std_logic_vector(lpm_width-1 downto 0) := (others => '0');
     enabletr : in std_logic := '0';
     enabledt : in std_logic := '0';
     result : out std_logic_vector(lpm_width-1 downto 0));
end mbustri;

architecture archlpmstd of Mbustri is

    signal yfb : std_logic_vector (result'range);

begin

    G0: for i in result'range generate

                U0: cy_triout port map (yfb(i),enabletr,result(i));
                U1: cy_bufoe port map (data(i),enabledt,tridata(i),yfb(i));

    end generate;

end archlpmstd;

--
-- MCOMPARE
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;

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
     clock : in std_logic := '0';
     aclr : in std_logic := '0');
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

            eqi(j) <= eq((j*C)+(C-1));

        end generate;
        C4: if (j = ((lpm_width-1)/C)) generate
            C5: if (((lpm_width-1) rem C) < (C-j)) generate
                eqi(j) <= eq(xnor_array'high);
            end generate;
            C6: if (((lpm_width-1) rem C) >= (C-j)) generate

                eqi(j) <= eq(lpm_width-1);

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

            lti(j) <= lt((j*K)+(K-1));
            gti(j) <= gt((j*K)+(K-1));

        end generate;
        C4: if (j = ((lpm_width-1)/K)) generate
            C5: if (((lpm_width-1) rem K) < (K-j)) generate
                lti(j) <= lt(lpm_width-1);
                gti(j) <= gt(lpm_width-1);
            end generate;
            C6: if (((lpm_width-1) rem K) >= (K-j)) generate

                lti(j) <= lt(lpm_width-1);
                gti(j) <= gt(lpm_width-1);

            end generate;
        end generate;
        albi(j) <= albi(j+1) OR (lti(j) AND NOT agbi(j+1));
        agbi(j) <= agbi(j+1) OR (gti(j) AND NOT albi(j+1));
    end generate;

    process (aclr, clock, aeqb, albi, agbi)
        variable eqpipe,ltpipe,gtpipe : std_logic_vector (lpm_pipeline downto 0);
    begin
        eqpipe(0) := aeqb(aeqb'high);
        ltpipe(0) := albi(0);
        gtpipe(0) := agbi(0);
        for i in lpm_pipeline downto 1 loop
            if (aclr = '1') then
                eqpipe(i) := '0';
                ltpipe(i) := '0';
                gtpipe(i) := '0';
            elsif (clock'event AND (clock = '1')) then
                eqpipe(i) := eqpipe(i-1);
                ltpipe(i) := ltpipe(i-1);
                gtpipe(i) := gtpipe(i-1);
            end if;
        end loop;
        aeb <= eqpipe(eqpipe'high);
        aneb <= NOT eqpipe(eqpipe'high);
        alb <= ltpipe(ltpipe'high);
        aleb <= NOT gtpipe(ltpipe'high);
        agb <= gtpipe(gtpipe'high);
        ageb <= NOT ltpipe(gtpipe'high);
    end process;
end archlpmstd;

--
-- MCLSHIFT
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mclshift is
    generic(lpm_width : positive := 1;
     lpm_widthdist : positive := 1;
     lpm_shifttype : shift_type := LPM_LOGICAL;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     distance : in std_logic_vector(lpm_widthdist-1 downto 0);
     direction : in std_logic := '0';
     result : out std_logic_vector(lpm_width-1 downto 0);
     overflow : out std_logic;
     underflow : out std_logic);
end mclshift;

architecture archlpmstd of Mclshift is

    signal def : std_logic;
    signal OK : boolean := true;
    signal widthv : std_logic_vector(distance'range);
    signal distexp : std_logic_vector(result'high downto 0);
    signal barrel :std_logic_vector(((result'length*result'length)-1) downto 0);
    signal left,right,sign,mask : std_logic_vector(result'high downto 0);
    signal output,loutput,aoutput : std_logic_vector(result'high downto 0);
    signal lunderflow,loverflow,aunderflow,aoverflow : std_logic;
    signal un,ov : std_logic_vector(result'high downto 0);

begin

    widthv <= vectorize(lpm_width-1,lpm_widthdist);
        OK <= (distance <= widthv);

    GB: for j in 0 to lpm_width-1 generate
        GJ1: for k in 0 to lpm_width-1 generate
            barrel((j*lpm_width)+k) <=
                data((j+k) rem lpm_width) when (direction = '1') else
                data(((j*lpm_width)+k-j) rem lpm_width);
        end generate;
    end generate;

    -- Multiplex the 'barrel' shifter inputs using 'distance' as the selector
    U0: mmux generic map (lpm_width, lpm_width, lpm_widthdist)
                port map (barrel, distance, output);

    G1: if (lpm_widthdist <= result'high) generate
        distexp(result'high downto lpm_widthdist) <= (others => '0');
    end generate;
    distexp(lpm_widthdist-1 downto 0) <= distance;

    GM:if (lpm_shifttype /= lpm_rotate) generate
        GML: for i in 0 to lpm_width-1 generate
            left(i) <= '1' when
                ((vectorize(i,lpm_width)) < distexp) else '0';
            right(result'high-i) <= '1' when
                ((vectorize(i,lpm_width)) < distexp) else '0';
        end generate;
        mask <= left when (direction = '0') else right;
    end generate;

    GL:if (lpm_shifttype = lpm_logical) generate
        loutput <= (output AND NOT mask);

        ov(0) <= output(0) AND mask(0);
        GLO: for i in 1 to lpm_width-1 generate
            ov(i) <= ov(i-1) OR (output(i) AND mask(i));
        end generate;
        loverflow <= NOT direction AND ov(ov'high);

        un(0) <= loutput(0);
        GLU: for i in 1 to lpm_width-1 generate
            un(i) <= un(i-1) OR loutput(i);
        end generate;
        lunderflow <= direction AND NOT un(un'high);
    end generate;

    GA:if (lpm_shifttype = lpm_arithmetic) generate
        sign <= (OTHERS => data(data'high));
        L0: for i in 0 to lpm_width-2 generate
            aoutput(i) <= output(i) AND NOT mask(i) when (direction = '0')
                else (output(i) AND NOT mask(i)) OR (right(i) AND sign(i));
        end generate;
        aoutput(result'high) <= data(result'high) when (direction = '0')
            else (output(result'high) AND NOT mask(result'high))
            OR (right(result'high) AND sign(result'high));

        ov(0) <= (output(0) XOR sign(0)) AND mask(0);
        GAO: for i in 1 to lpm_width-1 generate
            ov(i) <= ov(i-1) OR ((output(i) XOR sign(i)) AND mask(i));
        end generate;
        aoverflow <= NOT direction AND
                (ov(ov'high) OR (output(output'high) XOR data(data'high)));

        un(0) <= aoutput(0) XOR NOT sign(0);
        GAU: for i in 1 to lpm_width-1 generate
            un(i) <= un(i-1) AND (aoutput(i) XOR NOT sign(i));
        end generate;
        aunderflow <= direction AND un(un'high);
    end generate;

    result <= aoutput when ((lpm_shifttype = lpm_arithmetic) AND OK) else
                 loutput when ((lpm_shifttype = lpm_logical) AND OK) else
                 output when (lpm_shifttype = lpm_rotate) else
                 (OTHERS => data(data'high))
                 when ((lpm_shifttype = lpm_arithmetic) AND NOT OK) else
                 (OTHERS => '0');
    overflow <= aoverflow when (lpm_shifttype = lpm_arithmetic) else
                 loverflow when (lpm_shifttype = lpm_logical) else '0';
    underflow <= aunderflow when (lpm_shifttype = lpm_arithmetic) else
                 lunderflow when (lpm_shifttype = lpm_logical) else '0';

end archlpmstd;

--
-- MADD_SUB
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;

use cypress.cypress.all;

use cypress.lpmpkg.all;
entity madd_sub is
    generic(lpm_width : positive := 1;
     lpm_representation : repre_type := LPM_UNSIGNED;
     lpm_direction : arith_type := LPM_NO_TYP;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (dataa : in std_logic_vector(lpm_width-1 downto 0);
     datab : in std_logic_vector(lpm_width-1 downto 0);
     cin : in std_logic := '0';
     add_sub : in std_logic := '1';
     result : out std_logic_vector(lpm_width-1 downto 0);
     cout : out std_logic;
     overflow : out std_logic;
     clock : in std_logic := '0';
     aclr : in std_logic := '0');
end madd_sub;

architecture archlpmstd of Madd_sub is

    signal c,ci,e,ei,r,ri,rtmp : std_logic_vector(result'length downto 0);

    type slva is array (natural range <>) of
                   std_logic_vector(result'length-1 downto 0);

begin
        G0: if (lpm_width = 1) generate
            rtmp(0) <= (((dataA(0) XOR dataB(0)) XOR cin) AND add_sub) OR
                ((NOT(NOT dataA(0) XOR dataB(0)) XOR NOT cin) AND NOT add_sub);
            c(1) <= (((dataA(0) AND dataB(0)) OR
                    (dataA(0) AND cin) OR
                    (dataB(0) AND cin)) AND add_sub) OR
              (((NOT dataA(0) AND dataB(0)) OR
                    (NOT dataA(0) AND NOT cin) OR
                    (dataB(0) AND NOT cin)) AND NOT add_sub);
        end generate;
        G1: if (lpm_width > 1) generate
            rtmp(0) <= (((dataA(0) XOR dataB(0)) XOR cin) AND add_sub) OR
                (NOT(NOT(dataA(0) XOR dataB(0)) XOR NOT cin) AND NOT add_sub);

            rtmp(1) <= (((dataA(1) XOR dataB(1)) XOR
                       ((dataA(0) AND dataB(0)) OR ( dataA(0) AND cin) OR
                                     (dataB(0) AND cin))) AND add_sub) OR
                (NOT(NOT(dataA(1) XOR dataB(1)) XOR
                   ((NOT dataA(0) AND dataB(0)) OR (NOT dataA(0) AND NOT cin) OR
                                     (dataB(0) AND NOT cin))) AND NOT add_sub);

            c(0) <= (((dataA(0) AND dataB(0) AND dataA(1)) OR
                        (dataA(0) AND dataB(0) AND dataB(1)) OR
                             (cin AND dataB(0) AND dataA(1)) OR
                             (cin AND dataB(0) AND dataB(1)) OR
                        (dataA(0) AND cin AND dataA(1)) OR
                        (dataA(0) AND cin AND dataB(1)) OR
                        (dataA(1) AND dataB(1))) AND add_sub) OR
                  (((NOT dataA(0) AND dataB(0) AND NOT dataA(1)) OR
                    (NOT dataA(0) AND dataB(0) AND dataB(1)) OR
                         (NOT cin AND dataB(0) AND NOT dataA(1)) OR
                         (NOT cin AND dataB(0) AND dataB(1)) OR
                    (NOT dataA(0) AND NOT cin AND NOT dataA(1)) OR
                    (NOT dataA(0) AND NOT cin AND dataB(1)) OR
                    (NOT dataA(1) AND dataB(1))) AND NOT add_sub);

            c(2) <= c(0);

            ci(2) <= c(2);
        end generate;

        T1: if (lpm_width/2) /= 0 generate
            GB0: for h in 1 to ((lpm_width/2)-1) generate
                rtmp(2*h)<=((((dataA(2*h) XOR dataB(2*h)) XOR c(2*h)))
                        AND add_sub) OR
                    ((NOT(NOT(dataA(2*h) XOR dataB(2*h)) XOR c(2*h)))
                        AND NOT add_sub);
                rtmp(2*h+1) <= (((dataA(2*h+1) XOR dataB(2*h+1)) XOR
                               ((dataA(2*h) AND dataB(2*h)) OR
                                (dataA(2*h) AND c(2*h)) OR
                                (dataB(2*h) AND c(2*h)))) AND add_sub) OR
                        (NOT(NOT(dataA(2*h+1) XOR dataB(2*h+1)) XOR
                           ((NOT dataA(2*h) AND dataB(2*h)) OR
                            (NOT dataA(2*h) AND c(2*h)) OR
                                (dataB(2*h) AND c(2*h)))) AND NOT add_sub);

                GSS: if (lpm_hint = SPEED) generate
                  ei(2*h+2)<=(((dataA(2*h+1) AND dataB(2*h+1)) OR
                              ((dataA(2*h+1) OR dataB(2*h+1)) AND
                               (dataA(2*h) AND dataB(2*h)))) AND add_sub)
                      OR (((NOT dataA(2*h+1) AND dataB(2*h+1)) OR
                          ((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                           (NOT dataA(2*h) AND dataB(2*h)))) AND NOT add_sub);
                  ri(2*h+2)<=(((dataA(2*h+1) OR dataB(2*h+1)) AND
                               (dataA(2*h) OR dataB(2*h))) AND add_sub)
                      OR (((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                           (NOT dataA(2*h) OR dataB(2*h))) AND NOT add_sub);
                     e(2*h+2) <= ei(2*h+2);
                     r(2*h+2) <= ri(2*h+2);
                    ci(2*h+2) <= e(2*h+2) OR (ci(2*h) AND r(2*h+2));

                end generate;
                GAA: if (lpm_hint /= SPEED) generate
                  ci(2*h+2)<=(((dataA(2*h) AND dataB(2*h) AND dataA(2*h+1))
                        OR (dataA(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataA(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (dataA(2*h) AND c(2*h) AND dataA(2*h+1))
                        OR (dataA(2*h) AND c(2*h) AND dataB(2*h+1))
                        OR (dataA(2*h+1) AND dataB(2*h+1)))
                                                AND add_sub) OR
                         (((NOT dataA(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h+1) AND dataB(2*h+1)))
                                                AND NOT add_sub);
                end generate;

                c(2*h+2) <= ci(2*h+2);

            end generate;
        end generate;

        GB1: if (((lpm_width rem 2) /= 0) AND lpm_width /= 1) generate
            rtmp(result'high) <= ((((dataA(result'high) XOR
                                         dataB(result'high)) XOR
                                             c(result'high))) AND add_sub)
                            OR ((NOT(NOT(dataA(result'high) XOR
                                         dataB(result'high)) XOR
                                             c(result'high))) AND NOT add_sub);

            c(result'length) <= (((dataA(result'high) AND dataB(result'high)) OR
                           (dataA(result'high) AND c(result'high)) OR
                           (dataB(result'high) AND c(result'high))) AND add_sub)

                  OR (((NOT dataA(result'high) AND dataB(result'high)) OR
                       (NOT dataA(result'high) AND c(result'high)) OR
                           (dataB(result'high) AND c(result'high))) AND NOT add_sub);
        end generate;

    process (aclr,clock,rtmp,c,dataA,dataB,add_sub)
        variable rpipe : slva (lpm_pipeline downto 0);
        variable cpipe : std_logic_vector (lpm_pipeline downto 0);
        variable opipe : std_logic_vector (lpm_pipeline downto 0);
    begin
        rpipe(0) := rtmp(lpm_width-1 downto 0);
        if (((lpm_direction = lpm_no_typ) AND (add_sub = '1')) OR
              lpm_direction = lpm_add) then
            cpipe(0) := c(result'length);
            opipe(0) := ((rtmp(result'high) AND
                     NOT dataA(result'high) AND NOT dataB(result'high)) OR
                     (NOT rtmp(result'high) AND
                         dataA(result'high) AND dataB(result'high)));
        else
            cpipe(0) := NOT c(result'length);
            opipe(0) := ((rtmp(result'high) AND
                     NOT dataA(result'high) AND dataB(result'high)) OR
                     (NOT rtmp(result'high) AND
                         dataA(result'high) AND NOT dataB(result'high)));
        end if;
        for i in lpm_pipeline downto 1 loop
            if (aclr = '1') then
                rpipe(i) := (others => '0');
                cpipe(i) := '0';
                opipe(i) := '0';
            elsif (clock'event AND (clock = '1')) then
                rpipe(i) := rpipe(i-1);
                cpipe(i) := cpipe(i-1);
                opipe(i) := opipe(i-1);
            end if;
        end loop;

          result <= rpipe(rpipe'high);
            cout <= cpipe(cpipe'high);
        overflow <= opipe(opipe'high);

    end process;
end archlpmstd;

--
-- MMULT
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;

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
     sum : in std_logic_vector(lpm_widths-1 downto 0) := (others => '0');
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

        Ixg <= (s(0,isize-2) and a(isize-1)) or
                (s(0,isize-2) and b(isize-1)) or
                (a(isize-1) and b(isize-1));

    end generate;
    NG: if (lpm_representation = lpm_unsigned) generate
        Isg <= I((isize-1),(isize-1));
        Icg <= '1';
        Ixg <= '0';
    end generate;
    Imax <= Isg;

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

                s(col,row) <= si(col,row);
                c(col,row) <= ci(col,row);

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
                    C7: if (col = (isize-2)) generate
                        si(col,row) <= Imax xor c(col,row-1) xor c(col-1,row);
                        ci(col,row) <= (Imax and c(col,row-1)) or
                                        (Imax and c(col-1,row)) or
                                        (c(col,row-1) and c(col-1,row));
                    end generate;
                end generate;
                c(col,row) <= ci(col,row);
                s(col,row) <= si(col,row);

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

--
-- MABS
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mabs is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0);
     overflow : out std_logic);
end mabs;
architecture archlpmstd of Mabs is

    signal switch,tmp : std_logic_vector(result'high downto 0);

begin

    switch(0) <= data(0) AND data(data'high);
    tmp(0) <= data(0);

    G0:for i in 1 to lpm_width-1 generate
        switch(i) <= (switch(i-1) OR data(i)) AND data(data'high);
        tmp(i) <= switch(i-1) XOR data(i);
    end generate;

    result <= tmp;
    overflow <= NOT switch(switch'high-1) AND tmp(tmp'high);

end archlpmstd;

--
-- MCOUNTER
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_tsrff;

use cypress.cypress.all;

use cypress.lpmpkg.all;
entity mcounter is
    generic(lpm_width : positive := 1;
     lpm_direction : ctdir_type := LPM_NO_DIR;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => '0');
     clock : in std_logic;
     clk_en : in std_logic := '1';
     cnt_en : in std_logic := '1';
     updown : in std_logic := '1';
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := '0';
     aclr : in std_logic := '0';
     aload : in std_logic := '0';
     sset : in std_logic := '0';
     sclr : in std_logic := '0';
     sload : in std_logic := '0';
     testenab : in std_logic := '0';
     testin : in std_logic := '0';
     testout : out std_logic);
end mcounter;

architecture archlpmstd of Mcounter is
    signal qtmp,t,en : std_logic_vector(q'high downto 0);
    signal async,sync,set,clr : std_logic_vector(q'high downto 0);

begin

    async <= restring(lpm_avalue,lpm_width);
    sync <= restring(lpm_svalue,lpm_width);

    en(0) <= '1';

    G0: for j in q'range generate
        G1:if (j /= 0) generate
            TU: if (lpm_direction = lpm_up) generate
                en(j) <= (en(j-1) AND qtmp(j-1));
            end generate;
            TD: if (lpm_direction = lpm_down) generate
                en(j) <= (en(j-1) AND NOT qtmp(j-1));
            end generate;
            TB: if (lpm_direction = lpm_no_dir) generate
                en(j) <= (en(j-1) AND qtmp(j-1) AND updown)
                      OR (en(j-1) AND NOT qtmp(j-1) AND NOT updown);
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
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => '0');
     gate : in std_logic;
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := '0';
     aclr : in std_logic := '0');
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
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => '0');
     clock : in std_logic;
     enable : in std_logic := '1';
     shiftin : in std_logic := '0';
     load : in std_logic := '0';
     q : out std_logic_vector(lpm_width-1 downto 0);
     shiftout : out std_logic;
     aset : in std_logic := '0';
     aclr : in std_logic := '0';
     sset : in std_logic := '0';
     sclr : in std_logic := '0';
     testenab : in std_logic := '0';
     testin : in std_logic := '0';
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

--
-- MPARITY
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mparity is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (data : in std_logic_vector (lpm_width - 1 downto 0);
     even : out std_logic;
     odd : out std_logic;
     clock : in std_logic := '0';
     aclr : in std_logic := '0');
end mparity;

architecture archlpmstd of Mparity is

    CONSTANT slice : integer := 4;

begin

    Parity_Gen: process (Data,clock,aclr)
        variable datain : std_logic_vector (Data'range);
        variable length : integer; -- Length of the next parity tree
        variable pLength: integer; -- Length of the current parity tree
        variable index : integer; -- Loop count
        variable offset : integer; -- Offset for each level of parity tree
        variable last : std_logic; -- Stores the last XOR ever done

        variable result : std_logic_vector (((Data'length+slice-1)/slice*
                                       (Data'length+slice-1)/slice) downto 0);
        variable oddpipe,evnpipe : std_logic_vector (lpm_pipeline downto 0);

    begin
        pLength := Data'length;
        offset := (Data'length+(slice-1)) / slice;
        index := 0;
        last := '0';
        while ( pLength > 0 ) loop
            length := (plength+(slice-1)) / slice;
            if (index = 0) then
                datain := Data;
            else
                for i in plength-1 downto 0 loop
                    datain(i) := result(((index-1) * offset) + i);
                end loop;
            end if;
            for i in 0 to length - 1 loop
                last := datain(i*slice);
                for j in 1 to slice-1 loop
                    if (i*slice+j) < plength then
                        last := last XOR datain(i*slice+j);
                    end if;
                end loop;

                result((index * offset) + i) := last;

            end loop;
            if (length = 1) then
                plength := 0;
            else
                plength := length;
            end if;
            index := index + 1;
        end loop;

        oddpipe(0) := last;
        evnpipe(0) := NOT last;
        for i in lpm_pipeline downto 1 loop
            if (aclr = '1') then
                oddpipe(i) := '0';
                evnpipe(i) := '0';
            elsif (clock'event AND (clock = '1')) then
                oddpipe(i) := oddpipe(i-1);
                evnpipe(i) := evnpipe(i-1);
            end if;
        end loop;
        odd <= oddpipe(oddpipe'high);
        even <= evnpipe(evnpipe'high);

    end process parity_gen;

end archlpmstd;

--
-- MRAM_DQ
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

library cypress;
use cypress.lpmpkg.all;
entity mram_dq is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := LPM_REGISTERED;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     address : in std_logic_vector(lpm_widthad-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     inclock : in std_logic := '0';
     outclock : in std_logic := '0';
     we : in std_logic;
     outreg_ar : in std_logic := '0');
end mram_dq;

architecture archlpmstd of Mram_dq is

    constant size : integer := 2**lpm_widthad;
    signal atmp : std_logic_vector((lpm_widthad-1) downto 0);
    signal dtmp : std_logic_vector((lpm_width-1) downto 0);
    signal qtmp : std_logic_vector((lpm_width-1) downto 0);
    signal wtmp : std_logic;
    type memarray is array (size-1 downto 0)
                                    of std_logic_vector(lpm_width-1 downto 0);

    function hex2int (c : character) return integer is
    begin
        case c is
            when '0' => return 0;
            when '1' => return 1;
            when '2' => return 2;
            when '3' => return 3;
            when '4' => return 4;
            when '5' => return 5;
            when '6' => return 6;
            when '7' => return 7;
            when '8' => return 8;
            when '9' => return 9;
            when 'a' => return 10;
            when 'b' => return 11;
            when 'c' => return 12;
            when 'd' => return 13;
            when 'e' => return 14;
            when 'f' => return 15;
            when 'A' => return 10;
            when 'B' => return 11;
            when 'C' => return 12;
            when 'D' => return 13;
            when 'E' => return 14;
            when 'F' => return 15;
            when others => return -1;
        end case;
    end hex2int;

    function hex2vec (c : character) return std_logic_vector is
    begin
        case c is
            when '0' => return "0000";
            when '1' => return "0001";
            when '2' => return "0010";
            when '3' => return "0011";
            when '4' => return "0100";
            when '5' => return "0101";
            when '6' => return "0110";
            when '7' => return "0111";
            when '8' => return "1000";
            when '9' => return "1001";
            when 'a' => return "1010";
            when 'b' => return "1011";
            when 'c' => return "1100";
            when 'd' => return "1101";
            when 'e' => return "1110";
            when 'f' => return "1111";
            when 'A' => return "1010";
            when 'B' => return "1011";
            when 'C' => return "1100";
            when 'D' => return "1101";
            when 'E' => return "1110";
            when 'F' => return "1111";
            when others => assert (false)
       report "Illegal Intel Hex format in data field."
       severity error;
   return "0000";
        end case;
    end hex2vec;

    function "+" (a,b : std_logic_vector) return std_logic_vector is
 variable s : std_logic_vector (7 downto 0) := (others => '0');
 variable c : std_logic_vector (8 downto 0) := (others => '0');
 variable atmp : std_logic_vector (7 downto 0) := a;
 variable btmp : std_logic_vector (7 downto 0) := b;
    begin
     for i in 0 to 7 loop
     s(i) := atmp(i) XOR btmp(i) XOR c(i);
     c(i+1) := (atmp(i) AND btmp(i))
     OR (atmp(i) AND c(i))
     OR (btmp(i) AND c(i));
 end loop;
 return s;
    end "+";

    function fillmem(width : integer; length : natural; filename : string)
       return memarray is

     file instuff : text open read_mode is filename;

 constant onevect : std_logic_vector(7 downto 0) := "00000001";
 variable tmp0,tmp1 : line;
 variable char : character;
 variable start_code : character;
 variable byte_count : string (2 downto 1);
 variable address : string (4 downto 1);
 variable record_type : string (2 downto 1);
 variable data : string (2 downto 1);
 variable check_sum : string (2 downto 1);
 variable lsb,msb : integer;
 variable ab3,ab2,ab1,ab0: integer;
 variable count,addr : integer;
 variable offset : integer := 0;
 variable lsn, msn : std_logic_vector(3 downto 0);
 variable sum : std_logic_vector(7 downto 0);
 variable bytecount : integer := ((width-1)/8)+1;
 variable word : std_logic_vector((((width-1)/8)+1)*8-1 downto 0);
 variable mem : memarray;

    begin

 for i in length-1 downto 0 loop
     mem(i) := (others => '0');
 end loop;

     L1: while NOT (endfile(instuff)) loop
     readline (instuff,tmp0);
     sum := (others => '0');
     for i in 1 to tmp0'length loop
  read (tmp0,char);
  if ((char /= ' ') AND (char /= '_')) then
      write(tmp1,char);
  end if;
     end loop;

     read (tmp1, start_code);
     assert (start_code = ':')
  report "Illegal Intel Hex format."
  severity error;

     read (tmp1, byte_count);
     msb := hex2int(byte_count(2));
     lsb := hex2int(byte_count(1));
     msn := hex2vec(byte_count(2));
     lsn := hex2vec(byte_count(1));
     sum := sum + (msn & lsn);
     assert (lsb >= 0 AND msb >= 0)
  report "Illegal Intel Hex format in byte count field."
  severity error;
     count := 16*msb+lsb;

     read (tmp1, address);
     ab3 := hex2int(address(4));
     ab2 := hex2int(address(3));
     ab1 := hex2int(address(2));
     ab0 := hex2int(address(1));
     msn := hex2vec(address(4));
     lsn := hex2vec(address(3));
     sum := sum + (msn & lsn);
     msn := hex2vec(address(2));
     lsn := hex2vec(address(1));
     sum := sum + (msn & lsn);
     assert (ab3 >= 0 AND ab2 >= 0 AND ab1 >= 0 AND ab0 >= 0)
  report "Illegal Intel Hex format in address field."
  severity error;
     addr := 4096*ab3+256*ab2+16*ab1+ab0;

     read (tmp1, record_type);
     msn := hex2vec(record_type(2));
     lsn := hex2vec(record_type(1));
     sum := sum + (msn & lsn);
     assert (record_type="00" OR record_type="01" OR record_type="02")
  report "Illegal Intel Hex format in record type."
  severity error;
     if (record_type = "02") then
  offset := addr*16;
     end if;

     assert ((count REM bytecount) = 0)
  report "Illegal Intel Hex format in data field."
  severity error;
     for i in 0 to (count/bytecount)-1 loop
  for j in 1 to bytecount loop
      read (tmp1, data);
      msn := hex2vec(data(2));
      lsn := hex2vec(data(1));
      sum := sum + (msn & lsn);
      if (i+addr+offset < length) then
   word((bytecount-j+1)*8-1 downto ((bytecount-j+1)-1)*8)
          := msn & lsn;

   mem(i+addr+offset) := word(width-1 downto 0);
      end if;
  end loop;
     end loop;

     read (tmp1, check_sum);
     msn := hex2vec(check_sum(2));
     lsn := hex2vec(check_sum(1));
     sum := (NOT sum) + onevect;
     assert ((hex2vec(check_sum(2)) & hex2vec(check_sum(1))) = sum)
  report "Bad checksum."
  severity error;
     if (record_type = "01") then
  exit L1;
     end if;
 end loop;
 deallocate(tmp0);
 deallocate(tmp1);
 return mem;
    end fillmem;

    function initmem(width : integer; length : natural; filename : string)
       return memarray is
 variable mem : memarray;
    begin
     if (filename = "") then
     for i in length-1 downto 0 loop
      mem(i) := (others => '0');
     end loop;
     return mem;
 else
     return fillmem(width,length,filename);
 end if;
    end initmem;
begin

    assert (lpm_numwords = size)
    report "Lpm_widthad and lpm_numwords don't agree, lpm_widthad being used."
    severity note;

    process (inclock, address)
    begin
        -- Synchronous Address
        if (lpm_address_control = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                atmp <= address;
            end if;
        else
        -- Asynchronous Address
            atmp <= address;
        end if;
    end process;

    process (inclock, data)
    begin
        -- Synchronous Data
        if (lpm_indata = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                dtmp <= data;
            end if;
        else
        -- Asynchronous Data
            dtmp <= data;
        end if;
    end process;

    process (inclock, we)
        variable wreg : std_logic;
    begin
        -- Synchronous Write
        if (lpm_address_control = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                wreg := we;
            end if;
            wtmp <= wreg AND inclock;
        else
        -- Asynchronous Write
            wtmp <= we;
        end if;
    end process;

    -- Write and/or Read the appropriate range of memory
    MEMORY:process (dtmp, atmp, wtmp)

        variable mem : memarray := initmem(lpm_width,size,lpm_file);
        variable index : natural;

        function to_integer (a : std_logic_vector) return natural is
            variable tmp : std_logic_vector(a'length-1 downto 0);
            variable result, abit: natural := 0;
        begin
            if (a'length < 1) then
                return 0;
                end if;
            tmp := a;
            for i in tmp'reverse_range loop
                abit := 0;
                if tmp(i) = '1' then
                    abit := 2**i;
                end if;
                result := result + abit;
                exit when i = 31;
            end loop;
            return result;
        end to_integer;

    begin

        index := to_integer(atmp);
        if (wtmp = '1') then
            mem(index) := dtmp;
        end if;
        qtmp <= mem(index);

    end process;

    process (outreg_ar, outclock, qtmp)
    begin
        -- Synchronous Read of RAM
        if (lpm_outdata = lpm_registered) then
            if (outreg_ar = '1') then
                q <= (others => '0');
            elsif (outclock'event AND outclock = '1') then
                q <= qtmp;
            end if;
        else
        -- Asynchronous Read of RAM
            q <= qtmp;
        end if;
    end process;

end archlpmstd;

--
-- MRAM_IO
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

library cypress;
use cypress.lpmpkg.all;
library ieee;
use ieee.std_logic_1164.all;
entity mram_io is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := LPM_REGISTERED;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (dio : inout std_logic_vector(lpm_width-1 downto 0);
     address : in std_logic_vector(lpm_widthad-1 downto 0);
     inclock : in std_logic := '0';
     outclock : in std_logic := '0';
     memenab : in std_logic := '1';
     outenab : in std_logic := '0';
     we : in std_logic := '1';
     outreg_ar : in std_logic := '0');
end mram_io;

architecture archlpmstd of Mram_io is
    constant size : integer := 2**lpm_widthad;
    signal atmp : std_logic_vector((lpm_widthad-1) downto 0);
    signal dtmp : std_logic_vector((lpm_width-1) downto 0);
    signal qtmp : std_logic_vector((lpm_width-1) downto 0);
    signal wtmp : std_logic;
    signal q : std_logic_vector((lpm_width-1) downto 0);
    signal mw,mr: std_logic;
    type memarray is array (size-1 downto 0)
                                    of std_logic_vector(lpm_width-1 downto 0);

    function hex2int (c : character) return integer is
    begin
        case c is
            when '0' => return 0;
            when '1' => return 1;
            when '2' => return 2;
            when '3' => return 3;
            when '4' => return 4;
            when '5' => return 5;
            when '6' => return 6;
            when '7' => return 7;
            when '8' => return 8;
            when '9' => return 9;
            when 'a' => return 10;
            when 'b' => return 11;
            when 'c' => return 12;
            when 'd' => return 13;
            when 'e' => return 14;
            when 'f' => return 15;
            when 'A' => return 10;
            when 'B' => return 11;
            when 'C' => return 12;
            when 'D' => return 13;
            when 'E' => return 14;
            when 'F' => return 15;
            when others => return -1;
        end case;
    end hex2int;

    function hex2vec (c : character) return std_logic_vector is
    begin
        case c is
            when '0' => return "0000";
            when '1' => return "0001";
            when '2' => return "0010";
            when '3' => return "0011";
            when '4' => return "0100";
            when '5' => return "0101";
            when '6' => return "0110";
            when '7' => return "0111";
            when '8' => return "1000";
            when '9' => return "1001";
            when 'a' => return "1010";
            when 'b' => return "1011";
            when 'c' => return "1100";
            when 'd' => return "1101";
            when 'e' => return "1110";
            when 'f' => return "1111";
            when 'A' => return "1010";
            when 'B' => return "1011";
            when 'C' => return "1100";
            when 'D' => return "1101";
            when 'E' => return "1110";
            when 'F' => return "1111";
            when others => assert (false)
       report "Illegal Intel Hex format in data field."
       severity error;
   return "0000";
        end case;
    end hex2vec;

    function "+" (a,b : std_logic_vector) return std_logic_vector is
 variable s : std_logic_vector (7 downto 0) := (others => '0');
 variable c : std_logic_vector (8 downto 0) := (others => '0');
 variable atmp : std_logic_vector (7 downto 0) := a;
 variable btmp : std_logic_vector (7 downto 0) := b;
    begin
     for i in 0 to 7 loop
     s(i) := atmp(i) XOR btmp(i) XOR c(i);
     c(i+1) := (atmp(i) AND btmp(i))
     OR (atmp(i) AND c(i))
     OR (btmp(i) AND c(i));
 end loop;
 return s;
    end "+";

    function fillmem(width : integer; length : natural; filename : string)
       return memarray is

     file instuff : text open read_mode is filename;

 constant onevect : std_logic_vector(7 downto 0) := "00000001";
 variable tmp0,tmp1 : line;
 variable char : character;
 variable start_code : character;
 variable byte_count : string (2 downto 1);
 variable address : string (4 downto 1);
 variable record_type : string (2 downto 1);
 variable data : string (2 downto 1);
 variable check_sum : string (2 downto 1);
 variable lsb,msb : integer;
 variable ab3,ab2,ab1,ab0: integer;
 variable count,addr : integer;
 variable offset : integer := 0;
 variable lsn, msn : std_logic_vector(3 downto 0);
 variable sum : std_logic_vector(7 downto 0);
 variable bytecount : integer := ((width-1)/8)+1;
 variable word : std_logic_vector((((width-1)/8)+1)*8-1 downto 0);
 variable mem : memarray;

    begin

 for i in length-1 downto 0 loop
     mem(i) := (others => '0');
 end loop;

     L1: while NOT (endfile(instuff)) loop
     readline (instuff,tmp0);
     sum := (others => '0');
     for i in 1 to tmp0'length loop
  read (tmp0,char);
  if ((char /= ' ') AND (char /= '_')) then
      write(tmp1,char);
  end if;
     end loop;

     read (tmp1, start_code);
     assert (start_code = ':')
  report "Illegal Intel Hex format."
  severity error;

     read (tmp1, byte_count);
     msb := hex2int(byte_count(2));
     lsb := hex2int(byte_count(1));
     msn := hex2vec(byte_count(2));
     lsn := hex2vec(byte_count(1));
     sum := sum + (msn & lsn);
     assert (lsb >= 0 AND msb >= 0)
  report "Illegal Intel Hex format in byte count field."
  severity error;
     count := 16*msb+lsb;

     read (tmp1, address);
     ab3 := hex2int(address(4));
     ab2 := hex2int(address(3));
     ab1 := hex2int(address(2));
     ab0 := hex2int(address(1));
     msn := hex2vec(address(4));
     lsn := hex2vec(address(3));
     sum := sum + (msn & lsn);
     msn := hex2vec(address(2));
     lsn := hex2vec(address(1));
     sum := sum + (msn & lsn);
     assert (ab3 >= 0 AND ab2 >= 0 AND ab1 >= 0 AND ab0 >= 0)
  report "Illegal Intel Hex format in address field."
  severity error;
     addr := 4096*ab3+256*ab2+16*ab1+ab0;

     read (tmp1, record_type);
     msn := hex2vec(record_type(2));
     lsn := hex2vec(record_type(1));
     sum := sum + (msn & lsn);
     assert (record_type="00" OR record_type="01" OR record_type="02")
  report "Illegal Intel Hex format in record type."
  severity error;
     if (record_type = "02") then
  offset := addr*16;
     end if;

     assert ((count REM bytecount) = 0)
  report "Illegal Intel Hex format in data field."
  severity error;
     for i in 0 to (count/bytecount)-1 loop
  for j in 1 to bytecount loop
      read (tmp1, data);
      msn := hex2vec(data(2));
      lsn := hex2vec(data(1));
      sum := sum + (msn & lsn);
      if (i+addr+offset < length) then
   word((bytecount-j+1)*8-1 downto ((bytecount-j+1)-1)*8)
          := msn & lsn;

   mem(i+addr+offset) := word(width-1 downto 0);
      end if;
  end loop;
     end loop;

     read (tmp1, check_sum);
     msn := hex2vec(check_sum(2));
     lsn := hex2vec(check_sum(1));
     sum := (NOT sum) + onevect;
     assert ((hex2vec(check_sum(2)) & hex2vec(check_sum(1))) = sum)
  report "Bad checksum."
  severity error;
     if (record_type = "01") then
  exit L1;
     end if;
 end loop;
 deallocate(tmp0);
 deallocate(tmp1);
 return mem;
    end fillmem;

    function initmem(width : integer; length : natural; filename : string)
       return memarray is
 variable mem : memarray;
    begin
     if (filename = "") then
     for i in length-1 downto 0 loop
      mem(i) := (others => '0');
     end loop;
     return mem;
 else
     return fillmem(width,length,filename);
 end if;
    end initmem;
begin

    assert (lpm_numwords = size)
    report "Lpm_widthad and lpm_numwords don't agree, lpm_widthad being used."
    severity note;

    mw <= memenab AND (we AND NOT outenab);
    mr <= memenab AND NOT(we AND NOT outenab);

    process (inclock, address)
    begin
        -- Synchronous Address
        if (lpm_address_control = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                atmp <= address;
            end if;
        else
        -- Asynchronous Address
            atmp <= address;
        end if;
    end process;

    process (inclock, dio)
    begin
        -- Synchronous Data
        if (lpm_indata = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                dtmp <= dio;

            end if;
        else
        -- Asynchronous Data
            dtmp <= dio;

        end if;
    end process;

    process (inclock, mw)
        variable wreg : std_logic;
    begin
        -- Synchronous Write
        if (lpm_address_control = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                wreg := mw;
            end if;
            wtmp <= wreg AND inclock;
        else
        -- Asynchronous Write
            wtmp <= mw;
        end if;
    end process;

    -- Write and/or Read the appropriate range of memory
    MEMORY:process (dtmp, atmp, wtmp)

        variable mem : memarray := initmem(lpm_width,size,lpm_file);
        variable index : natural;

        function to_integer (a : std_logic_vector) return natural is
            variable tmp : std_logic_vector(a'length-1 downto 0);
            variable result, abit: natural := 0;
        begin
            if (a'length < 1) then
                return 0;
                end if;
            tmp := a;
            for i in tmp'reverse_range loop
                abit := 0;
                if tmp(i) = '1' then
                    abit := 2**i;
                end if;
                result := result + abit;
                exit when i = 31;
            end loop;
            return result;
        end to_integer;

    begin
        index := to_integer(atmp);
        if (wtmp = '1') then
            mem(index) := dtmp;
        end if;
        qtmp <= mem(index);
    end process;

    process (outreg_ar, outclock, qtmp)
    begin
        -- Synchronous Read of RAM
        if (lpm_outdata = lpm_registered) then
            if (outreg_ar = '1') then
                q <= (others => '0');
            elsif (outclock'event AND outclock = '1') then
                q <= qtmp;
            end if;
        else
        -- Asynchronous Read of RAM
            q <= qtmp;
        end if;
    end process;

    -- Output the data when in read mode, otherwise HI-Z
    process (q, mr)
    begin
        if (mr = '1') then
            dio <= q;

        else

            dio <= (others => 'Z');

        end if;
    end process;
end archlpmstd;

--
-- MROM
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

library cypress;
use cypress.lpmpkg.all;
library ieee;
use ieee.std_logic_1164.all;
entity mrom is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (address : in std_logic_vector(lpm_widthad-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     inclock : in std_logic := '0';
     outclock : in std_logic := '0';
     memenab : in std_logic := '1';
     outreg_AR : in std_logic := '0');
end mrom;

architecture archlpmstd of mrom is

    constant size : integer := 2**lpm_widthad;
    signal atmp : std_logic_vector((lpm_widthad-1) downto 0);
    signal qx : std_logic_vector((lpm_width-1) downto 0);
    signal qtmp : std_logic_vector((lpm_width-1) downto 0);
    type memarray is array (size-1 downto 0)
                                    of std_logic_vector(lpm_width-1 downto 0);

    function hex2int (c : character) return integer is
    begin
        case c is
            when '0' => return 0;
            when '1' => return 1;
            when '2' => return 2;
            when '3' => return 3;
            when '4' => return 4;
            when '5' => return 5;
            when '6' => return 6;
            when '7' => return 7;
            when '8' => return 8;
            when '9' => return 9;
            when 'a' => return 10;
            when 'b' => return 11;
            when 'c' => return 12;
            when 'd' => return 13;
            when 'e' => return 14;
            when 'f' => return 15;
            when 'A' => return 10;
            when 'B' => return 11;
            when 'C' => return 12;
            when 'D' => return 13;
            when 'E' => return 14;
            when 'F' => return 15;
            when others => return -1;
        end case;
    end hex2int;

    function hex2vec (c : character) return std_logic_vector is
    begin
        case c is
            when '0' => return "0000";
            when '1' => return "0001";
            when '2' => return "0010";
            when '3' => return "0011";
            when '4' => return "0100";
            when '5' => return "0101";
            when '6' => return "0110";
            when '7' => return "0111";
            when '8' => return "1000";
            when '9' => return "1001";
            when 'a' => return "1010";
            when 'b' => return "1011";
            when 'c' => return "1100";
            when 'd' => return "1101";
            when 'e' => return "1110";
            when 'f' => return "1111";
            when 'A' => return "1010";
            when 'B' => return "1011";
            when 'C' => return "1100";
            when 'D' => return "1101";
            when 'E' => return "1110";
            when 'F' => return "1111";
            when others => assert (false)
       report "Illegal Intel Hex format in data field."
       severity error;
   return "0000";
        end case;
    end hex2vec;

    function "+" (a,b : std_logic_vector) return std_logic_vector is
 variable s : std_logic_vector (7 downto 0) := (others => '0');
 variable c : std_logic_vector (8 downto 0) := (others => '0');
 variable atmp : std_logic_vector (7 downto 0) := a;
 variable btmp : std_logic_vector (7 downto 0) := b;
    begin
     for i in 0 to 7 loop
     s(i) := atmp(i) XOR btmp(i) XOR c(i);
     c(i+1) := (atmp(i) AND btmp(i))
     OR (atmp(i) AND c(i))
     OR (btmp(i) AND c(i));
 end loop;
 return s;
    end "+";

    function fillmem(width : integer; length : natural; filename : string)
       return memarray is

     file instuff : text open read_mode is filename;

 constant onevect : std_logic_vector(7 downto 0) := "00000001";
 variable tmp0,tmp1 : line;
 variable char : character;
 variable start_code : character;
 variable byte_count : string (2 downto 1);
 variable address : string (4 downto 1);
 variable record_type : string (2 downto 1);
 variable data : string (2 downto 1);
 variable check_sum : string (2 downto 1);
 variable lsb,msb : integer;
 variable ab3,ab2,ab1,ab0: integer;
 variable count,addr : integer;
 variable offset : integer := 0;
 variable lsn, msn : std_logic_vector(3 downto 0);
 variable sum : std_logic_vector(7 downto 0);
 variable bytecount : integer := ((width-1)/8)+1;
 variable word : std_logic_vector((((width-1)/8)+1)*8-1 downto 0);
 variable mem : memarray;

    begin

 for i in length-1 downto 0 loop
     mem(i) := (others => '0');
 end loop;

     L1: while NOT (endfile(instuff)) loop
     readline (instuff,tmp0);
     sum := (others => '0');
     for i in 1 to tmp0'length loop
  read (tmp0,char);
  if ((char /= ' ') AND (char /= '_')) then
      write(tmp1,char);
  end if;
     end loop;

     read (tmp1, start_code);
     assert (start_code = ':')
  report "Illegal Intel Hex format."
  severity error;

     read (tmp1, byte_count);
     msb := hex2int(byte_count(2));
     lsb := hex2int(byte_count(1));
     msn := hex2vec(byte_count(2));
     lsn := hex2vec(byte_count(1));
     sum := sum + (msn & lsn);
     assert (lsb >= 0 AND msb >= 0)
  report "Illegal Intel Hex format in byte count field."
  severity error;
     count := 16*msb+lsb;

     read (tmp1, address);
     ab3 := hex2int(address(4));
     ab2 := hex2int(address(3));
     ab1 := hex2int(address(2));
     ab0 := hex2int(address(1));
     msn := hex2vec(address(4));
     lsn := hex2vec(address(3));
     sum := sum + (msn & lsn);
     msn := hex2vec(address(2));
     lsn := hex2vec(address(1));
     sum := sum + (msn & lsn);
     assert (ab3 >= 0 AND ab2 >= 0 AND ab1 >= 0 AND ab0 >= 0)
  report "Illegal Intel Hex format in address field."
  severity error;
     addr := 4096*ab3+256*ab2+16*ab1+ab0;

     read (tmp1, record_type);
     msn := hex2vec(record_type(2));
     lsn := hex2vec(record_type(1));
     sum := sum + (msn & lsn);
     assert (record_type="00" OR record_type="01" OR record_type="02")
  report "Illegal Intel Hex format in record type."
  severity error;
     if (record_type = "02") then
  offset := addr*16;
     end if;

     assert ((count REM bytecount) = 0)
  report "Illegal Intel Hex format in data field."
  severity error;
     for i in 0 to (count/bytecount)-1 loop
  for j in 1 to bytecount loop
      read (tmp1, data);
      msn := hex2vec(data(2));
      lsn := hex2vec(data(1));
      sum := sum + (msn & lsn);
      if (i+addr+offset < length) then
   word((bytecount-j+1)*8-1 downto ((bytecount-j+1)-1)*8)
          := msn & lsn;

   mem(i+addr+offset) := word(width-1 downto 0);
      end if;
  end loop;
     end loop;

     read (tmp1, check_sum);
     msn := hex2vec(check_sum(2));
     lsn := hex2vec(check_sum(1));
     sum := (NOT sum) + onevect;
     assert ((hex2vec(check_sum(2)) & hex2vec(check_sum(1))) = sum)
  report "Bad checksum."
  severity error;
     if (record_type = "01") then
  exit L1;
     end if;
 end loop;
 deallocate(tmp0);
 deallocate(tmp1);
 return mem;
    end fillmem;

    function initmem(width : integer; length : natural; filename : string)
       return memarray is
 variable mem : memarray;
    begin
     if (filename = "") then
     for i in length-1 downto 0 loop
      mem(i) := (others => '0');
     end loop;
     return mem;
 else
     return fillmem(width,length,filename);
 end if;
    end initmem;
begin

    assert (lpm_numwords = size)
    report "Lpm_widthad and lpm_numwords don't agree, lpm_widthad being used."
    severity note;

    process (inclock, address)
    begin
        -- Synchronous Address
        if (lpm_address_control = lpm_registered) then
            if (inclock'event AND inclock = '1') then
                atmp <= address;
            end if;
        else
        -- Asynchronous Address
            atmp <= address;
        end if;
    end process;

    -- Read the appropriate range of memory
    MEMORY:process (atmp)

        variable mem : memarray := initmem(lpm_width,size,lpm_file);
        variable index : natural;

        function to_integer (a : std_logic_vector) return natural is
            variable tmp : std_logic_vector(a'length-1 downto 0);
            variable result, abit: natural := 0;
        begin
            if (a'length < 1) then
                return 0;
                end if;
            tmp := a;
            for i in tmp'reverse_range loop
                abit := 0;
                if tmp(i) = '1' then
                    abit := 2**i;
                end if;
                result := result + abit;
                exit when i = 31;
            end loop;
            return result;
        end to_integer;

    begin
        index := to_integer(atmp);
        qtmp <= mem(index);
    end process;

    process (outreg_ar, outclock, qtmp)
    begin
        -- Synchronous Read of ROM
        if (lpm_outdata = lpm_registered) then
            if (outreg_ar = '1') then
                qx <= (others => '0');
            elsif (outclock'event AND outclock = '1') then
                qx <= qtmp;
            end if;
        else
        -- Asynchronous Read of ROM
            qx <= qtmp;
        end if;
    end process;

    -- Output the data when in read mode, otherwise HI-Z
    process (qx, memenab)
    begin
        if (memenab = '1') then
            q <= qx;

        else

            q <= (others => 'Z');

        end if;
    end process;
end archlpmstd;

--
-- CY_FIFO
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity cy_fifo is
    generic(lpm_width : positive := 1;
     lpm_numwords: positive := 1;
     lpm_pafe_length : natural := 0;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     enr : in std_logic;
     enw : in std_logic;
     readclock : in std_logic;
     writeclock : in std_logic;
     mrb : in std_logic;
     efb : out std_logic;
     hfb : out std_logic;
     pafeb : out std_logic);
end cy_fifo;

architecture archlpmstd of cy_fifo is

begin
    -- Keep track of the address.
    process (mrb, writeclock, readclock)
        variable wadd : natural := 0;
        variable radd : natural := 0;
        variable idx : natural := 0;
        variable full : std_logic := '1';
        variable pafl : std_logic := '1';
        variable paem : std_logic := '0';
        variable empt : std_logic := '0';
        type mema is array (lpm_numwords-1 downto 0)
                                of std_logic_vector(lpm_width-1 downto 0);
        variable mem : mema;
    begin
        if (mrb = '0') then
            idx := 0;
            wadd := 0;
            radd := 0;
            empt := '0';
            paem := '0';
            hfb <= '1';
            full := '1';
            pafl := '1';
            q <= (others => '0');
        else
            if (writeclock'event AND (writeclock = '1') AND (mrb /= '0')
                                                        AND (full /= '0')) then
                if ((idx < lpm_numwords) AND (enw = '1')) then
                    idx := idx+1;
                    mem(wadd) := data;
                    wadd := wadd + 1;
                    if (wadd >= lpm_numwords) then
                        wadd := 0;
                    end if;
                end if;
            end if;
            if (readclock'event AND (readclock = '1') AND (mrb /= '0')
                                                        AND (empt /= '0')) then
                if ((idx > 0) AND (enr = '1')) then
                    idx := idx-1;
                    q <= mem(radd);
                    radd := radd + 1;
                    if (radd >= lpm_numwords) then
                        radd := 0;
                    end if;
                end if;
            end if;
        end if;

        if (readclock'event AND (readclock = '1')) then
            if (idx <= 0) then
                empt := '0';
            else
                empt := '1';
            end if;
            if (idx >= lpm_numwords/2) then
                hfb <= '0';
            else
                hfb <= '1';
            end if;
            if (idx <= lpm_pafe_length) then
                paem := '0';
            else
                paem := '1';
            end if;
        end if;
        if (writeclock'event AND (writeclock = '1')) then
            if (idx >= lpm_numwords) then
                full := '0';
            else
                full := '1';
            end if;
            if (idx >= lpm_numwords/2) then
                hfb <= '0';
            else
                hfb <= '1';
            end if;
            if (lpm_numwords-idx <= lpm_pafe_length) then
                pafl := '0';
            else
                pafl := '1';
            end if;
        end if;

        efb <= full AND empt;
        pafeb <= full AND empt AND pafl AND paem;

    end process;

end archlpmstd;

--
-- CY_RAM_DP
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

library cypress;
use cypress.lpmpkg.all;
entity cy_ram_dp is
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_indata : regis_type := lpm_registered;
     lpm_address_control : regis_type := lpm_registered;
     lpm_outdata_a : regis_type := lpm_registered;
     lpm_outdata_b : regis_type := lpm_registered;
     lpm_file : string := "";
     lpm_hint : goal_type := speed);
    port (data_a : in std_logic_vector(lpm_width-1 downto 0);
     data_b : in std_logic_vector(lpm_width-1 downto 0);
     address_a : in std_logic_vector(lpm_widthad-1 downto 0);
     address_b : in std_logic_vector(lpm_widthad-1 downto 0);
     q_a : out std_logic_vector(lpm_width-1 downto 0);
     q_b : out std_logic_vector(lpm_width-1 downto 0);
     addr_matchb : out std_logic;
     wea : in std_logic;
     web : in std_logic;
     inclock_a : in std_logic := '0';
     inclock_b : in std_logic := '0';
     outclock_a : in std_logic := '0';
     outclock_b : in std_logic := '0';
     outrega_ar : in std_logic := '0';
     outregb_ar : in std_logic := '0');
end cy_ram_dp;

architecture archlpmstd of cy_ram_dp is

    constant size : integer := 2**lpm_widthad;
    signal atmp_a,atmp_b : std_logic_vector(lpm_widthad-1 downto 0);
    signal dtmp_a,dtmp_b : std_logic_vector(lpm_width-1 downto 0);
    signal qtmp_a,qtmp_b : std_logic_vector(lpm_width-1 downto 0);
    signal wtmp_a,wtmp_b : std_logic;
    signal busy : std_logic := '1';
    type memarray is array (size-1 downto 0)
                                    of std_logic_vector(lpm_width-1 downto 0);

    function hex2int (c : character) return integer is
    begin
        case c is
            when '0' => return 0;
            when '1' => return 1;
            when '2' => return 2;
            when '3' => return 3;
            when '4' => return 4;
            when '5' => return 5;
            when '6' => return 6;
            when '7' => return 7;
            when '8' => return 8;
            when '9' => return 9;
            when 'a' => return 10;
            when 'b' => return 11;
            when 'c' => return 12;
            when 'd' => return 13;
            when 'e' => return 14;
            when 'f' => return 15;
            when 'A' => return 10;
            when 'B' => return 11;
            when 'C' => return 12;
            when 'D' => return 13;
            when 'E' => return 14;
            when 'F' => return 15;
            when others => return -1;
        end case;
    end hex2int;

    function hex2vec (c : character) return std_logic_vector is
    begin
        case c is
            when '0' => return "0000";
            when '1' => return "0001";
            when '2' => return "0010";
            when '3' => return "0011";
            when '4' => return "0100";
            when '5' => return "0101";
            when '6' => return "0110";
            when '7' => return "0111";
            when '8' => return "1000";
            when '9' => return "1001";
            when 'a' => return "1010";
            when 'b' => return "1011";
            when 'c' => return "1100";
            when 'd' => return "1101";
            when 'e' => return "1110";
            when 'f' => return "1111";
            when 'A' => return "1010";
            when 'B' => return "1011";
            when 'C' => return "1100";
            when 'D' => return "1101";
            when 'E' => return "1110";
            when 'F' => return "1111";
            when others => assert (false)
       report "Illegal Intel Hex format in data field."
       severity error;
   return "0000";
        end case;
    end hex2vec;

    function "+" (a,b : std_logic_vector) return std_logic_vector is
 variable s : std_logic_vector (7 downto 0) := (others => '0');
 variable c : std_logic_vector (8 downto 0) := (others => '0');
 variable atmp : std_logic_vector (7 downto 0) := a;
 variable btmp : std_logic_vector (7 downto 0) := b;
    begin
     for i in 0 to 7 loop
     s(i) := atmp(i) XOR btmp(i) XOR c(i);
     c(i+1) := (atmp(i) AND btmp(i))
     OR (atmp(i) AND c(i))
     OR (btmp(i) AND c(i));
 end loop;
 return s;
    end "+";

    function fillmem(width : integer; length : natural; filename : string)
       return memarray is

     file instuff : text open read_mode is filename;

 constant onevect : std_logic_vector(7 downto 0) := "00000001";
 variable tmp0,tmp1 : line;
 variable char : character;
 variable start_code : character;
 variable byte_count : string (2 downto 1);
 variable address : string (4 downto 1);
 variable record_type : string (2 downto 1);
 variable data : string (2 downto 1);
 variable check_sum : string (2 downto 1);
 variable lsb,msb : integer;
 variable ab3,ab2,ab1,ab0: integer;
 variable count,addr : integer;
 variable offset : integer := 0;
 variable lsn, msn : std_logic_vector(3 downto 0);
 variable sum : std_logic_vector(7 downto 0);
 variable bytecount : integer := ((width-1)/8)+1;
 variable word : std_logic_vector((((width-1)/8)+1)*8-1 downto 0);
 variable mem : memarray;

    begin

 for i in length-1 downto 0 loop
     mem(i) := (others => '0');
 end loop;

     L1: while NOT (endfile(instuff)) loop
     readline (instuff,tmp0);
     sum := (others => '0');
     for i in 1 to tmp0'length loop
  read (tmp0,char);
  if ((char /= ' ') AND (char /= '_')) then
      write(tmp1,char);
  end if;
     end loop;

     read (tmp1, start_code);
     assert (start_code = ':')
  report "Illegal Intel Hex format."
  severity error;

     read (tmp1, byte_count);
     msb := hex2int(byte_count(2));
     lsb := hex2int(byte_count(1));
     msn := hex2vec(byte_count(2));
     lsn := hex2vec(byte_count(1));
     sum := sum + (msn & lsn);
     assert (lsb >= 0 AND msb >= 0)
  report "Illegal Intel Hex format in byte count field."
  severity error;
     count := 16*msb+lsb;

     read (tmp1, address);
     ab3 := hex2int(address(4));
     ab2 := hex2int(address(3));
     ab1 := hex2int(address(2));
     ab0 := hex2int(address(1));
     msn := hex2vec(address(4));
     lsn := hex2vec(address(3));
     sum := sum + (msn & lsn);
     msn := hex2vec(address(2));
     lsn := hex2vec(address(1));
     sum := sum + (msn & lsn);
     assert (ab3 >= 0 AND ab2 >= 0 AND ab1 >= 0 AND ab0 >= 0)
  report "Illegal Intel Hex format in address field."
  severity error;
     addr := 4096*ab3+256*ab2+16*ab1+ab0;

     read (tmp1, record_type);
     msn := hex2vec(record_type(2));
     lsn := hex2vec(record_type(1));
     sum := sum + (msn & lsn);
     assert (record_type="00" OR record_type="01" OR record_type="02")
  report "Illegal Intel Hex format in record type."
  severity error;
     if (record_type = "02") then
  offset := addr*16;
     end if;

     assert ((count REM bytecount) = 0)
  report "Illegal Intel Hex format in data field."
  severity error;
     for i in 0 to (count/bytecount)-1 loop
  for j in 1 to bytecount loop
      read (tmp1, data);
      msn := hex2vec(data(2));
      lsn := hex2vec(data(1));
      sum := sum + (msn & lsn);
      if (i+addr+offset < length) then
   word((bytecount-j+1)*8-1 downto ((bytecount-j+1)-1)*8)
          := msn & lsn;

   mem(i+addr+offset) := word(width-1 downto 0);
      end if;
  end loop;
     end loop;

     read (tmp1, check_sum);
     msn := hex2vec(check_sum(2));
     lsn := hex2vec(check_sum(1));
     sum := (NOT sum) + onevect;
     assert ((hex2vec(check_sum(2)) & hex2vec(check_sum(1))) = sum)
  report "Bad checksum."
  severity error;
     if (record_type = "01") then
  exit L1;
     end if;
 end loop;
 deallocate(tmp0);
 deallocate(tmp1);
 return mem;
    end fillmem;

    function initmem(width : integer; length : natural; filename : string)
       return memarray is
 variable mem : memarray;
    begin
     if (filename = "") then
     for i in length-1 downto 0 loop
      mem(i) := (others => '0');
     end loop;
     return mem;
 else
     return fillmem(width,length,filename);
 end if;
    end initmem;
begin

    assert (lpm_numwords = size)
    report "Lpm_widthad and lpm_numwords don't agree, lpm_widthad being used."
    severity note;

-- Port "A"
    process (inclock_a, address_a)
    begin
        -- Synchronous Address "A"
        if (lpm_address_control = lpm_registered) then
            if (inclock_a'event AND inclock_a = '1') then
                atmp_a <= address_a;
            end if;
        else
        -- Asynchronous Address "A"
            atmp_a <= address_a;
        end if;
    end process;

    process (inclock_a, data_a)
    begin
        -- Synchronous Data "A"
        if (lpm_indata = lpm_registered) then
            if (inclock_a'event AND inclock_a = '1') then
                dtmp_a <= data_a;
            end if;
        else
        -- Asynchronous Data "A"
            dtmp_a <= data_a;
        end if;
    end process;

    process (inclock_a, wea)
        variable wreg : std_logic;
    begin
        -- Synchronous Write "A"
        if (lpm_address_control = lpm_registered) then
            if (inclock_a'event AND inclock_a = '1') then
                wreg := wea;
            end if;
            wtmp_a <= wreg AND inclock_a;
        else
        -- Asynchronous Write "A"
            wtmp_a <= wea;
        end if;
    end process;

    process (outrega_ar, outclock_a, qtmp_a)
    begin
        -- Synchronous Read of RAM "A"
        if (lpm_outdata_a = lpm_registered) then
            if (outrega_ar = '1') then
                q_a <= (others => '0');
            elsif (outclock_a'event AND outclock_a = '1') then
                q_a <= qtmp_a;
            end if;
        else
        -- Asynchronous Read of RAM "A"
            q_a <= qtmp_a;
        end if;
    end process;

    -- Write and/or Read the appropriate range of memory
    process (dtmp_a, atmp_a, wtmp_a, dtmp_b, atmp_b, wtmp_b)

        variable mem : memarray := initmem(lpm_width,size,lpm_file);
        variable ia, ib : natural;

        function to_integer (a : std_logic_vector) return natural is
            variable tmp : std_logic_vector(a'length-1 downto 0);
            variable result, abit: natural := 0;
        begin
            if (a'length < 1) then
                return 0;
            end if;
            tmp := a;
            for i in tmp'reverse_range loop
                abit := 0;
                if tmp(i) = '1' then
                    abit := 2**i;
                end if;
                result := result + abit;
                exit when i = 31;
            end loop;
            return result;
        end to_integer;

    begin

        ia := to_integer(atmp_a);
        ib := to_integer(atmp_b);

        if (ia = ib) then
            busy <= '0';
            if (wtmp_a = '1') then -- Port A always has priority to write;
                mem(ia) := dtmp_a;
            elsif (wtmp_b = '1') then -- if Port A is not writing, then B can.
                mem(ib) := dtmp_b;
            end if;
        else
            busy <= '1';
            if (wtmp_a = '1') then
                mem(ia) := dtmp_a;
            end if;
            if (wtmp_b = '1') then
                mem(ib) := dtmp_b;
            end if;
        end if;

        qtmp_a <= mem(ia);
        qtmp_b <= mem(ib);

    end process;

    addr_matchb <= busy;

-- Port "B"

    process (inclock_b, address_b)
    begin
        -- Synchronous Address "B"
        if (lpm_address_control = lpm_registered) then
            if (inclock_b'event AND inclock_b = '1') then
                atmp_b <= address_b;
            end if;
        else
        -- Asynchronous Address "B"
            atmp_b <= address_b;
        end if;
    end process;

    process (inclock_b, data_b)
    begin
        -- Synchronous Data "B"
        if (lpm_indata = lpm_registered) then
            if (inclock_b'event AND inclock_b = '1') then
                dtmp_b <= data_b;
            end if;
        else
        -- Asynchronous Data "B"
            dtmp_b <= data_b;
        end if;
    end process;

    process (inclock_b, web)
        variable wreg : std_logic;
    begin
        -- Synchronous Write "B"
        if (lpm_address_control = lpm_registered) then
            if (inclock_b'event AND inclock_b = '1') then
                wreg := web;
            end if;
            wtmp_b <= wreg AND inclock_b;
        else
        -- Asynchronous Write "B"
            wtmp_b <= web;
        end if;
    end process;

    process (outregb_ar, outclock_b, qtmp_b)
    begin
        -- Synchronous Read of RAM "B"
        if (lpm_outdata_b = lpm_registered) then
            if (outregb_ar = '1') then
                q_b <= (others => '0');
            elsif (outclock_b'event AND outclock_b = '1') then
                q_b <= qtmp_b;
            end if;
        else
        -- Asynchronous Read of RAM "B"
            q_b <= qtmp_b;
        end if;
    end process;
end archlpmstd;

--
-- MINPAD
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity minpad is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (result : out std_logic_vector(lpm_width-1 downto 0);
     pad : in std_logic_vector(lpm_width-1 downto 0) := (others => '0'));
end minpad;

architecture archlpmstd of Minpad is
begin

    result <= pad;

end archlpmstd;

--
-- MOUTPAD
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity moutpad is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     pad : out std_logic_vector(lpm_width-1 downto 0));
end moutpad;

architecture archlpmstd of Moutpad is
begin

    pad <= data;

end archlpmstd;

--
-- MBIPAD
--

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.cy_bufoe;
use cypress.lpmpkg.all;
entity mbipad is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector (lpm_width-1 downto 0);
     enable : in std_logic;
     result : out std_logic_vector (lpm_width-1 downto 0);
     pad : inout std_logic_vector(lpm_width-1 downto 0));
end mbipad;

architecture archlpmstd of Mbipad is
begin

    L0: for i in data'range generate
        U0: cy_bufoe port map (data(i),enable,pad(i),result(i));
    end generate;

end archlpmstd;
