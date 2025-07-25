--

--
-- CCPARITY
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.rtlpkg.all;

entity ccparity is
    generic(width : positive := 1;
            pipeline: natural := 0);
    port (data : in std_logic_vector (width - 1 downto 0);
            even : out std_logic;
            odd : out std_logic;
            clock : in std_logic := zero;
            aclr : in std_logic := zero);
end ccparity;

architecture c39k of ccparity is
    signal o,e : std_logic_vector ( width-1 downto 0);
    signal x1tmp : std_logic;
    signal odtmpx : std_logic;
    signal evtmpx : std_logic;
    signal evtmp,odtmp : std_logic;
    signal tmpev,tmpod : std_logic_vector (pipeline-1 downto 0);
    attribute no_factor of all : signal is true;
begin
    -- Generate the carry chain
    -- First stage
    GCC: if (width >= 5) generate
        odtmpx <= data(width-1);
        evtmpx <= NOT data(width-1);
        MSBO: cy_c39kcarry port map (zero, odtmpx, odtmpx, o(width-1));
        MSBE: cy_c39kcarry port map (zero, evtmpx, evtmpx, e(width-1));
        -- MSB-2 through LSB+4
        G0: for i in width-2 downto 4 generate
            U1: cy_c39kcarry port map (o(i+1),data(i),data(i),o(i));
            U2: cy_c39kcarry port map (e(i+1),data(i),data(i),e(i));
        end generate;
    end generate;

    -- Generate PT XOR inputs
    XOR4: process (data)
        variable b : std_logic;
        variable w : natural;
    begin
        if (data'length > 3) then w := 3; else w := data'length-1; end if;
        b := data(0);
        for j in 1 to w loop
            b := b XOR data(j);
        end loop;
        o(w) <= b;
        e(w) <= b;
    end process;

    -- Combine with the CC XOR input
    GNF: if (width < 5) generate
        odtmp <= o(width-1);
        evtmp <= NOT e(width-1);
    end generate;
    GFL: if (width >= 5) generate
        U1: cy_c39kxor port map(o(4), o(3), odtmp);
        U2: cy_c39kxor port map(e(4), e(3), evtmp);
-- Un-comment if a single carry chain is used for odd and even.
-- U2: cy_c39kcarry port map(o(4),one,one,x1tmp);
-- U3: cy_c39kxor port map(x1tmp, o(3), evtmp);
    end generate;

    RN: IF (pipeline <= 0) generate
        even <= evtmp;
        odd <= odtmp;
    end generate;
    RA: IF (pipeline > 0) generate
        G0: for i in pipeline-1 downto 0 generate
            process (clock, aclr)
            begin
                if (aclr = '1') then
                    tmpev(i) <= '0';
                    tmpod(i) <= '0';

                elsif (rising_edge(clock)) then

                    if (i = 0) then
                        tmpev(0) <= evtmp;
                        tmpod(0) <= odtmp;
                    else
                        tmpev(i) <= tmpev(i-1);
                        tmpod(i) <= tmpod(i-1);
                    end if;
                end if;
            end process;
        end generate;
        even <= tmpev(tmpev'high);
        odd <= tmpod(tmpod'high);
    end generate;
end c39k;

--
-- MPARITY
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
use cypress.rtlpkg.all;
entity mparity is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (data : in std_logic_vector (lpm_width - 1 downto 0);
     even : out std_logic;
     odd : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end mparity;

architecture c39k of mparity is

    function gtz (val : natural) return natural is
    begin
        if (val >= 0 ) then return val; else return 0; end if;
    end gtz;

    constant slice : integer := 5;
    constant vectsize : integer := (lpm_width+(slice-1)) / slice;
    constant pl_adj : natural := gtz(lpm_pipeline-1);
    signal datab : std_logic_vector(lpm_width-1 downto 0);
    signal x1,x2,x3,x4 : std_logic_vector( vectsize-1 downto 0);
    attribute no_factor of all : signal is true;

    component ccparity
    generic(width : positive := 1;
            pipeline: natural := 0);
    port (data : in std_logic_vector (width - 1 downto 0);
            even : out std_logic;
            odd : out std_logic;
            clock : in std_logic := zero;
            aclr : in std_logic := zero);
    end component;

begin

    -- Buffer all the input data.
    G0: for i in 0 to lpm_width-1 generate
        U0: cy_buf port map (data(i), datab(i));
    end generate;

    SMALL: if (lpm_width <= 16) generate
        U0: ccparity generic map (width => lpm_width, pipeline => lpm_pipeline)
                        port map (data => datab,
                                  even => even,
                                  odd => odd,
                                  clock => clock,
                                  aclr => aclr);
    end generate;

    LARGE: if (lpm_width > 16) generate
        -- Build the 4-input XOR gates
        XORS: process (datab)
            variable a, b : std_logic;
        begin
            for i in 0 to vectsize-1 loop
                if (lpm_width = ((i*slice) + 1)) then
                    a := '0';
                    b := datab(i*slice);
                else
                    a := datab(i*slice);
                    b := '0';
                    for j in 1 to slice-1 loop
                        if (i*slice+j) < lpm_width then
                            b := b XOR datab(i*slice+j);
                        end if;
                    end loop;
                end if;
                x1(i) <= a;
                x2(i) <= b;
            end loop;
        end process;

        -- Add the 4-input XOR gate to the 5th one.
        G1: for i in 0 to vectsize-1 generate
            U1: cy_c39kxor port map(x1(i), x2(i), x3(i));
        end generate;
        -- Generate a stage of pipelining after the XOR gates?
        RN: IF (lpm_pipeline <= 0) generate
            x4 <= x3;
        end generate;
        RA: IF (lpm_pipeline > 0) generate
            process (clock, aclr)
            begin
                if (aclr = '1') then
                    x4 <= (others => '0');

                elsif (rising_edge(clock)) then

                    x4 <= x3;
                end if;
            end process;
        end generate;
        -- Pass it off to the carry chain parity generator.
        U0: ccparity generic map (width => vectsize, pipeline => pl_adj)
                        port map (data => x4,
                                  even => even,
                                  odd => odd,
                                  clock => clock,
                                  aclr => aclr);
    end generate;
end c39k;
