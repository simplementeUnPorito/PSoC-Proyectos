-- /*******************************************************************************
-- * Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/
--------------------------------------------------------------------------
--
--		STD_LOGIC_ARITH package
--
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.ultragenpkg_sla.all;

package std_logic_arith is

    type unsigned is array (natural range <>) of std_logic;
    type   signed is array (natural range <>) of std_logic;
    subtype small_int is integer range 0 to 1;

-- add functions return unsigned

    function "+"(l: unsigned; r: unsigned) return unsigned;
	attribute ultragen of "+" [unsigned, unsigned return unsigned] :
	function is "add_uu_u";
    function "+"(l: unsigned; r: integer) return unsigned;
    	attribute ultragen of "+" [unsigned, integer return unsigned] :
	function is "add_ui_u";
    function "+"(l: integer; r: unsigned) return unsigned;
    	attribute ultragen of "+" [integer, unsigned return unsigned] :
	function is "add_iu_u";
    function "+"(l: unsigned; r: std_ulogic) return unsigned;
	attribute ultragen of "+" [unsigned, std_ulogic return unsigned] :
	function is "add_ub_u";
    function "+"(l: std_ulogic; r: unsigned) return unsigned;
	attribute ultragen of "+" [std_ulogic, unsigned return unsigned] :
	function is "add_bu_u";

-- add functions return signed

    function "+"(l: signed; r: signed) return signed;
	attribute ultragen of "+" [signed, signed return signed] :
	function is "add_ss_s";
    function "+"(l: unsigned; r: signed) return signed;
	attribute ultragen of "+" [unsigned, signed return signed] :
	function is "add_us_s";
    function "+"(l: signed; r: unsigned) return signed;
	attribute ultragen of "+" [signed, unsigned return signed] :
	function is "add_su_s";
    function "+"(l: signed; r: integer) return signed;
    	attribute ultragen of "+" [signed, integer return signed] :
	function is "add_si_s";
    function "+"(l: integer; r: signed) return signed;
	attribute ultragen of "+" [integer, signed return signed] :
	function is "add_is_s";
    function "+"(l: signed; r: std_ulogic) return signed;
	attribute ultragen of "+" [signed, std_ulogic return signed] :
	function is "add_sb_s";
    function "+"(l: std_ulogic; r: signed) return signed;
	attribute ultragen of "+" [std_ulogic, signed return signed] :
	function is "add_bs_s";

-- add functions return std_logic_vector
--
--    function "+"(l: unsigned; r: unsigned) return std_logic_vector;
--	attribute ultragen of "+" [unsigned, unsigned return std_logic_vector] :
--	function is "add_uu_v";
--    function "+"(l: signed; r: signed) return std_logic_vector;
--	attribute ultragen of "+" [signed, signed return std_logic_vector] :
--	function is "add_ss_v";
--    function "+"(l: unsigned; r: signed) return std_logic_vector;
--	attribute ultragen of "+" [unsigned, signed return std_logic_vector] :
--	function is "add_us_v";
--    function "+"(l: signed; r: unsigned) return std_logic_vector;
--	attribute ultragen of "+" [signed, unsigned return std_logic_vector] :
--	function is "add_su_v";
--    function "+"(l: unsigned; r: integer) return std_logic_vector;
--    	attribute ultragen of "+" [unsigned, integer return std_logic_vector] :
--	function is "add_ui_v";
--    function "+"(l: integer; r: unsigned) return std_logic_vector;
--    	attribute ultragen of "+" [integer, unsigned return std_logic_vector] :
--	function is "add_iu_v";
--    function "+"(l: signed; r: integer) return std_logic_vector;
--	attribute ultragen of "+" [signed, integer return std_logic_vector] :
--	function is "add_si_v";
--    function "+"(l: integer; r: signed) return std_logic_vector;
--	attribute ultragen of "+" [integer, signed return std_logic_vector] :
--	function is "add_is_v";
--    function "+"(l: unsigned; r: std_ulogic) return std_logic_vector;
--	attribute ultragen of "+" [unsigned,std_ulogic return std_logic_vector]:
--	function is "add_ub_v";
--    function "+"(l: std_ulogic; r: unsigned) return std_logic_vector;
--	attribute ultragen of "+" [std_ulogic,unsigned return std_logic_vector]:
--	function is "add_bu_v";
--    function "+"(l: signed; r: std_ulogic) return std_logic_vector;
--	attribute ultragen of "+" [signed, std_ulogic return std_logic_vector] :
--	function is "add_sb_v";
--    function "+"(l: std_ulogic; r: signed) return std_logic_vector;
--	attribute ultragen of "+" [std_ulogic, signed return std_logic_vector] :
--	function is "add_bs_v";

-- sub functions return unsigned

    function "-"(l: unsigned; r: unsigned) return unsigned;
	attribute ultragen of "-" [unsigned, unsigned return unsigned] :
	function is "sub_uu_u";
    function "-"(l: unsigned; r: integer) return unsigned;
    	attribute ultragen of "-" [unsigned, integer return unsigned] :
	function is "sub_ui_u";
    function "-"(l: integer; r: unsigned) return unsigned;
    	attribute ultragen of "-" [integer, unsigned return unsigned] :
	function is "sub_iu_u";
    function "-"(l: unsigned; r: std_ulogic) return unsigned;
	attribute ultragen of "-" [unsigned, std_ulogic return unsigned] :
	function is "sub_ub_u";
    function "-"(l: std_ulogic; r: unsigned) return unsigned;
	attribute ultragen of "-" [std_ulogic, unsigned return unsigned] :
	function is "sub_bu_u";

-- sub functions return signed

    function "-"(l: signed; r: signed) return signed;
	attribute ultragen of "-" [signed, signed return signed] :
	function is "sub_ss_s";
    function "-"(l: unsigned; r: signed) return signed;
	attribute ultragen of "-" [unsigned, signed return signed] :
	function is "sub_us_s";
    function "-"(l: signed; r: unsigned) return signed;
	attribute ultragen of "-" [signed, unsigned return signed] :
	function is "sub_su_s";
    function "-"(l: signed; r: integer) return signed;
    	attribute ultragen of "-" [signed, integer return signed] :
	function is "sub_si_s";
    function "-"(l: integer; r: signed) return signed;
	attribute ultragen of "-" [integer, signed return signed] :
	function is "sub_is_s";
    function "-"(l: signed; r: std_ulogic) return signed;
	attribute ultragen of "-" [signed, std_ulogic return signed] :
	function is "sub_sb_s";
    function "-"(l: std_ulogic; r: signed) return signed;
	attribute ultragen of "-" [std_ulogic, signed return signed] :
	function is "sub_bs_s";

-- sub functions return std_logic_vector
--
--    function "-"(l: unsigned; r: unsigned) return std_logic_vector;
--	attribute ultragen of "-" [unsigned, unsigned return std_logic_vector] :
--	function is "sub_uu_v";
--    function "-"(l: signed; r: signed) return std_logic_vector;
--	attribute ultragen of "-" [signed, signed return std_logic_vector] :
--	function is "sub_ss_v";
--    function "-"(l: unsigned; r: signed) return std_logic_vector;
--	attribute ultragen of "-" [unsigned, signed return std_logic_vector] :
--	function is "sub_us_v";
--    function "-"(l: signed; r: unsigned) return std_logic_vector;
--	attribute ultragen of "-" [signed, unsigned return std_logic_vector] :
--	function is "sub_su_v";
--    function "-"(l: unsigned; r: integer) return std_logic_vector;
--    	attribute ultragen of "-" [unsigned, integer return std_logic_vector] :
--	function is "sub_ui_v";
--    function "-"(l: integer; r: unsigned) return std_logic_vector;
--    	attribute ultragen of "-" [integer, unsigned return std_logic_vector] :
--	function is "sub_iu_v";
--    function "-"(l: signed; r: integer) return std_logic_vector;
--	attribute ultragen of "-" [signed, integer return std_logic_vector] :
--	function is "sub_si_v";
--    function "-"(l: integer; r: signed) return std_logic_vector;
--	attribute ultragen of "-" [integer, signed return std_logic_vector] :
--	function is "sub_is_v";
--    function "-"(l: unsigned; r: std_ulogic) return std_logic_vector;
--	attribute ultragen of "-" [unsigned,std_ulogic return std_logic_vector]:
--	function is "sub_ub_v";
--    function "-"(l: std_ulogic; r: unsigned) return std_logic_vector;
--	attribute ultragen of "-" [std_ulogic,unsigned return std_logic_vector]:
--	function is "sub_bu_v";
--    function "-"(l: signed; r: std_ulogic) return std_logic_vector;
--	attribute ultragen of "-" [signed, std_ulogic return std_logic_vector] :
--	function is "sub_sb_v";
--    function "-"(l: std_ulogic; r: signed) return std_logic_vector;
--	attribute ultragen of "-" [std_ulogic, signed return std_logic_vector] :
--	function is "sub_bs_v";

-- mult functions return unsigned

    function "*"(l: unsigned; r: unsigned) return unsigned;
	attribute ultragen of "*" [unsigned, unsigned return unsigned] :
	function is "mul_uu_u";

-- mult functions return signed

    function "*"(l: signed; r: signed) return signed;
	attribute ultragen of "*" [signed, signed return signed] :
	function is "mul_ss_s";
    function "*"(l: signed; r: unsigned) return signed;
	attribute ultragen of "*" [signed, unsigned return signed] :
	function is "mul_su_s";
    function "*"(l: unsigned; r: signed) return signed;
	attribute ultragen of "*" [unsigned, signed return signed] :
	function is "mul_us_s";

-- mult functions return std_logic_vector
--
--    function "*"(l: unsigned; r: unsigned) return std_logic_vector;
--	attribute ultragen of "*" [unsigned, unsigned return std_logic_vector] :
--	function is "mul_uu_v";
--    function "*"(l: signed; r: signed) return std_logic_vector;
--	attribute ultragen of "*" [signed, signed return std_logic_vector] :
--	function is "mul_ss_v";
--    function "*"(l: signed; r: unsigned) return std_logic_vector;
--	attribute ultragen of "*" [signed, unsigned return std_logic_vector] :
--	function is "mul_su_v";
--    function "*"(l: unsigned; r: signed) return std_logic_vector;
--	attribute ultragen of "*" [unsigned, signed return std_logic_vector] :
--	function is "mul_us_v";

-- less than compare functions return boolean

    function "<"(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of "<" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function "<"(l: signed; r: signed) return boolean;
	attribute ultragen of "<" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function "<"(l: unsigned; r: signed) return boolean;
	attribute ultragen of "<" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function "<"(l: signed; r: unsigned) return boolean;
	attribute ultragen of "<" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function "<"(l: unsigned; r: integer) return boolean;
	attribute ultragen of "<" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function "<"(l: integer; r: unsigned) return boolean;
	attribute ultragen of "<" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function "<"(l: signed; r: integer) return boolean;
	attribute ultragen of "<" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function "<"(l: integer; r: signed) return boolean;
	attribute ultragen of "<" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- less than or equal compare functions return boolean

    function "<="(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of "<=" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function "<="(l: signed; r: signed) return boolean;
	attribute ultragen of "<=" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function "<="(l: unsigned; r: signed) return boolean;
	attribute ultragen of "<=" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function "<="(l: signed; r: unsigned) return boolean;
	attribute ultragen of "<=" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function "<="(l: unsigned; r: integer) return boolean;
	attribute ultragen of "<=" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function "<="(l: integer; r: unsigned) return boolean;
	attribute ultragen of "<=" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function "<="(l: signed; r: integer) return boolean;
	attribute ultragen of "<=" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function "<="(l: integer; r: signed) return boolean;
	attribute ultragen of "<=" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- greater than compare functions return boolean

    function ">"(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of ">" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function ">"(l: signed; r: signed) return boolean;
	attribute ultragen of ">" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function ">"(l: unsigned; r: signed) return boolean;
	attribute ultragen of ">" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function ">"(l: signed; r: unsigned) return boolean;
	attribute ultragen of ">" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function ">"(l: unsigned; r: integer) return boolean;
	attribute ultragen of ">" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function ">"(l: integer; r: unsigned) return boolean;
	attribute ultragen of ">" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function ">"(l: signed; r: integer) return boolean;
	attribute ultragen of ">" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function ">"(l: integer; r: signed) return boolean;
	attribute ultragen of ">" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- greater than or equal compare functions return boolean

    function ">="(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of ">=" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function ">="(l: signed; r: signed) return boolean;
	attribute ultragen of ">=" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function ">="(l: unsigned; r: signed) return boolean;
	attribute ultragen of ">=" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function ">="(l: signed; r: unsigned) return boolean;
	attribute ultragen of ">=" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function ">="(l: unsigned; r: integer) return boolean;
	attribute ultragen of ">=" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function ">="(l: integer; r: unsigned) return boolean;
	attribute ultragen of ">=" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function ">="(l: signed; r: integer) return boolean;
	attribute ultragen of ">=" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function ">="(l: integer; r: signed) return boolean;
	attribute ultragen of ">=" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- equal compare functions return boolean

    function "="(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of "=" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function "="(l: signed; r: signed) return boolean;
	attribute ultragen of "=" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function "="(l: unsigned; r: signed) return boolean;
	attribute ultragen of "=" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function "="(l: signed; r: unsigned) return boolean;
	attribute ultragen of "=" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function "="(l: unsigned; r: integer) return boolean;
	attribute ultragen of "=" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function "="(l: integer; r: unsigned) return boolean;
	attribute ultragen of "=" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function "="(l: signed; r: integer) return boolean;
	attribute ultragen of "=" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function "="(l: integer; r: signed) return boolean;
	attribute ultragen of "=" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- equal compare functions return boolean

    function "/="(l: unsigned; r: unsigned) return boolean;
	attribute ultragen of "/=" [unsigned, unsigned return boolean] :
	function is "cmp_uu_bl";
    function "/="(l: signed; r: signed) return boolean;
	attribute ultragen of "/=" [signed, signed return boolean] :
	function is "cmp_ss_bl";
    function "/="(l: unsigned; r: signed) return boolean;
	attribute ultragen of "/=" [unsigned, signed return boolean] :
	function is "cmp_us_bl";
    function "/="(l: signed; r: unsigned) return boolean;
	attribute ultragen of "/=" [signed, unsigned return boolean] :
	function is "cmp_su_bl";
    function "/="(l: unsigned; r: integer) return boolean;
	attribute ultragen of "/=" [unsigned, integer return boolean] :
	function is "cmp_ui_bl";
    function "/="(l: integer; r: unsigned) return boolean;
	attribute ultragen of "/=" [integer, unsigned return boolean] :
	function is "cmp_iu_bl";
    function "/="(l: signed; r: integer) return boolean;
	attribute ultragen of "/=" [signed, integer return boolean] :
	function is "cmp_si_bl";
    function "/="(l: integer; r: signed) return boolean;
	attribute ultragen of "/=" [integer, signed return boolean] :
	function is "cmp_is_bl";

-- unary operator functions

    function "ABS"(l: signed) return signed;
	attribute ultragen of "ABS" [signed return signed] :
	function is "uni_as_s";
--    function "ABS"(l: signed) return std_logic_vector;
--	attribute ultragen of "ABS" [signed return std_logic_vector] :
--	function is "uni_as_v";

    function "+"(l: unsigned) return unsigned;
    function "+"(l: signed) return signed;
    function "+"(l: unsigned) return std_logic_vector;
    function "+"(l: signed) return std_logic_vector;

    function "-"(l: signed) return signed;
	attribute ultragen of "-" [signed return signed] :
	function is "uni_ms_s";
--    function "-"(l: signed) return std_logic_vector;
--	attribute ultragen of "-" [signed return std_logic_vector] :
--	function is "uni_ms_v";

-- shift functions

    function shl(ARG: unsigned; COUNT: unsigned) return unsigned;
    function shl(ARG:   signed; COUNT: unsigned) return   signed;
    function shr(ARG: unsigned; COUNT: unsigned) return unsigned;
    function shr(ARG:   signed; COUNT: unsigned) return   signed;

-- conversion functions

    function conv_integer (ARG:    integer) return integer;
    function conv_integer (ARG:   unsigned) return integer;
    function conv_integer (ARG:     signed) return integer;
    function conv_integer (ARG: std_ulogic) return small_int;
    function conv_unsigned(ARG:    integer; SIZE: integer) return unsigned;
    function conv_unsigned(ARG:   unsigned; SIZE: integer) return unsigned;
    function conv_unsigned(ARG:     signed; SIZE: integer) return unsigned;
    function conv_unsigned(ARG: std_ulogic; SIZE: integer) return unsigned;
    function conv_signed  (ARG:    integer; SIZE: integer) return signed;
    function conv_signed  (ARG:   unsigned; SIZE: integer) return signed;
    function conv_signed  (ARG:     signed; SIZE: integer) return signed;
    function conv_signed  (ARG: std_ulogic; SIZE: integer) return signed;

    function conv_std_logic_vector(ARG:    integer; SIZE: integer)
						    return std_logic_vector;
    function conv_std_logic_vector(ARG:   unsigned; SIZE: integer)
						    return std_logic_vector;
    function conv_std_logic_vector(ARG:     signed; SIZE: integer)
						    return std_logic_vector;
    function conv_std_logic_vector(ARG: std_ulogic; SIZE: integer)
						    return std_logic_vector;

-- extend functions

    function EXT(ARG: std_logic_vector; SIZE: integer) return std_logic_vector;
    function SXT(ARG: std_logic_vector; SIZE: integer) return std_logic_vector;

end std_logic_arith;


library ieee;
use ieee.std_logic_1164.all;

package body std_logic_arith is

    function "+"(l: unsigned) return unsigned is
    begin
    	return l;
    end;

    function "+"(l: signed) return signed is
    begin
    	return l;
    end;

    function "+"(l: unsigned) return std_logic_vector is
    begin
    	return std_logic_vector(l);
    end;

    function "+"(l: signed) return std_logic_vector is
    begin
    	return std_logic_vector(l);
    end;

-- Functions that had to be kept

    function min(L, r: integer) return integer is
    begin
    if L < R then
        return L;
    else
        return R;
    end if;
    end;

    function SHL(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
    constant control_msb: INTEGER := COUNT'length - 1;
    variable control: UNSIGNED (control_msb downto 0);
    constant result_msb: INTEGER := ARG'length-1;
    subtype rtype is UNSIGNED (result_msb downto 0);
    variable result, temp: rtype;
    begin
    control := COUNT;
    result := ARG;
    for i in 0 to control_msb loop
        if control(i) = '1' then
        temp := rtype'(others => '0');
        if 2**i <= result_msb then
            temp(result_msb downto 2**i) := 
                    result(result_msb - 2**i downto 0);
        end if;
        result := temp;
        end if;
    end loop;
    return result;
    end;

    function SHL(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
    constant control_msb: INTEGER := COUNT'length - 1;
    variable control: UNSIGNED (control_msb downto 0);
    constant result_msb: INTEGER := ARG'length-1;
    subtype rtype is SIGNED (result_msb downto 0);
    variable result, temp: rtype;
    begin
    control := COUNT;
    result := ARG;
    for i in 0 to control_msb loop
        if control(i) = '1' then
        temp := rtype'(others => '0');
        if 2**i <= result_msb then
            temp(result_msb downto 2**i) := 
                    result(result_msb - 2**i downto 0);
        end if;
        result := temp;
        end if;
    end loop;
    return result;
    end;


    function SHR(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
    constant control_msb: INTEGER := COUNT'length - 1;
    variable control: UNSIGNED (control_msb downto 0);
    constant result_msb: INTEGER := ARG'length-1;
    subtype rtype is UNSIGNED (result_msb downto 0);
    variable result, temp: rtype;
    begin
    control := COUNT;
    result := ARG;
    for i in 0 to control_msb loop
        if control(i) = '1' then
        temp := rtype'(others => '0');
        if 2**i <= result_msb then
            temp(result_msb - 2**i downto 0) := 
                    result(result_msb downto 2**i);
        end if;
        result := temp;
        end if;
    end loop;
    return result;
    end;

    function SHR(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
    constant control_msb: INTEGER := COUNT'length - 1;
    variable control: UNSIGNED (control_msb downto 0);
    constant result_msb: INTEGER := ARG'length-1;
    subtype rtype is SIGNED (result_msb downto 0);
    variable result, temp: rtype;
    variable sign_bit: STD_ULOGIC;
    begin
    control := COUNT;
    result := ARG;
    sign_bit := ARG(ARG'left);
    for i in 0 to control_msb loop
        if control(i) = '1' then
        temp := rtype'(others => sign_bit);
        if 2**i <= result_msb then
            temp(result_msb - 2**i downto 0) := 
                    result(result_msb downto 2**i);
        end if;
        result := temp;
        end if;
    end loop;
    return result;
    end;

    function conv_integer(ARG: integer) return integer is
    begin
    return ARG;
    end;

    function conv_integer(ARG: unsigned) return integer is
    variable result, abit : integer;
    variable tmp: std_ulogic;
    begin
	assert ARG'length <= 31
	    report "ARG is too large in conv_integer"
	    severity FAILURE;
	result := 0;
	for i in ARG'range loop
	    abit := 0;
	    tmp := ARG(i);
	    if tmp = '1' then
		abit := 2**i;
	    end if;
	    result := result + abit;
	end loop;
	return result;
    end;

    function conv_integer(ARG: signed) return integer is
	variable argx : signed(ARG'length-1 downto 0) := ARG;
	variable result,abit : integer;
	variable tmp: std_ulogic;
    begin
	assert argx'length <= 32
	    report "ARG is too large in conv_integer"
	    severity FAILURE;
	result := 0;
	for i in 31 downto 0 loop
	    if (i > argx'left) then
		tmp := argx(argx'left);
	    else
		tmp := argx(i);
	    end if;

	    abit := 0;
	    if (tmp = '1') then
		if (i = 31) then
		    abit := -2147483648;
		else
		    abit := 2**i;
		end if;
	    end if;
	    result := result + abit;
	end loop;
	return result;
    end;

    function conv_integer(ARG: std_ulogic) return small_int is
    variable tmp: std_ulogic;
    begin
    tmp := (ARG);
    if tmp = '1' then
        return 1;
    else
        return 0;
    end if;
    end;

    function conv_unsigned(ARG: integer; SIZE: integer) return unsigned is
	variable result : unsigned(size-1 downto 0) := (others => '0');
	variable aa : integer := arg;
	variable bb : std_logic := '0';
    begin
	if (aa < 0) then bb := '1'; aa := -(aa+1); end if;
	for i in result'reverse_range loop
	    if ((aa/(2**i)) mod 2) = 1 then
		result(i) := not bb;
	    else
		result(i) := bb;
	    end if;
	end loop;
	return result;
    end;

    function conv_unsigned(ARG: unsigned; SIZE: integer) return unsigned is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is unsigned (SIZE-1 downto 0);
    variable new_bounds: unsigned (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := ARG;
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;


    function conv_unsigned(ARG: signed; SIZE: integer) return unsigned is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is unsigned (SIZE-1 downto 0);
    variable new_bounds: unsigned (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := unsigned(ARG);
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;


    function conv_unsigned(ARG: std_ulogic; SIZE: integer) return unsigned is
    subtype rtype is unsigned (SIZE-1 downto 0);
    variable result: rtype;
    begin
    result := rtype'(others => '0');
    result(0) := (ARG);
    return result;
    end;

    function conv_signed(ARG: integer; SIZE: integer) return signed is
	variable result : signed(size-1 downto 0) := (others => '0');
	variable aa : integer := arg;
	variable bb : std_logic := '0';
    begin
	if (aa < 0) then bb := '1'; aa := -(aa+1); end if;
	for i in result'reverse_range loop
	    if ((aa/(2**i)) mod 2) = 1 then
		result(i) := not bb;
	    else
		result(i) := bb;
	    end if;
	end loop;
	return result;
    end;


    function conv_signed(ARG: unsigned; SIZE: integer) return signed is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is signed (SIZE-1 downto 0);
    variable new_bounds : signed (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := signed(ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;

    function conv_signed(ARG: signed; SIZE: integer) return signed is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is signed (SIZE-1 downto 0);
    variable new_bounds : signed (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := ARG;
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;


    function conv_signed(ARG: std_ulogic; SIZE: integer) return signed is
    subtype rtype is signed (SIZE-1 downto 0);
    variable result: rtype;
    begin
    result := rtype'(others => '0');
    result(0) := (ARG);
    return result;
    end;


    -- convert an integer to an std_logic_vector
    function conv_std_logic_vector(ARG: integer; SIZE: integer) return std_logic_vector is
	variable result : std_logic_vector(size-1 downto 0) := (others => '0');
	variable aa : integer := arg;
	variable bb : std_logic := '0';
    begin
	if (aa < 0) then bb := '1'; aa := -(aa+1); end if;
	for i in result'reverse_range loop
	    if ((aa/(2**i)) mod 2) = 1 then
		result(i) := not bb;
	    else
		result(i) := bb;
	    end if;
	end loop;
	return result;
    end;

    function conv_std_logic_vector(ARG: unsigned; SIZE: integer) return std_logic_vector is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is std_logic_vector (SIZE-1 downto 0);
    variable new_bounds : std_logic_vector (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := std_logic_vector(ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;

    function conv_std_logic_vector(ARG: signed; SIZE: integer) return std_logic_vector is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is std_logic_vector (SIZE-1 downto 0);
    variable new_bounds : std_logic_vector (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := std_logic_vector(ARG);
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;

    function conv_std_logic_vector(ARG: std_ulogic; SIZE: integer) return std_logic_vector is
    subtype rtype is std_logic_vector (SIZE-1 downto 0);
    variable result: rtype;
    begin
    result := rtype'(others => '0');
    result(0) := (ARG);
    return result;
    end;

    function EXT(ARG: std_logic_vector; SIZE: integer) 
                        return std_logic_vector is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is std_logic_vector (SIZE-1 downto 0);
    variable new_bounds: std_logic_vector (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := (ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;

    function SXT(ARG: std_logic_vector; SIZE: integer) return std_logic_vector is
    constant msb: integer := min(ARG'length, SIZE) - 1;
    subtype rtype is std_logic_vector (SIZE-1 downto 0);
    variable new_bounds : std_logic_vector (ARG'length-1 downto 0);
    variable result: rtype;
    begin
    new_bounds := (ARG);
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
    end;

end std_logic_arith;
