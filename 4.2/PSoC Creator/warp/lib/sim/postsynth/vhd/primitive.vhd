





library ieee;
use ieee.std_logic_1164.all;

package primitive is

    type reg_def is (reg, comb, dblreg);
    type polarity is (invt, ninv);
    type fb_type is (xpin, xreg, xadj, adj);
    type oreg_type is (dreg, treg, oltch, cmb);
    type ireg_type is (comb, ireg, dblireg, iltch);
    type src_type is (src_ptm, src_adj);
    type clk_type is (nopt, ckpt);
    type slw_type is (fast, slow);
    type pwr_type is (hipw, lopw);
    type clmem is array (1023 downto 0) of std_logic_vector(7 downto 0);
    type chmem is array ( 511 downto 0) of std_logic_vector(7 downto 0);

    function time_to_real (a : time) return real;
    function to_integer (a: std_logic_vector) return natural;
    function to_integer (a: Bit_Vector) return natural;
    function timeAdjust (time_constraint: time) return time;
    -- Global clock block
    component c39kck
 generic (
     cfgbits : Bit_Vector(63 downto 0) := (others => '0');
     xplPulseWthLo : time := 100 ps;
     xplPulseWthHi : time := 100 ps;
     xplMinInputDuty : positive := 30;
     xplMaxInputDuty : positive := 70;
     xplJitterUncertainty : time := 100 ps;
     xplZeroFBUncertainty : time := 100 ps;
     xplTreeFBUncertainty : time := 100 ps;
     xplMinPinClkPeriod : time := 100 ns;
     xplMaxPinClkPeriod : time := 1000 ns;
     xplLocktime : time := 100 ns;
     xplClockTreeOffset : time := 100 ps;
     xckPin2GClkDirect : time := 100 ps;
     xplSpreadFreqPercent : real := 0.0;
     xplSpreadFreqKHz : real := 0.0);
 port (
     clk : in std_logic_vector(3 downto 0);
     nios : in std_logic;
     lock : out std_logic;
     glclk : out std_logic_vector(3 downto 0));
    end component;

    -- Channel memory FIFO
    component c39kcf
 generic (
     cfgbits : Bit_Vector(45 downto 0) := (others => '0');
     memdata : chmem := (others => "00000000");
     xcmfClockWthCy : time := 100 ps;
     xcmfClockWthHi : time := 100 ps;
     xcmfClockWthLo : time := 100 ps;
     xcmfDinAtClkWrSetup : time := 100 ps;
     xcmfDinAtClkWrHold : time := 100 ps;
     xcmfEnxAtClockSetup : time := 100 ps;
     xcmfEnxAtClockHold : time := 100 ps;
     xcmfEfbinAtClkRdSetup : time := 100 ps;
     xcmfEfbinAtClkRdHold : time := 100 ps;
     xcmfHfbinAtClkRdSetup : time := 100 ps;
     xcmfHfbinAtClkRdHold : time := 100 ps;
     xcmfEfbinAtClkWrSetup : time := 100 ps;
     xcmfEfbinAtClkWrHold : time := 100 ps;
     xcmfHfbinAtClkWrSetup : time := 100 ps;
     xcmfHfbinAtClkWrHold : time := 100 ps;
     xcmfMrbWthLo : time := 100 ps;
     xcmfMrbRcr : time := 100 ps;
     xcmfRdWrSkewEfb : time := 100 ps;
     xcmfRdWrSkewHfb : time := 100 ps;
     xcmfRdWrSkewPafeb : time := 100 ps;
     xcmfDoutRegReWthHi : time := 100 ps;
     xcmfDoutRegReRcr : time := 100 ps;
     xcmfClkWr2Flagout : time := 100 ps;
     xcmfClkRd2Flagout : time := 100 ps;
     xcmfMrb2output : time := 100 ps;
     xcmfClock2Dout : time := 100 ps;
     xcmfReset2Dout : time := 100 ps);
 port (
     din : in std_logic_vector(7 downto 0);
     dout : inout std_logic_vector(7 downto 0);
     enr : in std_logic;
     enw : in std_logic;
     ckr : in std_logic;
     ckw : in std_logic;
     mrb : in std_logic := '1';
     efb : inout std_logic;
     hfb : inout std_logic;
     pafeb : out std_logic);
    end component;

    -- Channel memory RAM
    component c39kcm
 generic (
     cfgbits : Bit_Vector(45 downto 0) := (others => '0');
     memdata : chmem := (others => "00000000");
     xcmReadAddrWthHi : time := 100 ps;
     xcmWritAddrWthHi : time := 100 ps;
     xcmWriEnaWthHi : time := 100 ps;
     xcmAddrAtWriEnaFallSetup : time := 100 ps;
     xcmAddrAtWriEnaRiseSetup : time := 100 ps;
     xcmAddrAtWriEnaFallHold : time := 100 ps;
     xcmDinAtWriEnaFallSetup : time := 100 ps;
     xcmDinAtWriEnaFallHold : time := 100 ps;
     xcmAddr2DoutRegD : time := 100 ps;
     xcmWriEna2DoutRegD : time := 100 ps;
     xcmDin2DoutRegD : time := 100 ps;
     xcmDoutRegD2Dout : time := 100 ps;
     xcmClkinWthCy : time := 100 ps;
     xcmClkinWthHi : time := 100 ps;
     xcmClkinWthLo : time := 100 ps;
     xcmAddrAtClkinSetup : time := 100 ps;
     xcmAddrAtClkinHold : time := 100 ps;
     xcmWriEnaAtClkinSetup : time := 100 ps;
     xcmWriEnaAtClkinHold : time := 100 ps;
     xcmDinAtClkinSetup : time := 100 ps;
     xcmDinAtClkinHold : time := 100 ps;
     xcmClkin2DoutRegD : time := 100 ps;
     xcmDoutRegCkWthCy : time := 100 ps;
     xcmDoutRegCkWthHi : time := 100 ps;
     xcmDoutRegCkWthLo : time := 100 ps;
     xcmDoutRegSetup : time := 100 ps;
     xcmDoutRegHold : time := 100 ps;
     xcmDoutRegReWthHi : time := 100 ps;
     xcmDoutRegReRcr : time := 100 ps;
     xcmReset2Dout : time := 100 ps;
     xcmClkout2Dout : time := 100 ps;
     xcmAddrTransDetect : time := 800 ps);
 port (
     din_a : in std_logic_vector( 7 downto 0);
     din_b : in std_logic_vector( 7 downto 0);
     addr_a : in std_logic_vector(11 downto 0);
     addr_b : in std_logic_vector(11 downto 0);
     we_a : in std_logic;
     we_b : in std_logic;
     iclk_a : in std_logic := '0';
     iclk_b : in std_logic := '0';
     oclk_a : in std_logic := '0';
     oclk_b : in std_logic := '0';
     reset_a : in std_logic := '0';
     reset_b : in std_logic := '0';
     addr_matchb : out std_logic;
     dout_a : out std_logic_vector( 7 downto 0);
     dout_b : out std_logic_vector( 7 downto 0));
    end component;

    -- Cluster memory RAM
    component c39kcr
 generic (
     cfgbits : Bit_Vector(13 downto 0) := (others => '0');
     memdata : clmem := (others => "00000000");
     xcrReadAddrWthHi : time := 100 ps;
     xcrWritAddrWthHi : time := 100 ps;
     xcrWriEnaWthHi : time := 100 ps;
     xcrAddrAtWriEnaFallSetup : time := 100 ps;
     xcrAddrAtWriEnaRiseSetup : time := 100 ps;
     xcrAddrAtWriEnaFallHold : time := 100 ps;
     xcrDinAtWriEnaFallSetup : time := 100 ps;
     xcrDinAtWriEnaFallHold : time := 100 ps;
     xcrAddr2DoutRegD : time := 100 ps;
     xcrWriEna2DoutRegD : time := 100 ps;
     xcrDin2DoutRegD : time := 100 ps;
     xcrDoutRegD2Dout : time := 100 ps;
     xcrClkinWthCy : time := 100 ps;
     xcrClkinWthHi : time := 100 ps;
     xcrClkinWthLo : time := 100 ps;
     xcrAddrAtClkinSetup : time := 100 ps;
     xcrAddrAtClkinHold : time := 100 ps;
     xcrWriEnaAtClkinSetup : time := 100 ps;
     xcrWriEnaAtClkinHold : time := 100 ps;
     xcrDinAtClkinSetup : time := 100 ps;
     xcrDinAtClkinHold : time := 100 ps;
     xcrClkin2DoutRegD : time := 100 ps;
     xcrDoutRegCkWthHi : time := 100 ps;
     xcrDoutRegCkWthLo : time := 100 ps;
     xcrDoutRegCkWthCy : time := 100 ps;
     xcrDoutRegSetup : time := 100 ps;
     xcrDoutRegHold : time := 100 ps;
     xcrDoutRegReRcr : time := 100 ps;
     xcrDoutRegReWthHi : time := 100 ps;
     xcrClkout2Dout : time := 100 ps;
     xcrReset2Dout : time := 100 ps;
     xcrAddrTransDetect : time := 800 ps);
 port (
     din : in std_logic_vector( 7 downto 0);
     addr : in std_logic_vector(12 downto 0);
     we : in std_logic;
     iclk : in std_logic := '0';
     oclk : in std_logic := '0';
     reset : in std_logic := '0';
     dout : out std_logic_vector( 7 downto 0));
    end component;

    -- Macro-cell Block
    component c39kmc
 generic (
     cfgbits : Bit_Vector(11 downto 0) := (others => '0');
     xlbRegSetup : time := 100 ps;
     xlbRegHold : time := 100 ps;
     xlbRegCkWthHi : time := 100 ps;
     xlbRegCkWthLo : time := 100 ps;
     xlbRegCkWthCy : time := 100 ps;
     xlbRegPrRcr : time := 100 ps;
     xlbRegPrWthHi : time := 100 ps;
     xlbRegReRcr : time := 100 ps;
     xlbRegReWthHi : time := 100 ps;
     xlbSelin2Selout : time := 100 ps;
     xlbCpt2Selout : time := 100 ps;
     xlbCpt2RegD : time := 100 ps;
     xlbEqn2RegD : time := 100 ps;
     xlbSelin2RegD : time := 100 ps;
     xlbRegQ2RegD : time := 100 ps;
     xlbRegD2ToPIM : time := 100 ps;
     xlbRegCk2ToPIM : time := 100 ps;
     xlbRegPr2ToPIM : time := 100 ps;
     xlbRegRe2ToPIM : time := 100 ps);
 port (
     selin : in std_logic;
     cpt : in std_logic_vector(1 downto 0);
     set : in std_logic;
     clr : in std_logic;
     clk : in std_logic;
     din : in std_logic;
     selout : out std_logic;
     qout : out std_logic);
    end component;

    -- I/O Block
    component c39kio
 generic (
     cfgbits : Bit_Vector(35 downto 0) := (others => '0');
     xioClockWthHi : time := 100 ps;
     xioClockWthLo : time := 100 ps;
     xioClockWthCy : time := 100 ps;
     xioResetRcr : time := 100 ps;
     xioResetWthHi : time := 100 ps;
     xioIoRegSetup : time := 100 ps;
     xioIoRegHold : time := 100 ps;
     xioIoRegEnSup : time := 100 ps;
     xioIoRegEnHld : time := 100 ps;
     xioOeRegSetup : time := 100 ps;
     xioOeRegHold : time := 100 ps;
     xioFromChip2Pin : time := 100 ps;
     xioFromChip2IoRegD : time := 100 ps;
     xioIoRegCk2Pin : time := 100 ps;
     xioIoRegRe2Pin : time := 100 ps;
     xioIoRegRe2ToChip : time := 100 ps;
     xioOeRegCk2PinEA : time := 100 ps;
     xioOeRegCk2PinER : time := 100 ps;
     xioOeRegRe2PinER : time := 100 ps;
     xiooutEna2PinEA : time := 100 ps;
     xiooutEna2PinER : time := 100 ps;
     xioPin2IoRegD : time := 100 ps;
     xioIoRegCk2ToChip : time := 100 ps;
     xioPin2ToChip : time := 100 ps;
     xioAddOslow : time := 100 ps;
     xioAddEAslow : time := 100 ps;
     xioAddERslow : time := 100 ps;
     xioAdd : time := 100 ps);
 port (
     oe : in std_logic;
     din : in std_logic;
     en : in std_logic;
     clk : in std_logic;
     clr : in std_logic;
     fb : out std_logic;
     iop : inout std_logic);
    end component;
end primitive;

package body primitive is

    function to_integer (a : std_logic_vector) return natural is
 variable tmp : std_logic_vector(a'length-1 downto 0);
 variable result : natural := 0;
    begin
 if (a'length < 1) then
     return 0;
 end if;
 tmp := a;
 for i in tmp'reverse_range loop
     if tmp(i) = '1' then
  result := result + 2**i;
     end if;
 end loop;
 return result;
    end to_integer;

    function to_integer (a : Bit_Vector) return natural is
 variable tmp : Bit_Vector(a'length-1 downto 0);
 variable result : natural := 0;
    begin
 if (a'length < 1) then
     return 0;
 end if;
 tmp := a;
 for i in tmp'reverse_range loop
     if tmp(i) = '1' then
  result := result + 2**i;
     end if;
 end loop;
 return result;
    end to_integer;

    function timeAdjust (time_constraint: time) return time is
    begin
     if (time_constraint < 0 ns) then
     return -(time_constraint);
 else
     return 0 ns;
 end if;
    end timeAdjust;

    -- This is necessary to avoid loss of precision when
    -- convering time to a real number.
    function time_to_real (a : time) return real is

       variable result : real;
       variable x : time;
       variable os_count: integer;
       variable us_count: integer;
       variable ns_count: integer;
       variable ps_count: integer;
       variable fs_count: integer;

    begin

       x := a;
       os_count := x / 1 sec;
       x := x - os_count * 1 sec;
       us_count := x / 1 us;
       x := x - us_count * 1 us;
       ns_count := x / 1 ns;
       x := x - ns_count * 1 ns;
       x := x * 1e3;
       ps_count := x / 1 ns;
       x := x - ps_count * 1 ns;
       x := x * 1e3;
       fs_count := x / 1 ns;
       x := x - fs_count * 1 ns;

       result := 0.0;
       result := result + real(fs_count) * 1.0e-15;
       result := result + real(ps_count) * 1.0e-12;
       result := result + real(ns_count) * 1.0e-9;
       result := result + real(us_count) * 1.0e-6;
       result := result + real(os_count);
       return result;
    end time_to_real;

end primitive;

    -- Primitive Entity/Architecture pairs.

library ieee;
use ieee.std_logic_1164.all;


use work.primitive.all;

entity c39kcf is
    generic (
 cfgbits : Bit_Vector(45 downto 0);
 memdata : chmem;
 xcmfClockWthCy : time; -- checked parameters
 xcmfClockWthHi : time;
 xcmfClockWthLo : time;
 xcmfDinAtClkWrSetup : time;
 xcmfDinAtClkWrHold : time;
 xcmfEnxAtClockSetup : time;
 xcmfEnxAtClockHold : time;
 xcmfEfbInAtClkRdSetup : time;
 xcmfEfbInAtClkRdHold : time;
 xcmfHfbInAtClkRdSetup : time;
 xcmfHfbInAtClkRdHold : time;
 xcmfEfbInAtClkWrSetup : time;
 xcmfEfbInAtClkWrHold : time;
 xcmfHfbInAtClkWrSetup : time;
 xcmfHfbInAtClkWrHold : time;
 xcmfMrbWthLo : time;
 xcmfMrbRcr : time;
 xcmfRdWrSkewEfb : time;
 xcmfRdWrSkewHfb : time;
 xcmfRdWrSkewPafeb : time;
 xcmfDoutRegReWthHi : time;
 xcmfDoutRegReRcr : time;

 xcmfClkWr2FlagOut : time; -- applied parameters
 xcmfClkRd2FlagOut : time;
 xcmfMrb2Output : time;
 xcmfClock2Dout : time;
 xcmfReset2Dout : time);
    port (
 din : in std_logic_vector(7 downto 0);
 dout : inout std_logic_vector(7 downto 0);
 enr : in std_logic;
 enw : in std_logic;
 ckr : in std_logic;
 ckw : in std_logic;
 mrb : in std_logic := '1';
 efb : inout std_logic;
 hfb : inout std_logic;
 pafeb : out std_logic);
end c39kcf;

architecture sim of c39kcf is

    signal full : std_logic := '1';
    signal empt : std_logic := '0';
    signal half : std_logic := '0';
    signal pafl : std_logic := '1';
    signal paem : std_logic := '0';

    -- Signals for use with negative setup and hold checks
    signal d_din : std_logic_vector(7 downto 0);
    signal d_dckw : std_logic;
    signal d_enr : std_logic;
    signal e_dckr : std_logic;
    signal d_enw : std_logic;
    signal e_dckw : std_logic;
    signal r_efb : std_logic;
    signal f_dckr : std_logic;
    signal r_hfb : std_logic;
    signal h_dckr : std_logic;
    signal w_efb : std_logic;
    signal f_dckw : std_logic;
    signal w_hfb : std_logic;
    signal h_dckw : std_logic;

    -- Constants for use with negative setup and hold checks
    constant DataSetup : time := timeAdjust(xcmfDinAtClkWrSetup);
    constant DataHold : time := timeAdjust(xcmfDinAtClkWrHold);
    constant EnSetup : time := timeAdjust(xcmfEnxAtClockSetup);
    constant EnHold : time := timeAdjust(xcmfEnxAtClockHold);
    constant fflgSetupR : time := timeAdjust(xcmfEfbInAtClkRdSetup);
    constant hflgSetupR : time := timeAdjust(xcmfHfbInAtClkRdSetup);
    constant fflgHoldR : time := timeAdjust(xcmfEfbInAtClkRdHold);
    constant hflgHoldR : time := timeAdjust(xcmfHfbInAtClkRdHold);
    constant fflgSetupW : time := timeAdjust(xcmfEfbInAtClkWrSetup);
    constant hflgSetupW : time := timeAdjust(xcmfHfbInAtClkWrSetup);
    constant fflgHoldW : time := timeAdjust(xcmfEfbInAtClkWrHold);
    constant hflgHoldW : time := timeAdjust(xcmfHfbInAtClkWrHold);

    constant unk : string := " Setting output unknown.";

    signal ckrerr : std_logic;
    constant read_high : string :=
    "Read clock high width violation:" & unk;
    constant read_low : string :=
    "Read clock low width violation:" & unk;
    constant read_cycle : string :=
    "Read clock cycle width violation:" & unk;

    signal ckwerr : std_logic;
    constant write_high : string :=
    "Write clock high width violation:" & unk;
    constant write_low : string :=
    "Write clock low width violation:" & unk;
    constant write_cycle : string :=
    "Write clock cycle width violation:"& unk;

    signal wdserr : std_logic;
    constant writedata_setup : string :=
    "Write data setup violation:" & unk;

    signal wdherr : std_logic;
    constant writedata_hold : string :=
    "Write data hold violation:" & unk;

    signal enrserr : std_logic;
    constant readen_setup : string :=
    "Read enable setup violation:" & unk;

    signal enrherr : std_logic;
    constant readen_hold : string :=
    "Read enable hold violation:" & unk;

    signal enwserr : std_logic;
    constant writeen_setup : string :=
    "Write enable setup violation:" & unk;

    signal enwherr : std_logic;
    constant writeen_hold : string :=
    "Write enable hold violation:" & unk;

    signal rrcverr : std_logic;
    constant readreset_rcvry : string :=
    "Read reset recovery violation:" & unk;

    signal wrcverr : std_logic;
    constant writereset_rcvry : string :=
    "Write reset recovery violation:" & unk;

    signal mrberr : std_logic;
    constant reset_width : string :=
    "Reset width violation:" & unk;

    constant write2read_skew1 : string :=
    "Write to read skew insufficient for current cycle empty/full update.";
    constant write2read_skew2 : string :=
    "Write to read skew insufficient for current cycle almost empty update.";
    constant read2write_skew2 : string :=
    "Read to write skew insufficient for current cycle half full update.";
    constant read2write_skew3 : string :=
    "Read to write skew insufficient for current cycle almost full update.";

    signal refserr : std_logic;
    constant refflag_setup : string :=
    "Read clock to E/F flag setup violation.";

    signal refherr : std_logic;
    constant refflag_hold : string :=
    "E/F flag to read clock hold violation.";

    signal rhfserr : std_logic;
    constant rhfflag_setup : string :=
    "Read clock to H/F flag setup violation.";

    signal rhfherr : std_logic;
    constant rhfflag_hold : string :=
    "H/F flag to read clock hold violation.";

    signal wefserr : std_logic;
    constant wefflag_setup : string :=
    "Write clock to E/F flag setup violation.";

    signal wefherr : std_logic;
    constant wefflag_hold : string :=
    "E/F flag to write clock hold violation.";

    signal whfserr : std_logic;
    constant whfflag_setup : string :=
    "Write clock to H/F flag setup violation.";

    signal whfherr : std_logic;
    constant whfflag_hold : string :=
    "H/F flag to write clock hold violation.";

begin

    -- check read clock cycle, high and low times.
    process (ckr)
        variable clkhi, clklo : time := 0 ns;
    begin
 if (ckr = '0') then
     if ((clkhi /= 0 ns) AND ((NOW-clkhi) < xcmfClockWthHi)) then
  assert (false)
      report read_high
      severity warning;
  ckrerr <= '1';
  ckrerr <= transport '0' AFTER 1 ns;
     end if;
     clklo := NOW;
 elsif (ckr = '1') then
     if ((clklo /= 0 ns) AND ((NOW-clklo) < xcmfClockWthLo)) then
        assert (false)
      report read_low
      severity warning;
  ckrerr <= '1';
  ckrerr <= transport '0' AFTER 1 ns;
     end if;
     if ((clkhi /= 0 ns) AND ((NOW-clkhi) < xcmfClockWthCy)) then
  assert (false)
      report read_cycle
      severity warning;
  ckrerr <= '1';
  ckrerr <= transport '0' AFTER 1 ns;
     end if;
     clkhi := NOW;
 end if;
    end process;

    -- check write clock cycle, high and low times.
    process (ckw)
        variable clkhi, clklo : time := 0 ns;
    begin
 if (ckw = '0') then
     if ((clkhi /= 0 ns) AND ((NOW-clkhi) < xcmfClockWthHi)) then
  assert (false)
      report write_high
      severity warning;
  ckwerr <= '1';
  ckwerr <= transport '0' AFTER 1 ns;
     end if;
     clklo := NOW;
 elsif (ckw = '1') then
     if ((clklo /= 0 ns) AND ((NOW-clklo) < xcmfClockWthLo)) then
        assert (false)
      report write_low
      severity warning;
  ckwerr <= '1';
  ckwerr <= transport '0' AFTER 1 ns;
     end if;
     if ((clkhi /= 0 ns) AND ((NOW-clkhi) < xcmfClockWthCy)) then
  assert (false)
      report write_cycle
      severity warning;
  ckwerr <= '1';
  ckwerr <= transport '0' AFTER 1 ns;
     end if;
     clkhi := NOW;
 end if;
    end process;

    -- check write data setup
    d_dckw <= ckw after DataSetup;
    process (din, d_dckw)
     variable din_ev : time := 0 ns;
    begin
 if (rising_edge(d_dckw)) then
     if ((din_ev /= 0 ns) AND
      ((NOW-din_ev) < xcmfDinAtClkWrSetup + DataSetup)) then
  assert (false)
      report writedata_setup
      severity warning;
  wdserr <= '1';
  wdserr <= transport '0' AFTER 1 ns;
     end if;
 elsif (din'event) then
     din_ev := NOW;
 end if;
    end process;

    -- check write data hold
    d_din <= din after DataHold;
    process (d_din, ckw)
     variable clk_ev : time := 0 ns;
    begin
 if (rising_edge(ckw)) then
     clk_ev := NOW;
 elsif (d_din'event) then
     if ((clk_ev /= 0 ns) AND
      ((NOW-clk_ev) < xcmfDinAtClkWrHold + DataHold)) then
  assert (false)
      report writedata_hold
      severity warning;
  wdherr <= '1';
  wdherr <= transport '0' AFTER 1 ns;
     end if;
 end if;
    end process;

    -- check read enable setup
    e_dckr <= ckr after EnSetup;
    process (enr, e_dckr)
     variable enr_ev : time := 0 ns;
    begin
 if (rising_edge(e_dckr)) then
     if ((enr_ev /= 0 ns) AND
      ((NOW-enr_ev) < xcmfEnxAtClockSetup + EnSetup)) then
  assert (false)
      report readen_setup
      severity warning;
  enrserr <= '1';
  enrserr <= transport '0' AFTER 1 ns;
     end if;
 elsif (enr'event) then
     enr_ev := NOW;
 end if;
    end process;

    -- check read enable hold
    d_enr <= enr after EnHold;
    process (d_enr, ckr)
     variable clk_ev : time := 0 ns;
    begin
 if (rising_edge(ckr)) then
     clk_ev := NOW;
 elsif (d_enr'event) then
     if ((clk_ev /= 0 ns) AND
      ((NOW-clk_ev) < xcmfEnxAtClockHold + EnHold)) then
  assert (false)
      report readen_hold
      severity warning;
  enrherr <= '1';
  enrherr <= transport '0' AFTER 1 ns;
     end if;
 end if;
    end process;

    -- check write enable setup
    e_dckw <= ckw after EnSetup;
    process (enw, e_dckw)
     variable enw_ev : time := 0 ns;
    begin
 if (rising_edge(e_dckw)) then
     if ((enw_ev /= 0 ns) AND
      ((NOW-enw_ev) < xcmfEnxAtClockSetup + EnSetup)) then
  assert (false)
      report writeen_setup
      severity warning;
  enwserr <= '1';
  enwserr <= transport '0' AFTER 1 ns;
     end if;
 elsif (enw'event) then
     enw_ev := NOW;
 end if;
    end process;

    -- check write enable hold
    d_enw <= enw after EnHold;
    process (d_enw, ckw)
     variable clk_ev : time := 0 ns;
    begin
 if (rising_edge(ckw)) then
     clk_ev := NOW;
 elsif (d_enw'event) then
     if ((clk_ev /= 0 ns) AND
      ((NOW-clk_ev) < xcmfEnxAtClockHold + EnHold)) then
  assert (false)
      report writeen_hold
      severity warning;
  enwherr <= '1';
  enwherr <= transport '0' AFTER 1 ns;
     end if;
 end if;
    end process;

    -- check reset width
    process (mrb)
        variable mrblo : time := 0 ns;
    begin
 if (mrb = '0') then
     mrblo := NOW;
 else
     if ((mrblo /= 0 ns) AND ((NOW-mrblo) < xcmfMrbWthLo)) then
  assert (false)
      report reset_width
      severity warning;
  mrberr <= '1';
  mrberr <= transport '0' AFTER 1 ns;
     end if;
 end if;
    end process;

    -- check read reset recovery
    process (mrb, ckr)
        variable mrblastev, ckrlastev : time := 0 ns;
    begin
 if (mrb'event) then
     mrblastev := NOW;
 end if;
 if ((mrb = '1') AND rising_edge(ckr)) then
     if ((mrblastev /= 0 ns) AND ((NOW-mrblastev) < xcmfMrbRcr)) then
  assert (false)
      report readreset_rcvry
      severity warning;
  rrcverr <= '1';
  rrcverr <= transport '0' AFTER 1 ns;
     end if;
     ckrlastev := NOW;
 end if;
    end process;

    -- check write reset recovery
    process (mrb, ckw)
        variable mrblastev, ckwlastev : time := 0 ns;
    begin
 if (mrb'event) then
     mrblastev := NOW;
 end if;
 if ((mrb = '1') AND rising_edge(ckw)) then
     if ((mrblastev /= 0 ns) AND ((NOW-mrblastev) < xcmfMrbRcr)) then
  assert (false)
      report writereset_rcvry
      severity warning;
  wrcverr <= '1';
  wrcverr <= transport '0' AFTER 1 ns;
     end if;
     ckwlastev := NOW;
 end if;
    end process;

    -- check E/F flag to read clock setup
    f_dckr <= ckr after fflgSetupR;
    process (f_dckr, efb)
 variable efb_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(f_dckr)) then
  if ((efb_ev /= 0 ns) AND
   ((NOW-efb_ev) < xcmfEfbInAtClkRdSetup + fflgSetupR))then
      assert (false)
   report refflag_setup
   severity warning;
      refserr <= '1';
      refserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (efb'event) then
  efb_ev := NOW;
     end if;
 end if;
    end process;

    -- check H/F flag to read clock setup
    h_dckr <= ckr after hflgSetupR;
    process (h_dckr, hfb)
 variable hfb_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(h_dckr)) then
  if ((hfb_ev /= 0 ns) AND
   ((NOW-hfb_ev) < xcmfHfbInAtClkRdSetup + hflgSetupR))then
      assert (false)
   report rhfflag_setup
   severity warning;
      rhfserr <= '1';
      rhfserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (hfb'event) then
  hfb_ev := NOW;
     end if;
 end if;
    end process;

    -- check E/F flag to read clock hold
    r_efb <= efb after fflgHoldR;
    process (ckr, r_efb)
 variable clk_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(ckr)) then
  clk_ev := NOW;
     elsif (r_efb'event) then
  if ((clk_ev /= 0 ns) AND
   ((NOW-clk_ev) < xcmfEfbInAtClkRdHold + fflgHoldR)) then
      assert (false)
   report refflag_hold
   severity warning;
      refherr <= '1';
      refherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check H/F flag to read clock hold
    r_hfb <= hfb after hflgHoldR;
    process (ckr, r_hfb)
 variable clk_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(ckr)) then
  clk_ev := NOW;
     elsif (r_hfb'event) then
  if ((clk_ev /= 0 ns) AND
   ((NOW-clk_ev) < xcmfHfbInAtClkRdHold + hflgHoldR)) then
      assert (false)
   report rhfflag_hold
   severity warning;
      rhfherr <= '1';
      rhfherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check E/F flag to write clock setup
    f_dckw <= ckw after fflgSetupW;
    process (f_dckw, efb)
 variable efb_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(f_dckw)) then
  if ((efb_ev /= 0 ns) AND
   ((NOW-efb_ev) < xcmfEfbInAtClkWrSetup + fflgSetupW))then
      assert (false)
   report wefflag_setup
   severity warning;
      wefserr <= '1';
      wefserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (efb'event) then
  efb_ev := NOW;
     end if;
 end if;
    end process;


    -- check H/F flag to write clock setup
    h_dckw <= ckw after hflgSetupW;
    process (h_dckw, hfb)
 variable hfb_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(h_dckw)) then
  if ((hfb_ev /= 0 ns) AND
   ((NOW-hfb_ev) < xcmfHfbInAtClkWrSetup + hflgSetupW))then
      assert (false)
   report whfflag_setup
   severity warning;
      whfserr <= '1';
      whfserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (hfb'event) then
  hfb_ev := NOW;
     end if;
 end if;
    end process;

    -- check E/F flag to write clock hold
    w_efb <= efb after fflgHoldW;
    process (ckw, w_efb)
 variable clk_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(ckw)) then
  clk_ev := NOW;
     elsif (w_efb'event) then
  if ((clk_ev /= 0 ns) AND
   ((NOW-clk_ev) < xcmfEfbInAtClkWrHold + fflgHoldW)) then
      assert (false)
   report wefflag_hold
   severity warning;
      wefherr <= '1';
      wefherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check H/F flag to write clock hold
    w_hfb <= hfb after hflgHoldW;
    process (ckw, w_hfb)
 variable clk_ev : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "10") then
     if (rising_edge(ckw)) then
  clk_ev := NOW;
     elsif (hfb'event) then
  if ((clk_ev /= 0 ns) AND
   ((NOW-clk_ev) < xcmfHfbInAtClkWrHold + hflgHoldW)) then
      assert (false)
   report whfflag_hold
   severity warning;
      whfherr <= '1';
      whfherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check the skews between read and write for setting the flags
    process (ckr, ckw)
     variable ckr_re : time := 0 ns;
     variable ckw_re : time := 0 ns;
    begin
 if (cfgbits(1 downto 0) = "01") then
     if (rising_edge(ckr)) then
  ckr_re := NOW;
     end if;
     if (rising_edge(ckw)) then
  ckw_re := NOW;
     end if;

     if (rising_edge(ckr) AND (mrb = '1')) then
  -- empty
  if (((NOW-ckw_re) < xcmfRdWrSkewEfb) AND (efb = '0')) then
      assert (false)
   report write2read_skew1
   severity note;
  end if;
  -- programmable empty
  if (((NOW-ckw_re) < xcmfRdWrSkewPafeb) AND (paem = '0')) then
      assert (false)
   report write2read_skew2
   severity note;
  end if;
     end if;

     if (rising_edge(ckw) AND (mrb = '1')) then
  -- full
  if (((NOW-ckr_re) < xcmfRdWrSkewHfb) AND (hfb = '0')) then
      assert (false)
   report read2write_skew2
   severity note;
  end if;
  -- programmable full
  if (((NOW-ckr_re) < xcmfRdWrSkewPafeb) AND (pafl = '0')) then
      assert (false)
   report read2write_skew3
   severity note;
  end if;
     end if;
 end if;
    end process;

    -- simulate the fifo operations
    process (mrb, ckw, ckr,
  ckwerr, enwserr, enwherr, mrberr, wrcverr,
  ckrerr, wdserr, wdherr, enrserr, enrherr, rrcverr)
 variable dtmp : std_logic_vector(7 downto 0);
 variable dierr : std_logic_vector(7 downto 0);
 variable doerr : std_logic_vector(7 downto 0);
 variable wadd : natural := 0;
 variable radd : natural := 0;
 variable idx : natural := 0;
 variable top : natural := 0;
 variable wadr : natural;
 variable radr : natural;
 variable mem : chmem := memdata;
    begin

 case cfgbits(3 downto 2) is
 when "00" =>
     top := 512;
 when "01" =>
     top := 1024;
     wadr := (wadd mod 2)*4;
     radr := (radd mod 2)*4;
 when "10" =>
     top := 2048;
     wadr := (wadd mod 4)*2;
     radr := (radd mod 4)*2;
 when "11" =>
     top := 4096;
     wadr := (wadd mod 8);
     radr := (radd mod 8);
 end case;

 -- Condition input with errors
 if ((ckwerr OR enwserr OR enwherr OR mrberr OR wrcverr
         OR wdserr OR wdherr) = '1') then
     dierr := (others => 'X');
 else
     dierr := din;
 end if;

 if (mrb = '0') then
     idx := 0;
     wadd := 0;
     radd := 0;
     doerr := (others => '0');
 else
     case cfgbits(1 downto 0) is
     when "01" =>
  if (rising_edge(ckw)) then
      if ((idx < top) AND (enw = '1') AND (full /= '0')) then
   idx := idx+1;
   case cfgbits(3 downto 2) is
   when "00" =>
       mem(wadd) := dierr;
   when "01" =>
       mem(wadd/2)(wadr+3 downto wadr):= dierr(3 downto 0);
   when "10" =>
       mem(wadd/4)(wadr+1 downto wadr):= dierr(1 downto 0);
   when "11" =>
       mem(wadd/8)(wadr) := dierr(0);
   end case;
   wadd := wadd + 1;
   if (wadd >= top) then
       wadd := 0;
   end if;
      end if;
  end if;
  if (rising_edge(ckr)) then
      if ((idx > 0) AND (enr = '1') AND (empt /= '0')) then
   idx := idx-1;
   doerr := (others => '0');
   case cfgbits(3 downto 2) is
   when "00" =>
       doerr := mem(radd);
   when "01" =>
       doerr(3 downto 0):= mem(radd/2)(radr+3 downto radr);
   when "10" =>
       doerr(1 downto 0):= mem(radd/4)(radr+1 downto radr);
   when "11" =>
       doerr(0) := mem(radd/8)(radr);
   end case;
   radd := radd + 1;
   if (radd >= top) then
       radd := 0;
   end if;
      end if;
  end if;
     when "10" =>
  if (rising_edge(ckw)) then
      if (NOT((efb = '0') AND (hfb = '0')) AND (enw = '1')) then
   case cfgbits(3 downto 2) is
   when "00" =>
       mem(wadd) := dierr;
   when "01" =>
       mem(wadd/2)(wadr+3 downto wadr):= dierr(3 downto 0);
   when "10" =>
       mem(wadd/4)(wadr+1 downto wadr):= dierr(1 downto 0);
   when "11" =>
       mem(wadd/8)(wadr) := dierr(0);
   end case;
   wadd := wadd + 1;
   if (wadd >= top) then
       wadd := 0;
   end if;
      end if;
  end if;
  if (rising_edge(ckr)) then
      if (NOT((efb = '0') AND (hfb = '1')) AND (enr = '1')) then
   doerr := (others => '0');
   case cfgbits(3 downto 2) is
   when "00" =>
       doerr := mem(radd);
   when "01" =>
       doerr(3 downto 0):= mem(radd/2)(radr+3 downto radr);
   when "10" =>
       doerr(1 downto 0):= mem(radd/4)(radr+1 downto radr);
   when "11" =>
       doerr(0) := mem(radd/8)(radr);
   end case;
   radd := radd + 1;
   if (radd >= top) then
       radd := 0;
   end if;
      end if;
  end if;
     when others =>
      null;
     end case;
 end if;

 -- Condition output with errors and the reset
 if ((ckrerr OR enrserr OR enrherr OR mrberr OR rrcverr) = '1') then
     dtmp := (others => 'X');
 else
     dtmp := doerr;
 end if;

 if (mrb'event) then
     dout <= dtmp after xcmfReset2Dout;
 else
     dout <= dtmp after xcmfClock2Dout;
 end if;

 case cfgbits(1 downto 0) is
 when "01" =>
     if (mrb'event AND (mrb = '0')) then
  empt <= '0' after xcmfMrb2Output;
  paem <= '0' after xcmfMrb2Output;
  half <= '1' after xcmfMrb2Output;
  full <= '1' after xcmfMrb2Output;
  pafl <= '1' after xcmfMrb2Output;
     else
  if (rising_edge(ckr)) then
      if (idx <= 0) then
   empt <= '0' after xcmfClkRd2FlagOut;
      else
   empt <= '1' after xcmfClkRd2FlagOut;
      end if;
      if (idx >= top/2) then
   half <= '0' after xcmfClkWr2FlagOut;
      else
   half <= '1' after xcmfClkWr2FlagOut;
      end if;
      if (((idx <= to_integer(cfgbits(45 downto 35))) AND
       (top = 4096)) OR
   ((idx <= to_integer(cfgbits(45 downto 36))) AND
       (top = 2048)) OR
   ((idx <= to_integer(cfgbits(45 downto 37))) AND
       (top = 1024)) OR
   ((idx <= to_integer(cfgbits(45 downto 38))) AND
       (top = 512))) then
   paem <= '0' after xcmfClkRd2FlagOut;
      else
   paem <= '1' after xcmfClkRd2FlagOut;
      end if;
  end if;

  if (rising_edge(ckw)) then
      if (idx >= top) then
   full <= '0' after xcmfClkWr2FlagOut;
      else
   full <= '1' after xcmfClkWr2FlagOut;
      end if;
      if (idx >= top/2) then
   half <= '0' after xcmfClkWr2FlagOut;
      else
   half <= '1' after xcmfClkWr2FlagOut;
      end if;
      if (((top-idx <= to_integer(cfgbits(45 downto 35))) AND
       (top = 4096)) OR
   ((top-idx <= to_integer(cfgbits(45 downto 36))) AND
       (top = 2048)) OR
   ((top-idx <= to_integer(cfgbits(45 downto 37))) AND
       (top = 1024)) OR
   ((top-idx <= to_integer(cfgbits(45 downto 38))) AND
       (top = 512))) then
   pafl <= '0' after xcmfClkWr2FlagOut;
      else
   pafl <= '1' after xcmfClkWr2FlagOut;
      end if;
  end if;
     end if;
 when others =>
     null;
 end case;
    end process;

    process (half, full, empt, pafl, paem)
    begin
 case cfgbits(1 downto 0) is
 when "01" =>
     hfb <= half;
     efb <= full AND empt;
     pafeb <= pafl AND paem AND full AND empt;
 when others =>
     hfb <= 'Z';
     efb <= 'Z';
 end case;
    end process;

end sim;



library ieee;
use ieee.std_logic_1164.all;

entity c39kck is
    generic (
 cfgbits : Bit_Vector(63 downto 0);
 xplPulseWthLo : time;
 xplPulseWthHi : time;
 xplMinInputDuty : positive;
 xplMaxInputDuty : positive;
 xplJitterUncertainty : time; -- unused
 xplZeroFBUncertainty : time; -- unused
 xplTreeFBUncertainty : time; -- unused
 xplMinPinClkPeriod : time;
 xplMaxPinClkPeriod : time;
 xplLockTime : time;
 xplClockTreeOffset : time;
 xckPin2GClkDirect : time;
 xplSpreadFreqPercent : real; -- unused
 xplSpreadFreqKHz : real); -- unused
    port (
 clk : in std_logic_vector(3 downto 0);
 nios : in std_logic;
 lock : out std_logic;
 glclk : out std_logic_vector(3 downto 0));
end c39kck;

architecture sim of c39kck is

    -- To use the real silicon time, replace 3 us with xplLockTime.
    constant simLockTime: time := 3 us;

    signal clk_01 : std_logic_vector(3 downto 0);
    signal tmpglclk : std_logic_vector(3 downto 0);
    signal feedback : std_logic := '0';
    signal int_fdbk : std_logic := '0';
    signal tmp_fdbk : std_logic := '0';
    signal vco : std_logic := '0';
    signal plllock : std_logic := '0';
    signal lock_detect : std_logic := '0';
    signal syncb : std_logic := '1';
    signal cyc : time := 0 ns;
    signal mult : positive;
    signal pllclk : std_logic_vector(3 downto 0);
    signal xclk : std_logic_vector(3 downto 0);
    signal pllout : std_logic_vector(7 downto 0);
    signal tracking : boolean := false;
    signal speedup : boolean;
    signal slowdown : boolean;
    signal killvco : boolean := false;
    signal ckwidth : time := 0 ps;
    signal fbwidth : time := 0 ps;

    type intarray is array (3 downto 0) of natural;
    signal divide : intarray;
    signal phase : intarray;

    constant clk_high : string :=
    "Clock high width violation:";
    constant clk_low : string :=
    "Clock low width violation:";
    constant clk_cycle_max : string :=
    "Clock cycle maximum width violation:";
    constant clk_cycle_min : string :=
    "Clock cycle minimum width violation:";
    constant clk_duty_cycle : string :=
    "Clock duty cycle violation:";

    constant JitterSpec : real := 0.01;

begin
    clk_01 <= to_X01(clk);

    -- check clk cycle, high and low times.
    process (clk_01(0))
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(0) = '1') then
     if (clk_01(0) = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xplPulseWthHi)) then
      assert (false)
   report clk_high
   severity failure;
  end if;
  clklo := NOW;
     elsif (clk_01(0) = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xplPulseWthLo)) then
     assert (false)
   report clk_low
   severity failure;
  end if;
  if NOT ((clkhi=0 ns)OR((NOW-clkhi) >= xplMinPinClkPeriod)) then
      assert (false)
   report clk_cycle_min
   severity failure;
  end if;
  if NOT ((clkhi=0 ns)OR((NOW-clkhi) <= xplMaxPinClkPeriod)) then
      assert (false)
   report clk_cycle_max
   severity failure;
  end if;
  -- Check the duty cycle
  if ((clklo > 0 ns) AND (clkhi > 0 ns)) AND
      (((clklo - clkhi)*100/(NOW - clkhi) < xplMinInputDuty) OR
       ((clklo - clkhi)*100/(NOW - clkhi) > xplMaxInputDuty)) then
      assert (false)
   report clk_duty_cycle
   severity error;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- Get the feedback
    process (clk_01(1), int_fdbk)
    begin
 if (cfgbits(0) = '1') then
     case cfgbits(5 downto 4) is
  when "11" => feedback <= '0';
      assert(false)
      report "Illegal PLL feedback select."
      severity failure;
  when "10" => feedback <= clk_01(1);
  when "01" => feedback <= int_fdbk;
  when "00" => feedback <= int_fdbk;
     end case;
 end if;
    end process;

    mult <= 1 when (cfgbits(5 downto 4)) = "10" else
     6 when (cfgbits(3 downto 1)) = "111" else
     5 when (cfgbits(3 downto 1)) = "110" else
     3 when (cfgbits(3 downto 1)) = "101" else
     16 when (cfgbits(3 downto 1)) = "100" else
     8 when (cfgbits(3 downto 1)) = "011" else
     4 when (cfgbits(3 downto 1)) = "010" else
     2 when (cfgbits(3 downto 1)) = "001" else
     1 when (cfgbits(3 downto 1)) = "000";

    -- PLL and clock multiplier
    process (clk_01(0), feedback)
 variable fbevent: time := 0 ps;
 variable ckevent: time := 0 ps;
 variable kpwidth: time := 0 ps;
 variable width : time := 0 ps;
 variable edges : time := 0 ps;
 variable clock : std_logic := '1';
 variable switch : boolean := false;
    begin
 if (cfgbits(0) = '1') then
     if (rising_edge(clk_01(0))) then
  kpwidth := ckwidth;
  ckwidth <= NOW - ckevent;
  ckevent := NOW;
     end if;

     if (rising_edge(feedback)) then
  fbwidth <= NOW - fbevent;
  fbevent := NOW;
     end if;

     if (rising_edge(feedback)) then
  if ((((ckwidth-fbwidth > ckwidth*JitterSpec)
    OR (fbwidth-ckwidth > ckwidth*JitterSpec))
   AND (plllock = '1'))
    OR ((ckwidth-kpwidth > ckwidth*JitterSpec)
    OR (kpwidth-ckwidth > ckwidth*JitterSpec))) then
      plllock <= '0';
      syncb <= '1';
  end if;
     end if;

     -- Adjust VCO depending upon the widths of the source and feedback.
     if (rising_edge(clk_01(0)) OR rising_edge(feedback)) then
  if (rising_edge(feedback)) then
      switch := true;
  end if;
  if (NOT switch) then
      speedup <= false;
      slowdown <= false;
  elsif (rising_edge(feedback)) then
      if (abs(ckwidth-fbwidth) < (ckwidth*(JitterSpec/10.0))) then
   speedup <= false;
   slowdown <= false;
   syncb <= transport '0' after simLockTime/10;
   plllock <= transport '1' after simLockTime;
      elsif (ckwidth > fbwidth) then
   speedup <= false;
   slowdown <= true AND (syncb = '1');
      elsif (ckwidth < fbwidth) then
   speedup <= true AND (syncb = '1');
   slowdown <= false;
      else
   speedup <= false;
   slowdown <= false;
   syncb <= transport '0' after simLockTime/10;
   plllock <= transport '1' after simLockTime;
      end if;
  end if;
     end if;
 end if;
    end process;

    -- Let the VCO run free (at 145 MHz. initially).
    process
 variable res_fs : time := 1 fs;
 variable is_fs : boolean;
     variable width : time := 6.875 ns;
    begin
 if ((res_fs + res_fs) /= res_fs) then
     is_fs := true;
 else
     is_fs := false;
 end if;
 if (cfgbits(0) = '1') then
     if ( speedup AND NOT slowdown) then
  if (ckwidth + 1 ns < fbwidth) then
      width := width - 100 ps;
  elsif (is_fs) then
      if (ckwidth + 100 ps < fbwidth) then
   width := width - 10 ps;
      elsif (ckwidth + 10 ps < fbwidth) then
   width := width - 1 ps;
      elsif (ckwidth + 1 ps < fbwidth) then
   width := width - 100 fs;
      elsif (ckwidth + 100 fs < fbwidth) then
   width := width - 10 fs;
      else
   width := width - 1 fs;
      end if;
  else
      width := width - 1 ps;
  end if;
     elsif (NOT speedup AND slowdown) then
  if (ckwidth - 1 ns > fbwidth) then
      width := width + 100 ps;
  elsif (is_fs) then
      if (ckwidth - 100 ps > fbwidth) then
   width := width + 10 ps;
      elsif (ckwidth - 10 ps > fbwidth) then
   width := width + 1 ps;
      elsif (ckwidth - 1 ps > fbwidth) then
   width := width + 100 fs;
      elsif (ckwidth - 100 fs > fbwidth) then
   width := width + 10 fs;
      else
   width := width + 1 fs;
      end if;
  else
      width := width + 1 ps;
  end if;
     elsif (NOT speedup AND NOT slowdown AND (ckwidth > 0 ps)) then
  width := ckwidth/(ckwidth/(width - 5 ps)); -- a small fudge.
     end if;
     cyc <= width / 2;
     for i in 1 to 32 loop
  wait for width/2;
  vco <= NOT vco;
     end loop;
     if (killvco) then
  wait on killvco;
     end if;
 else
     vco <= '0';
     wait;
 end if;
    end process;

    -- Stop the VCO if the input clock is > 2X too slow after it has locked.
    process (vco, clk_01(0))
 variable ckevent: time := 0 ps;
    begin
 if (clk_01(0)'event) then
     ckevent := NOW;
 end if;
 if (NOW-ckevent > 2 * xplMaxPinClkPeriod AND lock_detect = '1') then
     killvco <= true;
 else
     killvco <= false;
 end if;
    end process;

    lock_detect <= plllock when (tracking OR (cfgbits(5 downto 4) /= "10"))
  else '0';

    -- lock detect select
    process (lock_detect, nios)
    begin
 if (cfgbits(0) = '1') then
     case cfgbits(42) is
  when '1' => lock <= lock_detect;
  when '0' => lock <= nios;
     end case;
 end if;
    end process;

    -- VCO Frequency Check
    process (vco)
 constant tmax : time := 10.000 ns; -- Min frequency = 100 MHz
 constant tmin : time := 3.750 ns; -- Max frequency = 266 MHz
 variable ckhi : time := 0 ns;
    begin
 if (cfgbits(0) = '1') then
     if (vco = '1') then
  if (syncb = '0') then
      if (((NOW - ckhi) < tmin) OR ((NOW - ckhi) > tmax)) then
   assert (false)
       report "VCO frequency outside its operating range."
       severity warning;
      end if;
  end if;
  ckhi := NOW;
     end if;
 end if;
    end process;

    -- phase shifter
    process (vco)
 variable width : time := 0 ns;
 variable edges : time := 0 ns;
    begin
 if (cfgbits(0) = '1') then
     width := (NOW - edges);
     edges := NOW;
     pllout(7) <= transport vco after width*1.75; -- 315 degrees
     pllout(6) <= transport vco after width*1.50; -- 270 degrees
     pllout(5) <= transport vco after width*1.25; -- 225 degrees
     pllout(4) <= transport vco after width*1.00; -- 180 degrees
     pllout(3) <= transport vco after width*0.75; -- 135 degrees
     pllout(2) <= transport vco after width*0.50; -- 90 degrees
     pllout(1) <= transport vco after width*0.25; -- 45 degrees
     pllout(0) <= transport vco after width*0.00; -- 0 degrees
 end if;
    end process;

    -- Divide and phase select
    process
    begin
 if (cfgbits(0) = '1') then
     for i in 0 to 3 loop
  if (cfgbits(22 + i*5) = '1') then
      divide(i) <= 1;
      if (cfgbits(21+i*5 downto 18+i*5) = "0110") then
   phase(i) <= 315;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0101") then
   phase(i) <= 270;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0100") then
   phase(i) <= 225;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0011") then
   phase(i) <= 180;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0010") then
   phase(i) <= 135;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0001") then
   phase(i) <= 90;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0000") then
   phase(i) <= 45;
      else
   assert(false)
   report "Illegal phase and divide select."
   severity failure;
      end if;
  else
      if (cfgbits(8+i*3 downto 6+i*3)="111") then
   divide(i) <= 6;
      elsif (cfgbits(8+i*3 downto 6+i*3)="110") then
   divide(i) <= 5;
      elsif (cfgbits(8+i*3 downto 6+i*3)="101") then
   divide(i) <= 3;
      elsif (cfgbits(8+i*3 downto 6+i*3)="100") then
   divide(i) <= 16;
      elsif (cfgbits(8+i*3 downto 6+i*3)="011") then
   divide(i) <= 8;
      elsif (cfgbits(8+i*3 downto 6+i*3)="010") then
   divide(i) <= 4;
      elsif (cfgbits(8+i*3 downto 6+i*3)="001") then
   divide(i) <= 2;
      elsif (cfgbits(8+i*3 downto 6+i*3)="000") then
   divide(i) <= 1;
      end if;

      if (cfgbits(21+i*5 downto 18+i*5) = "1110") then
   phase(i) <= 315;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1101") then
   phase(i) <= 270;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1100") then
   phase(i) <= 225;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1011") then
   phase(i) <= 180;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1010") then
   phase(i) <= 135;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1001") then
   phase(i) <= 90;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "1000") then
   phase(i) <= 45;
      elsif (cfgbits(21+i*5 downto 18+i*5) = "0000") then
   phase(i) <= 0;
      else
   assert(false)
   report "Illegal phase select."
   severity failure;
      end if;
  end if;
     end loop;
 end if;
 wait;
    end process;

    -- Generate 4 clocks depending on the phase.
    xclk(3) <= pllout(7) when (phase(3) = 315) else
  pllout(6) when (phase(3) = 270) else
  pllout(5) when (phase(3) = 225) else
  pllout(4) when (phase(3) = 180) else
  pllout(3) when (phase(3) = 135) else
  pllout(2) when (phase(3) = 90) else
  pllout(1) when (phase(3) = 45) else
  pllout(0) when (phase(3) = 0);
    xclk(2) <= pllout(7) when (phase(2) = 315) else
  pllout(6) when (phase(2) = 270) else
  pllout(5) when (phase(2) = 225) else
  pllout(4) when (phase(2) = 180) else
  pllout(3) when (phase(2) = 135) else
  pllout(2) when (phase(2) = 90) else
  pllout(1) when (phase(2) = 45) else
  pllout(0) when (phase(2) = 0);
    xclk(1) <= pllout(7) when (phase(1) = 315) else
  pllout(6) when (phase(1) = 270) else
  pllout(5) when (phase(1) = 225) else
  pllout(4) when (phase(1) = 180) else
  pllout(3) when (phase(1) = 135) else
  pllout(2) when (phase(1) = 90) else
  pllout(1) when (phase(1) = 45) else
  pllout(0) when (phase(1) = 0);
    xclk(0) <= pllout(7) when (phase(0) = 315) else
  pllout(6) when (phase(0) = 270) else
  pllout(5) when (phase(0) = 225) else
  pllout(4) when (phase(0) = 180) else
  pllout(3) when (phase(0) = 135) else
  pllout(2) when (phase(0) = 90) else
  pllout(1) when (phase(0) = 45) else
  pllout(0) when (phase(0) = 0);

    -- Apply the divide amount to the clocks.
    process
    begin
 wait on vco;
 if (rising_edge(vco) AND (NOW > 0 ps)) then
     tmp_fdbk <= '1';
     wait for mult * cyc;
     tmp_fdbk <= '0';
     wait for (mult-1) * cyc;
 end if;
    end process;

    process
    begin
 wait on xclk(3);
 if (rising_edge(xclk(3)) AND (NOW > 0 ps)) then
     pllclk(3) <= '1';
     wait for divide(3) * cyc;
     pllclk(3) <= '0';
     wait for (divide(3)-1) * cyc;
 end if;
    end process;

    process
    begin
 wait on xclk(2);
 if (rising_edge(xclk(2)) AND (NOW > 0 ps)) then
     pllclk(2) <= '1';
     wait for divide(2) * cyc;
     pllclk(2) <= '0';
     wait for (divide(2)-1) * cyc;
 end if;
    end process;

    process
    begin
 wait on xclk(1);
 if (rising_edge(xclk(1)) AND (NOW > 0 ps)) then
     pllclk(1) <= '1';
     wait for divide(1) * cyc;
     pllclk(1) <= '0';
     wait for (divide(1)-1) * cyc;
 end if;
    end process;

    process
    begin
 wait on xclk(0);
 if (rising_edge(xclk(0)) AND (NOW > 0 ps)) then
     pllclk(0) <= '1';
     wait for divide(0) * cyc;
     pllclk(0) <= '0';
     wait for (divide(0)-1) * cyc;
 end if;
    end process;

    -- global clock output mux
    process (pllclk, clk_01)
    begin
 for i in 3 downto 0 loop
     if (cfgbits(38+i) = '1') then
  if (cfgbits(0) = '1') then
      tmpglclk(i)<= pllclk(i);
  else
      assert(false)
      report "PLL powered down, no signal available for output."
      severity failure;
  end if;
     else
  tmpglclk(i)<= clk_01(i);
     end if;
 end loop;
    end process;

    -- compensate for external feedback
    process (tmpglclk, feedback, clk_01(0), tmp_fdbk)
 variable ckevent : time := 0 ps;
 variable half : time := 0 ps;
     variable var : time := 0 ps;
 variable delay : time := 0 ps;
    begin
 if (cfgbits(0) = '1') then
     if (rising_edge(clk_01(0))) then
  ckevent := NOW;
     end if;
     if (falling_edge(clk_01(0))) then
  half := NOW - ckevent;
     end if;
     if (syncb = '1') then
  if (rising_edge(feedback)) then
      if ((NOW - ckevent) < half) then
   var := 2*half - (NOW - ckevent);
      else
   var := 3*half - (NOW - ckevent);
      end if;
  end if;
  glclk <= tmpglclk;
  int_fdbk <= tmp_fdbk;
  tracking <= false;
     else
  if (cfgbits(5 downto 4) = "10") then
      if (rising_edge(feedback)) then
   if (((NOW - ckevent) > half)) then
       if NOT tracking AND (2*half-(NOW-ckevent) > 20 ps) then
    var := var + 20 ps;
       else
    if ((NOW - ckevent) /= 0 ps) then
        var := var + 1 ps;
    end if;
    tracking <= true;
       end if;
   else
       if NOT tracking AND ((NOW - ckevent) > 20 ps) then
    var := var - 20 ps;
       else
    if ((NOW - ckevent) /= 0 ps) then
        var := var - 1 ps;
    end if;
    tracking <= true;
       end if;
   end if;
      end if;
      glclk <= transport tmpglclk after var;
  else
      int_fdbk <= transport tmp_fdbk after var - half;
      if (cfgbits(5 downto 4) = "00") then
       delay := xckPin2GClkDirect;
      elsif (cfgbits(5 downto 4) = "01") then
   -- The 2*half is to add one full clock time to
   -- remove the chance for a negative delay.
       delay := 2*half + xckPin2GClkDirect-xplClockTreeOffset;
      end if;
      glclk <= transport tmpglclk after var - half + delay;
      tracking <= true;
  end if;
     end if;
 else
     glclk <= tmpglclk after xckPin2GClkDirect;
 end if;
    end process;

end sim;



library ieee;
use ieee.std_logic_1164.all;


use work.primitive.all;

entity c39kcm is
    generic (
 cfgbits : Bit_Vector(45 downto 0);
 memdata : chmem;
 -- Async parameters
 xcmReadAddrWthHi : time; -- checked parameters
 xcmWritAddrWthHi : time;
 xcmWriEnaWthHi : time;
 xcmAddrAtWriEnaFallSetup: time;
 xcmAddrAtWriEnaRiseSetup: time;
 xcmAddrAtWriEnaFallHold : time;
 xcmDinAtWriEnaFallSetup : time;
 xcmDinAtWriEnaFallHold : time;
 xcmAddr2DoutRegD : time; -- applied parameters
 xcmWriEna2DoutRegD : time;
 xcmDin2DoutRegD : time;
 xcmDoutRegD2Dout : time;
 -- Sync parameters
 xcmClkInWthCy : time; -- checked parameters
 xcmClkInWthHi : time;
 xcmClkInWthLo : time;
 xcmAddrAtClkInSetup : time;
 xcmAddrAtClkInHold : time;
 xcmWriEnaAtClkInSetup : time;
 xcmWriEnaAtClkInHold : time;
 xcmDinAtClkInSetup : time;
 xcmDinAtClkInHold : time;
 xcmClkIn2DoutRegD : time; -- applied parameters
 -- Output Register parameters
 xcmDoutRegCkWthCy : time; -- checked parameters
 xcmDoutRegCkWthHi : time;
 xcmDoutRegCkWthLo : time;
 xcmDoutRegSetup : time;
 xcmDoutRegHold : time;
 xcmDoutRegReWthHi : time;
 xcmDoutRegReRcr : time;
 xcmReset2Dout : time; -- applied parameters
 xcmClkOut2Dout : time;
 xcmAddrTransDetect : time);
    port (
 din_a : in std_logic_vector( 7 downto 0);
 din_b : in std_logic_vector( 7 downto 0);
 addr_a : in std_logic_vector(11 downto 0);
 addr_b : in std_logic_vector(11 downto 0);
 we_a : in std_logic;
 we_b : in std_logic;
 iclk_a : in std_logic := '0';
 iclk_b : in std_logic := '0';
 oclk_a : in std_logic := '0';
 oclk_b : in std_logic := '0';
 reset_a : in std_logic := '0';
 reset_b : in std_logic := '0';
 addr_matchb : out std_logic;
 dout_a : out std_logic_vector( 7 downto 0);
 dout_b : out std_logic_vector( 7 downto 0));
end c39kcm;

architecture sim of c39kcm is

    signal atmp_a,atmp_b : std_logic_vector(11 downto 0);
    signal dtin_a,dtin_b : std_logic_vector( 7 downto 0);
    signal dtout_a,dtout_b : std_logic_vector( 7 downto 0);
    signal cdout_a,cdout_b : std_logic_vector( 7 downto 0);
    signal wtmp_a,wtmp_b : std_logic;
    signal atd_a, atd_b : std_logic;

    -- Signals for use with negative setup and hold checks
    signal dsaddr_a :std_logic_vector(11 downto 0);
    signal daiclk_a :std_logic;
    signal dswe_a :std_logic;
    signal dwiclk_a :std_logic;
    signal dsdin_a :std_logic_vector( 7 downto 0);
    signal ddiclk_a :std_logic;
    signal dcdout_a :std_logic_vector( 7 downto 0);
    signal doclk_a :std_logic;
    signal dadin_a :std_logic_vector( 7 downto 0);
    signal ddwe_a :std_logic;
    signal daaddr_a :std_logic_vector(11 downto 0);
    signal dawer_a :std_logic;
    signal dawef_a :std_logic;

    signal dsaddr_b :std_logic_vector(11 downto 0);
    signal daiclk_b :std_logic;
    signal dswe_b :std_logic;
    signal dwiclk_b :std_logic;
    signal dsdin_b :std_logic_vector( 7 downto 0);
    signal ddiclk_b :std_logic;
    signal dcdout_b :std_logic_vector( 7 downto 0);
    signal doclk_b :std_logic;
    signal dadin_b :std_logic_vector( 7 downto 0);
    signal ddwe_b :std_logic;
    signal daaddr_b :std_logic_vector(11 downto 0);
    signal dawer_b :std_logic;
    signal dawef_b :std_logic;

    -- Constants for use with negative setup and hold checks
    constant syncAddrSetup : time := timeAdjust(xcmAddrAtClkInSetup);
    constant syncAddrHold : time := timeAdjust(xcmAddrAtClkInHold);
    constant syncWESetup : time := timeAdjust(xcmWriEnaAtClkInSetup);
    constant syncWEHold : time := timeAdjust(xcmWriEnaAtClkInHold);
    constant syncDataSetup : time := timeAdjust(xcmDinAtClkInSetup);
    constant syncDataHold : time := timeAdjust(xcmDinAtClkInHold);
    constant dataOutSetup : time := timeAdjust(xcmDoutRegSetup);
    constant dataOutHold : time := timeAdjust(xcmDoutRegHold);
    constant asyncAddrSetupF : time := timeAdjust(xcmAddrAtWriEnaFallSetup);
    constant asyncAddrSetupR : time := timeAdjust(xcmAddrAtWriEnaRiseSetup);
    constant asyncAddrHold : time := timeAdjust(xcmAddrAtWriEnaFallHold);
    constant asyncDataSetup : time := timeAdjust(xcmDinAtWriEnaFallSetup);
    constant asyncDataHold : time := timeAdjust(xcmDinAtWriEnaFallHold);

    constant unk : string := " Setting output unknown.";

    -- Port A check signals and errors
    signal iclkerr_a : std_logic;
    constant iclk_width_a : string :=
    "Input clock A cycle width violation:" & unk;
    constant iclk_low_a : string :=
    "Input clock A low width violation:" & unk;
    constant iclk_high_a : string :=
    "Input clock A high width violation:" & unk;

    signal aserr_a : std_logic;
    constant addr2iclk_setup_a : string :=
    "Address A to input clock setup violation:" & unk;

    signal aherr_a : std_logic;
    constant addr2iclk_hold_a : string :=
    "Input clock to address A hold violation:" & unk;

    signal wserr_a : std_logic;
    constant write2iclk_setup_a : string :=
    "Write A to clock setup violation:" & unk;

    signal wherr_a : std_logic;
    constant write2iclk_hold_a : string :=
    "Clock to write A hold violation:" & unk;

    signal dserr_a : std_logic;
    constant data2iclk_setup_a : string :=
    "Data A to clock setup violation:" & unk;

    signal dherr_a : std_logic;
    constant data2iclk_hold_a : string :=
    "Clock to data A hold violation:" & unk;

    signal wrwerr_a : std_logic;
    constant write_width_a : string :=
    "Minimum write width A violation:" & unk;

    signal wcycerr_a : std_logic;
    constant writeaddr_cycle_a : string :=
    "Minimum write cycle A violation:" & unk;

    signal rcycerr_a : std_logic;
    constant readaddr_cycle_a : string :=
    "Minimum read cycle A violation:" & unk;

    signal awserr_a : std_logic;
    constant addr2westart_setup_a: string :=
    "Address to we A start setup violation:" & unk;
    constant addr2weend_setup_a: string :=
    "Address to we A end setup violation:" & unk;

    signal awherr_a : std_logic;
    constant addr2we_hold_a : string :=
    "We to address A hold violation:" & unk;

    signal dwserr_a : std_logic;
    constant data2we_setup_a : string :=
    "Data A to we setup violation:" & unk;

    signal dwherr_a : std_logic;
    constant data2we_hold_a : string :=
    "We to data A hold violation:" & unk;

    signal oclkerr_a : std_logic;
    constant outputclock_width_a: string :=
    "Output clock A cycle width violation:" & unk;
    constant outputclock_low_a : string :=
    "Output clock A low width violation:" & unk;
    constant outputclock_high_a : string :=
    "Output clock A high width violation:" & unk;

    signal rcverr_a : std_logic;
    constant outreg_rcvry_a : string :=
    "Output reg. A reset recovery violation:" & unk;

    signal rsterr_a : std_logic;
    constant reset_width_a : string :=
    "Reset A width violation:" & unk;

    signal oserr_a : std_logic;
    constant data2oclk_setup_a : string :=
    "Data to output clock setup violation:" & unk;
    constant addr2oclk_setup_a : string :=
    "Address to output clock setup violation:" & unk;
    constant we2oclk_setup_a : string :=
    "WE to output clock setup violation:" & unk;
    constant iclk2oclk_setup_a : string :=
    "In clock to out clock setup violation:" & unk;

    signal oherr_a : std_logic;
    constant data2oclk_hold_a : string :=
    "Output clock to data hold violation:" & unk;
    constant addr2oclk_hold_a : string :=
    "Output clock to address hold violation:" & unk;
    constant we2oclk_hold_a : string :=
    "Output clock to WE hold violation:" & unk;
    constant iclk2oclk_hold_a : string :=
    "Out clock to in clock hold violation:" & unk;

    -- Port B check signals and errors
    signal iclkerr_b : std_logic;
    constant iclk_width_b : string :=
    "Input clock B cycle width violation:" & unk;
    constant iclk_low_b : string :=
    "Input clock B low width violation:" & unk;
    constant iclk_high_b : string :=
    "Input clock B high width violation:" & unk;

    signal aserr_b : std_logic;
    constant addr2iclk_setup_b : string :=
    "Address B to input clock setup violation:" & unk;

    signal aherr_b : std_logic;
    constant addr2iclk_hold_b : string :=
    "Input clock to address B hold violation:" & unk;

    signal wserr_b : std_logic;
    constant write2iclk_setup_b : string :=
    "Write B to clock setup violation:" & unk;

    signal wherr_b : std_logic;
    constant write2iclk_hold_b : string :=
    "Clock to write B hold violation:" & unk;

    signal dserr_b : std_logic;
    constant data2iclk_setup_b : string :=
    "Data B to clock setup violation:" & unk;

    signal dherr_b : std_logic;
    constant data2iclk_hold_b : string :=
    "Clock to data B hold violation:" & unk;

    signal wrwerr_b : std_logic;
    constant write_width_b : string :=
    "Minimum write width B violation:" & unk;

    signal wcycerr_b : std_logic;
    constant writeaddr_cycle_b : string :=
    "Minimum write cycle B violation:" & unk;

    signal rcycerr_b : std_logic;
    constant readaddr_cycle_b : string :=
    "Minimum read cycle B violation:" & unk;

    signal awserr_b : std_logic;
    constant addr2westart_setup_b: string :=
    "Address to we B start setup violation:" & unk;
    constant addr2weend_setup_b: string :=
    "Address to we B end setup violation:" & unk;

    signal awherr_b : std_logic;
    constant addr2we_hold_b : string :=
    "We to address B hold violation:" & unk;

    signal dwserr_b : std_logic;
    constant data2we_setup_b : string :=
    "Data B to we setup violation:" & unk;

    signal dwherr_b : std_logic;
    constant data2we_hold_b : string :=
    "We to data B hold violation:" & unk;

    signal oclkerr_b : std_logic;
    constant outputclock_width_b: string :=
    "Output clock B cycle width violation:" & unk;
    constant outputclock_low_b : string :=
    "Output clock B low width violation:" & unk;
    constant outputclock_high_b : string :=
    "Output clock B high width violation:" & unk;

    signal rcverr_b : std_logic;
    constant outreg_rcvry_b : string :=
    "Output reg. B reset recovery violation:" & unk;

    signal rsterr_b : std_logic;
    constant reset_width_b : string :=
    "Reset B width violation:" & unk;

    signal oserr_b : std_logic;
    constant data2oclk_setup_b : string :=
    "Data to output clock setup violation:" & unk;
    constant addr2oclk_setup_b : string :=
    "Address to output clock setup violation:" & unk;
    constant we2oclk_setup_b : string :=
    "WE to output clock setup violation:" & unk;
    constant iclk2oclk_setup_b : string :=
    "In clock to out clock setup violation:" & unk;

    signal oherr_b : std_logic;
    constant data2oclk_hold_b : string :=
    "Output clock to data hold violation:" & unk;
    constant addr2oclk_hold_b : string :=
    "Output clock to address hold violation:" & unk;
    constant we2oclk_hold_b : string :=
    "Output clock to WE hold violation:" & unk;
    constant iclk2oclk_hold_b : string :=
    "Out clock to in clock hold violation:" & unk;

begin

    -- check sync iclk_a cycle, high and low times.
    process (iclk_a)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(4) = '1') then
     if (iclk_a = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmClkInWthHi)) then
      assert (false)
   report iclk_width_a
   severity warning;
      iclkerr_a <= '1';
      iclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (iclk_a = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcmClkInWthLo)) then
     assert (false)
   report iclk_low_a
   severity warning;
      iclkerr_a <= '1';
      iclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmClkInWthCy)) then
      assert (false)
   report iclk_high_a
   severity warning;
      iclkerr_a <= '1';
      iclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check sync iclk_b cycle, high and low times.
    process (iclk_b)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(17) = '1') then
     if (iclk_b = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmClkInWthHi)) then
      assert (false)
   report iclk_width_b
   severity warning;
      iclkerr_b <= '1';
      iclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (iclk_b = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcmClkInWthLo)) then
     assert (false)
   report iclk_low_b
   severity warning;
      iclkerr_b <= '1';
      iclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmClkInWthCy)) then
      assert (false)
   report iclk_high_b
   severity warning;
      iclkerr_b <= '1';
      iclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check sync address setup _a
    daiclk_a <= iclk_a after syncAddrSetup;
    process (addr_a, daiclk_a)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(4) = '1') then
     if (rising_edge(daiclk_a)) then
  if ((addrev /= 0 ns) AND
   ((NOW-addrev) < xcmAddrAtClkInSetup+syncAddrSetup)) then
      assert (false)
   report addr2iclk_setup_a
   severity warning;
      aserr_a <= '1';
      aserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_a'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check sync address hold _a
    dsaddr_a <= addr_a after syncAddrHold;
    process (dsaddr_a, iclk_a)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(4) = '1') then
     if (rising_edge(iclk_a)) then
      clckev := NOW;
     elsif (dsaddr_a'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmAddrAtClkInHold+syncAddrHold)) then
      assert (false)
   report addr2iclk_hold_a
   severity warning;
      aherr_a <= '1';
      aherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync address setup _b
    daiclk_b <= iclk_b after syncAddrSetup;
    process (addr_b, daiclk_b)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(17) = '1') then
     if (rising_edge(daiclk_b)) then
  if ((addrev /= 0 ns) AND
   ((NOW-addrev) < xcmAddrAtClkInSetup+syncAddrSetup)) then
      assert (false)
   report addr2iclk_setup_b
   severity warning;
      aserr_b <= '1';
      aserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_b'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check sync address hold _b
    dsaddr_b <= addr_b after syncAddrHold;
    process (dsaddr_b, iclk_b)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(17) = '1') then
     if (rising_edge(iclk_b)) then
      clckev := NOW;
     elsif (dsaddr_b'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmAddrAtClkInHold+syncAddrHold)) then
      assert (false)
   report addr2iclk_hold_b
   severity warning;
      aherr_b <= '1';
      aherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync write setup _a
    dwiclk_a <= iclk_a after syncWESetup;
    process (we_a, dwiclk_a)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(4) = '1') then
     if (rising_edge(dwiclk_a)) then
  if ((writev /= 0 ns) AND
   ((NOW-writev) < xcmWriEnaAtClkInSetup+syncWESetup)) then
      assert (false)
   report write2iclk_setup_a
   severity warning;
      wserr_a <= '1';
      wserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (we_a'event) then
      writev := NOW;
     end if;
 end if;
    end process;

    -- check sync write hold _a
    dswe_a <= we_a after syncWEHold;
    process (dswe_a, iclk_a)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(4) = '1') then
     if (rising_edge(iclk_a)) then
      clckev := NOW;
     elsif (dswe_a'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmWriEnaAtClkInHold+syncWEHold)) then
      assert (false)
   report write2iclk_hold_a
   severity warning;
      wherr_a <= '1';
      wherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync write setup _b
    dwiclk_b <= iclk_b after syncWESetup;
    process (we_b, dwiclk_b)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(17) = '1') then
     if (rising_edge(dwiclk_b)) then
  if ((writev /= 0 ns) AND
   ((NOW-writev) < xcmWriEnaAtClkInSetup+syncWESetup)) then
      assert (false)
   report write2iclk_setup_b
   severity warning;
      wserr_b <= '1';
      wserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (we_b'event) then
      writev := NOW;
     end if;
 end if;
    end process;

    -- check sync write hold _b
    dswe_b <= we_b after syncWEHold;
    process (dswe_b, iclk_b)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(17) = '1') then
     if (rising_edge(iclk_b)) then
      clckev := NOW;
     elsif (dswe_b'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmWriEnaAtClkInHold+syncWEHold)) then
      assert (false)
   report write2iclk_hold_b
   severity warning;
      wherr_b <= '1';
      wherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync data setup _a
    ddiclk_a <= iclk_a after syncDataSetup;
    process (din_a, ddiclk_a)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(5) = '1') then
     if (rising_edge(ddiclk_a)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcmDinAtClkInSetup+syncDataSetup)) then
      assert (false)
   report data2iclk_setup_a
   severity warning;
      dserr_a <= '1';
      dserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (din_a'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data hold _a
    dsdin_a <= din_a after syncDataHold;
    process (dsdin_a, iclk_a)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(5) = '1') then
     if (rising_edge(iclk_a)) then
      clckev := NOW;
     elsif (dsdin_a'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmDinAtClkInHold+syncDataHold)) then
      assert (false)
   report data2iclk_hold_a
   severity warning;
      dherr_a <= '1';
      dherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync data setup _b
    ddiclk_b <= iclk_b after syncDataSetup;
    process (din_b, ddiclk_b)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(18) = '1') then
     if (rising_edge(ddiclk_b)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcmDinAtClkInSetup+syncDataSetup)) then
      assert (false)
   report data2iclk_setup_b
   severity warning;
      dserr_b <= '1';
      dserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (din_b'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data hold _b
    dsdin_b <= din_b after syncDataHold;
    process (dsdin_b, iclk_b)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(18) = '1') then
     if (rising_edge(iclk_b)) then
      clckev := NOW;
     elsif (dsdin_b'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmDinAtClkInHold+syncDataHold)) then
      assert (false)
   report data2iclk_hold_b
   severity warning;
      dherr_b <= '1';
      dherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async write_a minimum valid
    process (we_a)
 variable write_ev : time := 0 ns;
    begin
 if ((cfgbits(4) = '0') AND (we_a = '0')) then
     if NOT ((write_ev = 0 ns) OR ((NOW - write_ev) >= xcmWriEnaWthHi)) then
  assert (false)
      report write_width_a
      severity warning;
  wrwerr_a <= '1';
  wrwerr_a <= transport '0' AFTER 1 ns;
     end if;
     write_ev := NOW;
 end if;
    end process;

    -- check async write_b minimum valid
    process (we_b)
 variable write_ev : time := 0 ns;
    begin
 if ((cfgbits(17) = '0') AND (we_b = '0')) then
     if NOT ((write_ev = 0 ns) OR ((NOW - write_ev) >= xcmWriEnaWthHi)) then
  assert (false)
      report write_width_b
      severity warning;
  wrwerr_b <= '1';
  wrwerr_b <= transport '0' AFTER 1 ns;
     end if;
     write_ev := NOW;
 end if;
    end process;

    -- Generate the ATD for A
    process (addr_a)
    begin
     if (cfgbits(4) = '0') then
     atd_a <= '1';
     atd_a <= transport '0' after xcmAddrTransDetect;
 end if;
    end process;

    -- Generate the ATD for B
    process (addr_b)
    begin
     if (cfgbits(17) = '0') then
     atd_b <= '1';
     atd_b <= transport '0' after xcmAddrTransDetect;
 end if;
    end process;

    -- check async data to write setup _a
    ddwe_a <= we_a after asyncDataSetup;
    process (din_a, ddwe_a)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(5) = '0') then
     if (falling_edge(ddwe_a)) then
  if ((dataev /= 0 ns) AND
      ((NOW-dataev) < xcmDinAtWriEnaFallSetup+asyncDataSetup))then
      assert (false)
   report data2we_setup_a
   severity warning;
      dwserr_a <= '1';
      dwserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (din_a'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check async data to write hold _a
    dadin_a <= din_a after asyncDataHold;
    process (dadin_a, we_a)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(5) = '0') then
     if (falling_edge(we_a)) then
      writev := NOW;
     elsif (dadin_a'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcmDinAtWriEnaFallHold+asyncDataHold)) then
      assert (false)
   report data2we_hold_a
   severity warning;
      dwherr_a <= '1';
      dwherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async data to write setup _b
    ddwe_b <= we_b after asyncDataSetup;
    process (din_b, ddwe_b)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(18) = '0') then
     if (falling_edge(ddwe_b)) then
  if ((dataev /= 0 ns) AND
      ((NOW-dataev) < xcmDinAtWriEnaFallSetup+asyncDataSetup))then
      assert (false)
   report data2we_setup_b
   severity warning;
      dwserr_b <= '1';
      dwserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (din_b'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check async data to write hold _b
    dadin_b <= din_b after asyncDataHold;
    process (dadin_b, we_b)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(18) = '0') then
     if (falling_edge(we_b)) then
      writev := NOW;
     elsif (dadin_b'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcmDinAtWriEnaFallHold+asyncDataHold)) then
      assert (false)
   report data2we_hold_b
   severity warning;
      dwherr_b <= '1';
      dwherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async address to write rising setup _a
    dawer_a <= we_a after asyncAddrSetupR;
    process (addr_a, dawer_a)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(4) = '0') then
     if (rising_edge(dawer_a)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcmAddrAtWriEnaRiseSetup+asyncAddrSetupR)) then
      assert (false)
   report addr2westart_setup_a
   severity warning;
      awserr_a <= '1';
      awserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_a'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write falling setup _a
    dawef_a <= we_a after asyncAddrSetupF;
    process (addr_a, dawef_a)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(4) = '0') then
     if (falling_edge(dawef_a)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcmAddrAtWriEnaFallSetup+asyncAddrSetupF)) then
      assert (false)
   report addr2weend_setup_a
   severity warning;
      awserr_a <= '1';
      awserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_a'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write hold _a
    daaddr_a <= addr_a after asyncAddrHold;
    process (daaddr_a, we_a)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(4) = '0') then
     if (falling_edge(we_a)) then
      writev := NOW;
     elsif (daaddr_a'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcmAddrAtWriEnaFallHold+asyncAddrHold)) then
      assert (false)
   report addr2we_hold_a
   severity warning;
      awherr_a <= '1';
      awherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async address to write rising setup _b
    dawer_b <= we_b after asyncAddrSetupR;
    process (addr_b, dawer_b)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(17) = '0') then
     if (rising_edge(dawer_b)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcmAddrAtWriEnaRiseSetup+asyncAddrSetupR)) then
      assert (false)
   report addr2westart_setup_b
   severity warning;
      awserr_b <= '1';
      awserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_b'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write falling setup _b
    dawef_b <= we_b after asyncAddrSetupF;
    process (addr_b, dawef_b)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(17) = '0') then
     if (falling_edge(dawef_b)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcmAddrAtWriEnaFallSetup+asyncAddrSetupF)) then
      assert (false)
   report addr2weend_setup_b
   severity warning;
      awserr_b <= '1';
      awserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr_b'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write hold _b
    daaddr_b <= addr_b after asyncAddrHold;
    process (daaddr_b, we_b)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(17) = '0') then
     if (falling_edge(we_b)) then
      writev := NOW;
     elsif (daaddr_b'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcmAddrAtWriEnaFallHold+asyncAddrHold)) then
      assert (false)
   report addr2we_hold_b
   severity warning;
      awherr_b <= '1';
      awherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync oclk_a cycle, high and low times.
    process (oclk_a)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(4) = '1') then
     if (oclk_a = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmDoutRegCkWthHi)) then
      assert (false)
   report outputclock_high_a
   severity warning;
      oclkerr_a <= '1';
      oclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (oclk_a = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcmDoutRegCkWthLo)) then
     assert (false)
   report outputclock_low_a
   severity warning;
      oclkerr_a <= '1';
      oclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmDoutRegCkWthCy)) then
      assert (false)
   report outputclock_width_a
   severity warning;
      oclkerr_a <= '1';
      oclkerr_a <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check sync oclk_b cycle, high and low times.
    process (oclk_b)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(17) = '1') then
     if (oclk_b = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmDoutRegCkWthHi)) then
      assert (false)
   report outputclock_high_b
   severity warning;
      oclkerr_b <= '1';
      oclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (oclk_b = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcmDoutRegCkWthLo)) then
     assert (false)
   report outputclock_low_b
   severity warning;
      oclkerr_b <= '1';
      oclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcmDoutRegCkWthCy)) then
      assert (false)
   report outputclock_width_b
   severity warning;
      oclkerr_b <= '1';
      oclkerr_b <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;


    -- check output register A reset recovery and reset width
    process (reset_a, oclk_a)
 variable clrlastev, clklastev, clrhi : time := 0 ns;
    begin
     if (cfgbits(6) = '1') then
     if (reset_a'event) then
  clrlastev := NOW;
  if (reset_a = '1') then
      clrhi := NOW;
  else
      if NOT ((clrhi = 0 ns) OR ((NOW-clrhi) >= xcmDoutRegReWthHi)) then
   assert (false)
       report reset_width_a
       severity warning;
   rsterr_a <= '1';
   rsterr_a <= transport '0' AFTER 1 ns;
      end if;
  end if;
     end if;
     if ((reset_a = '0') AND rising_edge(oclk_a)) then
  if NOT((clrlastev = 0 ns) OR ((NOW-clrlastev) >= xcmDoutRegReRcr)) then
      assert (false)
   report outreg_rcvry_a
   severity warning;
      rcverr_a <= '1';
      rcverr_a <= transport '0' AFTER 1 ns;
  end if;
  clklastev := NOW;
     end if;
 end if;
    end process;

    -- check output register B reset recovery and reset width
    process (reset_b, oclk_b)
 variable clrlastev, clklastev, clrhi : time := 0 ns;
    begin
     if (cfgbits(19) = '1') then
     if (reset_b'event) then
  clrlastev := NOW;
  if (reset_b = '1') then
      clrhi := NOW;
  else
      if NOT ((clrhi = 0 ns) OR ((NOW-clrhi) >= xcmDoutRegReWthHi)) then
   assert (false)
       report reset_width_b
       severity warning;
   rsterr_b <= '1';
   rsterr_b <= transport '0' AFTER 1 ns;
      end if;
  end if;
     end if;
     if ((reset_b = '0') AND rising_edge(oclk_b)) then
  if NOT((clrlastev = 0 ns) OR ((NOW-clrlastev) >= xcmDoutRegReRcr)) then
      assert (false)
   report outreg_rcvry_b
   severity warning;
      rcverr_b <= '1';
      rcverr_b <= transport '0' AFTER 1 ns;
  end if;
  clklastev := NOW;
     end if;
 end if;
    end process;

    -- check sync data to oclk setup _a
    doclk_a <= oclk_a after dataOutSetup;
    process (cdout_a, doclk_a)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(6) = '1') then
     if ((reset_a = '0') AND rising_edge(doclk_a)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcmDoutRegSetup+dataOutSetup)) then
      assert (false)
   report data2oclk_setup_a
   severity warning;
      oserr_a <= '1';
      oserr_a <= transport '0' AFTER 1 ns;
  end if;
     elsif (cdout_a'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data to oclk hold _a
    dcdout_a <= cdout_a after dataOutHold;
    process (dcdout_a, oclk_a)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(6) = '1') then
     if ((reset_a = '0') AND rising_edge(oclk_a)) then
      clckev := NOW;
     elsif (dcdout_a'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmDoutRegHold+dataOutHold)) then
      assert (false)
   report data2oclk_hold_a
   severity warning;
      oherr_a <= '1';
      oherr_a <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync data to oclk setup _b
    doclk_b <= oclk_b after dataOutSetup;
    process (cdout_b, doclk_b)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(19) = '1') then
     if ((reset_b = '0') AND rising_edge(doclk_b)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcmDoutRegSetup+dataOutSetup)) then
      assert (false)
   report data2oclk_setup_b
   severity warning;
      oserr_b <= '1';
      oserr_b <= transport '0' AFTER 1 ns;
  end if;
     elsif (cdout_b'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data to oclk hold _b
    dcdout_b <= cdout_b after dataOutHold;
    process (dcdout_b, oclk_b)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(19) = '1') then
     if ((reset_b = '0') AND rising_edge(oclk_b)) then
      clckev := NOW;
     elsif (dcdout_b'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcmDoutRegHold+dataOutHold)) then
      assert (false)
   report data2oclk_hold_b
   severity warning;
      oherr_b <= '1';
      oherr_b <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- Simulate functionality
    process (iclk_a, addr_a, we_a, atd_a)
 variable wreg : std_logic;
    begin
 if (cfgbits(4) = '1') then
 -- Synchronous Address/Write port A
     if (rising_edge(iclk_a)) then
  atmp_a <= addr_a;
     end if;
     wtmp_a <= we_a AND iclk_a;
 else
 -- Asynchronous Address/Write port A
     if(falling_edge(atd_a) OR (xcmAddrTransDetect <= 0 ns)) then
  atmp_a <= addr_a;
     end if;
     wtmp_a <= we_a;
 end if;
    end process;

    process (iclk_b, addr_b, we_b, atd_b)
 variable wreg : std_logic;
    begin
 if (cfgbits(17) = '1') then
 -- Synchronous Address/Write port B
     if (rising_edge(iclk_b)) then
  atmp_b <= addr_b;
     end if;
     wtmp_b <= we_b AND iclk_b;
 else
 -- Asynchronous Address/Write port B
     if(falling_edge(atd_b) OR (xcmAddrTransDetect <= 0 ns)) then
  atmp_b <= addr_b;
     end if;
     wtmp_b <= we_b;
 end if;
    end process;

    process (iclk_a, din_a)
    begin
 if (cfgbits(5) = '1') then
 -- Synchronous Data port A
     if (rising_edge(iclk_a)) then
  dtin_a <= din_a;
     end if;
 else
 -- Asynchronous Data port A
     dtin_a <= din_a;
 end if;
    end process;

    process (iclk_b, din_b)
    begin
 if (cfgbits(18) = '1') then
 -- Synchronous Data port B
     if (rising_edge(iclk_b)) then
  dtin_b <= din_b;
     end if;
 else
 -- Asynchronous Data port B
     dtin_b <= din_b;
 end if;
    end process;

    -- simulate the dual port operations
    process (dtin_a, atmp_a, wtmp_a, iclk_a, dtin_b, atmp_b, wtmp_b, iclk_b)
 variable mem : chmem := memdata;
 variable vecta : natural;
 variable vectb : natural;
 variable btsela : natural;
 variable btselb : natural;
 variable dataa : std_logic_vector(7 downto 0);
 variable datab : std_logic_vector(7 downto 0);
    begin

 vecta := to_integer(atmp_a(11 downto 3));
 vectb := to_integer(atmp_b(11 downto 3));

 -- busy is asserted whenever the two address are the same
 -- the user is responsible to arbitrate based on that information
 if (vecta = vectb) then
     addr_matchb <= '0';
 else
     addr_matchb <= '1';
 end if;

 -- Write the array from port A
 if (wtmp_a = '1') then
     case cfgbits(3 downto 2) is
  when "00" =>
      mem(vecta) := dtin_a;
  when "01" =>
      btsela := to_integer(atmp_a(2 downto 2));
      mem(vecta)(btsela*4+3 downto btsela*4)
     := dtin_a(3 downto 0);
  when "10" =>
      btsela := to_integer(atmp_a(2 downto 1));
      mem(vecta)(btsela*2+1 downto btsela*2)
     := dtin_a(1 downto 0);
  when "11" =>
      btsela := to_integer(atmp_a(2 downto 0));
      mem(vecta)(btsela) := dtin_a(0);
     end case;
 end if;

 -- Write the array from port B
 -- This arbitration may be removed, the user should arbitrate.
 if (((wtmp_b = '1') AND (vecta /= vectb)) OR
     ((wtmp_b = '1') AND (vecta = vectb) AND (wtmp_a /= '1'))) then
     case cfgbits(3 downto 2) is
  when "00" =>
      mem(vectb) := dtin_b;
  when "01" =>
      btselb := to_integer(atmp_b( 2 downto 2));
      mem(vectb)(btselb*4+3 downto btselb*4)
     := dtin_b(3 downto 0);
  when "10" =>
      btselb := to_integer(atmp_b(2 downto 1));
      mem(vectb)(btselb*2+1 downto btselb*2)
     := dtin_b(1 downto 0);
  when "11" =>
      btselb := to_integer(atmp_b(2 downto 0));
      mem(vectb)(btselb) := dtin_b(0);
     end case;
 end if;

 -- Read the array from port A
 dataa := (others => '0');
 case cfgbits(3 downto 2) is
     when "00" =>
  dataa := mem(vecta);
     when "01" =>
  btsela := to_integer(atmp_a(2 downto 2));
  dataa(3 downto 0) := mem(vecta)(btsela*4+3 downto btsela*4);
     when "10" =>
  btsela := to_integer(atmp_a(2 downto 1));
  dataa(1 downto 0) := mem(vecta)(btsela*2+1 downto btsela*2);
     when "11" =>
  btsela := to_integer(atmp_a(2 downto 0));
      dataa(0) := mem(vecta)(btsela);
 end case;

 -- Read the array from port B
 datab := (others => '0');
 case cfgbits(3 downto 2) is
     when "00" =>
  datab := mem(vectb);
     when "01" =>
  btselb := to_integer(atmp_b(2 downto 2));
  datab(3 downto 0) := mem(vectb)(btselb*4+3 downto btselb*4);
     when "10" =>
  btselb := to_integer(atmp_b(2 downto 1));
  datab(1 downto 0) := mem(vectb)(btselb*2+1 downto btselb*2);
     when "11" =>
  btselb := to_integer(atmp_b(2 downto 0));
      datab(0) := mem(vectb)(btselb);
 end case;

 if (cfgbits(4) = '0') then
 -- async delays port A
     if (atmp_a'event) then
  dtout_a <= dataa after (xcmAddr2DoutRegD - xcmAddrTransDetect);
     elsif ((wtmp_a'event) AND (wtmp_a = '1')) then
  dtout_a <= dataa after xcmWriEna2DoutRegD;
     elsif ((dtin_a'event) AND (wtmp_a = '1')) then
  dtout_a <= dataa after xcmDin2DoutRegD;
     end if;
 else
 -- sync delays port A
     if (rising_edge(iclk_a)) then
  dtout_a <= dataa after xcmClkIn2DoutRegD;
     end if;
 end if;

 if (cfgbits(17) = '0') then
 -- async delays port B
     if (atmp_b'event) then
  dtout_b <= datab after (xcmAddr2DoutRegD - xcmAddrTransDetect);
     elsif ((wtmp_b'event) AND (wtmp_b = '1')) then
  dtout_b <= datab after xcmWriEna2DoutRegD;
     elsif ((dtin_b'event) AND (wtmp_b = '1')) then
  dtout_b <= datab after xcmDin2DoutRegD;
     end if;
 else
 -- sync delays port B
     if (rising_edge(iclk_b)) then
  dtout_b <= datab after xcmClkIn2DoutRegD;
     end if;
 end if;

    end process;

    -- condition the A ouput with errors that may have happened
    process (dtout_a,iclkerr_a,aserr_a,aherr_a,wserr_a,wherr_a,dserr_a,dherr_a,
      wrwerr_a,rcycerr_a,wcycerr_a,dwserr_a,dwherr_a,awserr_a,awherr_a)
    begin
 if ( iclkerr_a='1' OR aserr_a='1' OR aherr_a='1' OR wserr_a='1'
     OR wherr_a='1' OR dserr_a='1' OR dherr_a='1' OR wrwerr_a='1'
     OR rcycerr_a='1' OR wcycerr_a='1' OR dwserr_a='1' OR dwherr_a='1'
     OR awserr_a='1' OR awherr_a='1') then

     cdout_a <= (others => 'X');
 else
     cdout_a <= dtout_a;
 end if;
    end process;

    -- condition the B ouput with errors that may have happened
    process (dtout_b,iclkerr_b,aserr_b,aherr_b,wserr_b,wherr_b,dserr_b,dherr_b,
      wrwerr_b,rcycerr_b,wcycerr_b,dwserr_b,dwherr_b,awserr_b,awherr_b)
    begin
 if ( iclkerr_b='1' OR aserr_b='1' OR aherr_b='1' OR wserr_b='1'
     OR wherr_b='1' OR dserr_b='1' OR dherr_b='1' OR wrwerr_b='1'
     OR rcycerr_b='1' OR wcycerr_b='1' OR dwserr_b='1' OR dwherr_b='1'
     OR awserr_b='1' OR awherr_b='1') then

     cdout_b <= (others => 'X');
 else
     cdout_b <= dtout_b;
 end if;
    end process;

    process (reset_a,oclk_a,cdout_a,oclkerr_a,oserr_a,oherr_a,rsterr_a,rcverr_a)
    begin
 if (cfgbits(6) = '1') then
 -- Synchronous Read port A
     if (reset_a = '1') then
  dout_a <= (others => '0') after xcmReset2Dout;
     elsif (oclkerr_a = '1' OR oserr_a = '1' OR oherr_a = '1'
  OR rsterr_a = '1' OR rcverr_a = '1') then
  dout_a <= (others => 'X');
     elsif (rising_edge(oclk_a)) then
  dout_a <= cdout_a after xcmClkOut2Dout;
     end if;
 else
 -- Asynchronous Read port A
     dout_a <= cdout_a after xcmDoutRegD2Dout;
 end if;
    end process;

    process (reset_b,oclk_b,cdout_b,oclkerr_b,oserr_b,oherr_b,rsterr_b,rcverr_b)
    begin
 if (cfgbits(19) = '1') then
 -- Synchronous Read port B
     if (reset_b = '1') then
  dout_b <= (others => '0') after xcmReset2Dout;
     elsif (oclkerr_b = '1' OR oserr_b = '1' OR oherr_b = '1'
  OR rsterr_b = '1' OR rcverr_b = '1') then
  dout_b <= (others => 'X');
     elsif (rising_edge(oclk_b)) then
  dout_b <= cdout_b after xcmClkOut2Dout;
     end if;
 else
 -- Asynchronous Read port B
     dout_b <= cdout_b after xcmDoutRegD2Dout;
 end if;
    end process;

end sim;



library ieee;
use ieee.std_logic_1164.all;


use work.primitive.all;

entity c39kcr is
    generic (
 cfgbits : Bit_Vector(13 downto 0);
 memdata : clmem;
 -- asynchronous parameters
 xcrReadAddrWthHi : time; -- checked parameters
 xcrWritAddrWthHi : time;
 xcrWriEnaWthHi : time;
 xcrAddrAtWriEnaFallSetup: time;
 xcrAddrAtWriEnaRiseSetup: time;
 xcrAddrAtWriEnaFallHold : time;
 xcrDinAtWriEnaFallSetup : time;
 xcrDinAtWriEnaFallHold : time;
 xcrAddr2DoutRegD : time; -- applied parameters
 xcrWriEna2DoutRegD : time;
 xcrDin2DoutRegD : time;
 xcrDoutRegD2Dout : time;
 -- synchronous input parameters
 xcrClkInWthCy : time; -- checked parameters
 xcrClkInWthHi : time;
 xcrClkInWthLo : time;
 xcrAddrAtClkInSetup : time;
 xcrAddrAtClkInHold : time;
 xcrWriEnaAtClkInSetup : time;
 xcrWriEnaAtClkInHold : time;
 xcrDinAtClkInSetup : time;
 xcrDinAtClkInHold : time;
 xcrClkIn2DoutRegD : time; -- applied parameters
 -- synchronous output parameters
 xcrDoutRegCkWthHi : time; -- checked parameters
 xcrDoutRegCkWthLo : time;
 xcrDoutRegCkWthCy : time;
 xcrDoutRegSetup : time;
 xcrDoutRegHold : time;
 xcrDoutRegReRcr : time;
 xcrDoutRegReWthHi : time;
 xcrClkOut2Dout : time; -- applied parameters
 xcrReset2Dout : time;
 xcrAddrTransDetect : time);
    port (
 din : in std_logic_vector( 7 downto 0);
 addr : in std_logic_vector(12 downto 0);
 we : in std_logic;
 iclk : in std_logic;
 oclk : in std_logic;
 reset : in std_logic;
 dout : out std_logic_vector( 7 downto 0));
end c39kcr;

architecture sim of c39kcr is

    signal atmp : std_logic_vector(12 downto 0);
    signal dtin : std_logic_vector( 7 downto 0);
    signal dtout : std_logic_vector( 7 downto 0);
    signal cdout : std_logic_vector( 7 downto 0);
    signal wtmp : std_logic;
    signal atd : std_logic;

    -- Signals for use with negative setup and hold checks
    signal dsaddr :std_logic_vector(12 downto 0);
    signal daiclk :std_logic;
    signal dswe :std_logic;
    signal dwiclk :std_logic;
    signal dsdin :std_logic_vector( 7 downto 0);
    signal ddiclk :std_logic;
    signal dcdout :std_logic_vector( 7 downto 0);
    signal doclk :std_logic;
    signal dadin :std_logic_vector( 7 downto 0);
    signal ddwe :std_logic;
    signal daaddr :std_logic_vector(12 downto 0);
    signal dawer :std_logic;
    signal dawef :std_logic;

    -- Constants for use with negative setup and hold checks
    constant syncAddrSetup : time := timeAdjust(xcrAddrAtClkInSetup);
    constant syncAddrHold : time := timeAdjust(xcrAddrAtClkInHold);
    constant syncWESetup : time := timeAdjust(xcrWriEnaAtClkInSetup);
    constant syncWEHold : time := timeAdjust(xcrWriEnaAtClkInHold);
    constant syncDataSetup : time := timeAdjust(xcrDinAtClkInSetup);
    constant syncDataHold : time := timeAdjust(xcrDinAtClkInHold);
    constant dataOutSetup : time := timeAdjust(xcrDoutRegSetup);
    constant dataOutHold : time := timeAdjust(xcrDoutRegHold);
    constant asyncAddrSetupF : time := timeAdjust(xcrAddrAtWriEnaFallSetup);
    constant asyncAddrSetupR : time := timeAdjust(xcrAddrAtWriEnaRiseSetup);
    constant asyncAddrHold : time := timeAdjust(xcrAddrAtWriEnaFallHold);
    constant asyncDataSetup : time := timeAdjust(xcrDinAtWriEnaFallSetup);
    constant asyncDataHold : time := timeAdjust(xcrDinAtWriEnaFallHold);

    constant unk : string := " Setting output unknown.";

    signal iclkerr : std_logic;
    constant iclk_high : string :=
    "Input clock high width violation:" & unk;
    constant iclk_low : string :=
    "Input clock low width violation:" & unk;
    constant iclk_cycle : string :=
    "Input clock cycle width violation:" & unk;

    signal aserr : std_logic;
    constant address_setup : string :=
    "Address to input clock setup violation:" & unk;

    signal aherr : std_logic;
    constant address_hold : string :=
    "Input clock to address hold violation:" & unk;

    signal wserr : std_logic;
    constant write_setup : string :=
    "Write to input clock setup violation:" & unk;

    signal wherr : std_logic;
    constant write_hold : string :=
    "Input clock to write hold violation:" & unk;

    signal dserr : std_logic;
    constant data_setup : string :=
    "Data to input clock setup violation:" & unk;

    signal dherr : std_logic;
    constant data_hold : string :=
    "Input clock to data hold violation:" & unk;

    signal oclkerr : std_logic;
    constant oclk_high : string :=
    "Output clock high width violation:" & unk;
    constant oclk_low : string :=
    "Output clock low width violation:" & unk;
    constant oclk_cycle : string :=
    "Output clock cycle width violation:" & unk;

    signal rcverr : std_logic;
    constant outreg_rcvry : string :=
    "Output register reset recovery violation:" & unk;

    signal rsterr : std_logic;
    constant reset_width : string :=
    "Reset width violation:" & unk;

    signal oserr : std_logic;
    constant data2oclk_setup : string :=
    "Data to output clock setup violation:" & unk;

    signal oherr : std_logic;
    constant data2oclk_hold : string :=
    "Output clock to data hold violation:" & unk;

    signal wrwerr : std_logic;
    constant write_width : string :=
    "Minimum write width violation:" & unk;

    signal rcycerr : std_logic;
    constant read_cycle : string :=
    "Minimum read cycle violation:" & unk;

    signal wcycerr : std_logic;
    constant write_cycle : string :=
    "Minimum write cycle violation:" & unk;

    signal dwserr : std_logic;
    constant data2we_setup : string :=
    "Data to we setup violation:" & unk;

    signal dwherr : std_logic;
    constant data2we_hold : string :=
    "We to data hold violation:" & unk;

    signal awserr : std_logic;
    constant addr2westart_setup : string :=
    "Address to we start setup violation:" & unk;
    constant addr2weend_setup : string :=
    "Address to we end setup violation:" & unk;

    signal awherr : std_logic;
    constant addr2we_hold : string :=
    "We to address hold violation:" & unk;

begin

    -- check iclk cycle, high and low times.
    process (iclk)
 variable clkhi, clklo : time := 0 ns;
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if (iclk = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcrClkInWthHi)) then
      assert (false)
   report iclk_high
   severity warning;
      iclkerr <= '1';
      iclkerr <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (iclk = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcrClkInWthLo)) then
     assert (false)
   report iclk_low
   severity warning;
      iclkerr <= '1';
      iclkerr <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcrClkInWthCy)) then
      assert (false)
   report iclk_cycle
   severity warning;
      iclkerr <= '1';
      iclkerr <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check sync address setup
    daiclk <= iclk after syncAddrSetup;
    process (addr, daiclk)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(2) = '1') then
     if (rising_edge(daiclk)) then
  if ((addrev /= 0 ns) AND
   ((NOW-addrev) < xcrAddrAtClkInSetup+syncAddrSetup)) then
      assert (false)
   report address_setup
   severity warning;
      aserr <= '1';
      aserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check sync address hold
    dsaddr <= addr after syncAddrHold;
    process (dsaddr, iclk)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(2) = '1') then
     if (rising_edge(iclk)) then
      clckev := NOW;
     elsif (dsaddr'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcrAddrAtClkInHold+syncAddrHold)) then
      assert (false)
   report address_hold
   severity warning;
      aherr <= '1';
      aherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync write setup
    dwiclk <= iclk after syncWESetup;
    process (we, dwiclk)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(2) = '1') then
     if (rising_edge(dwiclk)) then
  if ((writev /= 0 ns) AND
   ((NOW-writev) < xcrWriEnaAtClkInSetup+syncWESetup)) then
      assert (false)
   report write_setup
   severity warning;
      wserr <= '1';
      wserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (we'event) then
      writev := NOW;
     end if;
 end if;
    end process;

    -- check sync write hold
    dswe <= we after syncWEHold;
    process (dswe, iclk)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(2) = '1') then
     if (rising_edge(iclk)) then
      clckev := NOW;
     elsif (dswe'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcrWriEnaAtClkInHold+syncWEHold)) then
      assert (false)
   report write_hold
   severity warning;
      wherr <= '1';
      wherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check sync data setup
    ddiclk <= iclk after syncDataSetup;
    process (din, ddiclk)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(3) = '1') then
     if (rising_edge(ddiclk)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcrDinAtClkInSetup+syncDataSetup)) then
      assert (false)
   report data_setup
   severity warning;
      dserr <= '1';
      dserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (din'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data hold
    dsdin <= din after syncDataHold;
    process (dsdin, iclk)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(3) = '1') then
     if (rising_edge(iclk)) then
      clckev := NOW;
     elsif (dsdin'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcrDinAtClkInHold+syncDataHold)) then
      assert (false)
   report data_hold
   severity warning;
      dherr <= '1';
      dherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check oclk cycle, high and low times.
    process (oclk)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(8) = '1') then
     if (oclk = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcrDoutRegCkWthHi)) then
      assert (false)
   report oclk_high
   severity warning;
      oclkerr <= '1';
      oclkerr <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (oclk = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xcrDoutRegCkWthLo)) then
     assert (false)
   report oclk_low
   severity warning;
      oclkerr <= '1';
      oclkerr <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xcrDoutRegCkWthCy)) then
      assert (false)
   report oclk_cycle
   severity warning;
      oclkerr <= '1';
      oclkerr <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

        -- check output register reset recovery and reset width
    process (reset, oclk)
 variable clrlastev, clklastev, clrhi : time := 0 ns;
    begin
     if (cfgbits(8) = '1') then
     if (reset'event) then
  clrlastev := NOW;
  if (reset = '1') then
      clrhi := NOW;
  else
      if NOT ((clrhi = 0 ns) OR ((NOW-clrhi) >= xcrDoutRegReWthHi)) then
   assert (false)
       report reset_width
       severity warning;
   rsterr <= '1';
   rsterr <= transport '0' AFTER 1 ns;
      end if;
  end if;
     end if;
     if ((reset = '0') AND rising_edge(oclk)) then
  if NOT((clrlastev = 0 ns) OR ((NOW-clrlastev) >= xcrDoutRegReRcr)) then
      assert (false)
   report outreg_rcvry
   severity warning;
      rcverr <= '1';
      rcverr <= transport '0' AFTER 1 ns;
  end if;
  clklastev := NOW;
     end if;
 end if;
    end process;

    -- check sync data to oclk setup
    doclk <= oclk after dataOutSetup;
    process (cdout, doclk)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(8) = '1') then
     if ((reset = '0') AND rising_edge(doclk)) then
  if ((dataev /= 0 ns) AND
   ((NOW-dataev) < xcrDoutRegSetup+dataOutSetup)) then
      assert (false)
   report data2oclk_setup
   severity warning;
      oserr <= '1';
      oserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (cdout'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check sync data to oclk hold
    dcdout <= cdout after dataOutHold;
    process (dcdout, oclk)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(8) = '1') then
     if ((reset = '0') AND rising_edge(oclk)) then
      clckev := NOW;
     elsif (dcdout'event) then
  if ((clckev /= 0 ns) AND
   ((NOW-clckev) < xcrDoutRegHold+dataOutHold)) then
      assert (false)
   report data2oclk_hold
   severity warning;
      oherr <= '1';
      oherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async write minimum valid
    process (we)
 variable write_ev : time := 0 ns;
    begin
 if ((cfgbits(2) = '0') AND (we = '0')) then
     if NOT ((write_ev = 0 ns) OR ((NOW - write_ev) >= xcrWriEnaWthHi)) then
  assert (false)
      report write_width
      severity warning;
  wrwerr <= '1';
  wrwerr <= transport '0' AFTER 1 ns;
     end if;
     write_ev := NOW;
 end if;
    end process;

    -- Generate the ATD
    process (addr)
    begin
     if (cfgbits(2) = '0') then
     atd <= '1';
     atd <= transport '0' after xcrAddrTransDetect;
 end if;
    end process;

    -- check async data to write setup
    ddwe <= we after asyncDataSetup;
    process (din, ddwe)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(3) = '0') then
     if (falling_edge(ddwe)) then
  if ((dataev /= 0 ns) AND
      ((NOW-dataev) < xcrDinAtWriEnaFallSetup+asyncDataSetup))then
      assert (false)
   report data2we_setup
   severity warning;
      dwserr <= '1';
      dwserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (din'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check async data to write hold
    dadin <= din after asyncDataHold;
    process (dadin, we)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(3) = '0') then
     if (falling_edge(we)) then
      writev := NOW;
     elsif (dadin'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcrDinAtWriEnaFallHold+asyncDataHold)) then
      assert (false)
   report data2we_hold
   severity warning;
      dwherr <= '1';
      dwherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check async address to write rising setup
    dawer <= we after asyncAddrSetupR;
    process (addr, dawer)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(2) = '0') then
     if (rising_edge(dawer)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcrAddrAtWriEnaRiseSetup+asyncAddrSetupR)) then
      assert (false)
   report addr2westart_setup
   severity warning;
      awserr <= '1';
      awserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write falling setup
    dawef <= we after asyncAddrSetupF;
    process (addr, dawef)
     variable addrev : time := 0 ns;
    begin
     if (cfgbits(2) = '0') then
     if (falling_edge(dawef)) then
  if ((addrev /= 0 ns) AND
  ((NOW-addrev) < xcrAddrAtWriEnaFallSetup+asyncAddrSetupF)) then
      assert (false)
   report addr2weend_setup
   severity warning;
      awserr <= '1';
      awserr <= transport '0' AFTER 1 ns;
  end if;
     elsif (addr'event) then
      addrev := NOW;
     end if;
 end if;
    end process;

    -- check async address to write hold
    daaddr <= addr after asyncAddrHold;
    process (daaddr, we)
     variable writev : time := 0 ns;
    begin
     if (cfgbits(2) = '0') then
     if (falling_edge(we)) then
      writev := NOW;
     elsif (daaddr'event) then
  if ((writev /= 0 ns) AND
      ((NOW-writev) < xcrAddrAtWriEnaFallHold+asyncAddrHold)) then
      assert (false)
   report addr2we_hold
   severity warning;
      awherr <= '1';
      awherr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    process (iclk, addr, we, atd)
    begin
 if (cfgbits(2) = '1') then
 -- Synchronous Address/Write
     if (rising_edge(iclk)) then
  atmp <= addr;
     end if;
     wtmp <= we AND iclk;
 else
 -- Asynchronous Address/Write
     if (falling_edge(atd) OR (xcrAddrTransDetect <= 0 ns)) then
  atmp <= addr;
     end if;
     wtmp <= we;
 end if;
    end process;

    process (iclk, din)
    begin
 if (cfgbits(3) = '1') then
 -- Synchronous Data
     if (rising_edge(iclk)) then
  dtin <= din;
     end if;
 else
 -- Asynchronous Data
     dtin <= din;
 end if;
    end process;

    process (dtin, atmp, wtmp, iclk)
 variable mem : clmem := memdata;
 variable vect : natural;
 variable btsel : natural;
 variable data : std_logic_vector(7 downto 0);
    begin

 vect := to_integer(atmp(12 downto 3));

 -- Write the array
 if (wtmp = '1') then
     case cfgbits(1 downto 0) is
  when "00" =>
      mem(vect) := dtin;
  when "01" =>
      btsel := to_integer(atmp(2 downto 2));
      mem(vect)(btsel*4+3 downto btsel*4) := dtin(3 downto 0);
  when "10" =>
      btsel := to_integer(atmp(2 downto 1));
      mem(vect)(btsel*2+1 downto btsel*2) := dtin(1 downto 0);
  when "11" =>
      btsel := to_integer(atmp(2 downto 0));
      mem(vect)(btsel) := dtin(0);
     end case;
 end if;

 data := (others => '0');

 -- Read the array
 case cfgbits(1 downto 0) is
     when "00" =>
  data := mem(vect);
     when "01" =>
  btsel := to_integer(atmp(2 downto 2));
  data(3 downto 0) := mem(vect)(btsel*4+3 downto btsel*4);
     when "10" =>
  btsel := to_integer(atmp(2 downto 1));
  data(1 downto 0) := mem(vect)(btsel*2+1 downto btsel*2);
     when "11" =>
  btsel := to_integer(atmp(2 downto 0));
      data(0) := mem(vect)(btsel);
 end case;

 if (cfgbits(3) = '0') then
 -- async delays
     if (atmp'event) then
  -- addresses have already been delayed, so account for it.
  dtout <= data after (xcrAddr2DoutRegD - xcrAddrTransDetect);
     elsif ((wtmp'event) AND (wtmp = '1')) then
  dtout <= data after xcrWriEna2DoutRegD;
     elsif ((dtin'event) AND (wtmp = '1')) then
  dtout <= data after xcrDin2DoutRegD;
     end if;
 else
 -- sync delays
     if (rising_edge(iclk)) then
  dtout <= data after xcrClkIn2DoutRegD;
     end if;
 end if;

    end process;

    -- condition the data with errors that may have happened
    process(dtout,iclkerr,aserr,aherr,wserr,wherr,dserr,dherr,
     wrwerr,rcycerr,wcycerr,dwserr,dwherr,awserr,awherr)
    begin
    if ( iclkerr='1' OR aserr='1' OR aherr='1' OR wserr='1'
 OR wherr='1' OR dserr='1' OR dherr='1' OR wrwerr='1'
 OR rcycerr='1' OR wcycerr='1' OR dwserr='1' OR dwherr='1'
 OR awserr='1' OR awherr='1') then
     cdout <= (others => 'X');
 else
     cdout <= dtout;
 end if;
    end process;

    process (reset, oclk, cdout, oclkerr, oserr, oherr, rsterr, rcverr)
    begin
 if (cfgbits(8) = '1') then
 -- Synchronous Read
     if (reset = '1') then
  dout <= (others => '0') after xcrReset2Dout;
     elsif (oclkerr = '1' OR oserr = '1' OR oherr = '1'
      OR rsterr = '1' OR rcverr = '1') then
      dout <= (others => 'X');
     elsif (rising_edge(oclk)) then
  dout <= cdout after xcrClkOut2Dout;
     end if;
 else
 -- Asynchronous Read
     dout <= cdout after xcrDoutRegD2Dout;
 end if;
    end process;

end sim;



library ieee;
use ieee.std_logic_1164.all;


use work.primitive.all;

entity c39kio is
    generic (
 cfgbits : Bit_Vector(35 downto 0);
 xioClockWthHi : time; -- Checked parameters
 xioClockWthLo : time;
 xioClockWthCy : time;
 xioResetRcr : time;
 xioResetWthHi : time;
 xioIoRegSetup : time;
 xioIoRegHold : time;
 xioIoRegEnSup : time;
 xioIoRegEnHld : time;
 xioOeRegSetup : time;
 xioOeRegHold : time;
 xioFromChip2Pin : time; -- applied parameters
 xioFromChip2IoRegD : time;
 xioIoRegCk2Pin : time;
 xioIoRegRe2Pin : time;
 xioIoRegRe2ToChip : time;
 xioOeRegCk2PinEA : time;
 xioOeRegCk2PinER : time;
 xioOeRegRe2PinER : time;
 xioOutEna2PinEA : time;
 xioOutEna2PinER : time;
 xioPin2IoRegD : time;
 xioIoRegCk2ToChip : time; -- May be Vert or Hori
 xioPin2ToChip : time; -- May be Vert or Hori
 xioAddOslow : time;
 xioAddEAslow : time;
 xioAddERslow : time;
 xioAdd : time);
    -- xioAdd is the delay added by bus hold and any IO standard.
    port (
 oe : in std_logic;
 din : in std_logic;
 en : in std_logic;
 clk : in std_logic;
 clr : in std_logic;
 fb : out std_logic;
 iop : inout std_logic);
end c39kio;

architecture sim of c39kio is

    signal d, qi, qo, q, ena : std_logic;
    signal iop_01, en_01, oe_01, clr_01 : std_logic;
    signal declk, den, ddclk, dd, doeclk, doe : std_logic;

    -- Adjust the setup and hold reference times if they are negative.
    constant enSetup : time := timeAdjust(xioIoRegEnSup);
    constant enHold : time := timeAdjust(xioIoRegEnHld);
    constant dSetup : time := timeAdjust(xioIoRegSetup);
    constant dHold : time := timeAdjust(xioIoRegHold);
    constant oeSetup : time := timeAdjust(xioOeRegSetup);
    constant oeHold : time := timeAdjust(xioOeRegHold);

    constant unk : string := " Setting output unknown.";

    signal clkerr : std_logic;
    constant clk_high : string :=
    "Clock high width violation:" & unk;
    constant clk_low : string :=
    "Clock low width violation:" & unk;
    constant clk_cycle : string :=
    "Clock cycle width violation:" & unk;

    signal clrerr : std_logic;
    constant reset_width : string :=
    "Reset width violation:" & unk;

    signal crcverr : std_logic;
    constant reset_rcvry : string :=
    "Reset recovery violation:" & unk;

    signal orstuperr : std_logic;
    constant odata2clk_setup : string :=
    "Output Data to clock setup violation:" & unk;

    signal orholderr : std_logic;
    constant odata2clk_hold : string :=
    "Clock to output data hold violation:" & unk;

    signal enstuperr : std_logic;
    constant enable2clk_setup : string :=
    "Enable to clock setup violation:" & unk;

    signal enholderr : std_logic;
    constant enable2clk_hold : string :=
    "Clock to enable hold violation:" & unk;

    signal oestuperr : std_logic;
    constant oe2clk_setup : string :=
    "OE to clock setup violation:" & unk;

    signal oeholderr : std_logic;
    constant oe2clk_hold : string :=
    "Clock to OE hold violation:" & unk;

begin

    -- don't propogate anything except 1, 0, or X.
    oe_01 <= to_X01(oe);
    iop_01 <= to_X01(iop);
    en_01 <= to_X01(en);
    clr_01 <= to_X01(clr);

    -- check clk cycle, high and low times.
    process (clk)
 variable clkhi, clklo : time := 0 ns;
    begin
 if ((cfgbits(2)= '1') OR (cfgbits(3)= '1') OR (cfgbits(17)= '1')) then
     if (clk = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xioClockWthHi)) then
      assert (false)
   report clk_high
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (clk = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xioClockWthLo)) then
     assert (false)
   report clk_low
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xioClockWthCy)) then
      assert (false)
   report clk_cycle
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check reset recovery and reset width
    process (clr_01, clk)
        variable clrlastev, clklastev, clrhi : time := 0 ns;
    begin
 if ((cfgbits(2)= '1') OR (cfgbits(3)= '1') OR (cfgbits(17)= '1')) then
            if (clr_01'event) then
                clrlastev := NOW;
                if (clr_01 = '1') then
                    clrhi := NOW;
                else
                    if NOT ((clrhi=0 ns) OR ((NOW-clrhi) >= xioResetWthHi)) then
                        assert (false)
                            report reset_width
                            severity warning;
                        clrerr <= '1';
                        clrerr <= transport '0' AFTER 1 ns;
                    end if;
                end if;
            end if;
            if ((clr_01 = '0') AND rising_edge(clk)) then
                if NOT((clrlastev=0 ns) OR ((NOW-clrlastev)>=xioResetRcr)) then
                    assert (false)
   report reset_rcvry
                        severity warning;
                    crcverr <= '1';
                    crcverr <= transport '0' AFTER 1 ns;
                end if;
                clklastev := NOW;
            end if;
        end if;
    end process;

    -- Enable setup check
    declk <= clk after enSetup;
    process (en_01, declk)
     variable enevent : time := 0 ns;
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if ((clr_01 = '0') AND rising_edge(declk)) then
  if ((enevent /= 0 ns) AND
      ((NOW-enevent) < xioIoRegEnSup-enSetup)) then
      assert (false)
   report enable2clk_setup
   severity warning;
      enstuperr <= '1';
      enstuperr <= transport '0' AFTER 1 ns;
  end if;
     elsif (en_01'event) then
  enevent := NOW;
     end if;
 end if;
    end process;

    -- Enable hold check
    den <= en_01 after enHold;
    process (den, clk)
     variable clkevent : time := 0 ns;
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if ((clr_01 = '0') AND rising_edge(clk)) then
  clkevent := NOW;
     elsif (den'event) then
  if ((clkevent /= 0 ns) AND
      ((NOW-clkevent) < xioIoRegEnHld-enHold)) then
      assert (false)
   report enable2clk_hold
   severity warning;
      enholderr <= '1';
      enholderr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- Data setup check
    ddclk <= clk after dSetup;
    process (d, ddclk)
     variable dataevent : time := 0 ns;
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if ((clr_01='0') AND (en_01='1') AND rising_edge(ddclk)) then
  if ((dataevent /= 0 ns) AND
      ((NOW-dataevent) < xioIoRegSetup+dSetup)) then
      assert (false)
   report odata2clk_setup
   severity warning;
      orstuperr <= '1';
      orstuperr <= transport '0' AFTER 1 ns;
  end if;
     elsif (d'event) then
  dataevent := NOW;
     end if;
 end if;
    end process;

    -- Data hold check
    dd <= d after dHold;
    process (dd, clk)
     variable clkevent : time := 0 ns;
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if ((clr_01='0') AND (en_01='1') AND rising_edge(clk)) then
  clkevent := NOW;
     elsif (dd'event) then
  if ((clkevent /= 0 ns) AND
      ((NOW-clkevent) < xioIoRegHold+dHold)) then
      assert (false)
   report odata2clk_hold
   severity warning;
      orholderr <= '1';
      orholderr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- OE setup check
    doeclk <= clk after oeSetup;
    process (oe_01, doeclk)
     variable oeevent : time := 0 ns;
    begin
     if (cfgbits(17) = '0') then
     if ((clr_01 = '0') AND rising_edge(doeclk)) then
  if ((oeevent /= 0 ns) AND
      ((NOW-oeevent) < xioOeRegSetup+oeSetup)) then
      assert (false)
   report oe2clk_setup
   severity warning;
      oestuperr <= '1';
      oestuperr <= transport '0' AFTER 1 ns;
  end if;
     elsif (oe_01'event) then
  oeevent := NOW;
     end if;
 end if;
    end process;

    -- OE hold check
    doe <= oe_01 after oeHold;
    process (doe, clk)
     variable clkevent : time := 0 ns;
    begin
     if (cfgbits(17) = '0') then
     -- setup check
     if ((clr_01 = '0') AND rising_edge(clk)) then
  clkevent := NOW;
     elsif (doe'event) then
  if ((clkevent /= 0 ns) AND
      ((NOW-clkevent) < xioOeRegHold+oeHold)) then
      assert (false)
   report oe2clk_hold
   severity warning;
      oeholderr <= '1';
      oeholderr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- generate the "D" input
    with cfgbits(1) select
 d <= din after xioFromChip2IoRegD when '1',
      iop_01 after xioPin2IoRegD when '0';

    -- generate the I/O register
    process (d, clr_01, clk, clkerr, crcverr, clrerr,
  enstuperr, enholderr, orstuperr, orholderr)
    begin
 if ((cfgbits(2) = '1') OR (cfgbits(3) = '1')) then
     if (clr_01 = '1') then
  qo <= '0' after xioIoRegRe2Pin;
  qi <= '0' after xioIoRegRe2ToChip;
     elsif (clkerr='1' OR crcverr='1' OR clrerr='1' OR enstuperr='1'
      OR enholderr='1' OR orstuperr='1' OR orholderr='1') then
  qo <= 'X' after xioIoRegCk2Pin;
  qi <= 'X' after xioIoRegCk2ToChip;
     elsif ((en_01 = '1') AND rising_edge(clk)) then
  qo <= d after xioIoRegCk2Pin;
  qi <= d after xioIoRegCk2ToChip;
     end if;
 end if;
    end process;

    -- generate the output select muxes
    process (qo, qi, din, iop_01)
    begin
 case cfgbits(3 downto 2) is
 when "00" =>
     fb <= iop_01 after xioPin2ToChip;
     q <= din after xioFromChip2Pin;
 when "01" =>
     fb <= qi;
     q <= din after xioFromChip2Pin;
 when "10" =>
     fb <= iop_01 after xioPin2ToChip;
     q <= qo;
 when "11" =>
     fb <= qi;
     q <= qo;
 end case;
    end process;

    -- generate the output enable register
    process (oe_01, clr_01, clk, oestuperr, oeholderr, clkerr, crcverr, clrerr)
    begin
     if (cfgbits(17) = '1') then -- not registered
     if (cfgbits(6) = '0') then
  if (oe_01 = '1') then
      ena <= oe_01 after xioOutEna2PinEA;
  else
      ena <= oe_01 after xioOutEna2PinER;
  end if;
     else
  if (cfgbits(5) = '0') then
      if (oe_01 = '1') then
   ena <= oe_01 after xioOutEna2PinEA;
      else
   ena <= oe_01 after xioOutEna2PinER;
      end if;
  else
      if (cfgbits(4) = '1') then
   ena <= '0';
      else
   ena <= '1';
      end if;
  end if;
     end if;
 else -- registered
     if (clr_01 = '1') then
  ena <= '0' after xioOeRegRe2PinER;
     elsif (clkerr='1' OR crcverr='1' OR clrerr='1'
        OR oestuperr='1' OR oeholderr='1') then
      ena <= 'X' after xioOeRegCk2PinER;
     elsif (rising_edge(clk)) then
  if (oe_01 = '1') then
      ena <= oe_01 after xioOeRegCk2PinEA;
  else
      ena <= oe_01 after xioOeRegCk2PinER;
  end if;
     end if;
 end if;
    end process;

    -- generate the TRI-STATE buffer
    process (ena, q)
     variable lastout : std_logic := '0';
    begin
     if (ena'event) then
     if (ena = '1') then
  if (cfgbits(0) = '1') then
      iop <= q after xioadd + xioAddEAslow;
  else
      iop <= q after xioAdd;
  end if;
  lastout := q;
     elsif (ena = 'X') then
  if (cfgbits(0) = '1') then
      iop <= 'X' after xioadd + xioAddERslow;
  else
      iop <= 'X' after xioAdd;
  end if;
      lastout := 'X';
     else
  if (cfgbits(16) = '0') then
      if (lastout = 'X') then
   iop <= 'W' after xioAdd;
      elsif (lastout = '1') then
   iop <= 'H' after xioAdd;
      else
   iop <= 'L' after xioAdd;
      end if;
  else
      iop <= 'Z' after xioAdd;
  end if;
     end if;
 else
     if (ena = '1') then
  if (cfgbits(0) = '1') then
      iop <= q after xioAdd + xioAddOslow;
  else
      iop <= q after xioAdd;
  end if;
  lastout := q;
     elsif (ena = 'X') then
      iop <= 'X';
      lastout := 'X';
     else
  if (cfgbits(16) = '0') then
      if (lastout = 'X') then
   iop <= 'W';
      elsif (lastout = '1') then
   iop <= 'H';
      else
   iop <= 'L';
      end if;
  else
      iop <= 'Z';
  end if;
     end if;
 end if;
    end process;

end sim;



library ieee;
use ieee.std_logic_1164.all;


use work.primitive.all;

entity c39kmc is
    generic (
 cfgbits : Bit_Vector(11 downto 0);
 xlbRegSetup : time; -- checked parameters
 xlbRegHold : time;
 xlbRegCkWthHi : time;
 xlbRegCkWthLo : time;
 xlbRegCkWthCy : time;
 xlbRegPrRcr : time;
 xlbRegPrWthHi : time;
 xlbRegReRcr : time;
 xlbRegReWthHi : time;
 xlbSelin2Selout : time; -- applied parameters
 xlbCpt2Selout : time;
 xlbCpt2RegD : time;
 xlbEqn2RegD : time;
 xlbSelin2RegD : time;
 xlbRegQ2RegD : time;
 xlbRegD2ToPim : time;
 xlbRegCk2ToPim : time;
 xlbRegPr2ToPim : time;
 xlbRegRe2ToPim : time);
    port (
 selin : in std_logic;
 cpt : in std_logic_vector(1 downto 0);
 set : in std_logic;
 clr : in std_logic;
 clk : in std_logic;
 din : in std_logic;
 selout : out std_logic;
 qout : out std_logic);
end c39kmc;

architecture sim of c39kmc is

    signal qp : std_logic := '0';
    signal qn : std_logic := '1';
    signal cmxout,c3 : std_logic;
    signal regd : std_logic;
    signal xorin : std_logic_vector(1 downto 0);
    signal dclk : std_logic;
    signal dregd : std_logic;

    constant dataSetup : time := timeAdjust(xlbRegSetup);
    constant dataHold : time := timeAdjust(xlbRegHold);
    constant unk : string := " Setting output unknown.";

    signal clkerr : std_logic;
    constant clk_high : string :=
    "Clock high width violation:" & unk;
    constant clk_low : string :=
    "Clock low width violation:" & unk;
    constant clk_cycle : string :=
    "Clock cycle width violation:" & unk;

    signal stuperr : std_logic;
    constant data_setup : string :=
    "Data to clock setup violation:" & unk;

    signal holderr : std_logic;
    constant data_hold : string :=
    "Clock to data hold violation:" & unk;

    signal clrerr : std_logic;
    constant reset_width : string :=
    "Reset width violation:" & unk;

    signal crcverr : std_logic;
    constant reset_rcvry : string :=
    "Reset recovery violation:" & unk;

    signal seterr : std_logic;
    constant preset_width : string :=
    "Preset width violation:" & unk;

    signal srcverr : std_logic;
    constant preset_rcvry : string :=
    "Preset recovery violation:" & unk;

begin

    -- check clk cycle, high and low times.
    process (clk)
 variable clkhi, clklo : time := 0 ns;
    begin
 if (cfgbits(11) = '1') then
     if (clk = '0') then
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xlbRegCkWthHi)) then
      assert (false)
   report clk_high
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  clklo := NOW;
     elsif (clk = '1') then
  if NOT ((clklo = 0 ns) OR ((NOW-clklo) >= xlbRegCkWthLo)) then
     assert (false)
   report clk_low
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  if NOT ((clkhi = 0 ns) OR ((NOW-clkhi) >= xlbRegCkWthCy)) then
      assert (false)
   report clk_cycle
   severity warning;
      clkerr <= '1';
      clkerr <= transport '0' AFTER 1 ns;
  end if;
  clkhi := NOW;
     end if;
 end if;
    end process;

    -- check setup
    dclk <= clk after dataSetup;
    process (regd, dclk)
     variable dataev : time := 0 ns;
    begin
     if (cfgbits(11) = '1') then
     if ((clr = '0') AND (set = '0') AND rising_edge(dclk)) then
  if ((dataev/=0 ns) AND ((NOW-dataev)<xlbRegSetup+dataSetup))then
      assert (false)
   report data_setup
   severity warning;
      stuperr <= '1';
      stuperr <= transport '0' AFTER 1 ns;
  end if;
     elsif (regd'event) then
      dataev := NOW;
     end if;
 end if;
    end process;

    -- check hold
    dregd <= regd after dataHold;
    process (dregd, clk)
     variable clckev : time := 0 ns;
    begin
     if (cfgbits(11) = '1') then
     if ((clr = '0') AND (set = '0') AND rising_edge(clk)) then
      clckev := NOW;
     elsif (dregd'event) then
  if ((clckev/=0 ns) AND ((NOW-clckev)<xlbRegHold+dataHold)) then
      assert (false)
   report data_hold
   severity warning;
      holderr <= '1';
      holderr <= transport '0' AFTER 1 ns;
  end if;
     end if;
 end if;
    end process;

    -- check reset recovery and reset width
    process (clr, clk)
        variable clrlastev, clklastev, clrhi : time := 0 ns;
    begin
        if (cfgbits(11) = '1') then
            if (clr'event) then
                clrlastev := NOW;
                if (clr = '1') then
                    clrhi := NOW;
                else
                    if NOT ((clrhi=0 ns) OR ((NOW-clrhi) >= xlbRegReWthHi)) then
                        assert (false)
                            report reset_width
                            severity warning;
                        clrerr <= '1';
                        clrerr <= transport '0' AFTER 1 ns;
                    end if;
                end if;
            end if;
            if ((clr = '0') AND rising_edge(clk)) then
                if NOT((clrlastev=0 ns) OR ((NOW-clrlastev)>=xlbRegReRcr)) then
                    assert (false)
   report reset_rcvry
                        severity warning;
                    crcverr <= '1';
                    crcverr <= transport '0' AFTER 1 ns;
                end if;
                clklastev := NOW;
            end if;
        end if;
    end process;

    -- check preset recovery and preset width
    process (set, clk)
        variable setlastev, clklastev, sethi : time := 0 ns;
    begin
        if (cfgbits(11) = '1') then
            if (set'event) then
                setlastev := NOW;
                if (set = '1') then
                    sethi := NOW;
                else
                    if NOT ((sethi=0 ns) OR ((NOW-sethi) >= xlbRegPrWthHi)) then
                        assert (false)
                            report preset_width
                            severity warning;
                        seterr <= '1';
                        seterr <= transport '0' AFTER 1 ns;
                    end if;
                end if;
            end if;
            if ((set = '0') AND rising_edge(clk)) then
                if NOT((setlastev=0 ns) OR ((NOW-setlastev)>=xlbRegPrRcr)) then
                    assert (false)
   report preset_rcvry
                        severity warning;
                    srcverr <= '1';
                    srcverr <= transport '0' AFTER 1 ns;
                end if;
                clklastev := NOW;
            end if;
        end if;
    end process;

    -- generate selout and carry chain mux output
    process (cpt, selin)
    begin
 if (cfgbits(2) = '0') then
     selout <= cpt(0) after xlbCpt2Selout;
     cmxout <= cpt(0) after xlbCpt2RegD;
     elsif ( selin'event AND (selin = '0')) then
     selout <= transport cpt(0) after xlbSelin2Selout;
     cmxout <= transport cpt(0) after xlbSelin2RegD;
     elsif ( selin'event AND (selin = '1')) then
     selout <= transport NOT cpt(1) after xlbSelin2Selout;
     cmxout <= transport NOT cpt(1) after xlbSelin2RegD;
     elsif (cpt(0)'event AND (selin = '0')) then
     selout <= transport cpt(0) after xlbCpt2Selout;
     cmxout <= transport cpt(0) after xlbCpt2RegD;
     elsif (cpt(1)'event AND (selin = '1')) then
     selout <= transport NOT cpt(1) after xlbCpt2Selout;
     cmxout <= transport NOT cpt(1) after xlbCpt2RegD;
 end if;
    end process;

    -- generate the XOR inputs
    c3 <= '1' when cfgbits(3) = '1' else '0';

    with cfgbits(1 downto 0) select
     xorin(1) <= qp after xlbRegQ2RegD when "00",
  qn after xlbRegQ2RegD when "01",
  cmxout when "10",
  c3 when "11";

    xorin(0) <= din after xlbEqn2RegD;

    -- generate the "D" input
    regd <= xorin(1) XOR xorin(0);

    -- generate the register
    process (set,clr,clk,regd,qp,
  stuperr,holderr,crcverr,srcverr,seterr,clrerr,clkerr)
    begin
     if (cfgbits(11) = '1') then
     if (clr = '1') then
  qp <= '0' after xlbRegRe2ToPim;
  qn <= '1' after xlbRegRe2ToPim;
     elsif (set = '1') then
  qp <= '1' after xlbRegPr2ToPim;
  qn <= '0' after xlbRegPr2ToPim;
     elsif(stuperr='1' OR holderr='1' OR crcverr='1' OR srcverr='1' OR
     seterr='1' OR clrerr='1' OR clkerr='1') then
      qp <= 'X' after xlbRegCk2ToPim;
      qn <= 'X' after xlbRegCk2ToPim;
     elsif (rising_edge(clk)) then
  qp <= regd after xlbRegCk2ToPim;
  qn <= NOT regd after xlbRegCk2ToPim;
     end if;
     qout <= qp;
 else
     qout <= regd after xlbRegD2ToPim;
 end if;
    end process;

end sim;
