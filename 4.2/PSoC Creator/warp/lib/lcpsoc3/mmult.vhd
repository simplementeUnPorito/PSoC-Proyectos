--

--
-- Kludge to get around a Warp problem
-- Warp 'sometimes' does not like using functions to set constants.
-- See "constant mc" and "constant mp" in the cy_multiply architecture.
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;

entity cy_psoc3_multiply is
    generic (
        IsSigned : boolean := false;
        DataWidthA : positive := 1;
        DataWidthB : positive := 1;
        DataWidthP : positive := 1);
    port (
        Data_A : in std_logic_vector (DataWidthA - 1 downto 0);
        Data_B : in std_logic_vector (DataWidthB - 1 downto 0);
        Product : out std_logic_vector (DataWidthP - 1 downto 0));
end cy_psoc3_multiply;

architecture psoc3 of cy_psoc3_multiply is

    component cy_multiply
        generic (
            IsSigned : boolean := false;
            DataWidthA : positive := 1;
            DataWidthB : positive := 1;
            DataWidthP : positive := 1);
        port (
            Data_A : in std_logic_vector (DataWidthA - 1 downto 0);
            Data_B : in std_logic_vector (DataWidthB - 1 downto 0);
            Product : out std_logic_vector (DataWidthP - 1 downto 0));
    end component;

begin

    -- If input A is the larger, make the connections as is.
    agtb: if (DataWidthA >= DataWidthB) generate
        U0: cy_multiply
            generic map (
                IsSigned => IsSigned,
                DataWidthA => DataWidthA,
                DataWidthB => DataWidthB,
                DataWidthP => DataWidthP)
            port map (
                Data_A => Data_A,
                Data_B => Data_B,
                Product => Product);
    end generate;

    -- If input B is the larger, swap inputs A and B.
    bgta: if (DataWidthB > DataWidthA) generate
        U0: cy_multiply
            generic map (
                IsSigned => IsSigned,
                DataWidthA => DataWidthB,
                DataWidthB => DataWidthA,
                DataWidthP => DataWidthP)
            port map (
                Data_A => Data_B,
                Data_B => Data_A,
                Product => Product);
    end generate;

end architecture;

--
-- PSoC Mulitplier
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;

entity cy_multiply is
    generic (
        IsSigned : boolean := false;
        DataWidthA : positive := 1;
        DataWidthB : positive := 1;
        DataWidthP : positive := 1);
    port (
        Data_A : in std_logic_vector (DataWidthA - 1 downto 0);
        Data_B : in std_logic_vector (DataWidthB - 1 downto 0);
        Product : out std_logic_vector (DataWidthP - 1 downto 0));
end cy_multiply;

architecture psoc3 of cy_multiply is

    function GetMultiplicand (a, b : natural) return natural is
    begin
        if (a >= b) then
            return a;
        else
            return b;
        end if;
    end GetMultiplicand;

    function GetMultiplier (a, b : natural) return natural is
    begin
        if (b <= a) then
            return b;
        else
            return a;
        end if;
    end GetMultiplier;

-- constant mc : natural := GetMultiplicand (DataWidthA, DataWidthB);
-- constant mp : natural := GetMultiplier (DataWidthA, DataWidthB);
    constant mc : natural := DataWidthA;
    constant mp : natural := DataWidthB;
    constant dv2: natural := (mp / 2) + (mp mod 2);
    constant odd: natural := (mp mod 2);

    signal a : std_logic_vector (mc-1 downto 0) := (others => '0');
    signal b : std_logic_vector (mp-1 downto 0) := (others => '0');
    signal p0 : std_logic_vector (mc+3+odd downto 0) := (others => '0');
    signal p1 : std_logic_vector (mc+3+odd downto 0) := (others => '0');
    signal p2 : std_logic_vector (mc+3+odd downto 0) := (others => '0');
    signal p3 : std_logic_vector (mc+3+odd downto 0) := (others => '0');
    signal p4 : std_logic_vector (mc+7+odd downto 0) := (others => '0');
    signal p5 : std_logic_vector (mc+7+odd downto 0) := (others => '0');
    signal pina : std_logic_vector (product'range) := (others => '0');
    signal pinb : std_logic_vector (product'range) := (others => '0');

    -- Array of input vectors
    type ins_array is array ( mp-1 downto 0) of
            std_logic_vector (mc-1 downto 0);
    signal mlts : ins_array := (others => (others => '0'));

    -- Array of partial sums
    type add_array is array (dv2-1 downto 0) of
            std_logic_vector (mc+1+odd downto 0);
    signal adds : add_array := (others => (others => '0'));
    signal in_a : add_array := (others => (others => '0'));
    signal in_b : add_array := (others => (others => '0'));

begin

    -- Limit the maximum size of the multiplier to (16+n)X16.
    limit: if ((DataWidthA > 16) AND (DataWidthB > 16)) generate
        assert (false)
        report "Maximum multiplier size allowed is 16 by 16."
        severity failure;
    end generate;

    -- Make the multiplier (b) the smallest of the two vectors
    agtb: if (DataWidthA >= DataWidthB) generate
        a <= Data_A;
        b <= Data_B;
    end generate;
    bgta: if (DataWidthB > DataWidthA) generate
        a <= Data_B;
        b <= Data_A;
    end generate;

    -- If the multiplier std_logic (b(i)) is 0, set that adder input to 0, else to a
    fm: for i in mp-1 downto 0 generate
        mlts(i) <= a when b(i) = '1' else (others => '0');
    end generate;

    -- Generate the first level additions
    add0: for j in dv2-1 downto 0 generate
        go: if (((j+1)*2) > mp) generate -- Pass input if single input
            go: if (odd = 1) generate
                adds(j) <= ("000" & mlts(j*2));
            end generate;
            ge: if (odd = 0) generate
                adds(j) <= ("00" & mlts(j*2));
            end generate;
        end generate;
        ge: if (((j+1)*2) <= mp) generate -- Add them if two inputs
            go: if (odd = 1) generate
                in_a(j) <= "000" & mlts(j*2);
                in_b(j) <= "00" & mlts(j*2+1) & '0';
            end generate;
            ge: if (odd = 0) generate
                in_a(j) <= "00" & mlts(j*2);
                in_b(j) <= '0' & mlts(j*2+1) & '0';
            end generate;
            U0: madd_sub
                generic map (
                    lpm_width => mc+2+odd,
                    lpm_direction => lpm_add)
                port map (
                    dataA => in_a(j),
                    dataB => in_b(j),
                    cin => zero,
                    result => adds(j),
                    add_sub => one);
        end generate;
    end generate;

    -- Generate the second level additions
    gp0: if (mp >= 5) generate
        signal ina : std_logic_vector (p0'range) := (others => '0');
        signal inb : std_logic_vector (p0'range) := (others => '0');
    begin
        ina <= "00" & adds(0);
        inb <= adds(1) & "00";
        U0: madd_sub
            generic map (
                lpm_width => p0'length,
                lpm_direction => lpm_add)
            port map (
                dataA => ina,
                dataB => inb,
                cin => zero,
                result => p0,
                add_sub => one);
    end generate;
    gp1: if (mp >= 7) generate
        signal ina : std_logic_vector (p0'range) := (others => '0');
        signal inb : std_logic_vector (p0'range) := (others => '0');
    begin
        ina <= "00" & adds(2);
        inb <= adds(3) & "00";
        U0: madd_sub
            generic map (
                lpm_width => p1'length,
                lpm_direction => lpm_add)
            port map (
                dataA => ina,
                dataB => inb,
                cin => zero,
                result => p1,
                add_sub => one);
    end generate;
    gp2: if (mp >= 11) generate
        signal ina : std_logic_vector (p0'range) := (others => '0');
        signal inb : std_logic_vector (p0'range) := (others => '0');
    begin
        ina <= "00" & adds(4);
        inb <= adds(5) & "00";
        U0: madd_sub
            generic map (
                lpm_width => p2'length,
                lpm_direction => lpm_add)
            port map (
                dataA => ina,
                dataB => inb,
                cin => zero,
                result => p2,
                add_sub => one);
    end generate;
    gp3a: if (mp = 13) generate
        p3 <= ("00000" & mlts(12));
    end generate;
    gp3b: if (mp = 14) generate
        p3 <= ("00" & adds(6));
    end generate;
    gp3c: if (mp >= 15) generate
        signal ina : std_logic_vector (p0'range) := (others => '0');
        signal inb : std_logic_vector (p0'range) := (others => '0');
    begin
        ina <= "00" & adds(6);
        inb <= adds(7) & "00";
        U0: madd_sub
            generic map (
                lpm_width => p3'length,
                lpm_direction => lpm_add)
            port map (
                dataA => ina,
                dataB => inb,
                cin => zero,
                result => p3,
                add_sub => one);
    end generate;

    -- Generate the third level additions
    gp4: if (mp >= 9) generate
        signal lv2a : std_logic_vector (p4'range) := (others => '0');
        signal lv2b : std_logic_vector (p4'range) := (others => '0');
    begin
        lv2a <= "0000" & p0;
        lv2b <= p1 & "0000";
        U0: madd_sub
            generic map (
                lpm_width => p4'length,
                lpm_direction => lpm_add)
            port map (
                dataA => lv2a,
                dataB => lv2b,
                cin => zero,
                result => p4,
                add_sub => one);
    end generate;
    gp7: if (mp >= 13) generate
        signal lv2a : std_logic_vector (p5'range) := (others => '0');
        signal lv2b : std_logic_vector (p5'range) := (others => '0');
    begin
        lv2a <= "0000" & p2;
        lv2b <= p3 & "0000";
        U0: madd_sub
            generic map (
                lpm_width => p5'length,
                lpm_direction => lpm_add)
            port map (
                dataA => lv2a,
                dataB => lv2b,
                cin => zero,
                result => p5,
                add_sub => one);
    end generate;

    -- Special case the 1 and 2 std_logic multiplies
    add1: if (mp = 1) generate
        product <= mlts(0);
    end generate;
    add2: if (mp = 2) generate
        product <= adds(0);
    end generate;

        -- Generate the larger multiplier products
    add3: if (mp = 3) generate
        pina <= adds(0);
        pinb <= '0' & mlts(2) & "00";
    end generate;
    add4: if (mp = 4) generate
        pina <= "00" & adds(0);
        pinb <= adds(1) & "00";
    end generate;

    -- Anything beyond here requires a second level of logic
    add5: if (mp = 5) generate
        -- Warp workaround - it doesn't like adds(2)(mc downto 0);
        signal tmp : std_logic_vector (mc+1+odd downto 0) := (others => '0');
    begin
        pina <= p0;
        tmp <= adds(2);
        pinb <= tmp(mc downto 0) & "0000";
    end generate;
    add6: if (mp = 6) generate
        pina <= "00" & p0;
        pinb <= adds(2) & "0000";
    end generate;
    add7: if (mp = 7) generate
        pina <= "00" & p0;
        pinb <= p1(mc+2 downto 0) & "0000";
    end generate;
    add8: if (mp = 8) generate
        pina <= "0000" & p0;
        pinb <= p1 & "0000";
    end generate;

    -- Anything beyond here requires a third level of logic
    add9: if (mp = 9) generate
        -- Warp workaround - it doesn't like adds(4)(mc downto 0);
        signal tmp : std_logic_vector (mc+1+odd downto 0) := (others => '0');
    begin
        pina <= p4;
        tmp <= adds(4);
        pinb <= tmp(mc downto 0) & "00000000";
    end generate;
    add10: if (mp = 10) generate
        pina <= "00" & p4;
        pinb <= adds(4) & "00000000";
    end generate;
    add11: if (mp = 11) generate
        pina <= "00" & p4;
        pinb <= p2(mc+2 downto 0) & "00000000";
    end generate;
    add12: if (mp = 12) generate
        pina <= "0000" & p4;
        pinb <= p2 & "00000000";
    end generate;
    add13: if (mp = 13) generate
        pina <= "0000" & p4;
        pinb <= p5(p5'length-5 downto 0) & "00000000";
    end generate;
    add14: if (mp = 14) generate
        pina <= "000000" & p4;
        pinb <= p5(p5'length-3 downto 0) & "00000000";
    end generate;
    add15: if (mp = 15) generate
        pina <= "000000" & p4;
        pinb <= p5(p5'length-3 downto 0) & "00000000";
    end generate;
    add16: if (mp = 16) generate
        pina <= "00000000" & p4;
        pinb <= p5 & "00000000";
    end generate;

    -- Build the final adder
    final: if (mp > 2) generate
        U0: madd_sub
            generic map (
                lpm_width => product'length,
                lpm_direction => lpm_add)
            port map (
                dataA => pina,
                dataB => pinb,
                cin => zero,
                result => product,
                add_sub => one);
    end generate;

end architecture;

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

architecture psoc3 of mmult is

    component cy_psoc3_multiply
        generic (
            IsSigned : boolean := false;
            DataWidthA : positive;
            DataWidthB : positive;
            DataWidthP : positive);
        port (
            Data_A : in std_logic_vector (DataWidthA - 1 downto 0);
            Data_B : in std_logic_vector (DataWidthB - 1 downto 0);
            Product : out std_logic_vector (DataWidthP - 1 downto 0));
    end component;

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

    -- if both A and B are bigger than 2 Bits, call the amazing multiplier

    tc: if (lpm_widtha > 2 AND lpm_widthb > 2) generate
            i1: cy_psoc3_multiply generic map (
                            IsSigned => mtype,
                            DataWidthA => lpm_widtha,
                            DataWidthB => lpm_widthb,
                            DataWidthP => psize)
                     port map (
                            Data_A => dataA,
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
end psoc3;
