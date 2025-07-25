-- /*******************************************************************************
-- * Copyright 1999, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/
--------------------------------------------------------------------------------
--
--	Ultragen std_logic_arith Component Package
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package ultragenpkg_sla is

    TYPE unsigned is array (natural range <>) of std_logic;
    TYPE   signed is array (natural range <>) of std_logic;

    constant noWarning : boolean := false;

    function vectorize (a, size : natural)  return std_logic_vector;
    function resize (x : std_logic_vector; size : natural)
						    return std_logic_vector;
    function resize (x : signed; size : natural) return signed;
    function resize (x : unsigned; size : natural) return unsigned;
    function lsb1 (a : std_logic_vector; maxsize : natural) return natural;
    function lsb1 (a : unsigned; maxsize : natural) return natural;
    function lsb1 (a : signed; maxsize : natural) return natural;
    function lsb1 (a : integer; maxsize : natural) return natural;
    function msb1 (a : std_logic_vector; maxsize : natural) return natural;
    function msb1 (a : unsigned; maxsize : natural) return natural;
    function msb1 (a : signed; maxsize : natural) return natural;
    function msb1 (a : integer; maxsize : natural) return natural;
    function get_max (x : integer) return integer;
    function bits_needed (val : natural) return natural;
    function max (a,b : natural) return natural;

-- generic adder

    component add_gen
	generic (goal : goal_type := speed; 
		 IsSigned  : Boolean := false;
		 IsAStatic : Boolean := false;
		 IsBStatic : Boolean := false;
		 lsbOne : natural;
		 msbOne : natural);
	port (aa,bb : in std_logic_vector; ss : out std_logic_vector);
    end component;

-- adder components return unsigned

    component add_uu_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

    component add_ui_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  integer;
	    s	: out unsigned);
    end component;

    component add_iu_u
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

    component add_ub_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  std_ulogic;
	    s	: out unsigned);
    end component;

    component add_bu_u
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

-- adder components return signed

    component add_ss_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component add_us_s
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component add_su_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    s	: out signed);
    end component;

    component add_si_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  integer;
	    s	: out signed);
    end component;

    component add_is_s
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component add_sb_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  std_ulogic;
	    s	: out signed);
    end component;

    component add_bs_s
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  signed;
	    s	: out signed);
    end component;

-- adder components return std_logic_vector

    component add_uu_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component add_ui_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component add_iu_v
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component add_ub_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component add_bu_v
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component add_ss_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component add_us_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component add_su_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component add_si_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component add_is_v
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component add_sb_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component add_bs_v
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

-- add unsigned std_logic_vector return std_logic_vector

    component add_vv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component add_vi_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component add_iv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component add_vb_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component add_bv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

-- add signed std_logic_vector return std_logic_vector

    component add_vv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component add_vi_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component add_iv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component add_vb_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component add_bv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

-- generic subtractor

    component sub_gen
	generic (goal : goal_type := speed; 
		 IsSigned  : Boolean := false;
		 IsAStatic : Boolean := false;
		 IsBStatic : Boolean := false;
		 lsbOne : natural;
		 msbOne : natural);
	port (aa,bb : in std_logic_vector; ss : out std_logic_vector);
    end component;

-- subtractor components return unsigned

    component sub_uu_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

    component sub_ui_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  integer;
	    s	: out unsigned);
    end component;

    component sub_iu_u
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

    component sub_ub_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  std_ulogic;
	    s	: out unsigned);
    end component;

    component sub_bu_u
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  unsigned;
	    s	: out unsigned);
    end component;

-- subtractor components return signed

    component sub_ss_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component sub_us_s
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component sub_su_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    s	: out signed);
    end component;

    component sub_si_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  integer;
	    s	: out signed);
    end component;

    component sub_is_s
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  signed;
	    s	: out signed);
    end component;

    component sub_sb_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  std_ulogic;
	    s	: out signed);
    end component;

    component sub_bs_s
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  signed;
	    s	: out signed);
    end component;

-- subtractor components return std_logic_vector

    component sub_uu_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component sub_ui_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component sub_iu_v
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component sub_ub_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component sub_bu_v
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component sub_ss_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component sub_us_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component sub_su_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    s	: out std_logic_vector);
    end component;

    component sub_si_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component sub_is_v
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

    component sub_sb_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component sub_bs_v
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  signed;
	    s	: out std_logic_vector);
    end component;

-- subtract unsigned std_logic_vector return std_logic_vector

    component sub_vv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component sub_vi_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component sub_iv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component sub_vb_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component sub_bv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

-- subtract signed std_logic_vector return std_logic_vector

    component sub_vv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component sub_vi_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  integer;
	    s	: out std_logic_vector);
    end component;

    component sub_iv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  integer;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

    component sub_vb_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_ulogic;
	    s	: out std_logic_vector);
    end component;

    component sub_bv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_ulogic;
	    b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;


-- Generic multiplier

    component mul_gen
	generic (goal : goal_type := speed; 
		 IsSigned  : Boolean := false;
		 IsAStatic : Boolean := false;
		 IsBStatic : Boolean := false;
		 lsbOne : natural;
		 msbOne : natural);
	port (aa,bb : in std_logic_vector; pp : out std_logic_vector);
    end component;

-- multiplier component returns unsigned

    component mul_uu_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    p	: out unsigned);
    end component;

-- multiplier component returns signed

    component mul_ss_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    p	: out signed);
    end component;

    component mul_su_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    p	: out signed);
    end component;

    component mul_us_s
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    p	: out signed);
    end component;

-- multiplier component returns std_logic_vector

    component mul_uu_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  unsigned;
	    p	: out std_logic_vector);
    end component;

    component mul_ss_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  signed;
	    p	: out std_logic_vector);
    end component;

    component mul_su_v
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: in  unsigned;
	    p	: out std_logic_vector);
    end component;

    component mul_us_v
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: in  signed;
	    p	: out std_logic_vector);
    end component;

-- multiply unsigned std_logic_vector return std_logic_vector

    component mul_vv_v_us
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    p	: out std_logic_vector);
    end component;

-- multiply signed std_logic_vector return std_logic_vector

    component mul_vv_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: in  std_logic_vector;
	    p	: out std_logic_vector);
    end component;

-- Generic comparator

    component cmp_gen
	generic (goal : goal_type := speed; 
		 IsSigned  : Boolean := false;
		 IsAStatic : Boolean := false;
		 IsBStatic : Boolean := false);
	port (a,b : in std_logic_vector; lt,lte,gt,gte,eq,neq: out Boolean);
    end component;

-- comparator components return boolean

    component cmp_uu_bl
	generic (goal : goal_type := speed);
	port (a	: in unsigned;
	    b	: in unsigned;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_ss_bl
	generic (goal : goal_type := speed);
	port (a	: in signed;
	    b	: in signed;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_us_bl
	generic (goal : goal_type := speed);
	port (a	: in unsigned;
	    b	: in signed;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_su_bl
	generic (goal : goal_type := speed);
	port (a	: in signed;
	    b	: in unsigned;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_ui_bl
	generic (goal : goal_type := speed);
	port (a	: in unsigned;
	    b	: in integer;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iu_bl
	generic (goal : goal_type := speed);
	port (a	: in integer;
	    b	: in unsigned;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_si_bl
	generic (goal : goal_type := speed);
	port (a	: in signed;
	    b	: in integer;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_is_bl
	generic (goal : goal_type := speed);
	port (a	: in integer;
	    b	: in signed;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

-- compare unsigned std_logic_vectors

    component cmp_vv_us_bl
	generic (goal : goal_type := speed);
	port (a	: in std_logic_vector;
	    b	: in std_logic_vector;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_vi_us_bl
	generic (goal : goal_type := speed);
	port (a	: in std_logic_vector;
	    b	: in integer;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iv_us_bl
	generic (goal : goal_type := speed);
	port (a	: in integer;
	    b	: in std_logic_vector;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

-- compare signed std_logic_vectors

    component cmp_vv_sg_bl
	generic (goal : goal_type := speed);
	port (a	: in std_logic_vector;
	    b	: in std_logic_vector;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_vi_sg_bl
	generic (goal : goal_type := speed);
	port (a	: in std_logic_vector;
	    b	: in integer;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iv_sg_bl
	generic (goal : goal_type := speed);
	port (a	: in integer;
	    b	: in std_logic_vector;
	    lt,lte,gt,gte,eq,neq : out boolean);
    end component;

-- Unary operations

    component uni_as_s
    	generic (goal : goal_type := speed);
	port (a : in  signed;
	    b	: out signed);
    end component;

    component uni_ms_s
	generic (goal : goal_type := speed);
	port (b	: in  signed;
	    s	: out signed);
    end component;

    component uni_as_v_sg
	generic (goal : goal_type := speed);
	port (a	: in  std_logic_vector;
	    b	: out std_logic_vector);
    end component;

    component uni_ms_v_sg
	generic (goal : goal_type := speed);
	port (b	: in  std_logic_vector;
	    s	: out std_logic_vector);
    end component;

-- shift components

    component shl_uu_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: out unsigned;
	    s	: out unsigned);
    end component;

    component shl_su_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: out unsigned;
	    s	: out signed);
    end component;

    component shr_uu_u
	generic (goal : goal_type := speed);
	port (a	: in  unsigned;
	    b	: out unsigned;
	    s	: out unsigned);
    end component;

    component shr_su_s
	generic (goal : goal_type := speed);
	port (a	: in  signed;
	    b	: out unsigned;
	    s	: out signed);
    end component;

end package ultragenpkg_sla;

--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package body ultragenpkg_sla is

    function vectorize (a, size : natural) return unsigned is
	variable result : unsigned(size-1 downto 0) := (others => '0');
	variable tmp : unsigned(size-1 downto 0) := (others => '0');
	variable b : natural;
	variable carry : std_logic;
	variable newsize : integer := size;
    begin
	if (newsize > 32) then 
	    newsize := 32;
	end if;

	if (a < 0) then
	    b := -a;
	else
	    b := a;
	end if;

	if (newsize <= 31) then
	    for i in result'reverse_range loop
		if ((b/(2**i)) mod 2) = 1 then
		    result(i) := '1';
		end if;
	    end loop;
	end if;
	if (newsize = 32) then
	    if ((b mod 2) = 1) then
		result(result'low) := '1';
	    end if;
	    b := b/2;
	    for i in 0 to (newsize-2) loop
		if ((b/(2**i)) mod 2) = 1 then
		    result(i+1) := '1';
		end if;
	    end loop;
	end if;

-- Do a 2's complement if a is less than 0.
	if (a < 0) then
	    tmp := NOT result;
	    result(0) := NOT tmp(0);
	    carry := tmp(0);
	    for i in 1 to size-1 loop
	    	result(i) := tmp(i) XOR carry;
		carry := tmp(i) AND carry;
	    end loop;
	end if;

	return result;
    end vectorize;

    function resize (x : std_logic_vector; size : natural) return std_logic_vector is
	variable a : std_logic_vector ((x'length-1) downto 0) := x;
        variable result : std_logic_vector((size-1) downto 0) :=(others => '0');
    begin
        if (size < 1 ) then return result; end if;
        if a'length < size then

	    result((result'high) downto a'length) := (others => '0');

	    result((a'length - 1) downto 0) := a;
        else
	    result := a((size-1) downto 0);
        end if;
        return result;
    end resize;

    function resize (x : signed; size : natural) return signed is
	variable a : signed ((x'length-1) downto 0) := x;
        variable result : signed((size-1) downto 0) :=(others => '0');
    begin
        if (size < 1 ) then return result; end if;
        if a'length < size then

	    -- Sign extend
	    result((result'high) downto a'length) := (others => x(x'high));

	    result((a'length - 1) downto 0) := a;
        else
	    result := a((size-1) downto 0);
        end if;
        return result;
    end resize;

    function resize (x : unsigned; size : natural) return unsigned is
	variable a : unsigned ((x'length-1) downto 0) := x;
        variable result : unsigned((size-1) downto 0) :=(others => '0');
    begin
        if (size < 1 ) then return result; end if;
        if a'length < size then

	    result((result'high) downto a'length) := (others => '0');

	    result((a'length - 1) downto 0) := a;
        else
	    result := a((size-1) downto 0);
        end if;
        return result;
    end resize;

    -- returns first least significant std_logic position less than maxsize
    -- or return maxsize

    function lsb1 (a : std_logic_vector; maxsize : natural) return natural is
	variable val  : std_logic_vector (a'length-1 downto 0) := a;
	variable indx : natural := 0;
    begin
        for i in val'reverse_range loop
	    IF (indx >= maxsize) OR (val(i) = '1') then
    	        return indx;
    	    end IF;
	    indx := indx + 1;
        end loop;
        return maxsize;
    end lsb1;

    function lsb1 (a : unsigned; maxsize : natural) return natural is
	variable val  : unsigned (a'length-1 downto 0) := a;
	variable indx : natural := 0;
    begin
        for i in val'reverse_range loop
	    IF (indx >= maxsize) OR (val(i) = '1') then
    	        return indx;
    	    end IF;
	    indx := indx + 1;
        end loop;
        return maxsize;
    end lsb1;

    function lsb1 (a : signed; maxsize : natural) return natural is
	variable val  : signed (a'length-1 downto 0) := a;
	variable indx : natural := 0;
    begin
        for i in val'reverse_range loop
	    IF (indx >= maxsize) OR (val(i) = '1') then
    	        return indx;
    	    end IF;
	    indx := indx + 1;
        end loop;
        return maxsize;
    end lsb1;

    function lsb1 (a : integer; maxsize : natural) return natural is
	variable indx	: natural := 0;
	variable v	: integer := a;
    begin
	while (( indx <= 31 ) AND (indx <= maxsize)) loop
	    if (v mod 2) = 1 then
		return indx;
	    end if;
	    v := v / 2;
	    indx := indx + 1;
	end loop;
	return maxsize;
    end lsb1;

    -- returns first most significant std_logic position less than maxsize
    -- or return maxsize

    function msb1 (a : std_logic_vector; maxsize : natural) return natural is
	variable val  : std_logic_vector (a'length-1 downto 0) := a;
	variable indx : natural := val'length-1;
    begin
        for i in val'range loop
	    IF ((indx < maxsize) AND (val(i) = '1')) then
		return indx;
	    end IF;
	    indx := indx - 1;
        end loop;
        return maxsize;
    end msb1;

    function msb1 (a : unsigned; maxsize : natural) return natural is
	variable val  : unsigned (a'length-1 downto 0) := a;
	variable indx : natural := val'length-1;
    begin
        for i in val'range loop
	    IF ((indx < maxsize) AND (val(i) = '1')) then
		return indx;
	    end IF;
	    indx := indx - 1;
        end loop;
        return maxsize;
    end msb1;

    function msb1 (a : signed; maxsize : natural) return natural is
	variable val  : signed (a'length-1 downto 0) := a;
	variable indx : natural := val'length-1;
    begin
        for i in val'range loop
	    IF ((indx < maxsize) AND (val(i) = '1')) then
		return indx;
	    end IF;
	    indx := indx - 1;
        end loop;
        return maxsize;
    end msb1;

    function msb1 (a : integer; maxsize : natural) return natural is
	variable indx : natural := 31;
    begin
	if (maxsize < indx) then
	    indx := maxsize;
	end if;
	if (indx = 31) then
	    indx := 30;
	    if ((a/2) mod (2**30)) = 1 then
		return 31;
	    end if;
	end if;
	while ( indx >= 0 ) loop
	    if ((a / (2**indx)) mod 2) = 1 then
		return indx;
	    end if;
	    indx := indx - 1;
	end loop;
	return maxsize;
    end msb1;

    function get_max (x : integer) return integer IS
    begin
	if (x'globally_static) then
	    return x ;
	else
	    return x'high ;
	end if ;
    end get_max ;

    function bits_needed (val : natural) return natural IS
	variable tmp  : natural := val;
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

    function max (a,b : natural) return natural is
    begin
	if (a < b) then return b; else return a; end if;
    end max;

end ultragenpkg_sla;
