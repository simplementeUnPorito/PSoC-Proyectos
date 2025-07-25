-- lpmpkg.vhp --
--

--------------------------------------------------------------------------------
-- LPM Component Declarations --
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
package lpmpkg is

-- LPM types
    type Shift_Type is (LPM_LOGICAL, LPM_ROTATE, LPM_ARITHMETIC);
    type Repre_Type is (LPM_SIGNED, LPM_UNSIGNED);
    type Truth_Type is (LPM_F, LPM_FD, LPM_FR, LPM_FDR);
    type CtDir_Type is (LPM_NO_DIR, LPM_UP, LPM_DOWN);
    type Arith_Type is (LPM_NO_TYP, LPM_ADD, LPM_SUB);
    type Fflop_Type is (LPM_DFF,LPM_TFF);
    type ShDir_Type is (LPM_LEFT,LPM_RIGHT);
    type Regis_Type is (LPM_REGISTERED,LPM_UNREGISTERED);
    type Stgth_Type is (LPM_NO_STRENGTH,LPM_WEAK);
    type goal_type is (SPEED,AREA,COMBINATORIAL,MEMORY);

-- Internal functions declarations
    function port_state (arg : std_logic) return port_state_type;

    function connects (x : std_logic; i : integer) return integer;

    function max (a,b : natural) return natural;
    function vectorize (a, size : natural) RETURN std_logic_vector;
    function restring (a : std_logic_vector; w : positive) return std_logic_vector;
    function registered( regQ : regis_type) return BOOLEAN;

-- Constant signals
    signal zero : std_logic := '0' ;
    signal one : std_logic := '1' ;

-- LPM Components
component mcnstnt
    generic(lpm_width : positive := 1;
     lpm_cvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED;
     lpm_strength: stgth_type := LPM_NO_STRENGTH);
    port (result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component minv
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mand
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mor
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mxor
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_data_pol : std_logic_vector := "";
     lpm_result_pol : std_logic_vector := "");
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mbustri
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (tridata : inout std_logic_vector(lpm_width-1 downto 0);
     data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     enabletr : in std_logic := zero;
     enabledt : in std_logic := zero;
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mmux
    generic(lpm_width : positive := 1;
     lpm_size : positive := 1;
     lpm_widths : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector((lpm_width*lpm_size)-1 downto 0);
     sel : in std_logic_vector(lpm_widths-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mdecode
    generic(lpm_width : positive := 1;
     lpm_decodes : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     enable : in std_logic := one;
     eq : out std_logic_vector(lpm_decodes-1 downto 0));
end component;
component mclshift
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
end component;
component madd_sub
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
end component;
component mcompare
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
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end component;
component mmult
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
end component;
component mabs
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0);
     overflow : out std_logic);
end component;
component mcounter
    generic(lpm_width : positive := 1;
     lpm_direction : ctdir_type := LPM_NO_DIR;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     clock : in std_logic;
     clk_en : in std_logic := one;
     cnt_en : in std_logic := one;
     updown : in std_logic := one;
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
end component;
component mlatch
    generic(lpm_width : positive := 1;
     lpm_avalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     gate : in std_logic;
     q : out std_logic_vector(lpm_width-1 downto 0);
     aset : in std_logic := zero;
     aclr : in std_logic := zero);
end component;
component mshiftreg
    generic(lpm_width : positive := 1;
     lpm_direction : shdir_type:= LPM_LEFT;
     lpm_avalue : std_logic_vector := "";
     lpm_svalue : std_logic_vector := "";
     lpm_pvalue : std_logic_vector := "";
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0) := (others => zero);
     clock : in std_logic;
     enable : in std_logic := one;
     shiftin : in std_logic := zero;
     load : in std_logic := zero;
     q : out std_logic_vector(lpm_width-1 downto 0);
     shiftout : out std_logic;
     aset : in std_logic := zero;
     aclr : in std_logic := zero;
     sset : in std_logic := zero;
     sclr : in std_logic := zero;
     testenab : in std_logic := zero;
     testin : in std_logic := zero;
     testout : out std_logic);
end component;
component mff
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
end component;
component mram_dq
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
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     we : in std_logic;
     outreg_ar : in std_logic := zero);
end component;
component mram_io
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
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     memenab : in std_logic := one;
     outenab : in std_logic := zero;
     we : in std_logic := one;
     outreg_ar : in std_logic := zero);
end component;
component mrom
    generic(lpm_width : positive := 1;
     lpm_widthad : positive := 1;
     lpm_numwords: natural := 1;
     lpm_address_control : regis_type := LPM_REGISTERED;
     lpm_outdata : regis_type := LPM_REGISTERED;
     lpm_file : string := "";
     lpm_hint : goal_type := SPEED);
    port (address : in std_logic_vector(lpm_widthad-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     inclock : in std_logic := zero;
     outclock : in std_logic := zero;
     memenab : in std_logic := one;
     outreg_AR : in std_logic := zero);
end component;
component cy_fifo
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
end component;
component cy_ram_dp
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
     inclock_a : in std_logic := zero;
     inclock_b : in std_logic := zero;
     outclock_a : in std_logic := zero;
     outclock_b : in std_logic := zero;
     outrega_ar : in std_logic := zero;
     outregb_ar : in std_logic := zero);
end component;
component mparity
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (data : in std_logic_vector (lpm_width - 1 downto 0);
     even : out std_logic;
     odd : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end component;
component minpad
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (result : out std_logic_vector(lpm_width-1 downto 0);
     pad : in std_logic_vector(lpm_width-1 downto 0) := (others => zero));
end component;
component moutpad
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     pad : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mbipad
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector (lpm_width-1 downto 0);
     enable : in std_logic;
     result : out std_logic_vector (lpm_width-1 downto 0);
     pad : inout std_logic_vector(lpm_width-1 downto 0));
end component;
component mgnd
    generic(lpm_width : positive := 1);
    port (x : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mvcc
    generic(lpm_width : positive := 1);
    port (x : out std_logic_vector(lpm_width-1 downto 0));
end component;
component mbuf
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0));
end component;

end lpmpkg;

-- Internal functions definitions
package body lpmpkg is

    function port_state (arg : std_logic) return port_state_type is
        variable result : port_state_type := ps_connected;
    begin

        result := arg'port_state_att;

        return result;
    end port_state;

    function connects (x : std_logic; i : integer) return integer is
        variable result : integer := i;
    begin
        if (port_state(x) = ps_connected) then
            result := result - 1;
        end if;
        return (result);
    end connects;

    function max (a,b : natural) return natural is
    begin
        if (a < b) then return b; else return a; end if;
    end max;

    function vectorize (a, size : natural) return std_logic_vector is
        variable result : std_logic_vector(size-1 downto 0) := (others => '0');
        variable b : natural;
        variable newsize : integer := size;
    begin
        if (newsize > 32) then
            newsize := 32;
        end if;
        if (newsize <= 31) then
            for i in result'reverse_range loop
                if ((a/(2**i)) mod 2) = 1 then
                    result(i) := '1';
                end if;
            end loop;
        end if;
        if (newsize = 32) then
            b := a/2;
            if ((a mod 2) = 1) then
                result(result'low) := '1';
            end if;
            for i in 0 to (newsize - 2) loop
                if ((b/(2**i)) mod 2) = 1 then
                    result(i+1) := '1';
                end if;
            end loop;
        end if;
        return result;
    end vectorize;

    function restring (a : std_logic_vector; w : positive) return std_logic_vector is
        variable result : std_logic_vector (w-1 downto 0) := (others => '1');
        variable indx : natural;
    begin

        if (a'length = 0) then
            return result;
        else
            indx := 0;
            Resloop: for i in a'reverse_range loop
                case a(i) is
                when '1' => result(indx) := '1';
                when '0' => result(indx) := '0';
                when others => Assert (false)
                    Report "Invalid char. literal (must be '1' or '0').  Defauting to  '0'."
                    Severity Warning;
                    result(indx) := '0';
                end case;
                indx := indx + 1;
                if (indx >= w) then
                    exit Resloop;
                end if;
            end loop;
            return result;
        end if;
    end restring;

    function registered( regQ : regis_type) return BOOLEAN is
    begin
        if regQ = LPM_registered then
            return(TRUE);
        else
            return(FALSE);
        end if;
    end registered;
end lpmpkg;
