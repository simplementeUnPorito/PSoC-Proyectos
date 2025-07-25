--
library ieee;
use ieee.std_logic_1164.all;
PACKAGE rtlpkg IS

attribute atomic_rtl of rtlpkg:PACKAGE is NOT_RTL_type;
component cy_bufoe
    port (x : in std_logic;
     oe : in std_logic;
     y : inout std_logic;
     yfb : out std_logic);
end component;
component cy_dltch
    port (d : in std_logic;
     e : in std_logic;
     q : out std_logic);
end component;
component cy_dff
    port (d : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
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
component cy_tsrff
    port (t : in std_logic;
     s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
component cy_tff
    port (t : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
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
component cy_dsrlch
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     q : out std_logic);
end component;
component cy_dsrffe
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end component;
component cy_c39kcarry
    port (SelIn : in std_logic;
     Cpt0 : in std_logic;
     Cpt1 : in std_logic;
     SelOut : out std_logic);
end component;
component cy_c39kxor
    port (SIn : in std_logic;
     PtmPts : in std_logic;
     XorOut : out std_logic);
end component;
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
component cy_psoc3_dp
    generic(cy_dpconfig : std_logic_vector (207 downto 0) :=
     X"0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_0000_0000_0000";
     d0_init : std_logic_vector (7 downto 0) := (others => '0');
     d1_init : std_logic_vector (7 downto 0) := (others => '0');
     a0_init : std_logic_vector (7 downto 0) := (others => '0');
     a1_init : std_logic_vector (7 downto 0) := (others => '0');
     ce0_sync : std_logic := '1';
     cl0_sync : std_logic := '1';
     z0_sync : std_logic := '1';
     ff0_sync : std_logic := '1';
     ce1_sync : std_logic := '1';
     cl1_sync : std_logic := '1';
     z1_sync : std_logic := '1';
     ff1_sync : std_logic := '1';
     ov_msb_sync : std_logic := '1';
     co_msb_sync : std_logic := '1';
     cmsb_sync : std_logic := '1';
     so_sync : std_logic := '1';
     f0_bus_sync : std_logic := '1';
     f0_blk_sync : std_logic := '1';
     f1_bus_sync : std_logic := '1';
     f1_blk_sync : std_logic := '1');
    port (reset : in std_logic := '0';
     clk : in std_logic := '0';
     cs_addr : in std_logic_vector (2 downto 0) := "000";
     route_si : in std_logic := '0';
     route_ci : in std_logic := '0';
     f0_load : in std_logic := '0';
     f1_load : in std_logic := '0';
     d0_load : in std_logic := '0';
     d1_load : in std_logic := '0';
     ce0 : out std_logic;
     cl0 : out std_logic;
     z0 : out std_logic;
     ff0 : out std_logic;
     ce1 : out std_logic;
     cl1 : out std_logic;
     z1 : out std_logic;
     ff1 : out std_logic;
     ov_msb : out std_logic;
     co_msb : out std_logic;
     cmsb : out std_logic;
     so : out std_logic;
     f0_bus_stat : out std_logic;
     f0_blk_stat : out std_logic;
     f1_bus_stat : out std_logic;
     f1_blk_stat : out std_logic;
     ce0_reg : out std_logic;
     cl0_reg : out std_logic;
     z0_reg : out std_logic;
     ff0_reg : out std_logic;
     ce1_reg : out std_logic;
     cl1_reg : out std_logic;
     z1_reg : out std_logic;
     ff1_reg : out std_logic;
     ov_msb_reg : out std_logic;
     co_msb_reg : out std_logic;
     cmsb_reg : out std_logic;
     so_reg : out std_logic;
     f0_bus_stat_reg : out std_logic;
     f0_blk_stat_reg : out std_logic;
     f1_bus_stat_reg : out std_logic;
     f1_blk_stat_reg : out std_logic;
     ci : in std_logic := '0';
     co : out std_logic;
     sir : in std_logic := '0';
     sor : out std_logic;
     sil : in std_logic := '0';
     sol : out std_logic;
     msbi : in std_logic := '0';
     msbo : out std_logic;
     cei : in std_logic_vector (1 downto 0) := "00";
     ceo : out std_logic_vector (1 downto 0);
     cli : in std_logic_vector (1 downto 0) := "00";
     clo : out std_logic_vector (1 downto 0);
     zi : in std_logic_vector (1 downto 0) := "00";
     zo : out std_logic_vector (1 downto 0);
     fi : in std_logic_vector (1 downto 0) := "00";
     fo : out std_logic_vector (1 downto 0);
     capi : in std_logic_vector (1 downto 0) := "00";
     capo : out std_logic_vector (1 downto 0);
     cfbi : in std_logic := '0';
     cfbo : out std_logic;
     pi : in std_logic_vector (7 downto 0) := "00000000";
     po : out std_logic_vector (7 downto 0));
end component;
component cy_psoc3_carry
    port (Cin : in std_logic;
     Cpt0 : in std_logic;
     Cpt1 : in std_logic;
     Sum : out std_logic;
     Cout : out std_logic);
end component;
component cy_psoc3_status
    generic(cy_force_order : boolean := false;
     cy_md_select : std_logic_vector (7 downto 0) := "00000000");
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     status : in std_logic_vector (7 downto 0));
end component;
component cy_psoc3_statusi
    generic(cy_force_order : boolean := false;
     cy_md_select : std_logic_vector (6 downto 0) := "0000000";
     cy_int_mask : std_logic_vector (6 downto 0) := "0000000");
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     status : in std_logic_vector (6 downto 0);
     interrupt : out std_logic);
end component;
component cy_psoc3_control
    generic(cy_init_value : std_logic_vector (7 downto 0) := "00000000";
     cy_force_order : boolean := false;
     cy_ctrl_mode_1 : std_logic_vector (7 downto 0) := "00000000";
     cy_ctrl_mode_0 : std_logic_vector (7 downto 0) := "00000000";
     cy_ext_reset : boolean := false);
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     control : out std_logic_vector (7 downto 0));
end component;
component cy_isr_v1_0
    generic(int_type : std_logic_vector := ""; -- 00 = Rising Edge
      -- 01 = Level
      -- 10 = 'derived', which is the old AUTO
         is_nmi : boolean := false);
    port (int_signal : in std_logic);
end component;
component cy_dma_v1_0
    generic(drq_type : std_logic_vector := ""; -- 00 = Rising Edge
      -- 01 = Level
      -- 10 = 'derived', which is the old AUTO
         num_tds : natural := 0); -- deprecated, no longer supported
    port (drq : in std_logic := '0';
     trq : in std_logic := '0';
     nrq : out std_logic);
end component;
component cy_psoc3_count7
    generic(cy_period : std_logic_vector (6 downto 0) := "1111111";
            cy_init_value : std_logic_vector (6 downto 0) := "0000000";
     cy_route_ld : boolean := false;
     cy_route_en : boolean := false;
     cy_alt_mode : boolean := false);
    port (clock : in std_logic;
     reset : in std_logic;
     load : in std_logic;
     enable : in std_logic;
     count : out std_logic_vector (6 downto 0);
     tc : out std_logic);
end component;
component cy_psoc3_sync
    port (clock : in std_logic := '0';
     sc_in : in std_logic;
     sc_out : out std_logic);
end component;
component cy_psoc3_udb_clock_enable_v1_0
    generic(sync_mode : boolean := true);
    port (clock_in : in std_logic := '0';
     enable : in std_logic := '1';
     clock_out : out std_logic);
end component;
-- ********************* DeltaSigma_Mod ***************************** --

component cy_psoc3_ds_mod_v1_0
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end component;
-- ********************* DeltaSigma_Mod ***************************** --

component cy_psoc3_ds_mod_v2_0
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end component;
-- ********************* DeltaSigma_Mod ***************************** --

component cy_psoc3_ds_mod_v3_0
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     ext_vssa : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end component;
-- ********************* DeltaSigma_Mod ***************************** --

component cy_psoc3_ds_mod_v4_0
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     ext_vssa : in std_logic; -- analog
     qtz_ref : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end component;
-- *********************** Decimator ******************************* --

component cy_psoc3_decimator_v1_0
    generic(cy_registers: string := "");
    port (aclock : in std_logic; -- digital
     mod_dat : in std_logic_vector(3 downto 0); -- digital
     ext_start : in std_logic; -- digital
     mod_reset : out std_logic; -- digital
     interrupt : out std_logic); -- digital
end component;
-- ********************* VIDAC ***************************** --

component cy_psoc3_vidac8_v1_0
    generic(cy_registers: string := "";
         reg_data : boolean := true;
     is_all_if_any:boolean := true);
    port (reset : in std_logic := '0'; -- digital
     idir : in std_logic := '0'; -- digital
     ioff : in std_logic := '0'; -- digital
     data : in std_logic_vector (7 downto 0)
        := (others => '0'); -- digital
     strobe : in std_logic := '0'; -- digital
     strobe_udb : in std_logic := '0'; -- digital
     vout : out std_logic; -- analog
     iout : out std_logic); -- analog
end component;
-- ********************* SCBLOCK ***************************** --

component cy_psoc3_scblock_v1_0
    generic(cy_registers: string := "");
    port (vref : in std_logic; -- analog
     vin : in std_logic; -- analog
     aclk : in std_logic; -- digital
     bst_clk : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     dyn_cntl : in std_logic; -- digital
     modout_sync : out std_logic; -- digital
     vout : out std_logic); -- analog
end component;
-- ********************* Comparator ***************************** --

component cy_psoc3_ctcomp_v1_0
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     clock : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     cmpout : out std_logic); -- digital
end component;
-- ********************* AMUX ***************************** --

component cy_psoc3_amux_v1_0
    generic(cy_registers: string := "";
     muxin_width : positive := 8;
     hw_control : boolean := false;
     one_active : boolean := false;
     init_mux_sel: std_logic_vector := "00000000"; -- Deflt selector (mask)
          -- Same size as muxin.
     api_type : natural := 0; -- 0 = table driven
          -- 1 = sequential
          -- 2 = hardware
     connect_mode: natural := 1); -- 0 = single_ended
          -- 1 = double_static
          -- 2 = double_dynamic
    port (muxin : inout std_logic_vector (muxin_width-1 downto 0); -- analog
     hw_ctrl_en : in std_logic_vector (muxin_width-1 downto 0)
        := (others => '0'); -- digital
     vout : inout std_logic); -- analog
end component;
-- ********************* ABUF ***************************** --

component cy_psoc3_abuf_v1_0
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vout : out std_logic); -- analog
end component;
-- ********************* Cap Sense ABUF ***************************** --

component cy_psoc3_csabuf_v1_0
   generic(cy_registers: string := "");
   port (vchan : in std_logic; -- analog
    vref : in std_logic; -- analog
           vout : out std_logic; -- analog
    swon : in std_logic := '0'); -- digital
end component;
-- ********************* VREF ***************************** --

component cy_psoc3_vref_v1_0
    generic(cy_registers: string := "";
     vref_value : string);
    port (vref : out std_logic); -- analog
end component;
-- *** Place holder to force the back end to keep this analog signal *** --

component cy_analog_marker_v1_0
    port (marker : in std_logic); -- analog
end component;
-- *** This component is used to connect analog signals together *** --

component cy_connect_v1_0
    generic(sig_width : positive := 1;
     is_net_join : boolean := false);
    port (signal1 : in std_logic_vector (sig_width-1 downto 0); -- analog
     signal2 : in std_logic_vector (sig_width-1 downto 0)); -- analog
end component;
-- ********************* LPF ***************************** --

component cy_psoc3_lpf_v1_0
    generic(cy_registers: string := "");
    port (vin : in std_logic; -- analog
     vout : out std_logic); -- analog
end component;
-- ********************* SAR3 ***************************** --

component cy_psoc3_sar_v1_0
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     clock : in std_logic; -- digital
     pump_clock : in std_logic; -- digital
     sof_udb : in std_logic; -- digital
     clk_udb : in std_logic := '0'; -- digital
     vp_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     vn_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     irq : out std_logic; -- digital
     data_out : out std_logic_vector(11 downto 0);-- digital
     eof_udb : out std_logic); -- digital
end component;
-- ********************* SAR5 ***************************** --

component cy_psoc5_sar_v2_0
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     ext_pin : inout std_logic; -- analog
     vrefhi_out : out std_logic; -- analog
     vref : in std_logic; -- analog
     clock : in std_logic; -- digital
     pump_clock : in std_logic; -- digital
     sof_udb : in std_logic; -- digital
     clk_udb : in std_logic := '0'; -- digital
     vp_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     vn_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     irq : out std_logic; -- digital
     next_out : out std_logic; -- digital
     data_out : out std_logic_vector(11 downto 0);-- digital
     eof_udb : out std_logic); -- digital
end component;
-- ********************* VREF ***************************** --

component cy_vref_v1_0
    generic(guid : string := "";
     name : string := "";
     autoenable : boolean := false;
     ignoresleep : boolean := false);
    port (vout : out std_logic); -- analog
end component;
-- *** Component to denote where there are analog connections that are *** --
-- *** *meant* to be unconnected, so we can detect the unintentional ones *** --

component cy_analog_noconnect_v1_0
       port (noconnect : inout std_logic); -- analog
end component;
-- ********************* Location ***************************** --

component cy_analog_location_v1_0
    generic(guid : string := "";
     name : string := "";
  is_always_static : boolean := false;
  is_amux_constraint : boolean := false;
  exclusive_use : boolean := false);
    port (connect : inout std_logic); -- analog
end component;
-- ********************* Terminal Reserve ***************************** --

component cy_terminal_reserve_v1_0
    port (connect : inout std_logic); -- analog
end component;
-- ********************* Stay Awake Component ***************************** --

component cy_stay_awake_v1_0
    port (connect : inout std_logic); -- analog
end component;
-- ********************* Annotation Universal Component ********************* --
component cy_annotation_universal_v1_0
    generic(comp_name : string := "";
     port_names : string := "";
     width : positive := 2);
    port (connect : inout std_logic_vector (width-1 downto 0));
end component;
-- ********************* Annotation Noconnect Component ********************* --
component cy_annotation_noconnect_v1_0
   port (noconnect : inout std_logic);
end component;
component cy_psoc3_port_v1_0
    generic(width : natural := 0; -- number of pins
            siorefwidth : natural := 0; -- number of SIO refs (width/2)
            pin_aliases : string := ""; -- CSV of aliases
            id : string := ""; -- id from the GUI
            access_mode : string := "SW_ONLY"; -- SW_ONLY, HW_ONLY,
                                                        -- LCD, EMIF
            layout_mode : string := "CONTIGUOUS";-- CONTIGUOUS,
                                                        -- NONCONTIGUOUS
            port_mode : string := "INPUT"; -- INPUT, OUTPUT,
                                                        -- INOUT, ANALOG
                                                        -- BIDIRECTIONAL
            vtrip : std_logic := '0'; -- 0 = CMOS
                                                        -- 1 = LVTTL
            slew_rate : std_logic_vector := ""; -- 0 = Fast, 1 = Slow
            intr_mode : std_logic_vector := ""; -- size is width*2
            drive_mode : std_logic_vector := ""; -- size is width*3
            lcd_sw_drive: boolean := false; -- False = HW drives LCD
                                                        -- True = SW drives LCD
            lcd_com_seg : std_logic_vector := ""; -- size is width
            por_state : natural := 0; -- 0 = inp dis, out hi-Z
                                                        -- 1 = inp en, out hi-Z
                                                        -- 2 = inp dis, out '0' (pullup)
                                                        -- 3 = inp dis, out '1' (pulldown)
            emif_mode : string := ""; -- default "" = not EMIF
                                                        -- MSB_ADDR, MID_ADDR,
                                                        -- LSB_ADDR,
                                                        -- MSB_DATA, LSB_DATA,
                                                        -- CONTROL
            enable_shielding : std_logic_vector := ""; -- 0 = FALSE, 1 = TRUE
            cs_mode : std_logic_vector (1 downto 0) := "00"; -- 00 = Neither
                                                                -- 01 = Pull Up
                                                                -- 10 = None
                                                                -- 11 = Pull Dn
            sio_obuf : std_logic_vector := ""; -- SIO Output buf, size =width/2
                                                -- 0 = unreulated, 1 = regulated
            sio_ibuf : std_logic_vector := ""; -- SIO INput buf, size =width/2
                                                -- 0 = sngl end, 1 =differential
            sio_hyst : std_logic_vector := ""; -- SIO Output buf, size = width
                                                -- 0 = disabled, 1 = enabled
            sio_hifreq : std_logic_vector := ""; -- SIO PU current, size =width/2
                                                -- 0 = low, 1 = high
            sio_vtrip : std_logic_vector := ""; -- SIO Vtrip set, size = width/2
                                                -- 0 = 0.5 mult, 1 = 0.4 or 1
            sio_refsel : std_logic_vector := ""; -- SIO Vref sel, size = width/2
                                                -- 0 = vcc_io, 1 = vohref
            port_alias_required : std_logic := '0'; -- 0 = Does not require port alias mask
                                                -- 1 = Requires port alias mask
            port_alias_group : string := ""); -- Name of group, used to allow multiple
                                                -- ports using mask in the same phy. port

    port ( oe : in std_logic := '1'; -- Output Enable
            y : in std_logic_vector (width-1 downto 0); -- Input
            fb : out std_logic_vector (width-1 downto 0); -- Feed back
            analog : inout std_logic_vector (width-1 downto 0); -- Analog Port
            io : inout std_logic_vector (width-1 downto 0); -- Bidirectional
            siovref : inout std_logic_vector (siorefwidth-1 downto 0); -- Analog SIO Vref
            interrupt : out std_logic; -- Interrupt
            precharge : in std_logic := '0'); -- Capsense
end component;
component cy_psoc3_pins_v1_10
    generic(id : string := ""; -- id from the GUI
            drive_mode : std_logic_vector := ""; -- size = width * 3
                                                        -- 000 = Analog Hi-Z
                                                        -- 001 = Digital Hi-Z
                                                        -- 010 = Res Pull Up
                                                        -- 011 = Res Pull Down
                                                        -- 100 = Open Drain Lo
                                                        -- 101 = Open Drain Hi
                                                        -- 110 = CMOS Out
                                                        -- 111 = Res PullUp/Down
            ibuf_enabled : std_logic_vector := ""; -- size = width
                                                        -- 0 = enabled
                                                        -- 1 = disabled
            init_dr_st : std_logic_vector := ""; -- intial drive state
                                                        -- size = width
                                                        -- 0 = low
                                                        -- 1 = high
            input_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            input_clk_en: std_logic := '0'; -- 0 = rising edge
                                                        -- 1 = level
            input_sync_mode : std_logic_vector:= ""; -- size = width
                                                        -- 0 = double
                                                        -- 1 = single
            intr_mode : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = None
                                                        -- 01 = Rising Edge
                                                        -- 10 = Falling Edge
                                                        -- 11 = On Change
            invert_in_clock : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_in_clock_en : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_in_reset : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_clock : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_clock_en : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_reset : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            io_voltage : string := ""; -- CSV IO supply volts
                                                        -- each volt is a float
            layout_mode : string := "CONTIGUOUS";-- CONTIGUOUS,
                                                        -- NONCONTIGUOUS
            output_conn : std_logic_vector := ""; -- size = width
                                                        -- 0 = not visible
                                                        -- 1 = visible
            output_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            output_clk_en: std_logic := '0'; -- 0 = rising edge
                                                        -- 1 = level
            output_mode : std_logic_vector := ""; -- size = width
                                                        -- 0 = data
                                                        -- 1 = clock
            output_reset: std_logic := '0'; -- 0 = don't use reset
                                                        -- 1 = use reset
            output_clock_mode : std_logic_vector:= ""; -- size = width, when mode is clock
                                                        -- 0 = normal
                                                        -- 1 = inverted
            oe_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            oe_conn : std_logic_vector := ""; -- size = width
                                                        -- 0 = not visible
                                                        -- 1 = visible
            oe_reset : std_logic := '0'; -- 0 = don't use reset
                                                        -- 1 = use reset
            pin_aliases : string := ""; -- CSV of aliases
            pin_mode : string := ""; -- size = width
                                                        -- I = input
                                                        -- O = output
                                                        -- A = analog only
                                                        -- B = bidirectional
            por_state : natural := 0; -- 0 = High-Z Analog
                                                        -- 1 = High-Z Dig (NA)
                                                        -- 2 = Pulled up
                                                        -- 3 = Pulled down
                                                        -- 4 = Dont care
            sio_group_cnt : natural := 0; -- # SIO pairs/singles
            sio_hifreq : std_logic_vector := ""; -- SIO PU current
                                                        -- size = sio_group_cnt
                                                        -- 0 = low
                                                        -- 1 = high
            sio_hyst : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            sio_ibuf : std_logic_vector := ""; -- SIO Input buf
                                                        -- size = sio_group_cnt
                                                        -- 0 = single ended
                                                        -- 1 = differential
            sio_info : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = not SIO
                                                        -- 01 = SIO single
                                                        -- 10 = #1 of SIO pair
                                                        -- 11 = #2 of SIO Pair
            sio_obuf : std_logic_vector := ""; -- SIO Output buf
                                                        -- size = sio_group_cnt
                                                        -- 0 = unreulated
                                                        -- 1 = regulated
            sio_refsel : std_logic_vector := ""; -- SIO Vref sel
                                                        -- size = sio_group_cnt
                                                        -- 0 = vcc_io,
                                                        -- 1 = vohref
            sio_vtrip : std_logic_vector := ""; -- SIO Vtrip set
                                                        -- size = sio_group_cnt
                                                        -- 0 = 0.5 mult
                                                        -- 1 = 0.4 or 1
     sio_vohsel : std_logic_vector := ""; -- SIO VOH multiplier setting
       -- size = sio_group_cnt * 3
       -- See SIO.PAIR_VOH_SEL field values
            slew_rate : std_logic_vector := ""; -- size = width
                                                        -- 0 = Fast
                                                        -- 1 = Slow
            spanning : std_logic := '0'; -- 0 = not spanning
                                                        -- 1 = spanning
            sw_only : std_logic := '0'; -- 0 = HW/SW
                                                        -- 1 = SW ONLY
            vtrip : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = CMOS
                                                        -- 01 = LVTTL
                                                        -- 10 = CMOS or LVTTL
            width : natural := 0; -- number of pins
            port_alias_required : std_logic := '0'; -- 0 = Does not require port alias mask
                                                        -- 1 = Requires port alias mask
            port_alias_group : string := ""; -- Name of group, used to allow multiple
                                                        -- ports using mask in the same phy. port
            use_annotation : std_logic_vector := "";
            pa_in_clock : integer := -1; -- index of pin to use a PA input to in_clock
            pa_in_clock_en : integer := -1; -- index of pin to use a PA input to in_clock_en
            pa_in_reset : integer := -1; -- index of pin to use a PA input to in_reset
            pa_out_clock : integer := -1; -- index of pin to use a PA input to out_clock
            pa_out_clock_en: integer := -1; -- index of pin to use a PA input to out_clock_en
            pa_out_reset : integer := -1; -- index of pin to use a PA input to out_reset
            ovt_needed : std_logic_vector := ""; -- size = width
                                                        -- overvoltage needed
            ovt_slew_control : std_logic_vector := ""; -- size = width * 2
                                                        -- ovt slew control, range
            ovt_hyst_trim : std_logic_vector := ""; -- size = width
                                                        -- ovt hysteresis trim
            input_buffer_sel : std_logic_vector := ""); -- size = width * 2
                                                        -- GPIOv2 input buffer mode

    port ( oe : in std_logic_vector (width-1 downto 0); -- Output Enable
            y : in std_logic_vector (width-1 downto 0); -- Input
            fb : out std_logic_vector (width-1 downto 0); -- Feed back
            analog : inout std_logic_vector (width-1 downto 0); -- Analog Port
            io : inout std_logic_vector (width-1 downto 0); -- Bidirectional
            siovref : inout std_logic_vector; -- Analog SIO Vref
            annotation : inout std_logic_vector (width-1 downto 0); -- Off chip conn
            in_clock : in std_logic := '0'; -- Clock for input register
            in_clock_en : in std_logic := '1'; -- Clock Enable for input register
            in_reset : in std_logic := '0'; -- Reset for input register
            out_clock : in std_logic := '0'; -- Clock for output register
            out_clock_en: in std_logic := '1'; -- Clock Enable for output register
            out_reset : in std_logic := '0'; -- Reset for output register
            interrupt : out std_logic); -- Interrupt
end component;
-- ****************** Controller Area Network Controller ********************

component cy_psoc3_can_v1_0
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     can_rx : in std_logic;
     can_tx : out std_logic;
     can_tx_en : out std_logic;
     interrupt : out std_logic);
end component;
-- **************** Inter-Integrated Circuit Controller **********************

component cy_psoc3_i2c_v1_0
    generic(cy_registers: string := "";
     use_wakeup : boolean := false);
    port (clock : in std_logic;
     scl_in : in std_logic;
     sda_in : in std_logic;
     scl_out : out std_logic;
     sda_out : out std_logic;
     interrupt : out std_logic);
end component;
-- ********************* Timer/Counter/PWM *****************************

component cy_psoc3_timer_v1_0
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     kill : in std_logic;
     enable : in std_logic;
     capture : in std_logic;
     timer_reset : in std_logic;
     tc : out std_logic;
     compare : out std_logic;
     interrupt : out std_logic);
end component;
-- ********************* Digital Filter Block *****************************

component cy_psoc3_dfb_v1_0
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     in_1 : in std_logic;
     in_2 : in std_logic;
     out_1 : out std_logic;
     out_2 : out std_logic;
     dmareq_1 : out std_logic;
     dmareq_2 : out std_logic;
     interrupt : out std_logic);
end component;
-- *************************** USB Block **********************************

component cy_psoc3_usb_v1_0
    generic(cy_registers: string := "");
    port (dp : inout std_logic; -- analog;
     dm : inout std_logic; -- analog;
     sof_int : out std_logic;
     arb_int : out std_logic;
     usb_int : out std_logic;
     ept_int : out std_logic_vector (8 downto 0);
     ord_int : out std_logic;
     dma_req : out std_logic_vector (7 downto 0);
     dma_termin : out std_logic);
end component;
-- *********************** LCD Control Block ******************************

component cy_psoc3_lcd_v1_0
    generic(cy_registers: string := "";
     global_bias : boolean := false);
    port (drive_en : in std_logic;
     en_hi : in std_logic;
     frame : in std_logic;
     data_clk : in std_logic;
     dac_dis : in std_logic;
     chop_clk : in std_logic;
     bias : inout std_logic_vector (4 downto 0)); -- analog
end component;
-- *********************** LCD Control Block ******************************

component cy_psoc3_lcd_v2_0
    generic(cy_registers: string := "";
     global_bias : boolean := false);
    port (drive_en : in std_logic;
     frame : in std_logic;
     data_clk : in std_logic;
     int_clr : in std_logic;
     lp_ack_udb : in std_logic;
     mode_1 : in std_logic;
     mode_2 : in std_logic;
     interrupt : out std_logic;
     bias : inout std_logic_vector (4 downto 0)); -- analog
end component;
-- *********************** CLK Control Block ******************************

component cy_clock_v1_0
    generic(cy_registers: string := "";
     id : string := "";
     source_clock_id : string := "";
     divisor : natural := 1;
     period : string := "";
     is_direct : boolean := false;
     is_digital : boolean := true);
    port (clock_out : out std_logic;
   dig_domain_out : out std_logic);
end component;
-- *********************** EMIF Control Block ******************************

component cy_psoc3_emif_v1_0
    generic(cy_registers: string := "";
     udb_mode : boolean := false);
    port (clock : out std_logic;
     ce : out std_logic;
     oe : out std_logic;
     adsc : out std_logic;
     sleep : out std_logic;
     wr : out std_logic;
            data_oe_n : out std_logic;
            xmem_wr : out std_logic;
            xmem_rd : out std_logic;
            udb_stall : in std_logic);
end component;
component cy_psoc3_emif_v2_0
    generic(cy_registers: string := "";
     udb_mode : boolean := false);
    port (clock : out std_logic;
     ce : out std_logic;
     oe : out std_logic;
     adsc : out std_logic;
     sleep : out std_logic;
     wr : out std_logic;
            data_oe : out std_logic;
            xmem_wr : out std_logic;
            xmem_rd : out std_logic;
            udb_ready : in std_logic);
end component;
-- ********************* Global Signal Ref ***************************** --

component cy_gsref_v1_0
   generic(guid : string := "");
   port (sig_out : out std_logic);
end component;
-- *********************** Digital Sentinel ******************************

component cy_psoc3_digital_sentinel_v1_0
    generic(info : string := "");
    port (watch : in std_logic);
end component;
component cy_tsg4_ssc_v1_0
    generic(if_type : string := "I2C");
    -- I2C (default)
    -- SPI
    port (scli : in std_logic := '0';
     sdai : in std_logic := '0';
     csel : in std_logic := '0';
     sclo : out std_logic;
     sdao : out std_logic;
     irq : out std_logic);
end component;
component cy_tsg4_tss_v1_0
    port (clk_seq : in std_logic;
     clk_adc : in std_logic;
     ext_reject : in std_logic;
     ext_sync : in std_logic;
     reject_in : in std_logic;
     start_in : in std_logic;
     tx_sync : in std_logic;
     lx_det_hi : out std_logic;
     lx_det_lo : out std_logic;
     rej_window : out std_logic;
     tx_hilo : out std_logic;
     phase_end : out std_logic;
     phase_num : out std_logic_vector (3 downto 0);
     ipq_reject : out std_logic;
     ipq_start : out std_logic;
     epq_reject : out std_logic;
     epq_start : out std_logic;
     mcs_reject : out std_logic;
     mcs_start : out std_logic;
     do_switch : out std_logic;
     adc_start : out std_logic;
     adc_done : out std_logic);
end component;
-- ********************************************************* --
-- ***************** PSOC4 Temp Sensor ********************* --

component cy_psoc4_temp_v1_0
    generic(cy_registers: string := "");
    port (
   temp : out std_logic; -- analog
   vssa_kelvin : in std_logic); -- analog
end component;
-- ********************************************************* --
-- ************* PSOC4 Low Power Comparator***************** --

component cy_psoc4_lpcomp_v1_0
    generic(cy_registers: string := "";
         needs_hibernate: boolean := true);
    port (vminus : in std_logic; -- analog
        vplus : in std_logic; -- analog
        cmpout : out std_logic); -- digital
end component;
-- ********************************************************* --
-- ********************* PSOC4 SAR ************************* --

component cy_psoc4_sar_v1_0
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vref : in std_logic; -- analog
     ext_vref : in std_logic; -- analog
   clock : in std_logic; -- digital
   sample_done : out std_logic; -- digital
   chan_id_valid : out std_logic; -- digital
   chan_id : out std_logic_vector (3 downto 0); -- digital
   data_valid : out std_logic; -- digital
   data : out std_logic_vector (11 downto 0); -- digital
   eos_intr : out std_logic; -- digital
   irq : out std_logic; -- digital
   sw_negvref : in std_logic; -- digital
   cfg_st_sel : in std_logic_vector (1 downto 0); -- digital
   cfg_average : in std_logic; -- digital
   cfg_resolution : in std_logic; -- digital
   cfg_differential: in std_logic; -- digital
   trigger : in std_logic; -- digital
   data_hilo_sel : in std_logic); -- digital
end component;
-- ********************************************************* --
-- ******************** PSOC4 Opamp *********************** --

component cy_psoc4_abuf_v1_0
    generic(cy_registers: string := "";
         needs_dsab: boolean := false;
         deepsleep_available: boolean := false;
         has_resistor: boolean := false);
    port (
   vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vout1 : out std_logic; -- analog
     rs_bot : out std_logic; -- analog
     vout10 : out std_logic; -- analog
     cmpout : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ****************** PSOC4 Half-UAB *********************** --

component cy_psoc4_half_uab_v1_0
    generic(cy_registers: string := "");
    port (
  x0 : in std_logic; -- analog
  x1 : in std_logic; -- analog
  x2 : in std_logic; -- analog
  x3 : in std_logic; -- analog
  ref : in std_logic; -- analog
  agnd : in std_logic; -- analog
  vout : out std_logic; -- analog
  couple : in std_logic; -- analog
  clock : in std_logic; -- digital
  modbitab : in std_logic; -- digital
  modbitc : in std_logic; -- digital
  strobe : in std_logic; -- digital
  trigger : in std_logic; -- digital
  comp : out std_logic; -- digital
  uab_valid : out std_logic; -- digital
  uab_trig_out : out std_logic; -- digital
  uab_dac_intr : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ****************** PSOC4 Decimator ********************** --

component cy_psoc4_decimator_v1_0
    generic(cy_registers: string := "");
    port (
  valid : in std_logic; -- digital
  incr : in std_logic; -- digital
  reset : out std_logic; -- digital
  intr : out std_logic); -- digital

end component;
component cy_psoc4_decimator_v1_10
    generic(cy_registers: string := "");
    port (
  valid : in std_logic; -- digital
  incr : in std_logic; -- digital
  trigger : in std_logic; -- digital
  reset : out std_logic; -- digital
  intr : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ************ PSOC4 Programmable Reference *************** --

component cy_psoc4_pref_v1_0
    generic(cy_registers : string := "";
   referenceID : integer := 0;
   tapID : integer := 0);
    port (vout : out std_logic); -- analog
end component;
-- ********************************************************* --
-- ******************* PSOC4 CSD Comp ********************** --

component cy_psoc4_csd_comp_v1_0
    generic(cy_registers: string := "");
    port (
  vplus : in std_logic; -- analog
  clk_sample : in std_logic := '0'; -- digital
  cmpout : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ****************** PSOC4 CSD Comp v2 ******************** --

component cy_psoc4_csd_comp2_v1_0
    generic(cy_registers: string := "");
    port (
  vplus : in std_logic; -- analog
  vminus : in std_logic; -- analog
  clk_sample : in std_logic := '0'; -- digital
  cmpout : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ********************** PSOC4 CSD ************************ --

component cy_psoc4_csd_v1_0
    generic(cy_registers: string := "";
   sensors_count : positive := 1;
   shield_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  source : in std_logic_vector (sensors_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end component;
-- ********************************************************* --
-- ********************** PSOC4 CSD ************************ --

component cy_psoc4_csd_v1_10
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end component;
component cy_psoc4_csd_v1_20
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end component;
-- ********************************************************* --
-- ******************** PSOC4 CSDv2 ************************ --

component cy_psoc4_csd2_v1_0
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic; -- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end component;
component cy_psoc4_csd2_v1_10
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic; -- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end component;
component cy_psoc4_csd2_v1_20
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   dedicated_io_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic_vector (dedicated_io_count -1 downto 0);-- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end component;
component cy_psoc4_csd2_v1_30
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   dedicated_io_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic_vector (dedicated_io_count -1 downto 0);-- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  tr_adc_done : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end component;
-- ********************************************************* --
-- ********************* PSOC4 CS IDAC ********************* --

component cy_psoc4_csidac_v1_0
    generic(cy_registers: string := "";
           resolution : integer := 7);
    port (iout : out std_logic; -- analog
      en : in std_logic); -- digital

end component;
-- ********************************************************* --
-- ********************* PSOC4 CS IDAC ********************* --

component cy_psoc4_csidac2_v1_0
    generic(cy_registers: string := "";
   leg3_needed : boolean := false);
    port (
  iout : out std_logic; -- analog
  en_a : in std_logic; -- digital
  en_b : in std_logic; -- digital
  en_c : in std_logic; -- digital
  pol : in std_logic); -- digital

end component;
-- ********************************************************* --
-- ********************* SARMUX **************************** --

component cy_psoc4_sarmux_v1_0
    generic(cy_registers: string := "";
     muxin_width : positive := 4;
     input_mode : string := "0000"); --0 = single-ended, 1 = differential
    port (
   muxin_plus : in std_logic_vector (muxin_width-1 downto 0); -- analog
   muxin_minus : in std_logic_vector (muxin_width-1 downto 0); -- analog
   cmn_neg : in std_logic; -- analog
   vout_plus : out std_logic; -- analog
   vout_minus : out std_logic); -- analog
end component;
-- ********************************************************* --
-- ********************* SARMUX **************************** --

component cy_psoc4_sarmux_v1_10
    generic(cy_registers: string := "";
     muxin_width : positive := 4;
  cmn_neg_width : positive := 1;
  input_mode : string := "0000"); --0 = single-ended, 1 = differential
    port (
  muxin_plus : in std_logic_vector (muxin_width-1 downto 0); -- analog
  muxin_minus : in std_logic_vector (muxin_width-1 downto 0); -- analog
  cmn_neg : in std_logic_vector (cmn_neg_width-1 downto 0); -- analog
  vout_plus : out std_logic; -- analog
  vout_minus : out std_logic); -- analog
end component;
-- ********************************************************* --
-- ********************** LNFE ***************************** --

component cy_psoc4_lnfe_v1_0
    generic(cy_registers: string := "");
    port (
  lc : out std_logic; -- analog
  lb : out std_logic; -- analog
  le : out std_logic); -- analog
end component;
component cy_psoc4_imo_fss_v1_0
    port (ss_clock : in std_logic;
     ss : in std_logic_vector (4 downto 0) := "00000";
     ss_updn : out std_logic);
end component;
-- ****************************** TCPWM ************************************* --

component cy_m0s8_tcpwm_v1_0
     generic(cy_registers : string := "");
     port (clock : in std_logic; -- digital
             capture : in std_logic; -- digital
             count : in std_logic; -- digital
             reload : in std_logic; -- digital
             stop : in std_logic; -- digital
             start : in std_logic; -- digital
             underflow : out std_logic; -- digital
             overflow : out std_logic; -- digital
             compare_match : out std_logic; -- digital
             line_out : out std_logic; -- digital
             line_out_compl : out std_logic; -- digital
             interrupt : out std_logic); -- digital
end component;
-- ****************************** SCB ************************************* --
component cy_m0s8_scb_v1_0
    generic(cy_registers : string := "";
     scb_mode : integer := 0); -- 0 = I2C
       -- 1 = SPI
       -- 2 = UART
    port ( clock : in std_logic; -- digital
     interrupt : out std_logic; -- digital
     rx : in std_logic; -- digital
     tx : out std_logic; -- digital
     mosi_m : out std_logic; -- digital
     miso_m : in std_logic; -- digital
     select_m : out std_logic_vector (3 downto 0);-- digital
     sclk_m : out std_logic; -- digital
     mosi_s : in std_logic; -- digital
     miso_s : out std_logic; -- digital
     select_s : in std_logic; -- digital
     sclk_s : in std_logic; -- digital
     scl : inout std_logic; -- digital
     sda : inout std_logic); -- digital
end component;
-- ****************************** SCBv2 ************************************* --
component cy_m0s8_scb_v2_0
    generic(cy_registers : string := "";
     scb_mode : integer := 0); -- 0 = I2C
       -- 1 = SPI
       -- 2 = UART
    port ( clock : in std_logic; -- digital
     interrupt : out std_logic; -- digital
     rx : in std_logic; -- digital
     tx : out std_logic; -- digital
     cts : in std_logic; -- digital
     rts : out std_logic; -- digital
     mosi_m : out std_logic; -- digital
     miso_m : in std_logic; -- digital
     select_m : out std_logic_vector (3 downto 0);-- digital
     sclk_m : out std_logic; -- digital
     mosi_s : in std_logic; -- digital
     miso_s : out std_logic; -- digital
     select_s : in std_logic; -- digital
     sclk_s : in std_logic; -- digital
     scl : inout std_logic; -- digital
     sda : inout std_logic; -- digital
     tx_req : out std_logic; -- digital
     rx_req : out std_logic); -- digital

end component;
-- ****************************** LCD ************************************* --
component cy_m0s8_lcd_v1_0
    generic(cy_registers : string := "";
     common_width : natural := 1 ; -- number of common
     segment_width : natural := 1); -- number of segment
    port ( clock : in std_logic := '1'; -- digital
            common : out std_logic_vector (common_width -1 downto 0);
       -- digital
     segment : out std_logic_vector (segment_width-1 downto 0));
       -- digital
end component;
-- ****************************** BLE ************************************* --
component cy_m0s8_ble_v1_0
    generic(cy_registers : string := "");
    port ( interrupt : out std_logic; -- digital
      rf_ext_pa_en : out std_logic); -- digital

end component;
-- ****************************** BLE II ************************************* --
component cy_m0s8_ble_v2_0
    generic(cy_registers : string := "");
port( interrupt : out std_logic; -- digital
   ext_pa_tx_ctl : out std_logic; -- digital
   ext_lna_rx_ctl : out std_logic; -- digital
   ext_pa_lna_chip_en : out std_logic); -- digital

end component;
-- ****************************** DMA ************************************* --
component cy_m0s8_dma_v1_0
    generic(priority : std_logic_vector (1 downto 0) := "00"); -- 00 = Highest
                                                -- 01
            -- 10
            -- 11 = Lowest
            port(tr_in : in std_logic := '0';
tr_out : out std_logic);

end component;
    -- ****************** Controller Area Network Controller ********************
component cy_m0s8_can_v1_0
    generic(cy_registers : string := "");
    port(can_rx: in std_logic;
         can_tx: out std_logic;
         can_tx_en: out std_logic;
         interrupt: out std_logic);
end component;
-- ****************** USB ********************
component cy_m0s8_usb_v1_0
    generic(cy_registers : string := "");
    port(dp: out std_logic; -- These are declared as outputs for simplicity. The actual
         dm: out std_logic; -- drive mode is controlled by the USB hardware.
         vbus_valid: in std_logic;
         interrupt_lo: out std_logic;
         interrupt_med: out std_logic;
         interrupt_hi: out std_logic;
         dsi_usb_sof: out std_logic;
         dma_burstend: in std_logic_vector(7 downto 0);
         dma_req: out std_logic_vector(7 downto 0));
end component;
-- ****************** USB (Legacy) ********************
component cy_psoc4u_usb_v1_0
    generic(cy_registers : string := "");
    port(dp: out std_logic; -- These are declared as outputs for simplicity. The actual
         dm: out std_logic; -- drive mode is controlled by the USB hardware.
         sof: out std_logic;
         ep0: out std_logic;
         ep8_1: out std_logic;
         reset: out std_logic;
         arb: out std_logic);
end component;
-- ****************** usbpd ********************
component cy_psoc4_usbpd_v1_0
    generic(cy_registers : string := "");
    port(clock_rx: in std_logic;
         clock_tx: in std_logic;
         clock_sar: in std_logic;
         interrupt: out std_logic;
         interrupt_wakeup: out std_logic;
         cmp_out: out std_logic;
         tx_data: in std_logic;
         tx_data_en: in std_logic;
         tr_out_0: out std_logic;
         tr_out_1: out std_logic;
         tr_out_2: out std_logic;
         tr_out_3: out std_logic;
         tr_out_4: out std_logic);
end component;
-- ****************** usbpd ********************
component cy_psoc4_usbpd_v2_0
    generic(cy_registers : string := "");
    port(clock_rx: in std_logic;
         clock_tx: in std_logic;
         clock_sar: in std_logic;
         interrupt: out std_logic;
         interrupt_wakeup: out std_logic;
         cmp_out: out std_logic_vector(1 downto 0);
         tx_data: in std_logic;
         tx_data_en: in std_logic;
         tr_out_0: out std_logic;
         tr_out_1: out std_logic;
         tr_out_2: out std_logic;
         tr_out_3: out std_logic;
         tr_out_4: out std_logic;
         tr_out_5: out std_logic;
         tr_out_6: out std_logic;
         hpd: out std_logic);
end component;
-- ****************************** PRGIO ************************************* --
component cy_m0s8_prgio_v1_0
    generic(cy_registers : string := "";
   port_id : natural := 0); -- port number to place prgio at
    port(clock : in std_logic;
         data0_i : in std_logic;
         data0_o : out std_logic;
         data0_oe : out std_logic;
         data0_io : inout std_logic;
         data1_i : in std_logic;
         data1_o : out std_logic;
         data1_oe : out std_logic;
         data1_io : inout std_logic;
         data2_i : in std_logic;
         data2_o : out std_logic;
         data2_oe : out std_logic;
         data2_io : inout std_logic;
         data3_i : in std_logic;
         data3_o : out std_logic;
         data3_oe : out std_logic;
         data3_io : inout std_logic;
         data4_i : in std_logic;
         data4_o : out std_logic;
         data4_oe : out std_logic;
         data4_io : inout std_logic;
         data5_i : in std_logic;
         data5_o : out std_logic;
         data5_oe : out std_logic;
         data5_io : inout std_logic;
         data6_i : in std_logic;
         data6_o : out std_logic;
         data6_oe : out std_logic;
         data6_io : inout std_logic;
         data7_i : in std_logic;
         data7_o : out std_logic;
         data7_oe : out std_logic;
         data7_io : inout std_logic;

         gpio0_i : in std_logic;
         gpio0_o : out std_logic;
         gpio0_oe : out std_logic;
         gpio0_io : inout std_logic;
         gpio1_i : in std_logic;
         gpio1_o : out std_logic;
         gpio1_oe : out std_logic;
         gpio1_io : inout std_logic;
         gpio2_i : in std_logic;
         gpio2_o : out std_logic;
         gpio2_oe : out std_logic;
         gpio2_io : inout std_logic;
         gpio3_i : in std_logic;
         gpio3_o : out std_logic;
         gpio3_oe : out std_logic;
         gpio3_io : inout std_logic;
         gpio4_i : in std_logic;
         gpio4_o : out std_logic;
         gpio4_oe : out std_logic;
         gpio4_io : inout std_logic;
         gpio5_i : in std_logic;
         gpio5_o : out std_logic;
         gpio5_oe : out std_logic;
         gpio5_io : inout std_logic;
         gpio6_i : in std_logic;
         gpio6_o : out std_logic;
         gpio6_oe : out std_logic;
         gpio6_io : inout std_logic;
         gpio7_i : in std_logic;
         gpio7_o : out std_logic;
         gpio7_oe : out std_logic;
         gpio7_io : inout std_logic);
end component;
-- ****************************** CRYPTO ************************************* --
component cy_psoc4_crypto_v1_0
    generic(cy_registers : string := "");
    port(tr_in : in std_logic;
         tr_out : out std_logic;
         interrupt : out std_logic);
end component;
component cy_mxs40_tcpwm_v1_0
    generic(
        cy_registers : string :="";
        width : natural :=32;
        exact_width : boolean :=false);
    port (
        clock : in std_logic; --digital
        capture : in std_logic; --digital
        count : in std_logic; --digital
        reload : in std_logic; --digital
        stop : in std_logic; --digital
        start : in std_logic; --digital
        tr_underflow : out std_logic; --digital
        tr_compare_match : out std_logic; --digital
        tr_overflow : out std_logic; --digital
        line_compl : out std_logic; --digital
        line : out std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_dw_v1_0
    generic(
        cy_registers : string :="";
        priority : std_logic_vector (1 downto 0) :="00");
    port (
        tr_in : in std_logic; --digital
        tr_out : out std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_gpio_v1_0
    generic(
        cy_registers : string :="";
        width : natural :=1;
        sio_grp_cnt : natural :=1;
        id : string :="";
        drive_mode : string :="";
        ibuf_enabled : string :="";
        init_dr_st : string :="";
        input_sync : string :="";
        intr_mode : string :="";
        io_voltage : string :="";
        output_conn : string :="";
        oe_conn : string :="";
        output_sync : string :="";
        oe_sync : string :="";
        drive_strength : string :="";
        max_frequency : string :="";
        output_current_cap : string :="";
        i2c_mode : string :="";
        pin_aliases : string :="";
        pin_mode : string :="";
        slew_rate : string :="";
        vtrip : string :="";
        use_annotation : string :="";
        hotswap_needed : string :="");
    port (
        oe : in std_logic_vector(width - 1 downto 0); --digital
        y : in std_logic_vector(width - 1 downto 0); --digital
        fb : out std_logic_vector(width - 1 downto 0); --digital
        analog : inout std_logic_vector(width - 1 downto 0); --analog
        io : inout std_logic_vector(width - 1 downto 0); --digital
        annotation : inout std_logic_vector(width - 1 downto 0); --analog
        siovref : inout std_logic_vector); --analog
end component;
component cy_mxs40_smartio_v1_0
    generic(
        cy_registers : string :="";
        port_id : natural :=0);
    port (
        clock : in std_logic; --digital
        data0_i : in std_logic; --digital
        data0_o : out std_logic; --digital
        data0_oe : out std_logic; --digital
        data0_io : inout std_logic; --digital
        data1_i : in std_logic; --digital
        data1_o : out std_logic; --digital
        data1_oe : out std_logic; --digital
        data1_io : inout std_logic; --digital
        data2_i : in std_logic; --digital
        data2_o : out std_logic; --digital
        data2_oe : out std_logic; --digital
        data2_io : inout std_logic; --digital
        data3_i : in std_logic; --digital
        data3_o : out std_logic; --digital
        data3_oe : out std_logic; --digital
        data3_io : inout std_logic; --digital
        data4_i : in std_logic; --digital
        data4_o : out std_logic; --digital
        data4_oe : out std_logic; --digital
        data4_io : inout std_logic; --digital
        data5_i : in std_logic; --digital
        data5_o : out std_logic; --digital
        data5_oe : out std_logic; --digital
        data5_io : inout std_logic; --digital
        data6_i : in std_logic; --digital
        data6_o : out std_logic; --digital
        data6_oe : out std_logic; --digital
        data6_io : inout std_logic; --digital
        data7_i : in std_logic; --digital
        data7_o : out std_logic; --digital
        data7_oe : out std_logic; --digital
        data7_io : inout std_logic; --digital
        gpio0_i : in std_logic; --digital
        gpio0_o : out std_logic; --digital
        gpio0_oe : out std_logic; --digital
        gpio0_io : inout std_logic; --digital
        gpio1_i : in std_logic; --digital
        gpio1_o : out std_logic; --digital
        gpio1_oe : out std_logic; --digital
        gpio1_io : inout std_logic; --digital
        gpio2_i : in std_logic; --digital
        gpio2_o : out std_logic; --digital
        gpio2_oe : out std_logic; --digital
        gpio2_io : inout std_logic; --digital
        gpio3_i : in std_logic; --digital
        gpio3_o : out std_logic; --digital
        gpio3_oe : out std_logic; --digital
        gpio3_io : inout std_logic; --digital
        gpio4_i : in std_logic; --digital
        gpio4_o : out std_logic; --digital
        gpio4_oe : out std_logic; --digital
        gpio4_io : inout std_logic; --digital
        gpio5_i : in std_logic; --digital
        gpio5_o : out std_logic; --digital
        gpio5_oe : out std_logic; --digital
        gpio5_io : inout std_logic; --digital
        gpio6_i : in std_logic; --digital
        gpio6_o : out std_logic; --digital
        gpio6_oe : out std_logic; --digital
        gpio6_io : inout std_logic; --digital
        gpio7_i : in std_logic; --digital
        gpio7_o : out std_logic; --digital
        gpio7_oe : out std_logic; --digital
        gpio7_io : inout std_logic); --digital
end component;
component cy_mxs40_smif_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        spi_clk : out std_logic; --digital
        spi_select : out std_logic_vector(3 downto 0); --digital
        spi_data : out std_logic_vector(7 downto 0); --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic); --digital
end component;
component cy_mxs40_ble_v1_0
    generic(
        cy_registers : string :="";
        low_power : boolean :=false);
    port (
        ext_pa_lna_chip_en_out : out std_logic; --digital
        ext_lna_rx_ctl_out : out std_logic; --digital
        ext_pa_tx_ctl_out : out std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_scb_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        uart_rx : in std_logic; --digital
        uart_tx : out std_logic; --digital
        uart_rts : out std_logic; --digital
        uart_cts : in std_logic; --digital
        i2c_scl : inout std_logic; --digital
        i2c_sda : inout std_logic; --digital
        spi_clk_m : out std_logic; --digital
        spi_clk_s : in std_logic; --digital
        spi_select_m : out std_logic_vector(3 downto 0); --digital
        spi_select_s : in std_logic; --digital
        spi_mosi_m : out std_logic; --digital
        spi_miso_m : in std_logic; --digital
        spi_mosi_s : in std_logic; --digital
        spi_miso_s : out std_logic; --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic; --digital
        tr_i2c_scl_filtered : out std_logic); --digital
end component;
component cy_mxs40_scb_v1_10
    generic(
        cy_registers : string :="";
        requires_io_preconfigure : boolean :=false;
        mode : natural :=0;
        master : boolean :=false);
    port (
        clock : in std_logic; --digital
        uart_rx : in std_logic; --digital
        uart_tx : out std_logic; --digital
        uart_rts : out std_logic; --digital
        uart_cts : in std_logic; --digital
        uart_tx_en : out std_logic; --digital
        i2c_scl : inout std_logic; --digital
        i2c_sda : inout std_logic; --digital
        spi_clk_m : out std_logic; --digital
        spi_clk_s : in std_logic; --digital
        spi_select_m : out std_logic_vector(3 downto 0); --digital
        spi_select_s : in std_logic; --digital
        spi_mosi_m : out std_logic; --digital
        spi_miso_m : in std_logic; --digital
        spi_mosi_s : in std_logic; --digital
        spi_miso_s : out std_logic; --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic; --digital
        tr_i2c_scl_filtered : out std_logic); --digital
end component;
component cy_mxs40_csd_v1_0
    generic(
        cy_registers : string :="";
        sensors_count : natural :=1;
        rx_count : natural :=1;
        tx_count : natural :=1;
        shield_count : natural :=1;
        adc_channel_count : natural :=1;
        dedicated_io_count : natural :=1;
        is_cmod_charge : boolean :=false;
        is_capsense : boolean :=true;
        sense_as_shield : boolean :=false;
        shield_as_sense : boolean :=false);
    port (
        sense : in std_logic_vector(sensors_count - 1 downto 0); --analog
        rx : in std_logic_vector(rx_count - 1 downto 0); --analog
        tx : out std_logic_vector(tx_count - 1 downto 0); --analog
        shield : out std_logic_vector(shield_count - 1 downto 0); --analog
        adc_channel : in std_logic_vector(adc_channel_count - 1 downto 0); --analog
        amuxa : in std_logic; --analog
        amuxb : in std_logic; --analog
        csh : in std_logic; --analog
        cmod : in std_logic; --analog
        shield_pad : in std_logic; --analog
        dedicated_io : in std_logic_vector(dedicated_io_count - 1 downto 0); --analog
        vref_ext : in std_logic; --analog
        vref_pass : in std_logic; --analog
        dsi_sense_out : out std_logic; --digital
        dsi_sample_out : out std_logic; --digital
        dsi_sense_in : in std_logic; --digital
        dsi_sample_in : in std_logic; --digital
        dsi_csh_tank : out std_logic; --digital
        dsi_cmod : out std_logic; --digital
        dsi_hscmp : out std_logic; --digital
        dsi_start : in std_logic; --digital
        dsi_sampling : out std_logic; --digital
        dsi_adc_on : out std_logic; --digital
        dsi_count : out std_logic_vector(15 downto 0); --digital
        dsi_count_val_sel : in std_logic; --digital
        csd_tx : out std_logic; --digital
        csd_tx_n : out std_logic; --digital
        clock : in std_logic; --digital
        interrupt : out std_logic; --digital
        tr_adc_done : out std_logic); --digital
end component;
component cy_mxs40_usb_v1_0
    generic(
        cy_registers : string :="");
    port (
        usb_dp_pad : out std_logic; --digital
        usb_dm_pad : out std_logic; --digital
        interrupt_lo : out std_logic; --digital
        interrupt_med : out std_logic; --digital
        interrupt_hi : out std_logic; --digital
        dma_req : out std_logic_vector(7 downto 0); --digital
        dma_burstend : in std_logic_vector(7 downto 0); --digital
        dsi_usb_sof : out std_logic; --digital
        clk_usb_dev : in std_logic; --digital
        clk_usb_host : in std_logic; --digital
        clock_dev_brs : in std_logic); --digital
end component;
component cy_mxs40_ipc_v1_0
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_crypto_v1_0
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_profile_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        interrupt : out std_logic; --digital
        tr_start : in std_logic; --digital
        tr_stop : in std_logic); --digital
end component;
component cy_mxs40_i2s_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        clk_i2s_if : in std_logic; --digital
        tx_sck_m : out std_logic; --digital
        tx_sck_s : in std_logic; --digital
        tx_ws_m : out std_logic; --digital
        tx_ws_s : in std_logic; --digital
        tx_sdo : out std_logic; --digital
        rx_sck_m : out std_logic; --digital
        rx_sck_s : in std_logic; --digital
        rx_ws_m : out std_logic; --digital
        rx_ws_s : in std_logic; --digital
        rx_sdi : in std_logic; --digital
        tr_i2s_tx_req : out std_logic; --digital
        tr_i2s_rx_req : out std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_pdm_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        pdm_clk : out std_logic; --digital
        pdm_data : in std_logic; --digital
        tr_pdm_rx_req : out std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_lpcomp_v1_0
    generic(
        cy_registers : string :="");
    port (
        inp : in std_logic; --analog
        inn : in std_logic; --analog
        dsi_comp : out std_logic); --digital
end component;
component cy_mxs40_isr_v1_0
    generic(
        cy_registers : string :="";
        deepsleep_required : boolean :=false;
        int_type : std_logic_vector :="00");
    port (
        int_signal : in std_logic); --digital
end component;
component cy_mxs40_samplehold_v1_0
    generic(
        cy_registers : string :="");
    port (
        vin : inout std_logic); --analog
end component;
component cy_mxs40_csidac_v1_0
    generic(
        cy_registers : string :="";
        leg3_needed : boolean :=false);
    port (
        iout : out std_logic; --analog
        dsi_idac_leg1_en : in std_logic; --digital
        dsi_idac_leg2_en : in std_logic; --digital
        dsi_idac_leg3_en : in std_logic; --digital
        dsi_idac_pol : in std_logic); --digital
end component;
component cy_mxs40_opamp_v1_0
    generic(
        cy_registers : string :="";
        has_resistor : boolean :=false;
        deepsleep_available : boolean :=false;
        needs_dsab : boolean :=false);
    port (
        out_1x : out std_logic; --analog
        out_10x : out std_logic; --analog
        vplus : in std_logic; --analog
        vminus : in std_logic; --analog
        ctb_dsi_comp : out std_logic); --digital
end component;
component cy_mxs40_lcd_v1_0
    generic(
        cy_registers : string :="";
        common_width : natural :=1;
        segment_width : natural :=1);
    port (
        clock : in std_logic; --digital
        com : out std_logic_vector(common_width - 1 downto 0); --digital
        seg : out std_logic_vector(segment_width - 1 downto 0)); --digital
end component;
component cy_mxs40_ctdac_v1_0
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        ctdrefdrive : in std_logic; --analog
        ctdrefsense : out std_logic; --analog
        ctdvout : out std_logic; --analog
        ctdvoutsw : out std_logic; --analog
        dsi_ctdac_strobe : in std_logic; --digital
        tr_ctdac_empty : out std_logic); --digital
end component;
component cy_mxs40_ctdac_v1_10
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        ctdrefdrive : in std_logic; --analog
        ctdrefsense : out std_logic; --analog
        ctdvout : out std_logic; --analog
        ctdvoutsw : out std_logic; --analog
        dsi_ctdac_strobe : in std_logic; --digital
        tr_ctdac_empty : out std_logic; --digital
        interrupt_dac : out std_logic); --digital
end component;
component cy_mxs40_sar_v1_0
    generic(
        cy_registers : string :="";
        edge_trigger : boolean :=false);
    port (
        vplus : in std_logic; --analog
        vminus : out std_logic; --analog
        vref : out std_logic; --analog
        ext_vref : out std_logic; --analog
        dsi_sar_sample_done : out std_logic; --digital
        dsi_sar_chan_id_valid : out std_logic; --digital
        dsi_sar_data_valid : out std_logic; --digital
        tr_sar_out : out std_logic; --digital
        dsi_sar_data : out std_logic_vector(11 downto 0); --digital
        dsi_sar_chan_id : out std_logic_vector(3 downto 0); --digital
        dsi_sar_cfg_st_sel : in std_logic_vector(1 downto 0); --digital
        dsi_sar_cfg_average : in std_logic; --digital
        dsi_sar_cfg_differential : in std_logic; --digital
        dsi_sar_sw_negvref : in std_logic; --digital
        dsi_sar_data_hilo_sel : in std_logic; --digital
        tr_sar_in : in std_logic; --digital
        clock : in std_logic; --digital
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_sarmux_v1_0
    generic(
        cy_registers : string :="";
        muxin_width : natural :=4;
        cmn_neg_width : natural :=1;
        input_mode : string :="1");
    port (
        muxin_plus : in std_logic_vector(muxin_width - 1 downto 0); --analog
        muxin_minus : in std_logic_vector(muxin_width - 1 downto 0); --analog
        cmn_neg : in std_logic_vector(cmn_neg_width - 1 downto 0); --analog
        muxout_plus : out std_logic; --analog
        muxout_minus : out std_logic); --analog
end component;
component cy_mxs40_temp_v1_0
    generic(
        cy_registers : string :="");
    port (
        temp : out std_logic); --analog
end component;
component cy_mxs40_mcwdt_v1_0
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end component;
component cy_mxs40_rtc_v1_0
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end component;
end rtlpkg;

--------------------------------------------------------------------------
-- Enties/Architectures for Generic RTL. --
--------------------------------------------------------------------------

--
-- BUFOE
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_bufoe is
    port (x : in std_logic;
     oe : in std_logic;
     y : inout std_logic;
     yfb : out std_logic);
end cy_bufoe;

ARCHITECTURE archRTL OF CY_BUFOE IS
BEGIN
    PROCESS (x, oe)
    BEGIN
        IF (oe = '1') THEN
            if (x = '0') then y <= '0';
            elsif (x = '1') then y <= '1';

            else y <= 'X';

            end if;
        ELSE

            y <= 'Z';

        END IF;

    END PROCESS;

    PROCESS (y)
    BEGIN
        if (y = '1') then yfb <= '1';

        elsif (y = '0') then yfb <= '0';
        else yfb <= 'X';

        end if;

    END PROCESS;
END archRTL;

--
-- DLTCH
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dltch is
    port (d : in std_logic;
     e : in std_logic;
     q : out std_logic);
end cy_dltch;

ARCHITECTURE archRTL OF CY_DLTCH IS
    SIGNAL qx : std_logic;
BEGIN
    qx <= (d and e) or (d and qx) or (not(e) and qx);
    q <= qx;
END archRTL;

--
-- CY_DFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dff is
    port (d : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_dff;

ARCHITECTURE archRTL OF CY_DFF IS
BEGIN
      PROCESS
      BEGIN
          WAIT UNTIL clk = '1';
              q <= d;
      END PROCESS;
END archRTL;

--
-- XDFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_xdff is
    port (x1 : in std_logic;
     x2 : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_xdff;

use work.rtlpkg.all;
ARCHITECTURE archRTL OF CY_XDFF IS
    SIGNAL dx : std_logic;
BEGIN
    dx <= x1 xor x2;
    u1 : CY_DFF port map(dx,clk,q);
END archRTL;

--
-- JKFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_jkff is
    port (j : in std_logic;
     k : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_jkff;

use work.rtlpkg.all;
ARCHITECTURE archRTL OF CY_JKFF IS
    SIGNAL qx, dx : std_logic;
BEGIN
    dx <= (j and not(qx)) or (not(k) and qx);
    q <= qx;
    d1: CY_DFF port map(dx,clk,qx);
END archRTL;

--
-- BUF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_buf is
    port (x : in std_logic;
     y : out std_logic);
end cy_buf;

ARCHITECTURE archRTL OF CY_BUF IS
BEGIN
    y <= x;
END archRTL;

--
-- SRLCH
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_srlch is
    port (s : in std_logic;
     r : in std_logic;
     q : out std_logic);
end cy_srlch;

ARCHITECTURE archRTL OF CY_SRLCH IS
    SIGNAL qx : std_logic;
BEGIN
    qx <= (s and not(r)) or (qx and not(r));
    q <= qx;
END archRTL;

--
-- SRFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_srff is
    port (s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_srff;

use work.rtlpkg.all;
ARCHITECTURE archRTL OF CY_SRFF IS
    SIGNAL qx, dx : std_logic;
BEGIN
    dx <= not ((not(s) or r) and (not (qx) or r));
    q <= qx;
    d: CY_DFF port map(dx,clk,qx);
END archRTL;

--
-- DSRFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dsrff is
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_dsrff;

ARCHITECTURE archRTL OF CY_DSRFF IS
BEGIN
    PROCESS (r, s, clk)
    BEGIN
        IF (r = '1') THEN
            q <= '0';
        ELSIF (s = '1') THEN
            q <= '1';
        ELSIF (clk = '1' AND clk'event) THEN
            q <= d;
        END IF;
    END PROCESS;
END archRTL;

--
-- TSRFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_tsrff is
    port (t : in std_logic;
     s : in std_logic;
     r : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_tsrff;

ARCHITECTURE archRTL of CY_TSRFF IS
   signal dtmp,qtmp : std_logic := '0';
BEGIN
    dtmp <= qtmp xor t;
    PROCESS (r, s, clk)
    BEGIN
        IF (r = '1') THEN
            qtmp <= '0';
        ELSIF (s = '1') THEN
            qtmp <= '1';
        ELSIF (clk = '1' AND clk'event) THEN
            qtmp <= dtmp;
        END IF;
    END PROCESS;
    q <= qtmp;
END archRTL;

--
-- TFF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_tff is
    port (t : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_tff;

use work.rtlpkg.all;
ARCHITECTURE archRTL OF CY_TFF IS
    SIGNAL qx, dx : std_logic;
BEGIN
    dx <= t xor qx;
    q <= qx;
    d: CY_DFF port map(dx,clk,qx);
END archRTL;

--
-- XBUF
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_xbuf is
    port (x1 : in std_logic;
     x2 : in std_logic;
     q : out std_logic);
end cy_xbuf;

ARCHITECTURE archRTL OF CY_XBUF IS
BEGIN
    q <= x1 xor x2;
END archRTL;

--
-- TRIOUT
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_triout is
    port (x : in std_logic;
     oe : in std_logic;
     y : out std_logic);
end cy_triout;

ARCHITECTURE archRTL OF CY_TRIOUT IS
BEGIN
    PROCESS (x, oe)
    BEGIN
        IF (oe = '1') THEN
            if (x = '0') then y <= '0';
            elsif (x = '1') then y <= '1';

            else y <= 'X';

            end if;
        ELSE

            y <= 'Z';

        END IF;
    END PROCESS;
END archRTL;

--
-- DSRLCH
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dsrlch is
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     q : out std_logic);
end cy_dsrlch;

ARCHITECTURE archRTL of CY_DSRLCH IS
    signal qi: std_logic;
BEGIN
    qi <= (NOT(R) AND (S OR (D AND E) OR (qi AND NOT(E))));
    Q <= qi;
end archRTL;

--
-- DSRFFE
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dsrffe is
    port (d : in std_logic;
     s : in std_logic;
     r : in std_logic;
     e : in std_logic;
     clk : in std_logic;
     q : out std_logic);
end cy_dsrffe;

architecture archRTL of CY_DSRFFE is
begin
    PROCESS (r, s, clk)
    BEGIN
        IF (r = '1') THEN
            q <= '0';
        ELSIF (s = '1') THEN
            q <= '1';
        ELSIF (clk = '1' AND clk'event) THEN
            IF (e = '1') THEN
                q <= d;
            END IF;
        END IF;
    END PROCESS;
end archRTL;

--
-- CY_C39KCARRY
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_c39kcarry is
    port (SelIn : in std_logic;
     Cpt0 : in std_logic;
     Cpt1 : in std_logic;
     SelOut : out std_logic);
end cy_c39kcarry;

architecture archRTL of CY_C39KCARRY is
begin
    SelOut <= ((NOT SelIn) AND Cpt0) OR (SelIn AND (NOT Cpt1));
end archRTL;

--
-- CY_C39KXOR
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_c39kxor is
    port (SIn : in std_logic;
     PtmPts : in std_logic;
     XorOut : out std_logic);
end cy_c39kxor;

architecture archRTL of CY_C39KXOR is
begin
    XorOut <= SIn XOR PtmPts;
end archRTL;

--
-- CY_C39KPLL
--
library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;
entity cy_c39kpll is
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
end cy_c39kpll;
architecture archRTL of CY_C39KPLL is
begin
end archRTL;

--
-- CY_25G01SERDES
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_25g01serdes is

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

end cy_25g01serdes;
architecture archRTL of cy_25g01serdes is
begin
    -- These are dummy assignments
    serial_out_n <= '0';
    serial_out_p <= '0';
    fifo_err <= '0';
    txclk <= '0';
    rxd <= (others => '0');
    rxclk <= '0';
    lfib <= '0';
end archRTL;

--
-- CY_2GSERDES
--
library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.cy_25g01serdes;
entity cy_2gserdes is

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

end cy_2gserdes;
architecture archRTL of cy_2gserdes is
begin

    UA: cy_25g01serdes port map (
            txd => txd,
            fifo_rstb => fifo_rstb,
            loop_time => loop_time,
            diagloop => diagloop,
            loopa => loopa,
            lineloop => lineloop,
            resetb => resetb,
            pwrdnb => pwrdnb,
            lockrefb => lockrefb,
            refclk_n => refclk_n,
            refclk_p => refclk_p,
            serial_in_n => serial_in_n,
            serial_in_p => serial_in_p,
            sd => sd,
            serial_out_n=> serial_out_n,
            serial_out_p=> serial_out_p,
            fifo_err => fifo_err,
            txclk => txclk,
            rxd => rxd,
            rxclk => rxclk,
            lfib => lfib);

end archRTL;

--
-- CY_15G04SERDES
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_15g04serdes is

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

end cy_15g04serdes;
architecture archRTL of cy_15g04serdes is
begin
    -- These are dummy assignments
    txpera <= '0';
    txperb <= '0';
    txperc <= '0';
    txperd <= '0';
    txclko_p <= '0';
    rxda <= (others => '0');
    rxdb <= (others => '0');
    rxdc <= (others => '0');
    rxdd <= (others => '0');
    rxsta <= (others => '0');
    rxstb <= (others => '0');
    rxstc <= (others => '0');
    rxstd <= (others => '0');
    rxclka_p <= '0';
    rxclkb_p <= '0';
    rxclkc_p <= '0';
    rxclkd_p <= '0';
    serial_outa1_p <= '0';
    serial_outb1_p <= '0';
    serial_outc1_p <= '0';
    serial_outd1_p <= '0';
    serial_outa2_p <= '0';
    serial_outb2_p <= '0';
    serial_outc2_p <= '0';
    serial_outd2_p <= '0';
    serial_outa1_n <= '0';
    serial_outb1_n <= '0';
    serial_outc1_n <= '0';
    serial_outd1_n <= '0';
    serial_outa2_n <= '0';
    serial_outb2_n <= '0';
    serial_outc2_n <= '0';
    serial_outd2_n <= '0';
    bondst <= (others => '0');
    bond_all <= '0';
    lfiab <= '0';
    lfibb <= '0';
    lficb <= '0';
    lfidb <= '0';
end archRTL;

--
-- CY_C39KMULTIPLY
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.cypress.all;
entity cy_c39kmultiply is
    generic(IsSigned : BOOLEAN := FALSE;
 DataWidthA : positive;
 DataWidthB : positive;
 DataWidthP : positive;

 Hint : goal_type := memory);

    port (Data_A : in std_logic_vector(DataWidthA-1 downto 0);
     Data_B : in std_logic_vector(DataWidthB-1 downto 0);
     Product : out std_logic_vector(DataWidthP-1 downto 0));
end cy_c39kmultiply;
architecture archRTL of cy_c39kmultiply is
begin
end archRTL;

--
-- Entities for Memory RTLs.
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_c39kdualport is
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
end cy_c39kdualport;
library ieee;
use ieee.std_logic_1164.all;
entity cy_c39kfifo is
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
end cy_c39kfifo;
library ieee;
use ieee.std_logic_1164.all;
entity cy_c39ksingleport is
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
end cy_c39ksingleport;
architecture archRTL of cy_c39kdualport is
begin
end archRTL;

architecture archRTL of cy_c39kfifo is
begin
end archRTL;

architecture archRTL of cy_c39ksingleport is
begin
end archRTL;

--
-- PSoC3 Data Path
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_dp is
    generic(cy_dpconfig : std_logic_vector (207 downto 0) :=
     X"0000_0000_0000_0000_0000_0000_0000_0000_FFFF_FFFF_0000_0000_0000";
     d0_init : std_logic_vector (7 downto 0) := (others => '0');
     d1_init : std_logic_vector (7 downto 0) := (others => '0');
     a0_init : std_logic_vector (7 downto 0) := (others => '0');
     a1_init : std_logic_vector (7 downto 0) := (others => '0');
     ce0_sync : std_logic := '1';
     cl0_sync : std_logic := '1';
     z0_sync : std_logic := '1';
     ff0_sync : std_logic := '1';
     ce1_sync : std_logic := '1';
     cl1_sync : std_logic := '1';
     z1_sync : std_logic := '1';
     ff1_sync : std_logic := '1';
     ov_msb_sync : std_logic := '1';
     co_msb_sync : std_logic := '1';
     cmsb_sync : std_logic := '1';
     so_sync : std_logic := '1';
     f0_bus_sync : std_logic := '1';
     f0_blk_sync : std_logic := '1';
     f1_bus_sync : std_logic := '1';
     f1_blk_sync : std_logic := '1');
    port (reset : in std_logic := '0';
     clk : in std_logic := '0';
     cs_addr : in std_logic_vector (2 downto 0) := "000";
     route_si : in std_logic := '0';
     route_ci : in std_logic := '0';
     f0_load : in std_logic := '0';
     f1_load : in std_logic := '0';
     d0_load : in std_logic := '0';
     d1_load : in std_logic := '0';
     ce0 : out std_logic;
     cl0 : out std_logic;
     z0 : out std_logic;
     ff0 : out std_logic;
     ce1 : out std_logic;
     cl1 : out std_logic;
     z1 : out std_logic;
     ff1 : out std_logic;
     ov_msb : out std_logic;
     co_msb : out std_logic;
     cmsb : out std_logic;
     so : out std_logic;
     f0_bus_stat : out std_logic;
     f0_blk_stat : out std_logic;
     f1_bus_stat : out std_logic;
     f1_blk_stat : out std_logic;
     ce0_reg : out std_logic;
     cl0_reg : out std_logic;
     z0_reg : out std_logic;
     ff0_reg : out std_logic;
     ce1_reg : out std_logic;
     cl1_reg : out std_logic;
     z1_reg : out std_logic;
     ff1_reg : out std_logic;
     ov_msb_reg : out std_logic;
     co_msb_reg : out std_logic;
     cmsb_reg : out std_logic;
     so_reg : out std_logic;
     f0_bus_stat_reg : out std_logic;
     f0_blk_stat_reg : out std_logic;
     f1_bus_stat_reg : out std_logic;
     f1_blk_stat_reg : out std_logic;
     ci : in std_logic := '0';
     co : out std_logic;
     sir : in std_logic := '0';
     sor : out std_logic;
     sil : in std_logic := '0';
     sol : out std_logic;
     msbi : in std_logic := '0';
     msbo : out std_logic;
     cei : in std_logic_vector (1 downto 0) := "00";
     ceo : out std_logic_vector (1 downto 0);
     cli : in std_logic_vector (1 downto 0) := "00";
     clo : out std_logic_vector (1 downto 0);
     zi : in std_logic_vector (1 downto 0) := "00";
     zo : out std_logic_vector (1 downto 0);
     fi : in std_logic_vector (1 downto 0) := "00";
     fo : out std_logic_vector (1 downto 0);
     capi : in std_logic_vector (1 downto 0) := "00";
     capo : out std_logic_vector (1 downto 0);
     cfbi : in std_logic := '0';
     cfbo : out std_logic;
     pi : in std_logic_vector (7 downto 0) := "00000000";
     po : out std_logic_vector (7 downto 0));
end cy_psoc3_dp;

architecture archRTL of cy_psoc3_dp is
begin
end archRTL;

--
-- PSoC3 Carry Chain
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_carry is
    port (Cin : in std_logic;
     Cpt0 : in std_logic;
     Cpt1 : in std_logic;
     Sum : out std_logic;
     Cout : out std_logic);
end cy_psoc3_carry;

architecture archRTL of cy_psoc3_carry is
begin
end archRTL;

--
-- PSoC3 Status Register
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_status is
    generic(cy_force_order : boolean := false;
     cy_md_select : std_logic_vector (7 downto 0) := "00000000");
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     status : in std_logic_vector (7 downto 0));
end cy_psoc3_status;

architecture archRTL of cy_psoc3_status is
begin
end archRTL;

--
-- PSoC3 Status Register with interrupt
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_statusi is
    generic(cy_force_order : boolean := false;
     cy_md_select : std_logic_vector (6 downto 0) := "0000000";
     cy_int_mask : std_logic_vector (6 downto 0) := "0000000");
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     status : in std_logic_vector (6 downto 0);
     interrupt : out std_logic);
end cy_psoc3_statusi;

architecture archRTL of cy_psoc3_statusi is
begin
end archRTL;

--
-- PSoC3 Control Register
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_control is
    generic(cy_init_value : std_logic_vector (7 downto 0) := "00000000";
     cy_force_order : boolean := false;
     cy_ctrl_mode_1 : std_logic_vector (7 downto 0) := "00000000";
     cy_ctrl_mode_0 : std_logic_vector (7 downto 0) := "00000000";
     cy_ext_reset : boolean := false);
    port (reset : in std_logic := '0';
     clock : in std_logic := '0';
     control : out std_logic_vector (7 downto 0));
end cy_psoc3_control;

architecture archRTL of cy_psoc3_control is
begin
end archRTL;

--
-- PSoC3 Interrupt Control
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_isr_v1_0 is
    generic(int_type : std_logic_vector := ""; -- 00 = Rising Edge
      -- 01 = Level
      -- 10 = 'derived', which is the old AUTO
         is_nmi : boolean := false);
    port (int_signal : in std_logic);
end cy_isr_v1_0;

architecture archRTL of cy_isr_v1_0 is
begin
end archRTL;

--
-- PSoC3 DMA Request
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_dma_v1_0 is
    generic(drq_type : std_logic_vector := ""; -- 00 = Rising Edge
      -- 01 = Level
      -- 10 = 'derived', which is the old AUTO
         num_tds : natural := 0); -- deprecated, no longer supported
    port (drq : in std_logic := '0';
     trq : in std_logic := '0';
     nrq : out std_logic);
end cy_dma_v1_0;

architecture archRTL of cy_dma_v1_0 is
begin
end archRTL;

--
-- PSoC3 7-std_logic Counter
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_count7 is
    generic(cy_period : std_logic_vector (6 downto 0) := "1111111";
            cy_init_value : std_logic_vector (6 downto 0) := "0000000";
     cy_route_ld : boolean := false;
     cy_route_en : boolean := false;
     cy_alt_mode : boolean := false);
    port (clock : in std_logic;
     reset : in std_logic;
     load : in std_logic;
     enable : in std_logic;
     count : out std_logic_vector (6 downto 0);
     tc : out std_logic);
end cy_psoc3_count7;

architecture archRTL of cy_psoc3_count7 is
begin
end archRTL;

--
-- PSoC3 Sync Component
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_sync is
    port (clock : in std_logic := '0';
     sc_in : in std_logic;
     sc_out : out std_logic);
end cy_psoc3_sync;

architecture archRTL of cy_psoc3_sync is
begin
end archRTL;

--
-- PSoC3 Clock Enable Component
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_udb_clock_enable_v1_0 is
    generic(sync_mode : boolean := true);
    port (clock_in : in std_logic := '0';
     enable : in std_logic := '1';
     clock_out : out std_logic);
end cy_psoc3_udb_clock_enable_v1_0;

architecture archRTL of cy_psoc3_udb_clock_enable_v1_0 is
begin
end archRTL;

--
-- PSoC3 Analog Components
--
library ieee;
use ieee.std_logic_1164.all;
-- ********************* DeltaSigma_Mod ***************************** --

entity cy_psoc3_ds_mod_v1_0 is
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end cy_psoc3_ds_mod_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* DeltaSigma_Mod ***************************** --

entity cy_psoc3_ds_mod_v2_0 is
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end cy_psoc3_ds_mod_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* DeltaSigma_Mod ***************************** --

entity cy_psoc3_ds_mod_v3_0 is
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     ext_vssa : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end cy_psoc3_ds_mod_v3_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* DeltaSigma_Mod ***************************** --

entity cy_psoc3_ds_mod_v4_0 is
    generic(cy_registers : string := "";
     resolution : positive := 12); -- DSM resolutn
    port (aclock : in std_logic; -- digital
     vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     modbit : in std_logic; -- digital
     reset_udb : in std_logic; -- digital
     reset_dec : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     extclk_cp_udb : in std_logic; -- digital
     ext_pin_1 : in std_logic; -- analog
     ext_pin_2 : in std_logic; -- analog
     ext_vssa : in std_logic; -- analog
     qtz_ref : in std_logic; -- analog
     dec_clock : out std_logic; -- digital
     mod_dat : out std_logic_vector(3 downto 0); -- digital
     dout_udb : out std_logic_vector(7 downto 0));-- digital
end cy_psoc3_ds_mod_v4_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** Decimator ******************************* --

entity cy_psoc3_decimator_v1_0 is
    generic(cy_registers: string := "");
    port (aclock : in std_logic; -- digital
     mod_dat : in std_logic_vector(3 downto 0); -- digital
     ext_start : in std_logic; -- digital
     mod_reset : out std_logic; -- digital
     interrupt : out std_logic); -- digital
end cy_psoc3_decimator_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* VIDAC ***************************** --

entity cy_psoc3_vidac8_v1_0 is
    generic(cy_registers: string := "";
         reg_data : boolean := true;
     is_all_if_any:boolean := true);
    port (reset : in std_logic := '0'; -- digital
     idir : in std_logic := '0'; -- digital
     ioff : in std_logic := '0'; -- digital
     data : in std_logic_vector (7 downto 0)
        := (others => '0'); -- digital
     strobe : in std_logic := '0'; -- digital
     strobe_udb : in std_logic := '0'; -- digital
     vout : out std_logic; -- analog
     iout : out std_logic); -- analog
end cy_psoc3_vidac8_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* SCBLOCK ***************************** --

entity cy_psoc3_scblock_v1_0 is
    generic(cy_registers: string := "");
    port (vref : in std_logic; -- analog
     vin : in std_logic; -- analog
     aclk : in std_logic; -- digital
     bst_clk : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     dyn_cntl : in std_logic; -- digital
     modout_sync : out std_logic; -- digital
     vout : out std_logic); -- analog
end cy_psoc3_scblock_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Comparator ***************************** --

entity cy_psoc3_ctcomp_v1_0 is
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     clock : in std_logic; -- digital
     clk_udb : in std_logic; -- digital
     cmpout : out std_logic); -- digital
end cy_psoc3_ctcomp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* AMUX ***************************** --

entity cy_psoc3_amux_v1_0 is
    generic(cy_registers: string := "";
     muxin_width : positive := 8;
     hw_control : boolean := false;
     one_active : boolean := false;
     init_mux_sel: std_logic_vector := "00000000"; -- Deflt selector (mask)
          -- Same size as muxin.
     api_type : natural := 0; -- 0 = table driven
          -- 1 = sequential
          -- 2 = hardware
     connect_mode: natural := 1); -- 0 = single_ended
          -- 1 = double_static
          -- 2 = double_dynamic
    port (muxin : inout std_logic_vector (muxin_width-1 downto 0); -- analog
     hw_ctrl_en : in std_logic_vector (muxin_width-1 downto 0)
        := (others => '0'); -- digital
     vout : inout std_logic); -- analog
end cy_psoc3_amux_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* ABUF ***************************** --

entity cy_psoc3_abuf_v1_0 is
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vout : out std_logic); -- analog
end cy_psoc3_abuf_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Cap Sense ABUF ***************************** --

entity cy_psoc3_csabuf_v1_0 is
   generic(cy_registers: string := "");
   port (vchan : in std_logic; -- analog
    vref : in std_logic; -- analog
           vout : out std_logic; -- analog
    swon : in std_logic := '0'); -- digital
end cy_psoc3_csabuf_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* VREF ***************************** --

entity cy_psoc3_vref_v1_0 is
    generic(cy_registers: string := "";
     vref_value : string);
    port (vref : out std_logic); -- analog
end cy_psoc3_vref_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *** Place holder to force the back end to keep this analog signal *** --

entity cy_analog_marker_v1_0 is
    port (marker : in std_logic); -- analog
end cy_analog_marker_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *** This component is used to connect analog signals together *** --

entity cy_connect_v1_0 is
    generic(sig_width : positive := 1;
     is_net_join : boolean := false);
    port (signal1 : in std_logic_vector (sig_width-1 downto 0); -- analog
     signal2 : in std_logic_vector (sig_width-1 downto 0)); -- analog
end cy_connect_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* LPF ***************************** --

entity cy_psoc3_lpf_v1_0 is
    generic(cy_registers: string := "");
    port (vin : in std_logic; -- analog
     vout : out std_logic); -- analog
end cy_psoc3_lpf_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* SAR3 ***************************** --

entity cy_psoc3_sar_v1_0 is
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     clock : in std_logic; -- digital
     pump_clock : in std_logic; -- digital
     sof_udb : in std_logic; -- digital
     clk_udb : in std_logic := '0'; -- digital
     vp_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     vn_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     irq : out std_logic; -- digital
     data_out : out std_logic_vector(11 downto 0);-- digital
     eof_udb : out std_logic); -- digital
end cy_psoc3_sar_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* SAR5 ***************************** --

entity cy_psoc5_sar_v2_0 is
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     ext_pin : inout std_logic; -- analog
     vrefhi_out : out std_logic; -- analog
     vref : in std_logic; -- analog
     clock : in std_logic; -- digital
     pump_clock : in std_logic; -- digital
     sof_udb : in std_logic; -- digital
     clk_udb : in std_logic := '0'; -- digital
     vp_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     vn_ctl_udb : in std_logic_vector (3 downto 0)
        := (others => '0'); -- digital
     irq : out std_logic; -- digital
     next_out : out std_logic; -- digital
     data_out : out std_logic_vector(11 downto 0);-- digital
     eof_udb : out std_logic); -- digital
end cy_psoc5_sar_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* VREF ***************************** --

entity cy_vref_v1_0 is
    generic(guid : string := "";
     name : string := "";
     autoenable : boolean := false;
     ignoresleep : boolean := false);
    port (vout : out std_logic); -- analog
end cy_vref_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *** Component to denote where there are analog connections that are *** --
-- *** *meant* to be unconnected, so we can detect the unintentional ones *** --

entity cy_analog_noconnect_v1_0 is
       port (noconnect : inout std_logic); -- analog
end cy_analog_noconnect_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Location ***************************** --

entity cy_analog_location_v1_0 is
    generic(guid : string := "";
     name : string := "";
  is_always_static : boolean := false;
  is_amux_constraint : boolean := false;
  exclusive_use : boolean := false);
    port (connect : inout std_logic); -- analog
end cy_analog_location_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Terminal Reserve ***************************** --

entity cy_terminal_reserve_v1_0 is
    port (connect : inout std_logic); -- analog
end cy_terminal_reserve_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Stay Awake Component ***************************** --

entity cy_stay_awake_v1_0 is
    port (connect : inout std_logic); -- analog
end cy_stay_awake_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Annotation Universal Component ********************* --
entity cy_annotation_universal_v1_0 is
    generic(comp_name : string := "";
     port_names : string := "";
     width : positive := 2);
    port (connect : inout std_logic_vector (width-1 downto 0));
end cy_annotation_universal_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Annotation Noconnect Component ********************* --
entity cy_annotation_noconnect_v1_0 is
   port (noconnect : inout std_logic);
end cy_annotation_noconnect_v1_0;
architecture archRTL of cy_psoc3_ds_mod_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_ds_mod_v2_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_ds_mod_v3_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_ds_mod_v4_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_decimator_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_vidac8_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_scblock_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_ctcomp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_amux_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_abuf_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_csabuf_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_vref_v1_0 is
begin
end archRTL;

architecture archRTL of cy_analog_marker_v1_0 is
begin
end archRTL;

architecture archRTL of cy_connect_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_lpf_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_sar_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc5_sar_v2_0 is
begin
end archRTL;

architecture archRTL of cy_vref_v1_0 is
begin
end archRTL;

architecture archRTL of cy_analog_noconnect_v1_0 is
begin
end archRTL;

architecture archRTL of cy_analog_location_v1_0 is
begin
end archRTL;

architecture archRTL of cy_terminal_reserve_v1_0 is
begin
end archRTL;

architecture archRTL of cy_stay_awake_v1_0 is
begin
end archRTL;

architecture archRTL of cy_annotation_universal_v1_0 is
begin
end archRTL;

architecture archRTL of cy_annotation_noconnect_v1_0 is
begin
end archRTL;

--
-- Port component
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_port_v1_0 is
    generic(width : natural := 0; -- number of pins
            siorefwidth : natural := 0; -- number of SIO refs (width/2)
            pin_aliases : string := ""; -- CSV of aliases
            id : string := ""; -- id from the GUI
            access_mode : string := "SW_ONLY"; -- SW_ONLY, HW_ONLY,
                                                        -- LCD, EMIF
            layout_mode : string := "CONTIGUOUS";-- CONTIGUOUS,
                                                        -- NONCONTIGUOUS
            port_mode : string := "INPUT"; -- INPUT, OUTPUT,
                                                        -- INOUT, ANALOG
                                                        -- BIDIRECTIONAL
            vtrip : std_logic := '0'; -- 0 = CMOS
                                                        -- 1 = LVTTL
            slew_rate : std_logic_vector := ""; -- 0 = Fast, 1 = Slow
            intr_mode : std_logic_vector := ""; -- size is width*2
            drive_mode : std_logic_vector := ""; -- size is width*3
            lcd_sw_drive: boolean := false; -- False = HW drives LCD
                                                        -- True = SW drives LCD
            lcd_com_seg : std_logic_vector := ""; -- size is width
            por_state : natural := 0; -- 0 = inp dis, out hi-Z
                                                        -- 1 = inp en, out hi-Z
                                                        -- 2 = inp dis, out '0' (pullup)
                                                        -- 3 = inp dis, out '1' (pulldown)
            emif_mode : string := ""; -- default "" = not EMIF
                                                        -- MSB_ADDR, MID_ADDR,
                                                        -- LSB_ADDR,
                                                        -- MSB_DATA, LSB_DATA,
                                                        -- CONTROL
            enable_shielding : std_logic_vector := ""; -- 0 = FALSE, 1 = TRUE
            cs_mode : std_logic_vector (1 downto 0) := "00"; -- 00 = Neither
                                                                -- 01 = Pull Up
                                                                -- 10 = None
                                                                -- 11 = Pull Dn
            sio_obuf : std_logic_vector := ""; -- SIO Output buf, size =width/2
                                                -- 0 = unreulated, 1 = regulated
            sio_ibuf : std_logic_vector := ""; -- SIO INput buf, size =width/2
                                                -- 0 = sngl end, 1 =differential
            sio_hyst : std_logic_vector := ""; -- SIO Output buf, size = width
                                                -- 0 = disabled, 1 = enabled
            sio_hifreq : std_logic_vector := ""; -- SIO PU current, size =width/2
                                                -- 0 = low, 1 = high
            sio_vtrip : std_logic_vector := ""; -- SIO Vtrip set, size = width/2
                                                -- 0 = 0.5 mult, 1 = 0.4 or 1
            sio_refsel : std_logic_vector := ""; -- SIO Vref sel, size = width/2
                                                -- 0 = vcc_io, 1 = vohref
            port_alias_required : std_logic := '0'; -- 0 = Does not require port alias mask
                                                -- 1 = Requires port alias mask
            port_alias_group : string := ""); -- Name of group, used to allow multiple
                                                -- ports using mask in the same phy. port

    port ( oe : in std_logic := '1'; -- Output Enable
            y : in std_logic_vector (width-1 downto 0); -- Input
            fb : out std_logic_vector (width-1 downto 0); -- Feed back
            analog : inout std_logic_vector (width-1 downto 0); -- Analog Port
            io : inout std_logic_vector (width-1 downto 0); -- Bidirectional
            siovref : inout std_logic_vector (siorefwidth-1 downto 0); -- Analog SIO Vref
            interrupt : out std_logic; -- Interrupt
            precharge : in std_logic := '0'); -- Capsense
end cy_psoc3_port_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_pins_v1_10 is
    generic(id : string := ""; -- id from the GUI
            drive_mode : std_logic_vector := ""; -- size = width * 3
                                                        -- 000 = Analog Hi-Z
                                                        -- 001 = Digital Hi-Z
                                                        -- 010 = Res Pull Up
                                                        -- 011 = Res Pull Down
                                                        -- 100 = Open Drain Lo
                                                        -- 101 = Open Drain Hi
                                                        -- 110 = CMOS Out
                                                        -- 111 = Res PullUp/Down
            ibuf_enabled : std_logic_vector := ""; -- size = width
                                                        -- 0 = enabled
                                                        -- 1 = disabled
            init_dr_st : std_logic_vector := ""; -- intial drive state
                                                        -- size = width
                                                        -- 0 = low
                                                        -- 1 = high
            input_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            input_clk_en: std_logic := '0'; -- 0 = rising edge
                                                        -- 1 = level
            input_sync_mode : std_logic_vector:= ""; -- size = width
                                                        -- 0 = double
                                                        -- 1 = single
            intr_mode : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = None
                                                        -- 01 = Rising Edge
                                                        -- 10 = Falling Edge
                                                        -- 11 = On Change
            invert_in_clock : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_in_clock_en : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_in_reset : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_clock : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_clock_en : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            invert_out_reset : std_logic := '0'; -- 0 = normal
                                                        -- 1 = inverted
            io_voltage : string := ""; -- CSV IO supply volts
                                                        -- each volt is a float
            layout_mode : string := "CONTIGUOUS";-- CONTIGUOUS,
                                                        -- NONCONTIGUOUS
            output_conn : std_logic_vector := ""; -- size = width
                                                        -- 0 = not visible
                                                        -- 1 = visible
            output_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            output_clk_en: std_logic := '0'; -- 0 = rising edge
                                                        -- 1 = level
            output_mode : std_logic_vector := ""; -- size = width
                                                        -- 0 = data
                                                        -- 1 = clock
            output_reset: std_logic := '0'; -- 0 = don't use reset
                                                        -- 1 = use reset
            output_clock_mode : std_logic_vector:= ""; -- size = width, when mode is clock
                                                        -- 0 = normal
                                                        -- 1 = inverted
            oe_sync : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            oe_conn : std_logic_vector := ""; -- size = width
                                                        -- 0 = not visible
                                                        -- 1 = visible
            oe_reset : std_logic := '0'; -- 0 = don't use reset
                                                        -- 1 = use reset
            pin_aliases : string := ""; -- CSV of aliases
            pin_mode : string := ""; -- size = width
                                                        -- I = input
                                                        -- O = output
                                                        -- A = analog only
                                                        -- B = bidirectional
            por_state : natural := 0; -- 0 = High-Z Analog
                                                        -- 1 = High-Z Dig (NA)
                                                        -- 2 = Pulled up
                                                        -- 3 = Pulled down
                                                        -- 4 = Dont care
            sio_group_cnt : natural := 0; -- # SIO pairs/singles
            sio_hifreq : std_logic_vector := ""; -- SIO PU current
                                                        -- size = sio_group_cnt
                                                        -- 0 = low
                                                        -- 1 = high
            sio_hyst : std_logic_vector := ""; -- size = width
                                                        -- 0 = disabled
                                                        -- 1 = enabled
            sio_ibuf : std_logic_vector := ""; -- SIO Input buf
                                                        -- size = sio_group_cnt
                                                        -- 0 = single ended
                                                        -- 1 = differential
            sio_info : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = not SIO
                                                        -- 01 = SIO single
                                                        -- 10 = #1 of SIO pair
                                                        -- 11 = #2 of SIO Pair
            sio_obuf : std_logic_vector := ""; -- SIO Output buf
                                                        -- size = sio_group_cnt
                                                        -- 0 = unreulated
                                                        -- 1 = regulated
            sio_refsel : std_logic_vector := ""; -- SIO Vref sel
                                                        -- size = sio_group_cnt
                                                        -- 0 = vcc_io,
                                                        -- 1 = vohref
            sio_vtrip : std_logic_vector := ""; -- SIO Vtrip set
                                                        -- size = sio_group_cnt
                                                        -- 0 = 0.5 mult
                                                        -- 1 = 0.4 or 1
     sio_vohsel : std_logic_vector := ""; -- SIO VOH multiplier setting
       -- size = sio_group_cnt * 3
       -- See SIO.PAIR_VOH_SEL field values
            slew_rate : std_logic_vector := ""; -- size = width
                                                        -- 0 = Fast
                                                        -- 1 = Slow
            spanning : std_logic := '0'; -- 0 = not spanning
                                                        -- 1 = spanning
            sw_only : std_logic := '0'; -- 0 = HW/SW
                                                        -- 1 = SW ONLY
            vtrip : std_logic_vector := ""; -- size = width * 2
                                                        -- 00 = CMOS
                                                        -- 01 = LVTTL
                                                        -- 10 = CMOS or LVTTL
            width : natural := 0; -- number of pins
            port_alias_required : std_logic := '0'; -- 0 = Does not require port alias mask
                                                        -- 1 = Requires port alias mask
            port_alias_group : string := ""; -- Name of group, used to allow multiple
                                                        -- ports using mask in the same phy. port
            use_annotation : std_logic_vector := "";
            pa_in_clock : integer := -1; -- index of pin to use a PA input to in_clock
            pa_in_clock_en : integer := -1; -- index of pin to use a PA input to in_clock_en
            pa_in_reset : integer := -1; -- index of pin to use a PA input to in_reset
            pa_out_clock : integer := -1; -- index of pin to use a PA input to out_clock
            pa_out_clock_en: integer := -1; -- index of pin to use a PA input to out_clock_en
            pa_out_reset : integer := -1; -- index of pin to use a PA input to out_reset
            ovt_needed : std_logic_vector := ""; -- size = width
                                                        -- overvoltage needed
            ovt_slew_control : std_logic_vector := ""; -- size = width * 2
                                                        -- ovt slew control, range
            ovt_hyst_trim : std_logic_vector := ""; -- size = width
                                                        -- ovt hysteresis trim
            input_buffer_sel : std_logic_vector := ""); -- size = width * 2
                                                        -- GPIOv2 input buffer mode

    port ( oe : in std_logic_vector (width-1 downto 0); -- Output Enable
            y : in std_logic_vector (width-1 downto 0); -- Input
            fb : out std_logic_vector (width-1 downto 0); -- Feed back
            analog : inout std_logic_vector (width-1 downto 0); -- Analog Port
            io : inout std_logic_vector (width-1 downto 0); -- Bidirectional
            siovref : inout std_logic_vector; -- Analog SIO Vref
            annotation : inout std_logic_vector (width-1 downto 0); -- Off chip conn
            in_clock : in std_logic := '0'; -- Clock for input register
            in_clock_en : in std_logic := '1'; -- Clock Enable for input register
            in_reset : in std_logic := '0'; -- Reset for input register
            out_clock : in std_logic := '0'; -- Clock for output register
            out_clock_en: in std_logic := '1'; -- Clock Enable for output register
            out_reset : in std_logic := '0'; -- Reset for output register
            interrupt : out std_logic); -- Interrupt
end cy_psoc3_pins_v1_10;
architecture archRTL of cy_psoc3_port_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_pins_v1_10 is
begin
end archRTL;

--
-- PSoC3 Fixed Digital Components
--
library ieee;
use ieee.std_logic_1164.all;
-- ****************** Controller Area Network Controller ********************

entity cy_psoc3_can_v1_0 is
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     can_rx : in std_logic;
     can_tx : out std_logic;
     can_tx_en : out std_logic;
     interrupt : out std_logic);
end cy_psoc3_can_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- **************** Inter-Integrated Circuit Controller **********************

entity cy_psoc3_i2c_v1_0 is
    generic(cy_registers: string := "";
     use_wakeup : boolean := false);
    port (clock : in std_logic;
     scl_in : in std_logic;
     sda_in : in std_logic;
     scl_out : out std_logic;
     sda_out : out std_logic;
     interrupt : out std_logic);
end cy_psoc3_i2c_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Timer/Counter/PWM *****************************

entity cy_psoc3_timer_v1_0 is
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     kill : in std_logic;
     enable : in std_logic;
     capture : in std_logic;
     timer_reset : in std_logic;
     tc : out std_logic;
     compare : out std_logic;
     interrupt : out std_logic);
end cy_psoc3_timer_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Digital Filter Block *****************************

entity cy_psoc3_dfb_v1_0 is
    generic(cy_registers: string := "");
    port (clock : in std_logic;
     in_1 : in std_logic;
     in_2 : in std_logic;
     out_1 : out std_logic;
     out_2 : out std_logic;
     dmareq_1 : out std_logic;
     dmareq_2 : out std_logic;
     interrupt : out std_logic);
end cy_psoc3_dfb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *************************** USB Block **********************************

entity cy_psoc3_usb_v1_0 is
    generic(cy_registers: string := "");
    port (dp : inout std_logic; -- analog;
     dm : inout std_logic; -- analog;
     sof_int : out std_logic;
     arb_int : out std_logic;
     usb_int : out std_logic;
     ept_int : out std_logic_vector (8 downto 0);
     ord_int : out std_logic;
     dma_req : out std_logic_vector (7 downto 0);
     dma_termin : out std_logic);
end cy_psoc3_usb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** LCD Control Block ******************************

entity cy_psoc3_lcd_v1_0 is
    generic(cy_registers: string := "";
     global_bias : boolean := false);
    port (drive_en : in std_logic;
     en_hi : in std_logic;
     frame : in std_logic;
     data_clk : in std_logic;
     dac_dis : in std_logic;
     chop_clk : in std_logic;
     bias : inout std_logic_vector (4 downto 0)); -- analog
end cy_psoc3_lcd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** LCD Control Block ******************************

entity cy_psoc3_lcd_v2_0 is
    generic(cy_registers: string := "";
     global_bias : boolean := false);
    port (drive_en : in std_logic;
     frame : in std_logic;
     data_clk : in std_logic;
     int_clr : in std_logic;
     lp_ack_udb : in std_logic;
     mode_1 : in std_logic;
     mode_2 : in std_logic;
     interrupt : out std_logic;
     bias : inout std_logic_vector (4 downto 0)); -- analog
end cy_psoc3_lcd_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** CLK Control Block ******************************

entity cy_clock_v1_0 is
    generic(cy_registers: string := "";
     id : string := "";
     source_clock_id : string := "";
     divisor : natural := 1;
     period : string := "";
     is_direct : boolean := false;
     is_digital : boolean := true);
    port (clock_out : out std_logic;
   dig_domain_out : out std_logic);
end cy_clock_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** EMIF Control Block ******************************

entity cy_psoc3_emif_v1_0 is
    generic(cy_registers: string := "";
     udb_mode : boolean := false);
    port (clock : out std_logic;
     ce : out std_logic;
     oe : out std_logic;
     adsc : out std_logic;
     sleep : out std_logic;
     wr : out std_logic;
            data_oe_n : out std_logic;
            xmem_wr : out std_logic;
            xmem_rd : out std_logic;
            udb_stall : in std_logic);
end cy_psoc3_emif_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc3_emif_v2_0 is
    generic(cy_registers: string := "";
     udb_mode : boolean := false);
    port (clock : out std_logic;
     ce : out std_logic;
     oe : out std_logic;
     adsc : out std_logic;
     sleep : out std_logic;
     wr : out std_logic;
            data_oe : out std_logic;
            xmem_wr : out std_logic;
            xmem_rd : out std_logic;
            udb_ready : in std_logic);
end cy_psoc3_emif_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************* Global Signal Ref ***************************** --

entity cy_gsref_v1_0 is
   generic(guid : string := "");
   port (sig_out : out std_logic);
end cy_gsref_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- *********************** Digital Sentinel ******************************

entity cy_psoc3_digital_sentinel_v1_0 is
    generic(info : string := "");
    port (watch : in std_logic);
end cy_psoc3_digital_sentinel_v1_0;
architecture archRTL of cy_psoc3_can_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_i2c_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_timer_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_dfb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_usb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_lcd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_lcd_v2_0 is
begin
end archRTL;

architecture archRTL of cy_clock_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_emif_v1_0 is
begin
end archRTL;

architecture archRTL of cy_gsref_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc3_digital_sentinel_v1_0 is
begin
end archRTL;

--
-- Gen4 Serial Slave Communication component
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_tsg4_ssc_v1_0 is
    generic(if_type : string := "I2C");
    -- I2C (default)
    -- SPI
    port (scli : in std_logic := '0';
     sdai : in std_logic := '0';
     csel : in std_logic := '0';
     sclo : out std_logic;
     sdao : out std_logic;
     irq : out std_logic);
end cy_tsg4_ssc_v1_0;

architecture archRTL of cy_tsg4_ssc_v1_0 is
begin
end archRTL;

--
-- PSoC4 Touch Screen Sub-system
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_tsg4_tss_v1_0 is
    port (clk_seq : in std_logic;
     clk_adc : in std_logic;
     ext_reject : in std_logic;
     ext_sync : in std_logic;
     reject_in : in std_logic;
     start_in : in std_logic;
     tx_sync : in std_logic;
     lx_det_hi : out std_logic;
     lx_det_lo : out std_logic;
     rej_window : out std_logic;
     tx_hilo : out std_logic;
     phase_end : out std_logic;
     phase_num : out std_logic_vector (3 downto 0);
     ipq_reject : out std_logic;
     ipq_start : out std_logic;
     epq_reject : out std_logic;
     epq_start : out std_logic;
     mcs_reject : out std_logic;
     mcs_start : out std_logic;
     do_switch : out std_logic;
     adc_start : out std_logic;
     adc_done : out std_logic);
end cy_tsg4_tss_v1_0;

architecture archRTL of cy_tsg4_tss_v1_0 is
begin
end archRTL;

--
-- PSoC4 Analog Components
--
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ***************** PSOC4 Temp Sensor ********************* --

entity cy_psoc4_temp_v1_0 is
    generic(cy_registers: string := "");
    port (
   temp : out std_logic; -- analog
   vssa_kelvin : in std_logic); -- analog
end cy_psoc4_temp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ************* PSOC4 Low Power Comparator***************** --

entity cy_psoc4_lpcomp_v1_0 is
    generic(cy_registers: string := "";
         needs_hibernate: boolean := true);
    port (vminus : in std_logic; -- analog
        vplus : in std_logic; -- analog
        cmpout : out std_logic); -- digital
end cy_psoc4_lpcomp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************* PSOC4 SAR ************************* --

entity cy_psoc4_sar_v1_0 is
    generic(cy_registers: string := "");
    port (vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vref : in std_logic; -- analog
     ext_vref : in std_logic; -- analog
   clock : in std_logic; -- digital
   sample_done : out std_logic; -- digital
   chan_id_valid : out std_logic; -- digital
   chan_id : out std_logic_vector (3 downto 0); -- digital
   data_valid : out std_logic; -- digital
   data : out std_logic_vector (11 downto 0); -- digital
   eos_intr : out std_logic; -- digital
   irq : out std_logic; -- digital
   sw_negvref : in std_logic; -- digital
   cfg_st_sel : in std_logic_vector (1 downto 0); -- digital
   cfg_average : in std_logic; -- digital
   cfg_resolution : in std_logic; -- digital
   cfg_differential: in std_logic; -- digital
   trigger : in std_logic; -- digital
   data_hilo_sel : in std_logic); -- digital
end cy_psoc4_sar_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ******************** PSOC4 Opamp *********************** --

entity cy_psoc4_abuf_v1_0 is
    generic(cy_registers: string := "";
         needs_dsab: boolean := false;
         deepsleep_available: boolean := false;
         has_resistor: boolean := false);
    port (
   vplus : in std_logic; -- analog
     vminus : in std_logic; -- analog
     vout1 : out std_logic; -- analog
     rs_bot : out std_logic; -- analog
     vout10 : out std_logic; -- analog
     cmpout : out std_logic); -- digital

end cy_psoc4_abuf_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ****************** PSOC4 Half-UAB *********************** --

entity cy_psoc4_half_uab_v1_0 is
    generic(cy_registers: string := "");
    port (
  x0 : in std_logic; -- analog
  x1 : in std_logic; -- analog
  x2 : in std_logic; -- analog
  x3 : in std_logic; -- analog
  ref : in std_logic; -- analog
  agnd : in std_logic; -- analog
  vout : out std_logic; -- analog
  couple : in std_logic; -- analog
  clock : in std_logic; -- digital
  modbitab : in std_logic; -- digital
  modbitc : in std_logic; -- digital
  strobe : in std_logic; -- digital
  trigger : in std_logic; -- digital
  comp : out std_logic; -- digital
  uab_valid : out std_logic; -- digital
  uab_trig_out : out std_logic; -- digital
  uab_dac_intr : out std_logic); -- digital

end cy_psoc4_half_uab_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ****************** PSOC4 Decimator ********************** --

entity cy_psoc4_decimator_v1_0 is
    generic(cy_registers: string := "");
    port (
  valid : in std_logic; -- digital
  incr : in std_logic; -- digital
  reset : out std_logic; -- digital
  intr : out std_logic); -- digital

end cy_psoc4_decimator_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_decimator_v1_10 is
    generic(cy_registers: string := "");
    port (
  valid : in std_logic; -- digital
  incr : in std_logic; -- digital
  trigger : in std_logic; -- digital
  reset : out std_logic; -- digital
  intr : out std_logic); -- digital

end cy_psoc4_decimator_v1_10;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ************ PSOC4 Programmable Reference *************** --

entity cy_psoc4_pref_v1_0 is
    generic(cy_registers : string := "";
   referenceID : integer := 0;
   tapID : integer := 0);
    port (vout : out std_logic); -- analog
end cy_psoc4_pref_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ******************* PSOC4 CSD Comp ********************** --

entity cy_psoc4_csd_comp_v1_0 is
    generic(cy_registers: string := "");
    port (
  vplus : in std_logic; -- analog
  clk_sample : in std_logic := '0'; -- digital
  cmpout : out std_logic); -- digital

end cy_psoc4_csd_comp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ****************** PSOC4 CSD Comp v2 ******************** --

entity cy_psoc4_csd_comp2_v1_0 is
    generic(cy_registers: string := "");
    port (
  vplus : in std_logic; -- analog
  vminus : in std_logic; -- analog
  clk_sample : in std_logic := '0'; -- digital
  cmpout : out std_logic); -- digital

end cy_psoc4_csd_comp2_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************** PSOC4 CSD ************************ --

entity cy_psoc4_csd_v1_0 is
    generic(cy_registers: string := "";
   sensors_count : positive := 1;
   shield_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  source : in std_logic_vector (sensors_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end cy_psoc4_csd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************** PSOC4 CSD ************************ --

entity cy_psoc4_csd_v1_10 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end cy_psoc4_csd_v1_10;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_csd_v1_20 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  clk1 : in std_logic; -- digital
  clk2 : in std_logic; -- digital
  irq : out std_logic; -- digital
  sample_in : in std_logic); -- digital

end cy_psoc4_csd_v1_20;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ******************** PSOC4 CSDv2 ************************ --

entity cy_psoc4_csd2_v1_0 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic; -- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end cy_psoc4_csd2_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_csd2_v1_10 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic; -- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end cy_psoc4_csd2_v1_10;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_csd2_v1_20 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   dedicated_io_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic_vector (dedicated_io_count -1 downto 0);-- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end cy_psoc4_csd2_v1_20;
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_csd2_v1_30 is
    generic(cy_registers : string := "";
   sensors_count : positive := 1;
   rx_count : positive := 1;
   tx_count : positive := 1;
   shield_count : positive := 1;
   adc_channel_count : positive := 1;
   dedicated_io_count : positive := 1;
   ganged_csx : boolean := false;
   sense_as_shield : boolean := false;
   shield_as_sense : boolean := false;
   is_capsense : boolean := true;
   is_mutual : boolean := false;
   is_cmod_charge : boolean := false;
         is_csh_charge : boolean := false);
    port (

  sense : in std_logic_vector (sensors_count -1 downto 0); -- analog
  rx : in std_logic_vector (rx_count -1 downto 0); -- analog
  tx : out std_logic_vector (tx_count -1 downto 0); -- analog
  shield : out std_logic_vector (shield_count -1 downto 0); -- analog
  amuxa : in std_logic; -- analog
  amuxb : in std_logic; -- analog
  csh : in std_logic; -- analog
  cmod : in std_logic; -- analog
  shield_pad : in std_logic; -- analog
  dedicated_io : in std_logic_vector (dedicated_io_count -1 downto 0);-- analog
  vref_ext : in std_logic; -- analog
  adc_channel : in std_logic_vector (adc_channel_count -1 downto 0); -- analog
  sense_out : out std_logic; -- digital
  sample_out : out std_logic; -- digital
  sense_in : in std_logic; -- digital
  sample_in : in std_logic; -- digital
  csh_tank_en : out std_logic; -- digital
  cmod_en : out std_logic; -- digital
  hscmp : out std_logic; -- digital
  start : in std_logic; -- digital
  sampling : out std_logic; -- digital
  adc_on : out std_logic; -- digital
  tr_adc_done : out std_logic; -- digital
  count : out std_logic_vector (15 downto 0); -- digital
  count_val_sel : in std_logic; -- digital
  clk : in std_logic; -- digital
  irq : out std_logic); -- digital

end cy_psoc4_csd2_v1_30;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************* PSOC4 CS IDAC ********************* --

entity cy_psoc4_csidac_v1_0 is
    generic(cy_registers: string := "";
           resolution : integer := 7);
    port (iout : out std_logic; -- analog
      en : in std_logic); -- digital

end cy_psoc4_csidac_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************* PSOC4 CS IDAC ********************* --

entity cy_psoc4_csidac2_v1_0 is
    generic(cy_registers: string := "";
   leg3_needed : boolean := false);
    port (
  iout : out std_logic; -- analog
  en_a : in std_logic; -- digital
  en_b : in std_logic; -- digital
  en_c : in std_logic; -- digital
  pol : in std_logic); -- digital

end cy_psoc4_csidac2_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************* SARMUX **************************** --

entity cy_psoc4_sarmux_v1_0 is
    generic(cy_registers: string := "";
     muxin_width : positive := 4;
     input_mode : string := "0000"); --0 = single-ended, 1 = differential
    port (
   muxin_plus : in std_logic_vector (muxin_width-1 downto 0); -- analog
   muxin_minus : in std_logic_vector (muxin_width-1 downto 0); -- analog
   cmn_neg : in std_logic; -- analog
   vout_plus : out std_logic; -- analog
   vout_minus : out std_logic); -- analog
end cy_psoc4_sarmux_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************* SARMUX **************************** --

entity cy_psoc4_sarmux_v1_10 is
    generic(cy_registers: string := "";
     muxin_width : positive := 4;
  cmn_neg_width : positive := 1;
  input_mode : string := "0000"); --0 = single-ended, 1 = differential
    port (
  muxin_plus : in std_logic_vector (muxin_width-1 downto 0); -- analog
  muxin_minus : in std_logic_vector (muxin_width-1 downto 0); -- analog
  cmn_neg : in std_logic_vector (cmn_neg_width-1 downto 0); -- analog
  vout_plus : out std_logic; -- analog
  vout_minus : out std_logic); -- analog
end cy_psoc4_sarmux_v1_10;
library ieee;
use ieee.std_logic_1164.all;
-- ********************************************************* --
-- ********************** LNFE ***************************** --

entity cy_psoc4_lnfe_v1_0 is
    generic(cy_registers: string := "");
    port (
  lc : out std_logic; -- analog
  lb : out std_logic; -- analog
  le : out std_logic); -- analog
end cy_psoc4_lnfe_v1_0;
architecture archRTL of cy_psoc4_temp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_lpcomp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_sar_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_abuf_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_half_uab_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_decimator_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_decimator_v1_10 is
begin
end archRTL;

architecture archRTL of cy_psoc4_pref_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd_v1_10 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd_v1_20 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd2_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd2_v1_10 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd_comp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csd_comp2_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csidac_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_csidac2_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_sarmux_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_sarmux_v1_10 is
begin
end archRTL;

--
-- PSoC4 IMO Frequency Spectrum Spreader
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_psoc4_imo_fss_v1_0 is
    port (ss_clock : in std_logic;
     ss : in std_logic_vector (4 downto 0) := "00000";
     ss_updn : out std_logic);
end cy_psoc4_imo_fss_v1_0;

architecture archRTL of cy_psoc4_imo_fss_v1_0 is
begin
end archRTL;

--
-- M0S8 Components
--
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** TCPWM ************************************* --

entity cy_m0s8_tcpwm_v1_0 is
     generic(cy_registers : string := "");
     port (clock : in std_logic; -- digital
             capture : in std_logic; -- digital
             count : in std_logic; -- digital
             reload : in std_logic; -- digital
             stop : in std_logic; -- digital
             start : in std_logic; -- digital
             underflow : out std_logic; -- digital
             overflow : out std_logic; -- digital
             compare_match : out std_logic; -- digital
             line_out : out std_logic; -- digital
             line_out_compl : out std_logic; -- digital
             interrupt : out std_logic); -- digital
end cy_m0s8_tcpwm_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** SCB ************************************* --
entity cy_m0s8_scb_v1_0 is
    generic(cy_registers : string := "";
     scb_mode : integer := 0); -- 0 = I2C
       -- 1 = SPI
       -- 2 = UART
    port ( clock : in std_logic; -- digital
     interrupt : out std_logic; -- digital
     rx : in std_logic; -- digital
     tx : out std_logic; -- digital
     mosi_m : out std_logic; -- digital
     miso_m : in std_logic; -- digital
     select_m : out std_logic_vector (3 downto 0);-- digital
     sclk_m : out std_logic; -- digital
     mosi_s : in std_logic; -- digital
     miso_s : out std_logic; -- digital
     select_s : in std_logic; -- digital
     sclk_s : in std_logic; -- digital
     scl : inout std_logic; -- digital
     sda : inout std_logic); -- digital
end cy_m0s8_scb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** SCBv2 ************************************* --
entity cy_m0s8_scb_v2_0 is
    generic(cy_registers : string := "";
     scb_mode : integer := 0); -- 0 = I2C
       -- 1 = SPI
       -- 2 = UART
    port ( clock : in std_logic; -- digital
     interrupt : out std_logic; -- digital
     rx : in std_logic; -- digital
     tx : out std_logic; -- digital
     cts : in std_logic; -- digital
     rts : out std_logic; -- digital
     mosi_m : out std_logic; -- digital
     miso_m : in std_logic; -- digital
     select_m : out std_logic_vector (3 downto 0);-- digital
     sclk_m : out std_logic; -- digital
     mosi_s : in std_logic; -- digital
     miso_s : out std_logic; -- digital
     select_s : in std_logic; -- digital
     sclk_s : in std_logic; -- digital
     scl : inout std_logic; -- digital
     sda : inout std_logic; -- digital
     tx_req : out std_logic; -- digital
     rx_req : out std_logic); -- digital

end cy_m0s8_scb_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** LCD ************************************* --
entity cy_m0s8_lcd_v1_0 is
    generic(cy_registers : string := "";
     common_width : natural := 1 ; -- number of common
     segment_width : natural := 1); -- number of segment
    port ( clock : in std_logic := '1'; -- digital
            common : out std_logic_vector (common_width -1 downto 0);
       -- digital
     segment : out std_logic_vector (segment_width-1 downto 0));
       -- digital
end cy_m0s8_lcd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** BLE ************************************* --
entity cy_m0s8_ble_v1_0 is
    generic(cy_registers : string := "");
    port ( interrupt : out std_logic; -- digital
      rf_ext_pa_en : out std_logic); -- digital

end cy_m0s8_ble_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** BLE II ************************************* --
entity cy_m0s8_ble_v2_0 is
    generic(cy_registers : string := "");
port( interrupt : out std_logic; -- digital
   ext_pa_tx_ctl : out std_logic; -- digital
   ext_lna_rx_ctl : out std_logic; -- digital
   ext_pa_lna_chip_en : out std_logic); -- digital

end cy_m0s8_ble_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** DMA ************************************* --
entity cy_m0s8_dma_v1_0 is
    generic(priority : std_logic_vector (1 downto 0) := "00"); -- 00 = Highest
                                                -- 01
            -- 10
            -- 11 = Lowest
            port(tr_in : in std_logic := '0';
tr_out : out std_logic);

end cy_m0s8_dma_v1_0;
library ieee;
use ieee.std_logic_1164.all;
    -- ****************** Controller Area Network Controller ********************
entity cy_m0s8_can_v1_0 is
    generic(cy_registers : string := "");
    port(can_rx: in std_logic;
         can_tx: out std_logic;
         can_tx_en: out std_logic;
         interrupt: out std_logic);
end cy_m0s8_can_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************** USB ********************
entity cy_m0s8_usb_v1_0 is
    generic(cy_registers : string := "");
    port(dp: out std_logic; -- These are declared as outputs for simplicity. The actual
         dm: out std_logic; -- drive mode is controlled by the USB hardware.
         vbus_valid: in std_logic;
         interrupt_lo: out std_logic;
         interrupt_med: out std_logic;
         interrupt_hi: out std_logic;
         dsi_usb_sof: out std_logic;
         dma_burstend: in std_logic_vector(7 downto 0);
         dma_req: out std_logic_vector(7 downto 0));
end cy_m0s8_usb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************** USB (Legacy) ********************
entity cy_psoc4u_usb_v1_0 is
    generic(cy_registers : string := "");
    port(dp: out std_logic; -- These are declared as outputs for simplicity. The actual
         dm: out std_logic; -- drive mode is controlled by the USB hardware.
         sof: out std_logic;
         ep0: out std_logic;
         ep8_1: out std_logic;
         reset: out std_logic;
         arb: out std_logic);
end cy_psoc4u_usb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************** usbpd ********************
entity cy_psoc4_usbpd_v1_0 is
    generic(cy_registers : string := "");
    port(clock_rx: in std_logic;
         clock_tx: in std_logic;
         clock_sar: in std_logic;
         interrupt: out std_logic;
         interrupt_wakeup: out std_logic;
         cmp_out: out std_logic;
         tx_data: in std_logic;
         tx_data_en: in std_logic;
         tr_out_0: out std_logic;
         tr_out_1: out std_logic;
         tr_out_2: out std_logic;
         tr_out_3: out std_logic;
         tr_out_4: out std_logic);
end cy_psoc4_usbpd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************** usbpd ********************
entity cy_psoc4_usbpd_v2_0 is
    generic(cy_registers : string := "");
    port(clock_rx: in std_logic;
         clock_tx: in std_logic;
         clock_sar: in std_logic;
         interrupt: out std_logic;
         interrupt_wakeup: out std_logic;
         cmp_out: out std_logic_vector(1 downto 0);
         tx_data: in std_logic;
         tx_data_en: in std_logic;
         tr_out_0: out std_logic;
         tr_out_1: out std_logic;
         tr_out_2: out std_logic;
         tr_out_3: out std_logic;
         tr_out_4: out std_logic;
         tr_out_5: out std_logic;
         tr_out_6: out std_logic;
         hpd: out std_logic);
end cy_psoc4_usbpd_v2_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** PRGIO ************************************* --
entity cy_m0s8_prgio_v1_0 is
    generic(cy_registers : string := "";
   port_id : natural := 0); -- port number to place prgio at
    port(clock : in std_logic;
         data0_i : in std_logic;
         data0_o : out std_logic;
         data0_oe : out std_logic;
         data0_io : inout std_logic;
         data1_i : in std_logic;
         data1_o : out std_logic;
         data1_oe : out std_logic;
         data1_io : inout std_logic;
         data2_i : in std_logic;
         data2_o : out std_logic;
         data2_oe : out std_logic;
         data2_io : inout std_logic;
         data3_i : in std_logic;
         data3_o : out std_logic;
         data3_oe : out std_logic;
         data3_io : inout std_logic;
         data4_i : in std_logic;
         data4_o : out std_logic;
         data4_oe : out std_logic;
         data4_io : inout std_logic;
         data5_i : in std_logic;
         data5_o : out std_logic;
         data5_oe : out std_logic;
         data5_io : inout std_logic;
         data6_i : in std_logic;
         data6_o : out std_logic;
         data6_oe : out std_logic;
         data6_io : inout std_logic;
         data7_i : in std_logic;
         data7_o : out std_logic;
         data7_oe : out std_logic;
         data7_io : inout std_logic;

         gpio0_i : in std_logic;
         gpio0_o : out std_logic;
         gpio0_oe : out std_logic;
         gpio0_io : inout std_logic;
         gpio1_i : in std_logic;
         gpio1_o : out std_logic;
         gpio1_oe : out std_logic;
         gpio1_io : inout std_logic;
         gpio2_i : in std_logic;
         gpio2_o : out std_logic;
         gpio2_oe : out std_logic;
         gpio2_io : inout std_logic;
         gpio3_i : in std_logic;
         gpio3_o : out std_logic;
         gpio3_oe : out std_logic;
         gpio3_io : inout std_logic;
         gpio4_i : in std_logic;
         gpio4_o : out std_logic;
         gpio4_oe : out std_logic;
         gpio4_io : inout std_logic;
         gpio5_i : in std_logic;
         gpio5_o : out std_logic;
         gpio5_oe : out std_logic;
         gpio5_io : inout std_logic;
         gpio6_i : in std_logic;
         gpio6_o : out std_logic;
         gpio6_oe : out std_logic;
         gpio6_io : inout std_logic;
         gpio7_i : in std_logic;
         gpio7_o : out std_logic;
         gpio7_oe : out std_logic;
         gpio7_io : inout std_logic);
end cy_m0s8_prgio_v1_0;
library ieee;
use ieee.std_logic_1164.all;
-- ****************************** CRYPTO ************************************* --
entity cy_psoc4_crypto_v1_0 is
    generic(cy_registers : string := "");
    port(tr_in : in std_logic;
         tr_out : out std_logic;
         interrupt : out std_logic);
end cy_psoc4_crypto_v1_0;
architecture archRTL of cy_m0s8_tcpwm_v1_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_scb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_scb_v2_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_lcd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_ble_v1_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_ble_v2_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_dma_v1_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_can_v1_0 is
begin
end archRTL;

-- M0S8 Hobto USB
architecture archRTL of cy_m0s8_usb_v1_0 is
begin
end archRTL;

-- PSoC4U USB
architecture archRTL of cy_psoc4u_usb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_usbpd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_usbpd_v2_0 is
begin
end archRTL;

architecture archRTL of cy_m0s8_prgio_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_lnfe_v1_0 is
begin
end archRTL;

architecture archRTL of cy_psoc4_crypto_v1_0 is
begin
end archRTL;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_tcpwm_v1_0 is
    generic(
        cy_registers : string :="";
        width : natural :=32;
        exact_width : boolean :=false);
    port (
        clock : in std_logic; --digital
        capture : in std_logic; --digital
        count : in std_logic; --digital
        reload : in std_logic; --digital
        stop : in std_logic; --digital
        start : in std_logic; --digital
        tr_underflow : out std_logic; --digital
        tr_compare_match : out std_logic; --digital
        tr_overflow : out std_logic; --digital
        line_compl : out std_logic; --digital
        line : out std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_tcpwm_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_dw_v1_0 is
    generic(
        cy_registers : string :="";
        priority : std_logic_vector (1 downto 0) :="00");
    port (
        tr_in : in std_logic; --digital
        tr_out : out std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_dw_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_gpio_v1_0 is
    generic(
        cy_registers : string :="";
        width : natural :=1;
        sio_grp_cnt : natural :=1;
        id : string :="";
        drive_mode : string :="";
        ibuf_enabled : string :="";
        init_dr_st : string :="";
        input_sync : string :="";
        intr_mode : string :="";
        io_voltage : string :="";
        output_conn : string :="";
        oe_conn : string :="";
        output_sync : string :="";
        oe_sync : string :="";
        drive_strength : string :="";
        max_frequency : string :="";
        output_current_cap : string :="";
        i2c_mode : string :="";
        pin_aliases : string :="";
        pin_mode : string :="";
        slew_rate : string :="";
        vtrip : string :="";
        use_annotation : string :="";
        hotswap_needed : string :="");
    port (
        oe : in std_logic_vector(width - 1 downto 0); --digital
        y : in std_logic_vector(width - 1 downto 0); --digital
        fb : out std_logic_vector(width - 1 downto 0); --digital
        analog : inout std_logic_vector(width - 1 downto 0); --analog
        io : inout std_logic_vector(width - 1 downto 0); --digital
        annotation : inout std_logic_vector(width - 1 downto 0); --analog
        siovref : inout std_logic_vector); --analog
end cy_mxs40_gpio_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_smartio_v1_0 is
    generic(
        cy_registers : string :="";
        port_id : natural :=0);
    port (
        clock : in std_logic; --digital
        data0_i : in std_logic; --digital
        data0_o : out std_logic; --digital
        data0_oe : out std_logic; --digital
        data0_io : inout std_logic; --digital
        data1_i : in std_logic; --digital
        data1_o : out std_logic; --digital
        data1_oe : out std_logic; --digital
        data1_io : inout std_logic; --digital
        data2_i : in std_logic; --digital
        data2_o : out std_logic; --digital
        data2_oe : out std_logic; --digital
        data2_io : inout std_logic; --digital
        data3_i : in std_logic; --digital
        data3_o : out std_logic; --digital
        data3_oe : out std_logic; --digital
        data3_io : inout std_logic; --digital
        data4_i : in std_logic; --digital
        data4_o : out std_logic; --digital
        data4_oe : out std_logic; --digital
        data4_io : inout std_logic; --digital
        data5_i : in std_logic; --digital
        data5_o : out std_logic; --digital
        data5_oe : out std_logic; --digital
        data5_io : inout std_logic; --digital
        data6_i : in std_logic; --digital
        data6_o : out std_logic; --digital
        data6_oe : out std_logic; --digital
        data6_io : inout std_logic; --digital
        data7_i : in std_logic; --digital
        data7_o : out std_logic; --digital
        data7_oe : out std_logic; --digital
        data7_io : inout std_logic; --digital
        gpio0_i : in std_logic; --digital
        gpio0_o : out std_logic; --digital
        gpio0_oe : out std_logic; --digital
        gpio0_io : inout std_logic; --digital
        gpio1_i : in std_logic; --digital
        gpio1_o : out std_logic; --digital
        gpio1_oe : out std_logic; --digital
        gpio1_io : inout std_logic; --digital
        gpio2_i : in std_logic; --digital
        gpio2_o : out std_logic; --digital
        gpio2_oe : out std_logic; --digital
        gpio2_io : inout std_logic; --digital
        gpio3_i : in std_logic; --digital
        gpio3_o : out std_logic; --digital
        gpio3_oe : out std_logic; --digital
        gpio3_io : inout std_logic; --digital
        gpio4_i : in std_logic; --digital
        gpio4_o : out std_logic; --digital
        gpio4_oe : out std_logic; --digital
        gpio4_io : inout std_logic; --digital
        gpio5_i : in std_logic; --digital
        gpio5_o : out std_logic; --digital
        gpio5_oe : out std_logic; --digital
        gpio5_io : inout std_logic; --digital
        gpio6_i : in std_logic; --digital
        gpio6_o : out std_logic; --digital
        gpio6_oe : out std_logic; --digital
        gpio6_io : inout std_logic; --digital
        gpio7_i : in std_logic; --digital
        gpio7_o : out std_logic; --digital
        gpio7_oe : out std_logic; --digital
        gpio7_io : inout std_logic); --digital
end cy_mxs40_smartio_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_smif_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        spi_clk : out std_logic; --digital
        spi_select : out std_logic_vector(3 downto 0); --digital
        spi_data : out std_logic_vector(7 downto 0); --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic); --digital
end cy_mxs40_smif_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_ble_v1_0 is
    generic(
        cy_registers : string :="";
        low_power : boolean :=false);
    port (
        ext_pa_lna_chip_en_out : out std_logic; --digital
        ext_lna_rx_ctl_out : out std_logic; --digital
        ext_pa_tx_ctl_out : out std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_ble_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_scb_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        uart_rx : in std_logic; --digital
        uart_tx : out std_logic; --digital
        uart_rts : out std_logic; --digital
        uart_cts : in std_logic; --digital
        i2c_scl : inout std_logic; --digital
        i2c_sda : inout std_logic; --digital
        spi_clk_m : out std_logic; --digital
        spi_clk_s : in std_logic; --digital
        spi_select_m : out std_logic_vector(3 downto 0); --digital
        spi_select_s : in std_logic; --digital
        spi_mosi_m : out std_logic; --digital
        spi_miso_m : in std_logic; --digital
        spi_mosi_s : in std_logic; --digital
        spi_miso_s : out std_logic; --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic; --digital
        tr_i2c_scl_filtered : out std_logic); --digital
end cy_mxs40_scb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_scb_v1_10 is
    generic(
        cy_registers : string :="";
        requires_io_preconfigure : boolean :=false;
        mode : natural :=0;
        master : boolean :=false);
    port (
        clock : in std_logic; --digital
        uart_rx : in std_logic; --digital
        uart_tx : out std_logic; --digital
        uart_rts : out std_logic; --digital
        uart_cts : in std_logic; --digital
        uart_tx_en : out std_logic; --digital
        i2c_scl : inout std_logic; --digital
        i2c_sda : inout std_logic; --digital
        spi_clk_m : out std_logic; --digital
        spi_clk_s : in std_logic; --digital
        spi_select_m : out std_logic_vector(3 downto 0); --digital
        spi_select_s : in std_logic; --digital
        spi_mosi_m : out std_logic; --digital
        spi_miso_m : in std_logic; --digital
        spi_mosi_s : in std_logic; --digital
        spi_miso_s : out std_logic; --digital
        interrupt : out std_logic; --digital
        tr_tx_req : out std_logic; --digital
        tr_rx_req : out std_logic; --digital
        tr_i2c_scl_filtered : out std_logic); --digital
end cy_mxs40_scb_v1_10;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_csd_v1_0 is
    generic(
        cy_registers : string :="";
        sensors_count : natural :=1;
        rx_count : natural :=1;
        tx_count : natural :=1;
        shield_count : natural :=1;
        adc_channel_count : natural :=1;
        dedicated_io_count : natural :=1;
        is_cmod_charge : boolean :=false;
        is_capsense : boolean :=true;
        sense_as_shield : boolean :=false;
        shield_as_sense : boolean :=false);
    port (
        sense : in std_logic_vector(sensors_count - 1 downto 0); --analog
        rx : in std_logic_vector(rx_count - 1 downto 0); --analog
        tx : out std_logic_vector(tx_count - 1 downto 0); --analog
        shield : out std_logic_vector(shield_count - 1 downto 0); --analog
        adc_channel : in std_logic_vector(adc_channel_count - 1 downto 0); --analog
        amuxa : in std_logic; --analog
        amuxb : in std_logic; --analog
        csh : in std_logic; --analog
        cmod : in std_logic; --analog
        shield_pad : in std_logic; --analog
        dedicated_io : in std_logic_vector(dedicated_io_count - 1 downto 0); --analog
        vref_ext : in std_logic; --analog
        vref_pass : in std_logic; --analog
        dsi_sense_out : out std_logic; --digital
        dsi_sample_out : out std_logic; --digital
        dsi_sense_in : in std_logic; --digital
        dsi_sample_in : in std_logic; --digital
        dsi_csh_tank : out std_logic; --digital
        dsi_cmod : out std_logic; --digital
        dsi_hscmp : out std_logic; --digital
        dsi_start : in std_logic; --digital
        dsi_sampling : out std_logic; --digital
        dsi_adc_on : out std_logic; --digital
        dsi_count : out std_logic_vector(15 downto 0); --digital
        dsi_count_val_sel : in std_logic; --digital
        csd_tx : out std_logic; --digital
        csd_tx_n : out std_logic; --digital
        clock : in std_logic; --digital
        interrupt : out std_logic; --digital
        tr_adc_done : out std_logic); --digital
end cy_mxs40_csd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_usb_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        usb_dp_pad : out std_logic; --digital
        usb_dm_pad : out std_logic; --digital
        interrupt_lo : out std_logic; --digital
        interrupt_med : out std_logic; --digital
        interrupt_hi : out std_logic; --digital
        dma_req : out std_logic_vector(7 downto 0); --digital
        dma_burstend : in std_logic_vector(7 downto 0); --digital
        dsi_usb_sof : out std_logic; --digital
        clk_usb_dev : in std_logic; --digital
        clk_usb_host : in std_logic; --digital
        clock_dev_brs : in std_logic); --digital
end cy_mxs40_usb_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_ipc_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end cy_mxs40_ipc_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_crypto_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end cy_mxs40_crypto_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_profile_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        interrupt : out std_logic; --digital
        tr_start : in std_logic; --digital
        tr_stop : in std_logic); --digital
end cy_mxs40_profile_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_i2s_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        clk_i2s_if : in std_logic; --digital
        tx_sck_m : out std_logic; --digital
        tx_sck_s : in std_logic; --digital
        tx_ws_m : out std_logic; --digital
        tx_ws_s : in std_logic; --digital
        tx_sdo : out std_logic; --digital
        rx_sck_m : out std_logic; --digital
        rx_sck_s : in std_logic; --digital
        rx_ws_m : out std_logic; --digital
        rx_ws_s : in std_logic; --digital
        rx_sdi : in std_logic; --digital
        tr_i2s_tx_req : out std_logic; --digital
        tr_i2s_rx_req : out std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_i2s_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_pdm_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        pdm_clk : out std_logic; --digital
        pdm_data : in std_logic; --digital
        tr_pdm_rx_req : out std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_pdm_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_lpcomp_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        inp : in std_logic; --analog
        inn : in std_logic; --analog
        dsi_comp : out std_logic); --digital
end cy_mxs40_lpcomp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_isr_v1_0 is
    generic(
        cy_registers : string :="";
        deepsleep_required : boolean :=false;
        int_type : std_logic_vector :="00");
    port (
        int_signal : in std_logic); --digital
end cy_mxs40_isr_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_samplehold_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        vin : inout std_logic); --analog
end cy_mxs40_samplehold_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_csidac_v1_0 is
    generic(
        cy_registers : string :="";
        leg3_needed : boolean :=false);
    port (
        iout : out std_logic; --analog
        dsi_idac_leg1_en : in std_logic; --digital
        dsi_idac_leg2_en : in std_logic; --digital
        dsi_idac_leg3_en : in std_logic; --digital
        dsi_idac_pol : in std_logic); --digital
end cy_mxs40_csidac_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_opamp_v1_0 is
    generic(
        cy_registers : string :="";
        has_resistor : boolean :=false;
        deepsleep_available : boolean :=false;
        needs_dsab : boolean :=false);
    port (
        out_1x : out std_logic; --analog
        out_10x : out std_logic; --analog
        vplus : in std_logic; --analog
        vminus : in std_logic; --analog
        ctb_dsi_comp : out std_logic); --digital
end cy_mxs40_opamp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_lcd_v1_0 is
    generic(
        cy_registers : string :="";
        common_width : natural :=1;
        segment_width : natural :=1);
    port (
        clock : in std_logic; --digital
        com : out std_logic_vector(common_width - 1 downto 0); --digital
        seg : out std_logic_vector(segment_width - 1 downto 0)); --digital
end cy_mxs40_lcd_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_ctdac_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        ctdrefdrive : in std_logic; --analog
        ctdrefsense : out std_logic; --analog
        ctdvout : out std_logic; --analog
        ctdvoutsw : out std_logic; --analog
        dsi_ctdac_strobe : in std_logic; --digital
        tr_ctdac_empty : out std_logic); --digital
end cy_mxs40_ctdac_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_ctdac_v1_10 is
    generic(
        cy_registers : string :="");
    port (
        clock : in std_logic; --digital
        ctdrefdrive : in std_logic; --analog
        ctdrefsense : out std_logic; --analog
        ctdvout : out std_logic; --analog
        ctdvoutsw : out std_logic; --analog
        dsi_ctdac_strobe : in std_logic; --digital
        tr_ctdac_empty : out std_logic; --digital
        interrupt_dac : out std_logic); --digital
end cy_mxs40_ctdac_v1_10;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_sar_v1_0 is
    generic(
        cy_registers : string :="";
        edge_trigger : boolean :=false);
    port (
        vplus : in std_logic; --analog
        vminus : out std_logic; --analog
        vref : out std_logic; --analog
        ext_vref : out std_logic; --analog
        dsi_sar_sample_done : out std_logic; --digital
        dsi_sar_chan_id_valid : out std_logic; --digital
        dsi_sar_data_valid : out std_logic; --digital
        tr_sar_out : out std_logic; --digital
        dsi_sar_data : out std_logic_vector(11 downto 0); --digital
        dsi_sar_chan_id : out std_logic_vector(3 downto 0); --digital
        dsi_sar_cfg_st_sel : in std_logic_vector(1 downto 0); --digital
        dsi_sar_cfg_average : in std_logic; --digital
        dsi_sar_cfg_differential : in std_logic; --digital
        dsi_sar_sw_negvref : in std_logic; --digital
        dsi_sar_data_hilo_sel : in std_logic; --digital
        tr_sar_in : in std_logic; --digital
        clock : in std_logic; --digital
        interrupt : out std_logic); --digital
end cy_mxs40_sar_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_sarmux_v1_0 is
    generic(
        cy_registers : string :="";
        muxin_width : natural :=4;
        cmn_neg_width : natural :=1;
        input_mode : string :="1");
    port (
        muxin_plus : in std_logic_vector(muxin_width - 1 downto 0); --analog
        muxin_minus : in std_logic_vector(muxin_width - 1 downto 0); --analog
        cmn_neg : in std_logic_vector(cmn_neg_width - 1 downto 0); --analog
        muxout_plus : out std_logic; --analog
        muxout_minus : out std_logic); --analog
end cy_mxs40_sarmux_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_temp_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        temp : out std_logic); --analog
end cy_mxs40_temp_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_mcwdt_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end cy_mxs40_mcwdt_v1_0;
library ieee;
use ieee.std_logic_1164.all;
entity cy_mxs40_rtc_v1_0 is
    generic(
        cy_registers : string :="");
    port (
        interrupt : out std_logic); --digital
end cy_mxs40_rtc_v1_0;
architecture archRTL of cy_mxs40_tcpwm_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_dw_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_gpio_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_smartio_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_smif_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_ble_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_scb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_scb_v1_10 is
begin
end archRTL;

architecture archRTL of cy_mxs40_csd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_usb_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_ipc_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_crypto_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_profile_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_i2s_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_pdm_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_lpcomp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_isr_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_samplehold_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_csidac_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_opamp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_lcd_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_ctdac_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_ctdac_v1_10 is
begin
end archRTL;

architecture archRTL of cy_mxs40_sar_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_sarmux_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_temp_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_mcwdt_v1_0 is
begin
end archRTL;

architecture archRTL of cy_mxs40_rtc_v1_0 is
begin
end archRTL;
