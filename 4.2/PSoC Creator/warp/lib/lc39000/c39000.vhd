--

--------------------------------------------------------------------------
-- Components for Generic RTL. --
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
PACKAGE rtlpkg IS
component cy_bufoe
    port (x : in std_logic;
     oe : in std_logic;
     y : inout std_logic;
     yfb : out std_logic);
end component;

    attribute atomic_rtl of cy_bufoe : component is bufoe_type;
component cy_dltch
    port (d : in std_logic;
     e : in std_logic;
     q : out std_logic);
end component;
component cy_dsrlch
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     q : out std_logic);
end component;
component cy_dff
    port (d : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;

    attribute atomic_rtl of cy_dff : component is dff_type;
component cy_xdff
    port (x1 : in std_logic;
     x2 : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
component cy_jkff
    port (j : in std_logic;
     k : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
component cy_buf
    port (x : in std_logic;
     y : out std_logic);
end component;

    attribute atomic_rtl of cy_buf : component is buf_type;
component cy_srlch
    port (s : in std_logic;
     r : in std_logic;
     q : out std_logic);
end component;
component cy_srff
    port (s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
component cy_dsrff
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;

    attribute atomic_rtl of cy_dsrff : component is dsrff_type;
component cy_tsrff
    port (t : in std_logic;
     s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;

    attribute atomic_rtl of cy_tsrff : component is tsrff_type;
component cy_tff
    port (t : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;

    attribute atomic_rtl of cy_tff : component is tff_type;
component cy_xbuf
    port (x1 : in std_logic;
     x2 : in std_logic;
     q : out std_logic);
end component;
component cy_triout
    port (x : in std_logic;
     oe : in std_logic;
     y : out std_logic);
end component;

    attribute atomic_rtl of cy_triout : component is triout_type;
component cy_dsrffe
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;

    attribute atomic_rtl of cy_dsrffe : component is rtl_generic;
component cy_c39kcarry
    port (SelIn : in std_logic;
     Cpt0 : in std_logic;
     Cpt1 : in std_logic;
     SelOut : out std_logic);
end component;

    attribute atomic_rtl of cy_c39kcarry : component is rtl_generic;
component cy_c39kxor
    port (SIn : in std_logic;
     PtmPts : in std_logic;
     XorOut : out std_logic);
end component;

    attribute atomic_rtl of cy_c39kxor : component is rtl_generic;
component cy_c39kmultiply
    generic(IsSigned : BOOLEAN := FALSE;
 DataWidthA : positive;
 DataWidthB : positive;
 DataWidthP : positive;

 Hint : goal_type := memory);

    port (Data_A : in std_logic_vector(DataWidthA-1 downto 0);
     Data_B : in std_logic_vector(DataWidthB-1 downto 0);
     Product : out std_logic_vector(DataWidthP-1 downto 0));
end component;

    attribute atomic_rtl of cy_c39kmultiply : component is rtl_generic;
TYPE fdbk_source IS (DIRECT, CLOCK_TREE, EXTERNAL);
component cy_c39kpll
    generic(feedback : fdbk_source := DIRECT;
     multiply : positive := 1;
     gclk0_phase : natural := 0;
     gclk0_divide: positive := 1;
     gclk1_phase : natural := 0;
     gclk1_divide: positive := 1;
     gclk2_phase : natural := 0;
     gclk2_divide: positive := 1;
     gclk3_phase : natural := 0;
     gclk3_divide: positive := 1;
     input_freq : natural := 0;
     ext_fdbk_delay_ps : natural := 0;
     ext_fdbk_port_out : string:="");
    port (pll_in : in std_logic;
     ext_fdbk : in std_logic := '0';
     lock_detect : out std_logic;
     gclk0 : out std_logic;
     gclk1 : out std_logic;
     gclk2 : out std_logic;
     gclk3 : out std_logic);
end component;

    attribute atomic_rtl of cy_c39kpll : component is rtl_generic;
component cy_25g01serdes

    port (txd : in std_logic_vector (15 downto 0) ;
     fifo_rstb : in std_logic ;
     loop_time : in std_logic ;
     diagloop : in std_logic ;
     loopa : in std_logic ;
     lineloop : in std_logic ;
     resetb : in std_logic ;
     pwrdnb : in std_logic ;
     lockrefb : in std_logic ;
     refclk_n : in std_logic ;
     refclk_p : in std_logic ;
     serial_in_n : in std_logic ;
     serial_in_p : in std_logic ;
     sd : in std_logic ;
     serial_out_n: out std_logic ;
     serial_out_p: out std_logic ;
     fifo_err : out std_logic ;
     txclk : out std_logic ;
     rxd : out std_logic_vector (15 downto 0) ;
     rxclk : out std_logic ;
     lfib : out std_logic );

end component;
    attribute atomic_rtl of cy_25g01serdes : component is rtl_generic;
component cy_2gserdes

    port (txd : in std_logic_vector (15 downto 0) ;
     fifo_rstb : in std_logic ;
     loop_time : in std_logic ;
     diagloop : in std_logic ;
     loopa : in std_logic ;
     lineloop : in std_logic ;
     resetb : in std_logic ;
     pwrdnb : in std_logic ;
     lockrefb : in std_logic ;
     refclk_n : in std_logic ;
     refclk_p : in std_logic ;
     serial_in_n : in std_logic ;
     serial_in_p : in std_logic ;
     sd : in std_logic ;
     serial_out_n: out std_logic ;
     serial_out_p: out std_logic ;
     fifo_err : out std_logic ;
     txclk : out std_logic ;
     rxd : out std_logic_vector (15 downto 0) ;
     rxclk : out std_logic ;
     lfib : out std_logic );

end component;
    attribute atomic_rtl of cy_2gserdes : component is rtl_generic;
    attribute replacement_rtl of cy_2gserdes : component is "cy_25g01serdes";
component cy_15g04serdes

    port ( txda : in std_logic_vector(7 downto 0) := (others => '0');
     txdb : in std_logic_vector(7 downto 0) := (others => '0');
     txdc : in std_logic_vector(7 downto 0) := (others => '0');
     txdd : in std_logic_vector(7 downto 0) := (others => '0');
     txpera : out std_logic;
     txperb : out std_logic;
     txperc : out std_logic;
     txperd : out std_logic;
     txcta : in std_logic_vector(1 downto 0) := (others => '0');
     txctb : in std_logic_vector(1 downto 0) := (others => '0');
     txctc : in std_logic_vector(1 downto 0) := (others => '0');
     txctd : in std_logic_vector(1 downto 0) := (others => '0');

     txclka : in std_logic;

     txclko_p : out std_logic;

     txrate : in std_logic;
     txmode : in std_logic_vector(1 downto 0);
     txcksel : in std_logic;
     txrstb : in std_logic;

     rxda : out std_logic_vector(7 downto 0);
     rxdb : out std_logic_vector(7 downto 0);
     rxdc : out std_logic_vector(7 downto 0);
     rxdd : out std_logic_vector(7 downto 0);
     rxsta : out std_logic_vector(2 downto 0);
     rxstb : out std_logic_vector(2 downto 0);
     rxstc : out std_logic_vector(2 downto 0);
     rxstd : out std_logic_vector(2 downto 0);

     rxrate : in std_logic;
     rfen : in std_logic;
     rxmode : in std_logic_vector(1 downto 0);
     rxcksel : in std_logic;
     framchar : in std_logic;
     rfmode : in std_logic;
     decmode : in std_logic;

     spdsel : in std_logic;
     rxclka_p : out std_logic;
     rxclkb_p : inout std_logic;
     rxclkc_p : out std_logic;
     rxclkd_p : inout std_logic;

     refclk_p : in std_logic;
     refclk_n : in std_logic;
     serial_outa1_p : out std_logic;
     serial_outb1_p : out std_logic;
     serial_outc1_p : out std_logic;
     serial_outd1_p : out std_logic;
     serial_outa2_p : out std_logic;
     serial_outb2_p : out std_logic;
     serial_outc2_p : out std_logic;
     serial_outd2_p : out std_logic;
     serial_ina1_p : in std_logic;
     serial_inb1_p : in std_logic;
     serial_inc1_p : in std_logic;
     serial_ind1_p : in std_logic;
     serial_ina2_p : in std_logic;
     serial_inb2_p : in std_logic;
     serial_inc2_p : in std_logic;
     serial_ind2_p : in std_logic;
     serial_outa1_n : out std_logic;
     serial_outb1_n : out std_logic;
     serial_outc1_n : out std_logic;
     serial_outd1_n : out std_logic;
     serial_outa2_n : out std_logic;
     serial_outb2_n : out std_logic;
     serial_outc2_n : out std_logic;
     serial_outd2_n : out std_logic;
     serial_ina1_n : in std_logic;
     serial_inb1_n : in std_logic;
     serial_inc1_n : in std_logic;
     serial_ind1_n : in std_logic;
     serial_ina2_n : in std_logic;
     serial_inb2_n : in std_logic;
     serial_inc2_n : in std_logic;
     serial_ind2_n : in std_logic;
     insela : in std_logic;
     inselb : in std_logic;
     inselc : in std_logic;
     inseld : in std_logic;
     sdasel : in std_logic;
     lpen : in std_logic;
     oele : in std_logic;
     bistle : in std_logic;
     rxle : in std_logic;
     boe : in std_logic_vector(7 downto 0);
     bondst : inout std_logic_vector(1 downto 0);
     masterb : in std_logic;
     bond_all : inout std_logic;
     bond_inhb : in std_logic;
     lfiab : out std_logic;
     lfibb : out std_logic;
     lficb : out std_logic;
     lfidb : out std_logic;
     trstzb : in std_logic);

end component;

    attribute atomic_rtl of cy_15g04serdes : component is rtl_generic;
component cy_c39kdualport
    generic(DataWidth : positive := 8;
 AddressWidth : positive := 11;
 indata_reg : BOOLEAN := TRUE;
 addr_ctrl_reg : BOOLEAN := TRUE;
 outdataA_reg : BOOLEAN := FALSE;
 outdataB_reg : BOOLEAN := FALSE;
 FileName : string := "");
    port (DIn_A : in std_logic_vector(DataWidth-1 downto 0) :=(others => '0');
     DIn_B : in std_logic_vector(DataWidth-1 downto 0) :=(others => '0');
     Addr_A : in std_logic_vector(AddressWidth-1 downto 0):=(others=>'0');
     Addr_B : in std_logic_vector(AddressWidth-1 downto 0):=(others=>'0');
     WEA : in std_logic := '0';
     WEB : in std_logic := '0';
     InClk_A : in std_logic := '0';
     OutClk_A : in std_logic := '0';
     OutRegA_AR : in std_logic := '0';
     InClk_B : in std_logic := '0';
     OutClk_B : in std_logic := '0';
     OutRegB_AR : in std_logic := '0';
     Addr_matchb : out std_logic;
     DOut_A : out std_logic_vector(DataWidth-1 downto 0);
     DOut_B : out std_logic_vector(DataWidth-1 downto 0));
end component;

    attribute atomic_rtl of cy_c39kdualport : component is rtl_generic;
component cy_c39kfifo
    generic(DataWidth : positive := 8;
 NumWords : positive := 512;
 PAFE_Distance : natural := 0);
    port (DIn : in std_logic_vector(DataWidth-1 downto 0);
     DOut : out std_logic_vector(DataWidth-1 downto 0);
     ENR : in std_logic := '0';
     ENW : in std_logic := '0';
     CKR : in std_logic := '0';
     CKW : in std_logic := '0';
     MRb : in std_logic := '0';
     EFb : out std_logic;
     HFb : out std_logic;
     PAFEb : out std_logic);
end component;

    attribute atomic_rtl of cy_c39kfifo : component is rtl_generic;
component cy_c39ksingleport
    generic(DataWidth : positive := 8;
 AddressWidth : positive := 13;
 indata_reg : BOOLEAN := TRUE;
 addr_ctrl_reg : BOOLEAN := TRUE;
 outdata_reg : BOOLEAN := FALSE;
 FileName : string := "");
    port (Din : in std_logic_vector(DataWidth-1 downto 0):=(others => '0');
     Addr : in std_logic_vector(AddressWidth-1 downto 0);
     WE : in std_logic := '0';
     InClk : in std_logic := '0';
     OutClk : in std_logic := '0';
     OutReg_AR : in std_logic := '0';
     DOut : out std_logic_vector(DataWidth-1 downto 0));
end component;

    attribute atomic_rtl of cy_c39ksingleport : component is rtl_generic;

END rtlpkg;

--------------------------------------------------------------------------
-- Force synthesis to use the device library.
--------------------------------------------------------------------------
use work.rtlpkg.all;
entity dummy is
end dummy;
