--

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
     direction : in std_logic := zero;
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

    G0: if (lpm_hint /= combinatorial) generate
        U0: mcompare generic map (lpm_widthdist,lpm_unsigned,lpm_hint)
                        port map (distance,widthv,open,open,open,open,def,open);
    end generate;

    GN: if (lpm_hint /= combinatorial) generate
        OK <= true when (def = '1') else false;
    end generate;
    GC: if (lpm_hint = combinatorial) generate

        OK <= (distance <= widthv);

    end generate;

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
