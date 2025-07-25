-- /*******************************************************************************
-- * Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/
--------------------------------------------------------------------------------
--
--		STD_LOGIC_SIGNED package
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.ultragenpkg_sla.all;

package std_logic_signed is

    constant noWarning : boolean := false;

    function "+"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "add_vv_v_sg";
    function "+"(l: std_logic_vector; r: integer) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, integer return std_logic_vector] :
        function is "add_vi_v_sg";
    function "+"(l: integer; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[integer, std_logic_vector return std_logic_vector] :
        function is "add_iv_v_sg";
    function "+"(l: std_logic_vector; r: std_logic) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic_vector, std_logic return std_logic_vector] :
        function is "add_vb_v_sg";
    function "+"(l: std_logic; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "+"
	[std_logic, std_logic_vector return std_logic_vector] :
        function is "add_bv_v_sg";

    function "-"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "sub_vv_v_sg";
    function "-"(l: std_logic_vector; r: integer) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, integer return std_logic_vector] :
        function is "sub_vi_v_sg";
    function "-"(l: integer; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[integer, std_logic_vector return std_logic_vector] :
        function is "sub_iv_v_sg";
    function "-"(l: std_logic_vector; r: std_logic) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic_vector, std_logic return std_logic_vector] :
        function is "sub_vb_v_sg";
    function "-"(l: std_logic; r: std_logic_vector) return std_logic_vector;
	attribute ultragen of "-"
	[std_logic, std_logic_vector return std_logic_vector] :
        function is "sub_bv_v_sg";

    function "*"(l, r : std_logic_vector) return std_logic_vector;
	attribute ultragen of "*"
	[std_logic_vector, std_logic_vector return std_logic_vector] :
        function is "mul_vv_v_sg";

    function "<"(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "<"
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function "<"(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "<"
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function "<"(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "<"
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function "<="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "<="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function "<="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "<="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function "<="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "<="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function ">"(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of ">"
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function ">"(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of ">"
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function ">"(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of ">"
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function ">="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of ">="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function ">="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of ">="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function ">="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of ">="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function "="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function "="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function "="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function "/="(l: std_logic_vector; r: std_logic_vector) return boolean;
	attribute ultragen of "/="
	[std_logic_vector, std_logic_vector return boolean] :
        function is "cmp_vv_sg_bl";
    function "/="(l: std_logic_vector; r: integer) return boolean;
	attribute ultragen of "/="
	[std_logic_vector, integer return boolean] :
        function is "cmp_vi_sg_bl";
    function "/="(l: integer; r: std_logic_vector) return boolean;
	attribute ultragen of "/="
	[integer, std_logic_vector return boolean] :
        function is "cmp_iv_sg_bl";

    function "ABS"(l: std_logic_vector) return std_logic_vector;
	attribute ultragen of "ABS" [std_logic_vector return std_logic_vector] :
	function is "uni_as_v_sg";

    function "+"(l: std_logic_vector) return std_logic_vector;

    function "-"(l: std_logic_vector) return std_logic_vector;
	attribute ultragen of "-" [std_logic_vector return std_logic_vector] :
	function is "uni_ms_v_sg";

    function conv_integer(a: std_logic_vector) return integer;

end std_logic_signed;

library ieee;
use ieee.std_logic_1164.all;

package body std_logic_signed is

    function "+"(l: std_logic_vector) return std_logic_vector is
    begin
        return l;
    end;

    function conv_integer (a : std_logic_vector) return integer is
	variable tmp,tmps,switch : std_logic_vector(a'length-1 downto 0);
	variable result, abit: integer := 0;
    begin
	if (a'length < 1) then
	    assert (noWarning)
	    report "conv_integer: null detected, returning 0."
	    severity warning;
	    return 0;
	    end if;
	tmp := a;

	if (a(a'high) = '1') then
	    switch(0) := a(0) AND a(a'high);
	    tmps(0) := tmp(0);

	    for i in (a'low + 1) to a'high loop
		switch(i) := (switch(i-1)  OR tmp(i)) AND a(a'high);
		tmp(i) :=  switch(i-1) XOR tmp(i);
	    end loop;
	    tmp := tmps;
	end if;

	for i in tmp'reverse_range loop
	    abit := 0;
	    if tmp(i) = '1' then
		abit := 2**i;
	    end if;
	    result := result + abit;
	    exit when i = 31;
	end loop;

	if (a(a'high) = '1') then
	    return -result;
	else
	    return result;
	end if;
    end conv_integer;

end std_logic_signed;
