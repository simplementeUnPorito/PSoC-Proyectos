-- /*******************************************************************************
-- * Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/
--------------------------------------------------------------------------------
--
--		STD_lOGIC_UNSIGNED package
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.ultragenpkg_sla.all;

package std_logic_unsigned is

    constant noWarning : boolean := false;

    function "+"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "add_vv_v_us";
    function "+"(l: std_logic_vector; r: integer) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, integer return std_logic_vector] :
        function is "add_vi_v_us";
    function "+"(l: integer; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[integer, std_logic_vector return std_logic_vector] :
        function is "add_iv_v_us";
    function "+"(l: std_logic_vector; r: std_logic) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, std_logic return std_logic_vector] :
        function is "add_vb_v_us";
    function "+"(l: std_logic; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic, std_logic_vector return std_logic_vector] :
        function is "add_bv_v_us";

    function "-"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "sub_vv_v_us";
    function "-"(l: std_logic_vector; r: integer) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, integer return std_logic_vector] :
        function is "sub_vi_v_us";
    function "-"(l: integer; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[integer, std_logic_vector return std_logic_vector] :
        function is "sub_iv_v_us";
    function "-"(l: std_logic_vector; r: std_logic) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, std_logic return std_logic_vector] :
        function is "sub_vb_v_us";
    function "-"(l: std_logic; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic, std_logic_vector return std_logic_vector] :
        function is "sub_bv_v_us";

    function "*"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "*"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "mul_vv_v_us";

    function "<"(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "<"
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function "<"(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "<"
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function "<"(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "<"
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function "<="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "<="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function "<="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "<="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function "<="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "<="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function ">"(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of ">"
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function ">"(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of ">"
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function ">"(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of ">"
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function ">="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of ">="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function ">="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of ">="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function ">="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of ">="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function "="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function "="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function "="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function "/="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "/="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_us_bl";
    function "/="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "/="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_us_bl";
    function "/="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "/="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_us_bl";

    function "+"(l: std_logic_vector) return std_logic_vector;

    function conv_integer(a: std_logic_vector) return integer;

end std_logic_unsigned;

library ieee;
use ieee.std_logic_1164.all;

package body std_logic_unsigned is

    function "+"(l: std_logic_vector) return std_logic_vector is
    begin
        return l;
    end;

    function conv_integer (a : std_logic_vector) return integer is
	variable tmp : std_logic_vector(a'length-1 downto 0);
	variable result, abit: integer := 0;
    begin
	if (a'length < 1) then
	    assert (noWarning)
	    report "conv_integer: null detected, returning 0."
	    severity warning;
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
    end conv_integer;

end std_logic_unsigned;
