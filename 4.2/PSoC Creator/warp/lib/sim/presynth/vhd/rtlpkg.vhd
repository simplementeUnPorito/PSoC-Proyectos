--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.cypress.all;

PACKAGE rtlpkg IS
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

 Hint : cygoal_type := memory);

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

    constant LockTime : time := 3000 ns;
    constant Jitter : real := 0.01;

    signal mult : positive;
    signal feedbacksig : std_logic := '0';
    signal int_fdbk : std_logic := '0';
    signal tmp_fdbk : std_logic := '0';
    signal vco : std_logic := '0';
    signal lock : std_logic := '0';
    signal syncb : std_logic := '1';
    signal cyc : time := 0 ns;
    signal tmpglclk : std_logic_vector(3 downto 0);
    signal pllclk : std_logic_vector(3 downto 0);
    signal xclk : std_logic_vector(3 downto 0);
    signal pllout : std_logic_vector(7 downto 0);
    signal tracking : boolean := false;
    signal speedup : boolean;
    signal slowdown : boolean;
    signal killvco : boolean := false;
    signal ckwidth : time := 0 ps;
    signal fbwidth : time := 0 ps;

begin

    -- Input Clock Frequency Check
    process (pll_in)
        variable ckhi : time := 0 ps;
        variable freq : natural;
    begin
        if (rising_edge(pll_in)) then
            if (NOW > 0 ns) then
                freq := 1 sec / (NOW - ckhi);
                if (((real(freq) > real(input_freq) * 1.01) OR
                     (real(freq) < real(input_freq) * 0.99)) AND
                     (input_freq /= 0)) then
                    assert (false)
                        report "Input frequency is outside the specified range."
                        severity warning;
                end if;
            end if;
            ckhi := NOW;
        end if;
    end process;

    -- Feedback select
    process (int_fdbk, ext_fdbk)
    begin

        case feedback is
            when EXTERNAL => feedbacksig <= ext_fdbk;
            when CLOCK_TREE => feedbacksig <= int_fdbk;
            when DIRECT => feedbacksig <= int_fdbk;
            when others => assert(false)
                                    report "Illegal PLL feedback select."
                                    severity failure;
        end case;

    end process;

    -- PLL and clock multiplier
    process (pll_in, feedbacksig)
        variable fbevent: time := 0 ps;
        variable ckevent: time := 0 ps;
        variable kpwidth: time := 0 ps;
        variable width : time := 0 ps;
        variable edges : time := 0 ps;
        variable clock : std_logic := '1';
        variable switch : boolean := false;
    begin
        if (feedback = EXTERNAL) then
            mult <= 1;
        elsif ((multiply = 16) OR (multiply = 8) OR (multiply <= 6)) then
            mult <= multiply;
        else
            assert(false)
            report "Illegal PLL multiply value."
            severity failure;
        end if;

        if (pll_in'event AND pll_in = '1') then
            kpwidth := ckwidth;
            ckwidth <= NOW - ckevent;
            ckevent := NOW;
        end if;

        if (feedbacksig'event AND feedbacksig = '1') then
            fbwidth <= NOW - fbevent;
            fbevent := NOW;
        end if;

        if (feedbacksig'event AND feedbacksig = '1') then
            if ((((ckwidth-fbwidth > ckwidth*Jitter)
               OR (fbwidth-ckwidth > ckwidth*Jitter)) AND (lock = '1'))
               OR((ckwidth-kpwidth > ckwidth*Jitter)
               OR (kpwidth-ckwidth > ckwidth*Jitter))) then
                lock <= '0';
                syncb <= '1';
            end if;
        end if;

        -- Adjust the VCO depending upon the widths of the source and feedback.
        if (rising_edge(pll_in) OR rising_edge(feedbacksig)) then
            if (rising_edge(feedbacksig)) then
                switch := true;
            end if;
            if (NOT switch) then
                speedup <= false;
                slowdown <= false;
            elsif (rising_edge(feedbacksig)) then
                if (abs(ckwidth-fbwidth) < (ckwidth*(Jitter/10.0))) then
                    speedup <= false;
                    slowdown <= false;
                    syncb <= transport '0' after Locktime/10;
                    lock <= transport '1' after LockTime;
                elsif (ckwidth > fbwidth) then
                    speedup <= false;
                    slowdown <= true AND (syncb = '1');
                elsif (ckwidth < fbwidth) then
                    speedup <= true AND (syncb = '1');
                    slowdown <= false;
                else
                    speedup <= false;
                    slowdown <= false;
                    syncb <= transport '0' after Locktime/10;
                    lock <= transport '1' after LockTime;
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
    end process;

    -- Stop the VCO if the input clock is > 2X too slow after it has locked.
    process (vco, pll_in)
        variable ckevent: time := 0 ps;
    begin
        if (pll_in'event) then
            ckevent := NOW;
        end if;
        if (NOW-ckevent > 160 ns AND lock = '1') then
            killvco <= true;
        else
            killvco <= false;
        end if;
    end process;

    lock_detect <= lock when tracking else '0';

    -- VCO Frequency Check
    process (vco)
        constant tmax : time := 10.000 ns; -- Min frequency = 100 MHz
        constant tmin : time := 3.750 ns; -- Max frequency = 266 MHz
        variable ckhi : time := 0 ns;
    begin
        if (vco = '1') then
            if (syncb = '0') then
                if (((NOW - ckhi) < tmin) OR ((NOW - ckhi) > tmax)) then
                    assert (false)
                        report "VCO frequency is outside its operating range."
                        severity warning;
                end if;
            end if;
            ckhi := NOW;
        end if;
    end process;

    -- phase shifter
    process (vco)
        variable width : time := 0 ns;
        variable edges : time := 0 ns;
    begin

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

    end process;

    -- Generate 4 clocks depending on the phase.
    xclk(3) <= pllout(7) when (gclk3_phase = 315) else
                pllout(6) when (gclk3_phase = 270) else
                pllout(5) when (gclk3_phase = 225) else
                pllout(4) when (gclk3_phase = 180) else
                pllout(3) when (gclk3_phase = 135) else
                pllout(2) when (gclk3_phase = 90) else
                pllout(1) when (gclk3_phase = 45) else
                pllout(0) when (gclk3_phase = 0);
    xclk(2) <= pllout(7) when (gclk2_phase = 315) else
                pllout(6) when (gclk2_phase = 270) else
                pllout(5) when (gclk2_phase = 225) else
                pllout(4) when (gclk2_phase = 180) else
                pllout(3) when (gclk2_phase = 135) else
                pllout(2) when (gclk2_phase = 90) else
                pllout(1) when (gclk2_phase = 45) else
                pllout(0) when (gclk2_phase = 0);
    xclk(1) <= pllout(7) when (gclk2_phase = 315) else
                pllout(6) when (gclk1_phase = 270) else
                pllout(5) when (gclk1_phase = 225) else
                pllout(4) when (gclk1_phase = 180) else
                pllout(3) when (gclk1_phase = 135) else
                pllout(2) when (gclk1_phase = 90) else
                pllout(1) when (gclk1_phase = 45) else
                pllout(0) when (gclk1_phase = 0);
    xclk(0) <= pllout(7) when (gclk0_phase = 315) else
                pllout(6) when (gclk0_phase = 270) else
                pllout(5) when (gclk0_phase = 225) else
                pllout(4) when (gclk0_phase = 180) else
                pllout(3) when (gclk0_phase = 135) else
                pllout(2) when (gclk0_phase = 90) else
                pllout(1) when (gclk0_phase = 45) else
                pllout(0) when (gclk0_phase = 0);

    -- Apply the divide amount to the clocks.
    process
    begin
        wait on vco;
        if (rising_edge(vco) AND (NOW > 0 ps)) then
            tmp_fdbk <= '1';
            wait for multiply * cyc;
            tmp_fdbk <= '0';
            wait for (multiply-1) * cyc;
        end if;
    end process;

    process
    begin
        wait on xclk(3);
        if (rising_edge(xclk(3)) AND (NOW > 0 ps)) then
            pllclk(3) <= '1';
            wait for gclk3_divide * cyc;
            pllclk(3) <= '0';
            wait for (gclk3_divide-1) * cyc;
        end if;
    end process;

    process
    begin
        wait on xclk(2);
        if (rising_edge(xclk(2)) AND (NOW > 0 ps)) then
            pllclk(2) <= '1';
            wait for gclk2_divide * cyc;
            pllclk(2) <= '0';
            wait for (gclk2_divide-1) * cyc;
        end if;
    end process;

    process
    begin
        wait on xclk(1);
        if (rising_edge(xclk(1)) AND (NOW > 0 ps)) then
            pllclk(1) <= '1';
            wait for gclk1_divide * cyc;
            pllclk(1) <= '0';
            wait for (gclk1_divide-1) * cyc;
        end if;
    end process;

    process
    begin
        wait on xclk(0);
        if (rising_edge(xclk(0)) AND (NOW > 0 ps)) then
            pllclk(0) <= '1';
            wait for gclk0_divide * cyc;
            pllclk(0) <= '0';
            wait for (gclk0_divide-1) * cyc;
        end if;
    end process;

    tmpglclk(3) <= pllclk(3);
    tmpglclk(2) <= pllclk(2);
    tmpglclk(1) <= pllclk(1);
    tmpglclk(0) <= pllclk(0);

    -- phase alignment
    process (tmpglclk, feedbacksig, pll_in, tmp_fdbk)
        variable ckevent: time := 0 ps;
        variable half : time := 0 ps;
        variable var : time := 0 ps;
    begin
            if (rising_edge(pll_in)) then
                ckevent := NOW;
            end if;
            if (falling_edge(pll_in)) then
                half := NOW - ckevent;
            end if;
            if (syncb = '1') then
                if (rising_edge(feedbacksig)) then
                    if ((NOW - ckevent) < half) then
                        var := 2*half - (NOW - ckevent);
                    else
                        var := 3*half - (NOW - ckevent);
                    end if;
                end if;
                gclk0 <= tmpglclk(0);
                gclk1 <= tmpglclk(1);
                gclk2 <= tmpglclk(2);
                gclk3 <= tmpglclk(3);
                int_fdbk <= tmp_fdbk;
                tracking <= false;
            else
                if (feedback = EXTERNAL) then
                    if (rising_edge(feedbacksig)) then
                        if (((NOW - ckevent) > half)) then
                            if NOT tracking AND (2*half-(NOW-ckevent)>20 ps)then
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
                    gclk0 <= transport tmpglclk(0) after var;
                    gclk1 <= transport tmpglclk(1) after var;
                    gclk2 <= transport tmpglclk(2) after var;
                    gclk3 <= transport tmpglclk(3) after var;
                else
                    int_fdbk <= transport tmp_fdbk after var - half;
                    gclk0 <= transport tmpglclk(0) after var - half;
                    gclk1 <= transport tmpglclk(1) after var - half;
                    gclk2 <= transport tmpglclk(2) after var - half;
                    gclk3 <= transport tmpglclk(3) after var - half;
                    tracking <= true;
                end if;
            end if;
    end process;

end archRTL;

--
-- Serdes FIFO
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_fifo_9532 is
port ( data_in : in std_logic_vector(15 downto 0);
        rstb : in std_logic;
        wrclk : in std_logic;
        out_2d : out std_logic_vector(15 downto 0);
        rdclk : in std_logic;
        fifoerr : out std_logic;
        fifoempty:inout std_logic);
end cy_fifo_9532;

architecture sim of cy_fifo_9532 is

    signal intrstb : std_logic;
    signal fifoclr : std_logic;
    signal undflow_err : std_logic;
    signal ovflow_err : std_logic;
    signal d_avl : std_logic;
    signal d_avl_sync1 : std_logic;
    signal d_avl_sync2 : std_logic;
    signal d_avl_sync2_d: std_logic;
    signal rstb_d : std_logic;
    signal rstb_2d : std_logic;
    signal fifofull : std_logic;
    signal rdcnt : integer range 0 to 5;
    signal rdcnt_sync1 : integer range 0 to 5;
    signal rdcnt_sync2 : integer range 0 to 5;
    signal wrcnt : integer range 0 to 5;
    signal wrcnt_sync1 : integer range 0 to 5;
    signal wrcnt_sync2 : integer range 0 to 5;
    signal fifoclrcnt : integer range 0 to 9;
    signal data_out : std_logic_vector(15 downto 0);
    signal out_d : std_logic_vector(15 downto 0);
    signal temp1 : std_logic_vector(15 downto 0);
    signal temp2 : std_logic_vector(15 downto 0);
    signal temp3 : std_logic_vector(15 downto 0);
    signal temp4 : std_logic_vector(15 downto 0);
    signal temp5 : std_logic_vector(15 downto 0);
    signal temp6 : std_logic_vector(15 downto 0);
begin

    Write: process (wrclk, intrstb)
    begin
        if (intrstb = '0') then
            wrcnt <= 0;
            rdcnt_sync1 <= 0;
            rdcnt_sync2 <= 0;
            ovflow_err <= '0' after 200 ps;
            d_avl <= '0';
            fifofull <= '0';
        elsif (rising_edge(wrclk)) then
            d_avl <= '1';

            if (fifofull = '0') then
                if (wrcnt = 5) then
                    wrcnt <= 0;
                else
                    wrcnt <= wrcnt + 1;
                end if;
            else
                ovflow_err <= '1';
            end if;

            if (((wrcnt-rdcnt_sync1) >= 5) OR ((rdcnt_sync1-wrcnt) = 1)) then
                fifofull <= '1';
            else
                fifofull <= '0';
            end if;

            rdcnt_sync1 <= rdcnt;
            rdcnt_sync2 <= rdcnt_sync1;

        end if;

        if (rising_edge(wrclk)) then
            rstb_d <= rstb;
            rstb_2d <= rstb_d;
            if (fifofull = '0') then
                case (wrcnt) is
                    when 0 => temp1 <= data_in;
                    when 1 => temp2 <= data_in;
                    when 2 => temp3 <= data_in;
                    when 3 => temp4 <= data_in;
                    when 4 => temp5 <= data_in;
                    when 5 => temp6 <= data_in;
                end case;
            end if;
        end if;
    end process;

    Read: process (rdclk, intrstb)
    begin
        if (intrstb = '0') then
            rdcnt <= 0;
            wrcnt_sync1 <= 0;
            wrcnt_sync2 <= 0;
            d_avl_sync1 <= '0';
            d_avl_sync2 <= '0';
            fifoempty <= '1';
            fifoclrcnt <= 0;
            data_out <= x"5555";
        elsif (rising_edge(rdclk)) then
            case (rdcnt) is
                when 0 => data_out <= temp1;
                when 1 => data_out <= temp2;
                when 2 => data_out <= temp3;
                when 3 => data_out <= temp4;
                when 4 => data_out <= temp5;
                when 5 => data_out <= temp6;
            end case;

            out_d <= data_out;
            out_2d <= out_d;

            if (rdcnt /= wrcnt_sync1) then
                if (rdcnt = 5) then
                    rdcnt <= 0;
                else
                    rdcnt <= rdcnt + 1;
                end if;
            end if;

            wrcnt_sync1 <= wrcnt;
            wrcnt_sync2 <= wrcnt_sync1;

            d_avl_sync1 <= d_avl;
            d_avl_sync2 <= d_avl_sync1;

            if (rdcnt = wrcnt_sync1) then
                fifoempty <= '1';
            else
                fifoempty <= '0';
            end if;

            if ((undflow_err = '1') OR (ovflow_err = '1')) then
                fifoclrcnt <= 1;
            elsif (fifoclrcnt /= 0) then
                fifoclrcnt <= fifoclrcnt + 1;
            end if;
        end if;
    end process;

    d_avl_sync2_d <= d_avl_sync2 after 200 ps;

    fifoerr <= undflow_err OR ovflow_err;
    undflow_err <= fifoempty AND d_avl_sync2_d;
    fifoclr <= '1' when (fifoclrcnt = 9) else '0';
    intrstb <= rstb AND NOT fifoclr;

end sim;

--
-- Serdes Core
--
library ieee;
use ieee.std_logic_1164.all;
entity cy_2gserdes_core is
port (txd : in std_logic_vector (15 downto 0);
    txclki : in std_logic;
    fifo_rstb : in std_logic;
    loop_time : in std_logic;
    diagloop : in std_logic;
    loopa : in std_logic;
    lineloop : in std_logic;
    resetb : in std_logic;
    pwrdnb : in std_logic;
    lockrefb : in std_logic;
    refclk : in std_logic;
    rd_in : in std_logic;
    sd : in std_logic;
    td_out : out std_logic;
    fifo_err : inout std_logic;
    txclko : inout std_logic;
    rxd : out std_logic_vector (15 downto 0) := (others => '0');
    rxclk : inout std_logic;
    lfib : out std_logic;
    locked : out std_logic);
end cy_2gserdes_core;

architecture sim of cy_2gserdes_core is

    signal txd_reg : std_logic_vector (15 downto 0);
    signal rx_dat16 : std_logic_vector (15 downto 0);
    signal rx_dat16_bak : std_logic_vector (15 downto 0);
    signal fifo_out : std_logic_vector (15 downto 0);
    signal fifo_out_d : std_logic_vector (15 downto 0);
    signal fifo_out_2d : std_logic_vector (15 downto 0);
    signal rx_sd_cnt16 : natural;
    signal rx_cnt16 : natural;
    signal cnt16 : natural;
    signal shiftcnt : natural;
    signal vco_buprox : natural;
    signal vco_buprox_1 : natural;
    signal rd_in_d : std_logic;
    signal out_1 : std_logic;
    signal retimed_data : std_logic;
    signal done16 : std_logic;
    signal done16_rec : std_logic;
    signal within_range : std_logic;
    signal cntrstb : std_logic;
    signal rxpll_in : std_logic;
    signal tx_bit_clock : std_logic;
    signal lfi_1 : std_logic;
    signal fifomt : std_logic;
    signal fifomt_d : std_logic;
    signal fifomt_2d : std_logic;
    signal fifomt_2d_V : std_logic;
    signal fifomt_3d : std_logic;
    signal fifomt_d_tx : std_logic := '1';
    signal fifomt_2d_tx : std_logic := '1';
    signal fifomt_3d_tx : std_logic := '1';
    signal fifomt_4d_tx : std_logic := '1';
    signal fifomt_4d_tv : std_logic := '1';
    signal out_1_d : std_logic;
    signal txclk_pll : std_logic := '0';
    signal recovered_clk: std_logic := '0';
    signal sd_d : std_logic;
    signal fifo_rstb_d : std_logic;
    signal fifo_rstb_2d : std_logic;

    signal timestamp_in_0 : time := 0 fs;
    signal timestamp_in_1 : time := 0 fs;
    signal timestamp_in_2 : time := 0 fs;
    signal timestamp_out_0 : time := 0 fs;
    signal timestamp_out_1 : time := 0 fs;
    signal timestamp_clk_0 : time := 0 fs;
    signal timestamp_clk_1 : time := 0 fs;
    signal dur_rec_clk : time := 1 fs;
    signal duration_in_0 : time := 0 fs;
    signal duration_in_1 : time := 0 fs;
    signal duration_in : time := 0 fs;
    signal duration_clk : time := 1 fs;
    signal duration_txclk : time := 0 fs;
    signal duration_in_0_d : time := 0 fs;
    signal duration_in_last : time := 0 fs;

    component cy_fifo_9532
        port (data_in : in std_logic_vector(15 downto 0);
            rstb : in std_logic;
            wrclk : in std_logic;
            out_2d : out std_logic_vector(15 downto 0);
            rdclk : in std_logic;
            fifoerr : out std_logic;
            fifoempty : inout std_logic);
    end component;
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

begin

    -- parallel input to serial output

    U0: cy_fifo_9532 port map
            (data_in => txd_reg,
            rstb => fifo_rstb,
            wrclk => txclki,
            out_2d => fifo_out,
            rdclk => txclko,
            fifoerr => fifo_err,
            fifoempty => fifomt);

    P1: process (txclki)
    begin
        if (rising_edge(txclki) AND (pwrdnb = '1')) then
            txd_reg <= txd;
        end if;
    end process;

    P2: process (txclko, resetb)
    begin
        if (resetb = '0') then
            fifo_rstb_d <= '0';
            fifo_rstb_2d <= '0';
        elsif (rising_edge(txclko)) then
            fifo_rstb_d <= fifo_rstb;
            fifo_rstb_2d <= fifo_rstb_d;
            fifomt_d_tx <= fifomt;
            fifomt_2d_tx <= fifomt_d_tx;
            fifomt_3d_tx <= fifomt_2d_tx;
        end if;
    end process;

    P3: process (txclko, fifomt_2d_tx)
    begin
        if (fifomt_2d_tx = '1') then
            fifo_out_d <= x"5555";
        elsif (rising_edge(txclko)) then
            fifo_out_d <= fifo_out;
        end if;
    end process;

    P4: process (txclko, fifomt_2d_tx)
    begin
        if (fifomt_2d_tx = '1') then
            fifo_out_2d <= x"5555";
        elsif (falling_edge(txclko)) then
            fifo_out_2d <= fifo_out_d;
        end if;
    end process;

    P5: process (txclko)
    begin
        if (falling_edge(txclko)) then
            fifomt_4d_tx <= fifomt_3d_tx;
        end if;
    end process;

    P6: process (tx_bit_clock, resetb)
    begin
        if (resetb = '0') then
            out_1 <= '0';
            shiftcnt <= 15;
        elsif (rising_edge(tx_bit_clock)) then
            if ((pwrdnb = '1') AND
                    (fifo_rstb_2d = '0') AND (fifo_rstb_d = '1')) then
                out_1 <= '0';
            elsif ((pwrdnb = '1') AND (fifomt_4d_tx = '1')) then
                out_1 <= NOT out_1;
                shiftcnt <= 15;
            elsif (pwrdnb = '1') then
                out_1 <= fifo_out_2d(shiftcnt);
                if (shiftcnt = 0) then
                    shiftcnt <= 15;
                else
                    shiftcnt <= shiftcnt - 1;
                end if;
            end if;
        end if;
    end process;

    P7: process (tx_bit_clock, resetb)
    begin
        if (resetb = '0') then
            cnt16 <= 0;
        elsif (rising_edge(tx_bit_clock) AND (pwrdnb = '1')) then
            if (cnt16 = 15) then
                cnt16 <= 0;
            else
                cnt16 <= cnt16 + 1;
            end if;
        end if;
    end process;

    P7a: process (tx_bit_clock, resetb)
    begin
        if (resetb = '0') then
            txclko <= '0';
        elsif (falling_edge(tx_bit_clock) AND (pwrdnb = '1')) then
            if (cnt16 = 8) then
                txclko <= '0';
            elsif (cnt16 = 0) then
                txclko <= '1';
            end if;
        end if;
    end process;

    td_out <= retimed_data when (lineloop = '1') else
                     rd_in when (loopa = '1') else out_1;

    tx_bit_clock <= recovered_clk when (loop_time = '1') else txclk_pll;

    -- serial input to parallel output

    P7b: process (out_1_d, rd_in_d, tx_bit_clock)
    begin
        if (diagloop = '1') then
            if(rising_edge(tx_bit_clock)) then
                rxpll_in <= out_1_d;
            end if;
        else
            if (rd_in_d'event) then
                rxpll_in <= rd_in_d;
            end if;
        end if;
    end process;
    rd_in_d <= rd_in after 10 ps;--10 ps;

    P8: process (recovered_clk, resetb)
    begin
        if (resetb = '0') then
            vco_buprox <= 0;
        elsif (rising_edge(recovered_clk) AND (vco_buprox /= 131072)) then
            vco_buprox <= vco_buprox + 1;
        end if;
    end process;

    P8a: process (rxpll_in, resetb)
    begin
        if (resetb = '0') then
            vco_buprox_1 <= 0;
        elsif (rising_edge(rxpll_in) AND (vco_buprox_1 /= 32768)) then
            vco_buprox_1 <= vco_buprox_1 + 1;
        end if;
    end process;

    P9: process (recovered_clk)
    begin
         if (pwrdnb = '1' AND falling_edge(recovered_clk)) then
            out_1_d <= out_1;
            fifomt_4d_tv <= fifomt_4d_tx;
            sd_d <= sd;
        elsif (falling_edge(recovered_clk)) then
            sd_d <= sd;
        end if;
    end process;

    P9a: process (duration_in_0, duration_clk)
    begin
        if (duration_clk > 0 fs) then
            if (((16.0*time_to_real(duration_in_0)/(time_to_real(duration_clk)))
                    <= 1.0002) AND
                ((16.0*time_to_real(duration_in_0)/(time_to_real(duration_clk)))
                    >= 0.9998)) then
                within_range <= '1';
            else
                within_range <= '0';
            end if;
        end if;
    end process;

     P10: process (pwrdnb, rxpll_in, diagloop, fifomt_2d)
     begin
         if (pwrdnb = '1') then
            if ((diagloop = '1' AND fifomt_2d = '1') OR
                (diagloop = '0')) then
                timestamp_in_0 <= NOW;
                timestamp_in_1 <= timestamp_in_0;
                timestamp_in_2 <= timestamp_in_1;
            end if;
        end if;
     end process;

     P11: process (refclk)
     begin
         if (pwrdnb = '1' AND rising_edge(refclk)) then
            timestamp_clk_0 <= NOW;
            timestamp_clk_1 <= timestamp_clk_0;
        end if;
     end process;

    P12: process (within_range)
    begin
        if (falling_edge(within_range)) then
            duration_in_last <= duration_in after 1 ps; --ps;
        end if;
    end process;

    P12x: process (duration_in_0)
    begin
        duration_in_0_d <= duration_in_0 after 1 ps; --ps;
    end process;

    P12a: process (duration_in_0_d)
    begin
        if (within_range = '1') then
            duration_in <= duration_in_0;
        else
            duration_in <= duration_in_last;
        end if;
    end process;

    P12b: process (pwrdnb, timestamp_in_0, timestamp_in_1, timestamp_clk_0,
                    duration_in, timestamp_clk_1, sd, lockrefb, within_range,
                    diagloop, lfi_1)
        variable var_clk : time;
    begin
         if (pwrdnb = '1') then
            duration_in_0 <= timestamp_in_0 - timestamp_in_1;

            var_clk := timestamp_clk_0 - timestamp_clk_1;
            duration_clk <= var_clk;

            if (lockrefb = '0' OR ((diagloop = '0') AND (sd = '0'))) then
                dur_rec_clk <= (var_clk / 16);
            elsif (lfi_1 = '1') then
                dur_rec_clk <= duration_in;
            else
                dur_rec_clk <= (var_clk / 16);
            end if;
            duration_txclk <= var_clk / 32;

        end if;
    end process;

     P13: process
     begin
        wait on refclk, pwrdnb, done16;
         if (pwrdnb = '1') then
            if (duration_txclk /= 0 fs) then
                for i in 1 to 32 loop
                    wait for duration_txclk;
                    txclk_pll <= NOT txclk_pll;
                end loop;
                done16 <= '1';
                wait for 5 fs;
                done16 <= '0';
            end if;
        end if;
     end process;

    P15: process
    begin
        wait on pwrdnb, done16_rec, dur_rec_clk;
        if (pwrdnb = '1') then
            if (dur_rec_clk /= 0 fs) then
                for i in 1 to 32 loop
                    wait for dur_rec_clk/2;
                    recovered_clk <= NOT recovered_clk;
                end loop;
                done16_rec <= '1';
                wait for 5 fs;
                done16_rec <= '0';
            end if;
        end if;
     end process;

    P17: process (recovered_clk, resetb)
     begin
         if (resetb = '0') then
            rx_cnt16 <= 0;
            fifomt_2d <= '1';
            fifomt_3d <= '1';
        elsif ((pwrdnb = '1') AND (rising_edge(recovered_clk))) then
            if (rx_cnt16 = 15) then
                rx_cnt16 <= 0;
            else
                rx_cnt16 <= rx_cnt16 + 1;
            end if;
            fifomt_2d <= fifomt_d;
            fifomt_3d <= fifomt_2d;
        end if;
     end process;

    P17a: process (recovered_clk, resetb)
     begin
         if (resetb = '0') then
            rxclk <= '1';
        elsif ((pwrdnb = '1') AND (falling_edge(recovered_clk))) then
            if (rx_cnt16 = 8) then
                rxclk <= '1';
            elsif (rx_cnt16 = 0) then
                rxclk <= '0';
            end if;
        end if;
     end process;

     P18: process (recovered_clk, resetb)
     begin
         if (resetb = '0') then
            fifomt_d <= '1';
        elsif ((pwrdnb = '1') AND (rising_edge(recovered_clk))) then
            fifomt_d <= fifomt_4d_tv;
        end if;
     end process;

     P19: process (refclk, resetb)
     begin
         if (resetb = '0') then
            lfi_1 <= '0';
        elsif ((within_range = '1') AND (pwrdnb = '1') AND
                (vco_buprox = 131072) AND (vco_buprox_1 = 32768) AND
                (rising_edge(refclk))) then
            lfi_1 <= '1';
        elsif ((pwrdnb = '0') AND (within_range = '0')) then
            lfi_1 <= '0';
        end if;
     end process;

     locked <= lfi_1;
     lfib <= lfi_1 AND lockrefb AND (diagloop OR sd);

     P20: process (recovered_clk, resetb)
     begin
         if (resetb = '0') then
            rx_dat16 <= (others => '0');
            rx_dat16_bak <= (others => '0');
            retimed_data <= '0';
        elsif ((pwrdnb = '1') AND (rising_edge(recovered_clk))) then
            rx_dat16(rx_sd_cnt16) <= retimed_data;
            if (rx_sd_cnt16 = 15) then
                rx_dat16_bak <= rx_dat16;
            end if;
            retimed_data <= rxpll_in;
        end if;
     end process;

     cntrstb <= resetb AND NOT (fifomt_2d AND diagloop);
     fifomt_2d_V <= fifomt_2d after 1 ps; --ps;

     P21: process (recovered_clk, cntrstb)
     begin
         if (cntrstb = '0') then
            rx_sd_cnt16 <= 15;
        elsif ((pwrdnb = '1') AND (rising_edge(recovered_clk))) then
            if ((diagloop = '1' AND fifomt_2d_V = '0') OR (diagloop = '0')) then
                if (rx_sd_cnt16 = 0) then
                    rx_sd_cnt16 <= 15;
                else
                    rx_sd_cnt16 <= rx_sd_cnt16 - 1;
                end if;
            end if;
        end if;
     end process;

     P22: process (rxclk, resetb)
     begin
         if (resetb = '0') then
            rxd <= (others => '0');
        elsif ((pwrdnb = '1') AND falling_edge(rxclk)) then
            rxd <= rx_dat16_bak;
        end if;
     end process;

end sim;

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

    signal refclk : std_logic;
    signal rd_in : std_logic;
    signal td_out : std_logic;
    signal txclki : std_logic;
    signal t_rxd : std_logic_vector (15 downto 0);
    signal t_txclk : std_logic;
    signal t_fifo_err : std_logic;
    signal t_rxclk : std_logic;

    signal in_there : std_logic;
    signal in_there_x : std_logic;
    signal in_there_d : std_logic;
    signal locked : std_logic;
    signal duration_in : real := 6425.0/16.0;
    signal duration_in_0 : real := 0.0;
    signal refclk_period : real := 0.0;
    signal timestamp_in_0 : time := 0 ps;
    signal timestamp_in_1 : time := 0 ps;

    constant txclk_period_min : time := 6380 ps;
    constant txclk_period_max : time := 6470 ps;
    constant txclk_period_vio : string
        := "ERROR-001: TXCLK Period Violation";

    constant txclk_dutycy_min : real := 0.43;
    constant txclk_dutycy_max : real := 0.57;
    constant txclk_dutycy_vio : string
        := "ERROR-002: TXCLK Duty-cycle Violation";

    constant rxclk_period_min : time := 6380 ps;
    constant rxclk_period_max : time := 6470 ps;
    constant rxclk_period_vio : string
        := "ERROR-005: RXCLK Period Violation";

    constant rxclk_dutycy_min : real := 0.43;
    constant rxclk_dutycy_max : real := 0.57;
    constant rxclk_dutycy_vio : string
        := "ERROR-006: RXCLK Duty Cycle Violation";

    constant rfclk_period_min : time := 6380 ps;
    constant rfclk_period_max : time := 6470 ps;
    constant rfclk_period_vio : string
        := "ERROR-007: REFCLK Period Violation";

    constant rfclk_dutycy_min : real := 0.35;
    constant rfclk_dutycy_max : real := 0.65;
    constant rfclk_dutycy_vio : string
        := "ERROR-008: REFCLK Duty Cycle Violation";

    constant rfclk_freqtol : real := 0.0001; -- +/- 100 ppm
    constant rfclk_freqtol_vio : string
        := "ERROR-009: REFCLK Frequency Tolerance Violation";

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
    component cy_2gserdes_core
        port (txd : in std_logic_vector (15 downto 0);
            txclki : in std_logic;
            fifo_rstb : in std_logic;
            loop_time : in std_logic;
            diagloop : in std_logic;
            loopa : in std_logic;
            lineloop : in std_logic;
            resetb : in std_logic;
            pwrdnb : in std_logic;
            lockrefb : in std_logic;
            refclk : in std_logic;
            rd_in : in std_logic;
            sd : in std_logic;
            td_out : out std_logic;
            fifo_err : inout std_logic;
            txclko : inout std_logic;
            rxd : out std_logic_vector (15 downto 0):=(others => '0');
            rxclk : inout std_logic;
            lfib : out std_logic;
            locked : out std_logic);
        end component;
begin

    -- check txclk period and duty cycle
    process (t_txclk)
        variable txckhi : time := 0 ns;
        variable txcklo : time := 0 ns;
        variable tcy : real;
    begin
        if (pwrdnb = '1') then
            if (t_txclk = '0') then
                txcklo := NOW;
            elsif (t_txclk = '1') then
                if ((txckhi /= 0 ns) AND (txcklo /= 0 ns)) then
                    tcy := (time_to_real(NOW-txcklo)/time_to_real(NOW-txckhi));
                    if((tcy < txclk_dutycy_min) OR (tcy > txclk_dutycy_max))then
                        assert (locked /= '1')
                            report txclk_dutycy_vio severity warning;
                    end if;
                end if;
                if (((txckhi/=0 ns) AND ((NOW-txckhi) < txclk_period_min)) OR
                    ((txckhi/=0 ns) AND ((NOW-txckhi) > txclk_period_max))) then
                    assert (locked /= '1')
                        report txclk_period_vio severity warning;
                end if;
                txckhi := NOW;
            end if;
        end if;
    end process;

    -- check rxclk period and duty cycle
    process (t_rxclk)
        variable rxckhi : time := 0 ns;
        variable rxcklo : time := 0 ns;
        variable rcy : real;
    begin
        if (pwrdnb = '1') then
            if (t_rxclk = '0') then
                rxcklo := NOW;
            elsif (t_rxclk = '1') then
                if ((rxckhi /= 0 ns) AND (rxcklo /= 0 ns)) then
                    rcy := (time_to_real(NOW-rxcklo)/time_to_real(NOW-rxckhi));
                    if((rcy < rxclk_dutycy_min) OR (rcy > rxclk_dutycy_max))then
                        assert (locked /= '1')
                        report rxclk_dutycy_vio severity warning;
                    end if;
                end if;
                if (((rxckhi/=0 ns) AND ((NOW-rxckhi) < rxclk_period_min)) OR
                    ((rxckhi/=0 ns) AND ((NOW-rxckhi) > rxclk_period_max))) then
                    assert (locked /= '1')
                        report rxclk_period_vio severity warning;
                end if;
                rxckhi := NOW;
            end if;
        end if;
    end process;

    -- check refclk period and duty cycle
    process (refclk)
        variable rfckhi : time := 0 ns;
        variable rfcklo : time := 0 ns;
        variable fcy : real;
    begin
        if (pwrdnb = '1') then
            if (refclk = '0') then
                rfcklo := NOW;
            elsif (refclk = '1') then
                if ((rfckhi /= 0 ns) AND (rfcklo /= 0 ns)) then
                    fcy := (time_to_real(NOW-rfcklo)/time_to_real(NOW-rfckhi));
                    if((fcy < rfclk_dutycy_min) OR (fcy > rfclk_dutycy_max))then
                        assert (locked /= '1')
                            report rfclk_dutycy_vio severity warning;
                    end if;
                end if;
                refclk_period <= time_to_real(NOW - rfckhi);
                if (((rfckhi/=0 ns) AND ((NOW-rfckhi) < rfclk_period_min)) OR
                    ((rfckhi/=0 ns) AND ((NOW-rfckhi) > rfclk_period_max))) then
                    assert (locked /= '1')
                        report rfclk_period_vio severity warning;
                end if;
                rfckhi := NOW;
            end if;
        end if;
    end process;

    -- check refclk freqency tolerance
    process (rd_in, pwrdnb)
    begin
        if (pwrdnb = '1') then
            timestamp_in_0 <= NOW;
            timestamp_in_1 <= timestamp_in_0;
            in_there <= '1';
        end if;
    end process;

    process (rd_in)
    begin
        if ((pwrdnb = '1') AND rising_edge(rd_in)) then
            in_there_x <= in_there;
            in_there_d <= in_there_x;
        end if;
    end process;

    process (timestamp_in_0, timestamp_in_1)
    begin
        duration_in_0 <= time_to_real(timestamp_in_0 - timestamp_in_1);
    end process;

    process (duration_in_0, refclk_period, pwrdnb)
    begin
        if ((pwrdnb = '1') AND (refclk_period > 0.0) AND
        ((16.0 * duration_in_0)/refclk_period <= (1.0 + rfclk_freqtol) AND
        ((16.0 * duration_in_0)/refclk_period >= (1.0 - rfclk_freqtol)))) then
            duration_in <= duration_in_0;
        end if;
    end process;

    process (refclk)
    begin
        if ((pwrdnb = '1') AND (rising_edge(refclk)) AND
        (in_there_d = '1') AND (resetb = '1') AND (refclk_period > 0.0) AND
            ((16.0 * duration_in)/refclk_period > (1.0 + rfclk_freqtol) OR
            ((16.0 * duration_in)/refclk_period < (1.0 - rfclk_freqtol)))) then
                assert (locked /= '1')
                    report rfclk_freqtol_vio severity warning;
         end if;
    end process;

    fifo_err <= t_fifo_err;
    rxclk <= t_rxclk;
    txclk <= t_txclk;
    txclki <= t_txclk;
    rxd <= t_rxd;

    refclk <= refclk_p AND NOT refclk_n;
    rd_in <= serial_in_p AND NOT serial_in_n;

    U1: cy_2gserdes_core port map
        (txd => txd,
        txclki => txclki,
        fifo_rstb => fifo_rstb,
        loop_time => loop_time,
        diagloop => diagloop,
        loopa => loopa,
        lineloop => lineloop,
        resetb => resetb,
        pwrdnb => pwrdnb,
        lockrefb => lockrefb,
        refclk => refclk,
        rd_in => rd_in,
        sd => sd,
        td_out => td_out,
        fifo_err => t_fifo_err,
        txclko => t_txclk,
        rxd => t_rxd,
        rxclk => t_rxclk,
        lfib => lfib,
        locked => locked);

    serial_out_n <= NOT td_out;
    serial_out_p <= td_out;

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
ARCHITECTURE SIM OF cy_15g04serdes IS
BEGIN
    assert (false)
    report "The cy_15g04serdes model is proprietary.  Contact Cypress Semiconductor for information."
    severity note;
END ARCHITECTURE SIM;
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

 Hint : cygoal_type := memory);

    port (Data_A : in std_logic_vector(DataWidthA-1 downto 0);
     Data_B : in std_logic_vector(DataWidthB-1 downto 0);
     Product : out std_logic_vector(DataWidthP-1 downto 0));
end cy_c39kmultiply;
architecture archRTL of CY_c39kmultiply is

    function max (a,b : natural) return natural is
    begin
        if (a < b) then return b; else return a; end if;
    end max;

    function "+" (a,b : std_logic_vector) return std_logic_vector is
        variable s : std_logic_vector (7 downto 0) := (others => '0');
        variable c : std_logic_vector (8 downto 0) := (others => '0');
    begin
        for i in 0 to 7 loop
            s(i) := a(i) XOR b(i) XOR c(i);
            c(i+1) :=(a(i) AND b(i)) OR (a(i) AND c(i)) OR (b(i) AND c(i));
        end loop;
        return s;
    end "+";

    type bvm is array (integer range <>,integer range <>) of std_logic;
    constant isize : natural := max(DataWidthA,DataWidthB);
    constant psize : natural := DataWidthA+DataWidthB;
    signal a,b : std_logic_vector ((isize-1) downto 0);
    signal I,c,s,ci,si : bvm (a'range,b'range);
    signal p : std_logic_vector (((isize*2)-1) downto 0);
    signal a0,b0 : std_logic_vector ((psize-1) downto 0);
    signal Imax,Isg : std_logic;
    signal Icg,Ixg,Itmp : std_logic;
    signal One : std_logic := '1';
    signal Zero : std_logic := '0';
begin
    SGW: if (IsSigned) generate
        assert ((DataWidthA >= 2) AND (DataWidthB >= 2))
        report "Signed multiply with input lengths of 1 are illegal."
        severity failure;
    end generate;

    -- Make the multiplier symmetrical.

    R0: if (DataWidthA > DataWidthB) generate
        SG: if (IsSigned) generate
            b((isize-1) downto DataWidthB) <= (OTHERS => data_b(data_b'high));
        end generate;
        UN: if (NOT IsSigned) generate
            b((isize-1) downto DataWidthB) <= (OTHERS => '0');
        end generate;
        b((DataWidthB - 1) downto 0) <= data_b;
        a <= data_a;
    end generate;
    R1: if (DataWidthA < DataWidthB) generate
        SG: if (IsSigned) generate
            a((isize-1) downto DataWidthA) <= (OTHERS => data_a(data_a'high));
        end generate;
        UN: if (NOT IsSigned) generate
            a((isize-1) downto DataWidthA) <= (OTHERS => '0');
        end generate;
        a((DataWidthA - 1) downto 0) <= data_a;
        b <= data_b;
    end generate;
    R2: if (DataWidthA = DataWidthB) generate
        a <= data_a;
        b <= data_b;
    end generate;

    I0: for j in 0 to (isize-1) generate
        I1: for k in 0 to (isize-1) generate
            SG: if (IsSigned) generate
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
            NG: if (NOT IsSigned) generate
                I(j,k) <= a(j) and b(k);
            end generate;
        end generate;
    end generate;
    SG: if (IsSigned) generate
        Isg <= I(isize-1,isize-1) xor a(isize-1) xor b(isize-1);
        Icg <= (I(isize-1,isize-1) and not a(isize-1)) or
               (I(isize-1,isize-1) and not b(isize-1)) or
                   (not a(isize-1) and not b(isize-1));
        Ixg <= (s(0,isize-2) and a(isize-1)) or
                (s(0,isize-2) and b(isize-1)) or
                (a(isize-1) and b(isize-1));
    end generate;
    NG: if (NOT IsSigned) generate
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
        SG: if (IsSigned) generate
            P1: if (l /= isize-1) generate
                p(l) <= s(0,l-1);
            end generate;
            P2: if (l = isize-1) generate
                p(l) <= s(0,l-1) xor (a(isize-1) xor b(isize-1));
            end generate;
        end generate;
        NG: if (NOT IsSigned) generate
            p(l) <= s(0,l-1);
        end generate;
    end generate;
    G1: for l in isize to ((isize*2)-2) generate
        p(l) <= s((l-isize),(isize-1));
    end generate;
    G2: if (isize*2 = 2) generate
        p(1) <= '0';
    end generate;
    G3: if (isize*2 > 2) generate
        p(p'high) <= c(isize-2,(isize-1)) xor not Icg;
    end generate;

    product <= p((psize-1) downto 0);
end archRTL;

--
-- Entities for Memory RTLs.
--
library ieee;
use ieee.std_logic_1164.all;
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
--
-- Architectures for Memory RTLs.
--

--
-- CY_C39KDUALPORT
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

architecture archRTL of CY_c39kdualport is
    signal atmp_a,atmp_b : std_logic_vector(addresswidth-1 downto 0);
    signal dtmp_a,dtmp_b : std_logic_vector(datawidth-1 downto 0);
    signal qtmp_a,qtmp_b : std_logic_vector(datawidth-1 downto 0);
    signal wtmp_a,wtmp_b : std_logic;
    signal busy : std_logic := '1';
    type memarray is array (2**addresswidth-1 downto 0)
                                    of std_logic_vector(datawidth-1 downto 0);

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
-- Port "A"

    process (inclk_a, addr_a)
    begin
        -- Synchronous Address "A"
        if (addr_ctrl_reg) then
            if (inclk_a'event AND inclk_a = '1') then
                atmp_a <= addr_a;
            end if;
        else
        -- Asynchronous Address "A"
            atmp_a <= addr_a;
        end if;
    end process;

    process (inclk_a, din_a)
    begin
        -- Synchronous Data "A"
        if (indata_reg) then
            if (inclk_a'event AND inclk_a = '1') then
                dtmp_a <= din_a;
            end if;
        else
        -- Asynchronous Data "A"
            dtmp_a <= din_a;
        end if;
    end process;

    process (inclk_a, wea)
        variable wreg : std_logic;
    begin
        -- Synchronous Write "A"
        if ((indata_reg) OR
            (addr_ctrl_reg)) then
            if (inclk_a'event AND inclk_a = '1') then
                wreg := wea;
            end if;
            wtmp_a <= wreg AND inclk_a;
        else
        -- Asynchronous Write "A"
            wtmp_a <= wea;
        end if;
    end process;

    process (outrega_ar, outclk_a, qtmp_a)
    begin
        -- Synchronous Read of RAM "A"
        if (outdataA_reg) then
            if (outrega_ar = '1') then
                dout_a <= (others => '0');
            elsif (outclk_a'event AND outclk_a = '1') then
                dout_a <= qtmp_a;
            end if;
        else
        -- Asynchronous Read of RAM "A"
            dout_a <= qtmp_a;
        end if;
    end process;

    -- Write and/or Read the appropriate range of memory
    process (dtmp_a, atmp_a, wtmp_a, dtmp_b, atmp_b, wtmp_b)

        variable mem : memarray := initmem(datawidth,2**addresswidth,filename);
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

    process (inclk_b, addr_b)
    begin
        -- Synchronous Address "B"
        if (addr_ctrl_reg) then
            if (inclk_b'event AND inclk_b = '1') then
                atmp_b <= addr_b;
            end if;
        else
        -- Asynchronous Address "B"
            atmp_b <= addr_b;
        end if;
    end process;

    process (inclk_b, din_b)
    begin
        -- Synchronous Data "B"
        if (indata_reg) then
            if (inclk_b'event AND inclk_b = '1') then
                dtmp_b <= din_b;
            end if;
        else
        -- Asynchronous Data "B"
            dtmp_b <= din_b;
        end if;
    end process;

    process (inclk_b, web)
        variable wreg : std_logic;
    begin
        -- Synchronous Write "B"
        if ((indata_reg) OR
            (addr_ctrl_reg)) then
            if (inclk_b'event AND inclk_b = '1') then
                wreg := web;
            end if;
            wtmp_b <= wreg AND inclk_b;
        else
        -- Asynchronous Write "B"
            wtmp_b <= web;
        end if;
    end process;

    process (outregb_ar, outclk_b, qtmp_b)
    begin
        -- Synchronous Read of RAM "B"
        if (outdataB_reg) then
            if (outregb_ar = '1') then
                dout_b <= (others => '0');
            elsif (outclk_b'event AND outclk_b = '1') then
                dout_b <= qtmp_b;
            end if;
        else
        -- Asynchronous Read of RAM "B"
            dout_b <= qtmp_b;
        end if;
    end process;
end archRTL;

--
-- CY_C39KFIFO
--
library ieee;
use ieee.std_logic_1164.all;
architecture archRTL of CY_c39kfifo is
    signal index: integer range numwords downto 0 := 0;
    type memarray is array (numwords-1 downto 0)
                                    of std_logic_vector(datawidth-1 downto 0);
begin
    -- Keep track of the address.
    process (mrb, ckw, ckr)
        variable wadd : integer range numwords downto 0 := 0;
        variable radd : integer range numwords downto 0 := 0;
        variable mem : memarray;
    begin

        if (mrb = '0') then
            index <= 0;
            wadd := 0;
            radd := 0;
            dout <= (others => '0');
        else
            if (ckw'event AND (ckw = '1')) then
                if ((index < numwords) AND (enw = '1')) then
                    index <= index+1;
                    mem(wadd) := din;
                    wadd := wadd + 1;
                    if (wadd >= numwords) then
                        wadd := 0;
                    end if;
                end if;
            end if;
            if (ckr'event AND (ckr = '1')) then
                if ((index > 0) AND (enr = '1')) then
                    index <= index-1;
                    dout <= mem(radd);
                    radd := radd + 1;
                    if (radd >= numwords) then
                        radd := 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    efb <= '0' when((index >= numwords) OR (index <= 0)) else '1';
    hfb <= '0' when (index >= numwords/2) else '1';
    pafeb <= '0' when (index >= pafe_distance) else '1';
end archRTL;

--
-- CY_C39KSINGLEPORT
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

use std.textio.all;

architecture archRTL of CY_c39ksingleport is
    signal atmp : std_logic_vector((addresswidth-1) downto 0);
    signal dtmp : std_logic_vector((datawidth-1) downto 0);
    signal qtmp : std_logic_vector((datawidth-1) downto 0);
    signal wtmp : std_logic;
    type memarray is array (2**addresswidth-1 downto 0)
                                    of std_logic_vector(datawidth-1 downto 0);

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
    process (inclk, addr)
    begin
        -- Synchronous Address
        if (addr_ctrl_reg) then
            if (inclk'event AND inclk = '1') then
                atmp <= addr;
            end if;
        else
        -- Asynchronous Address
            atmp <= addr;
        end if;
    end process;

    process (inclk, din)
    begin
        -- Synchronous Data
        if (indata_reg) then
            if (inclk'event AND inclk = '1') then
                dtmp <= din;
            end if;
        else
        -- Asynchronous Data
            dtmp <= din;
        end if;
    end process;

    process (inclk, we)
        variable wreg : std_logic;
    begin
        -- Synchronous Write
        if ((indata_reg) OR
            (addr_ctrl_reg)) then
            if (inclk'event AND inclk = '1') then
                wreg := we;
            end if;
            wtmp <= wreg AND inclk;
        else
        -- Asynchronous Write
            wtmp <= we;
        end if;
    end process;

    -- Write and/or Read the appropriate range of memory
    MEMORY:process (dtmp, atmp, wtmp)

        variable mem : memarray := initmem(datawidth,2**addresswidth,filename);
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

    process (outreg_ar, outclk, qtmp)
    begin
        -- Synchronous Read of RAM
        if (outdata_reg) then
            if (outreg_ar = '1') then
                dout <= (others => '0');
            elsif (outclk'event AND outclk = '1') then
                dout <= qtmp;
            end if;
        else
        -- Asynchronous Read of RAM
            dout <= qtmp;
        end if;
    end process;
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
