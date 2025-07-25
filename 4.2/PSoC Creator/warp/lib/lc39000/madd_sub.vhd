--

--
-- Full Adder
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;

entity FullAdd is
    port ( CurrA, CurrB, PrevA, PrevB, PrevCarry : in std_logic;
           Sum, NextCarry : out std_logic );
    attribute no_factor of FullAdd:entity is true;
end FullAdd;

architecture c39k of FullAdd is
    signal tmpCarry, Cpt0, Cpt1, PtIn : std_logic;
begin
    -- Generate the carry
    Cpt0 <= PrevA AND PrevB;
    Cpt1 <= NOT( PrevA OR PrevB );
    C: cy_c39kcarry port map (PrevCarry, Cpt0, Cpt1, tmpCarry);
    NextCarry <= tmpCarry;

    -- Generate the sum
    PtIn <= CurrA XOR CurrB;
    S: cy_c39kxor port map (tmpCarry, PtIn, Sum);
end c39k;

--
-- Full Subtractor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;

entity FullSub is
    port ( CurrA, CurrB, PrevA, PrevB, PrevCarry : in std_logic;
           Sum, NextCarry : out std_logic );
    attribute no_factor of FullSub:entity is true;
end FullSub;

architecture c39k of FullSub is
    signal tmpCarry, Cpt0, Cpt1, PtIn : std_logic;
begin
    -- Generate the borrow
    Cpt0 <= NOT PrevA AND PrevB;
    Cpt1 <= NOT(NOT PrevA OR PrevB);
    C: cy_c39kcarry port map (PrevCarry, Cpt0, Cpt1, tmpCarry);
    NextCarry <= tmpCarry;

    -- Generate the difference
    PtIn <= (CurrA XOR CurrB);
    S: cy_c39kxor port map (tmpCarry, PtIn, Sum);
end c39k;

--
-- Internal MADD_SUB
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.cy_buf;
use cypress.lpmpkg.all;
use cypress.cypress.all;

entity iadd_sub is
    generic(m_width : positive := 1;
            m_representation : repre_type := LPM_UNSIGNED;
            m_direction : arith_type := LPM_NO_TYP;
            m_hint : goal_type := SPEED);
    port (dataa : in std_logic_vector(m_width-1 downto 0);
            datab : in std_logic_vector(m_width-1 downto 0);
            cin : in std_logic := zero;
            add_sub : in std_logic := one;
            result : out std_logic_vector(m_width-1 downto 0);
            cout : out std_logic);
end iadd_sub;

architecture c39k of iadd_sub is

    component FullAdd
        port ( CurrA, CurrB, PrevA, PrevB, PrevCarry : in std_logic;
               Sum, NextCarry : out std_logic );
    end component;

    component FullSub
        port ( CurrA, CurrB, PrevA, PrevB, PrevCarry : in std_logic;
               Sum, NextCarry : out std_logic );
    end component;

    signal cAdd, cSub : std_logic_vector(result'length downto 0);
    signal rtmp, c : std_logic_vector(result'length downto 0);
    signal tmpAdd, tmpSub : std_logic_vector(result'length downto 0);
    signal bdataA, bdataB : std_logic_vector(m_width-1 downto 0);
    signal Zero : std_logic := '0';
    signal One : std_logic := '1';

begin

    UB: for i in m_width -1 downto 0 generate
        Ai: cy_buf port map(dataA(i),bdataA(i));
        Bi: cy_buf port map(dataB(i),bdataB(i));
    end generate;

    -- Generate this if it is an adder or both.
    GA: if(((m_direction=lpm_no_typ) AND (port_state(add_sub)=ps_tied_high))
        OR ((m_direction=lpm_no_typ) AND (port_state(add_sub)=ps_connected))
        OR (m_direction=lpm_add)) generate
        G0: if (m_width = 1) generate
            tmpAdd(0) <= (bdataA(0) XOR bdataB(0)) XOR cin;
              cAdd(1) <= (bdataA(0) AND bdataB(0)) OR
                         (bdataA(0) AND cin) OR
                         (bdataB(0) AND cin);
        end generate;
        G1: if (m_width > 1) generate
            Frst: FullAdd port map(bdataA(0),bdataB(0),
                                    cin,One,Zero,tmpAdd(0),cAdd(0));
            I: for i in 1 to m_width-1 generate
                A:FullAdd port map(bdataA(i),bdataB(i),bdataA(i-1),bdataB(i-1),
                                    cAdd(i-1),tmpAdd(i),cAdd(i));
            end generate;
            Last: FullAdd port map(Zero,Zero,
                                    bdataA(m_width-1),bdataB(m_width-1),
                                    cAdd(m_width-1),cAdd(m_width),open);
        end generate;
        G2: if (NOT((m_direction=lpm_no_typ) AND
            (port_state(add_sub)=ps_connected))) generate
            rtmp <= tmpAdd;
               c <= cAdd;
        end generate;
    end generate;

    -- Generate this if it is a subtractor or both.
    GS: if(((m_direction=lpm_no_typ) AND (port_state(add_sub)=ps_tied_low))
        OR ((m_direction=lpm_no_typ) AND (port_state(add_sub)=ps_connected))
        OR (m_direction=lpm_sub)) generate
        G0: if (m_width = 1) generate
            tmpSub(0) <= NOT (NOT bdataA(0) XOR bdataB(0)) XOR NOT cin;
              cSub(1) <= NOT((NOT bdataA(0) AND bdataB(0)) OR
                             (NOT bdataA(0) AND NOT cin) OR
                                 (bdataB(0) AND NOT cin));
        end generate;
        G1: if (m_width > 1) generate
            Frst: FullSub port map(bdataA(0),bdataB(0),
                                    cin,One,Zero,tmpSub(0),cSub(0));
            I: for i in 1 to m_width-1 generate
                A:FullSub port map(bdataA(i),bdataB(i),bdataA(i-1),bdataB(i-1),
                                    cSub(i-1),tmpSub(i),cSub(i));
            end generate;
            Last: FullSub port map( One,Zero,
                                    bdataA(m_width-1),bdataB(m_width-1),
                                    cSub(m_width-1),cSub(m_width),open);
        end generate;
        G2: if (NOT((m_direction=lpm_no_typ) AND
            (port_state(add_sub)=ps_connected))) generate
            rtmp <= tmpSub;
               c <= cSub;
        end generate;
    end generate;

    -- Generate this only if it is both.
    GB: if ((m_direction=lpm_no_typ) AND
            (port_state(add_sub)=ps_connected)) generate
        GMux: for i in rtmp'range generate
            rtmp(i) <= (add_sub AND tmpAdd(i))
                 OR (NOT add_sub AND tmpSub(i));
        end generate;
        c(result'length) <= (add_sub AND cAdd(result'length))
                     OR (NOT add_sub AND cSub(result'length));
    end generate;

    result <= rtmp(m_width-1 downto 0);
    cout <= c(result'length);
end c39k;

--
-- Module for an incrementor/decrementor
--

library ieee;
use ieee.std_logic_1164.all;

package incrpkg is
    component inc_dec
        generic(size : natural);
        port(switch : in std_logic := '1';
            data : in std_logic_vector((size-1) downto 0);
            cin0 : in std_logic;
            cin1 : in std_logic;
            cout : out std_logic;
            result : out std_logic_vector((size-1) downto 0));
    end component;
end package;

library ieee;
use ieee.std_logic_1164.all;

entity inc_dec is
    generic(size : natural);
    port(switch : in std_logic := '1';
        data : in std_logic_vector((size-1) downto 0);
        cin0 : in std_logic;
        cin1 : in std_logic;
        cout : out std_logic;
        result : out std_logic_vector((size-1) downto 0));
end inc_dec;

architecture archinc_dec of inc_dec is

    signal c : std_logic_vector(data'range);

begin

    result(0) <= NOT cin0 XOR data(0) when (switch='0') else cin0 XOR data(0);
         c(0) <= NOT cin0 when (switch='0') else cin0;

    GI: for i in 1 to data'high generate
        result(i) <= c(i) XOR data(i);
        c(i) <= NOT data(i-1) AND c(i-1)
            when (switch='0') else data(i-1) AND c(i-1);
    end generate;

    cout <= (NOT (NOT data(data'high) AND c(data'high)) AND cin1)
        when (switch='0') else (data(data'high) AND c(data'high)) OR cin1;

end archinc_dec;

--
-- Pipelined adder using incrementor/decrementor
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use work.incrpkg.all;
entity madd_sub is
    generic(lpm_width : positive := 1;
     lpm_representation : repre_type := LPM_UNSIGNED;
     lpm_direction : arith_type := LPM_NO_TYP;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (dataa : in std_logic_vector(lpm_width-1 downto 0);
     datab : in std_logic_vector(lpm_width-1 downto 0);
     cin : in std_logic := zero;
     add_sub : in std_logic := one;
     result : out std_logic_vector(lpm_width-1 downto 0);
     cout : out std_logic;
     overflow : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end madd_sub;

architecture archmadd_sub of madd_sub is

    function slicer (a, b : natural) return natural is
    begin
        assert (b >= 0) report "lpm_pipeline must be >= 0." severity failure;
        if (a REM (b + 1) = 0) then
            return a/(b+1);
        end if;
        return a/(b+1) + 1;
    end slicer;

    constant slice : natural := slicer(lpm_width,lpm_pipeline);
    constant lastslice : natural := lpm_width-(slice*lpm_pipeline);
    signal tmp_sum : std_logic_vector(slice-1 downto 0);

    type sum_array is array (natural range <>,natural range <>) of
                                            std_logic_vector(slice-1 downto 0);
    type car_array is array (natural range <>,natural range <>) of std_logic;

    signal ci : std_logic_vector (lpm_pipeline downto 0);
    signal s : sum_array (0 to lpm_pipeline+1, 0 to lpm_pipeline)
                        := (others => (others => (others => '0')));
    signal c : car_array (0 to lpm_pipeline+1, 0 to lpm_pipeline)
                        := (others => (others => '0'));
    signal atmp, btmp : std_logic_vector(slice*(lpm_pipeline+1) -1 downto 0);
    signal switch : std_logic;
    signal aov,bov,sov : std_logic;
    signal as_p : std_logic_vector(lpm_pipeline downto 1);
    signal aovp,bovp : std_logic_vector(lpm_pipeline downto 1);
    signal One : std_logic := '1';
    signal Zero : std_logic := '0';

    component iadd_sub
    generic(m_width : positive := 1;
            m_representation : repre_type := LPM_UNSIGNED;
            m_direction : arith_type := LPM_NO_TYP;
            m_hint : goal_type := SPEED);
    port (dataa : in std_logic_vector(m_width-1 downto 0);
            datab : in std_logic_vector(m_width-1 downto 0);
            cin : in std_logic := zero;
            add_sub : in std_logic := one;
            result : out std_logic_vector(m_width-1 downto 0);
            cout : out std_logic);
    end component;

begin
    -- Build the right thing: adder, subtractor, or add_sub
    GA: if (((port_state(add_sub) = ps_tied_high)
            AND (lpm_direction = lpm_no_typ))
             OR (lpm_direction = lpm_add)) generate
          switch <= '1';
    end generate;
    GS: if (((port_state(add_sub) = ps_tied_low)
            AND (lpm_direction = lpm_no_typ))
             OR (lpm_direction = lpm_sub)) generate
          switch <= '0';
    end generate;
    GB: if ((port_state(add_sub) = ps_connected)
            AND (lpm_direction = lpm_no_typ)) generate
          switch <= add_sub;
    end generate;

    -- Adjust the input vectors if necessary
    G_RESIZE : if (lastslice /= slice) generate
        atmp(atmp'high downto lpm_width) <= (others => '0');
        btmp(btmp'high downto lpm_width) <= (others => '0');
    end generate;
    atmp(dataa'range) <= dataa;
    btmp(datab'range) <= datab;

    ci(0) <= CIN;
    GCI: if (lpm_pipeline > 0) generate
        ci(lpm_pipeline downto 1) <= (others => NOT switch);
    end generate;

    GOF: if (lastslice > 0) generate
        G_ARITH : for j in 0 to lpm_pipeline generate
            -- Adders for all stages
            GA: iadd_sub
                generic map (m_width => slice,
                              m_representation => lpm_representation,
                              m_direction => lpm_direction,
                              m_hint => lpm_hint)
                    port map (dataA => atmp((j+1)*slice -1 downto j*slice),
                              dataB => btmp((j+1)*slice -1 downto j*slice),
                              cin => ci(j),
                              add_sub => switch,
                              result => s(0,j),
                              cout => c(0,j));
            -- Special handling for the first stage (no increment/decrement)
            GZ: if (j = 0) generate
                s(1,0) <= s(0,0);
                c(1,0) <= c(0,0);
            end generate;
            -- Non-special handling for the others
            GN: if (j /= 0) generate
                GI: inc_dec generic map (slice)
                    port map (switch => as_p(j),
                              data => s(j,j),
                              cin0 => c(j+1,j-1),
                              cin1 => c(j,j),
                              cout => c(j+1,j),
                              result => s(j+1,j));
            end generate;
            -- Collect the sum
            GS: if (j /= lpm_pipeline) generate
                result((j+1)*slice-1 downto j*slice) <= s(lpm_pipeline+1,j);
            end generate;
            -- Special handling for the last stage (trim "extra" bits)
            GL: if (j = lpm_pipeline) generate
                tmp_sum <= s(lpm_pipeline+1,j);
                result(lpm_width-1 downto j*slice)
                                            <= tmp_sum(lastslice-1 downto 0);
                G0: if (lastslice = slice) generate
                    cout <= c(lpm_pipeline+1,lpm_pipeline);
                end generate;
                G1: if ((lastslice /= slice) AND (lpm_pipeline /= 0)) generate
                    cout <= tmp_sum(lastslice) XOR NOT as_p(as_p'high);
                end generate;
                G2: if ((lastslice /= slice) AND (lpm_pipeline = 0)) generate
                    cout <= tmp_sum(lastslice) XOR NOT switch;
                end generate;
                G3: if (lpm_pipeline /= 0) generate
                    aov <= aovp(aovp'high);
                    bov <= bovp(bovp'high) XOR NOT as_p(as_p'high);
                end generate;
                G4: if (lpm_pipeline = 0) generate
                    aov <= dataa(dataa'high);
                    bov <= datab(datab'high) XOR NOT switch;
                end generate;
                sov <= tmp_sum(lastslice-1);
                overflow <= ( sov AND NOT aov AND NOT bov)
                         OR (NOT sov AND aov AND bov);
            end generate;
        end generate;
    end generate;

    -- ASSUME: lastslice has to be greater than 0.
    assert (lastslice > 0)
        report "Value for LPM_PIPELINE is impractical.  "
            & "Use a value of (LPM_WIDTH/16 - 1) to "
            & "(LPM_WIDTH/8 - 1) for best results."
        severity failure;

    -- Generate the pipeline for ADD_SUB and OVERFLOW
    G_AS_REG: for k in 1 to lpm_pipeline generate
        PIPE: process (clock, aclr)
        begin
            if (aclr = '1') then
                as_p(k) <= '0';
                aovp(k) <= '0';
                bovp(k) <= '0';
            elsif (clock'event AND clock = '1') then
                if (k = 1) then
                    as_p(k) <= switch;
                    aovp(k) <= dataa(dataa'high);
                    bovp(k) <= datab(datab'high);
                else
                    as_p(k) <= as_p(k-1);
                    aovp(k) <= aovp(k-1);
                    bovp(k) <= bovp(k-1);
                end if;
            end if;
        end process;
    end generate;

    -- Generate the pipeline registers
    G_REG: for k in 0 to lpm_pipeline generate
        G0: for l in 0 to lpm_pipeline generate
            G0: if (l /= k) generate
                PIPE: process (clock, aclr)
                begin
                    if (aclr = '1') then
                        s(l+1,k) <= (others => '0');
                        c(l+1,k) <= '0';
                    elsif (clock'event AND clock = '1') then
                        s(l+1,k) <= s(l,k);
                        c(l+1,k) <= c(l,k);
                    end if;
                end process;
            end generate;
        end generate;
    end generate;
end archmadd_sub;
