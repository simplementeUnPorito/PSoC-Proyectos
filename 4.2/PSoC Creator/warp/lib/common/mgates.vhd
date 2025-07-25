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
     enable : in std_logic := one;
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
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     clock : in std_logic;
     enable : in std_logic := one;
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
     data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     enabletr : in std_logic := zero;
     enabledt : in std_logic := zero;
     result : out std_logic_vector(lpm_width-1 downto 0));
end mbustri;

architecture archlpmstd of Mbustri is

    signal yfb : std_logic_vector (result'range);

begin

    G0: for i in result'range generate

        D0: if (result(i)'port_state_att /= ps_open) generate
            D00: if (port_state(enabletr) = ps_tied_high) generate
                result(i) <= '1' when (yfb(i) = '1') else '0';
            end generate;
            D01: if (port_state(enabletr) /= ps_tied_high) generate

                U0: cy_triout port map (yfb(i),enabletr,result(i));

            end generate;
        end generate;

        D1: if ((tridata(i)'port_state_att /= ps_open) OR
                (result(i)'port_state_att /= ps_open)) generate
            D10: if (port_state(enabledt) = ps_tied_high) generate
                tridata(i) <= '1' when (data(i) = '1') else '0';
                yfb(i) <= data(i);
            end generate;
            D11: if (port_state(enabledt) /= ps_tied_high) generate

                U1: cy_bufoe port map (data(i),enabledt,tridata(i),yfb(i));

            end generate;
        end generate;

    end generate;

end archlpmstd;
