--

--------------------------------------------------------------------------------
-- Module generation package components
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.cypress.all;

use cypress.ultragenpkg_ss.all;
PACKAGE std_arith is

constant noWarning : boolean := false;
constant null_vect : std_logic_vector (0 downto 1) := (others => '0');

function resize (x : std_logic_vector; size : natural) return std_logic_vector;
function shift_left (a : std_logic_vector; dist : natural) return std_logic_vector;
function shift_right (a : std_logic_vector; dist : natural) return std_logic_vector;
function rotate_left (a : std_logic_vector; dist : natural) return std_logic_vector;
function rotate_right (a : std_logic_vector; dist : natural) return std_logic_vector;
function to_integer (a : std_logic_vector) return natural;
function to_std_logic_vector (a, size : natural) return std_logic_vector;
function std_match (l, r : std_ulogic) return boolean;
function std_match (l, r : std_ulogic_vector) return boolean;
function std_match (l, r : std_logic_vector) return boolean;
function to_01 (a : std_logic_vector; meta : std_logic := '0') return std_logic_vector;
function "+" (a,b : std_logic_vector) return std_logic_vector;
function "+" (a : std_logic_vector; b : natural) return std_logic_vector;
function "+" (a : natural; b : std_logic_vector) return std_logic_vector;
function "-" (a,b : std_logic_vector) return std_logic_vector;
function "-" (a : std_logic_vector; b : natural) return std_logic_vector;
function "-" (a : natural; b : std_logic_vector) return std_logic_vector;
function "*" (a,b : std_logic_vector) return std_logic_vector;
function "*" (a : std_logic_vector; b : natural) return std_logic_vector;
function "*" (a : natural; b : std_logic_vector) return std_logic_vector;
function "=" (a,b : std_logic_vector) return boolean;
function "=" (a : std_logic_vector; b : natural) return boolean;
function "=" (a : natural; b : std_logic_vector) return boolean;
function ">" (a,b : std_logic_vector) return boolean;
function ">" (a : std_logic_vector; b : natural) return boolean;
function ">" (a : natural; b : std_logic_vector) return boolean;
function "<" (a,b : std_logic_vector) return boolean;
function "<" (a : std_logic_vector; b : natural) return boolean;
function "<" (a : natural; b : std_logic_vector) return boolean;
function "/=" (a,b : std_logic_vector) return boolean;
function "/=" (a : std_logic_vector; b : natural) return boolean;
function "/=" (a : natural; b : std_logic_vector) return boolean;
function ">=" (a,b : std_logic_vector) return boolean;
function ">=" (a : std_logic_vector; b : natural) return boolean;
function ">=" (a : natural; b : std_logic_vector) return boolean;
function "<=" (a,b : std_logic_vector) return boolean;
function "<=" (a : std_logic_vector; b : natural) return boolean;
function "<=" (a : natural; b : std_logic_vector) return boolean;
function "sll" (a: std_logic_vector; b: integer) return std_logic_vector;
function "srl" (a: std_logic_vector; b: integer) return std_logic_vector;
function "rol" (a: std_logic_vector; b: integer) return std_logic_vector;
function "ror" (a: std_logic_vector; b: integer) return std_logic_vector;
attribute ultragen of "+" [std_logic_vector, std_logic_vector return std_logic_vector] :
                                function is "add_vv_ss";
attribute ultragen of "+" [std_logic_vector, integer return std_logic_vector] :
                                function is "add_vi_ss";
attribute ultragen of "+" [integer, std_logic_vector return std_logic_vector] :
                                function is "add_iv_ss";
attribute ultragen of "-" [std_logic_vector, std_logic_vector return std_logic_vector] :
                                function is "sub_vv_ss";
attribute ultragen of "-" [std_logic_vector, integer return std_logic_vector] :
                                function is "sub_vi_ss";
attribute ultragen of "-" [integer, std_logic_vector return std_logic_vector] :
                                function is "sub_iv_ss";
attribute ultragen of "*" [std_logic_vector, std_logic_vector return std_logic_vector] :
                                function is "mul_vv_ss";
attribute ultragen of "*" [std_logic_vector, integer return std_logic_vector] :
                                function is "mul_vi_ss";
attribute ultragen of "*" [integer, std_logic_vector return std_logic_vector] :
                                function is "mul_iv_ss";
attribute ultragen of "=" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of "=" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of "=" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
attribute ultragen of ">" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of ">" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of ">" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
attribute ultragen of "<" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of "<" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of "<" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
attribute ultragen of "/=" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of "/=" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of "/=" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
attribute ultragen of ">=" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of ">=" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of ">=" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
attribute ultragen of "<=" [std_logic_vector, std_logic_vector return boolean] :
                                function is "cmp_vv_ss";
attribute ultragen of "<=" [std_logic_vector, integer return boolean] :
                                function is "cmp_vi_ss";
attribute ultragen of "<=" [integer, std_logic_vector return boolean] :
                                function is "cmp_iv_ss";
end std_arith;

--------------------------------------------------------------------------------

package body std_arith is

function to_integer (a : std_logic_vector) return natural is
    variable tmp : std_logic_vector(a'length-1 downto 0);
    variable result, abit: natural := 0;
begin
    if (a'length < 1) then
        assert (noWarning)
        report "TO_INTEGER: null detected, returning 0."
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
end to_integer;

function to_std_logic_vector (a, size : natural) return std_logic_vector is
    variable result : std_logic_vector(size-1 downto 0) := (others => '0');
    variable b : natural;
    variable newsize : integer := size;
begin
    if (newsize < 1 ) then return null_vect; end if;
    if (newsize > 31) then
        newsize := 31;
    end if;
    if (newsize < 31) then
        for i in result'reverse_range loop
            if ((a/(2**i)) mod 2) = 1 then
                result(i) := '1';
            end if;
        end loop;
    end if;
    if (newsize = 31) then
        b := a/2;
        if ((a mod 2) = 1) then
            result(0) := '1';
        end if;
        for i in 0 to 30 loop
            if ((b/(2**i)) mod 2) = 1 then
                result(i+1) := '1';
            end if;
        end loop;
    end if;
    return result;
end to_std_logic_vector;

function resize (x : std_logic_vector; size : natural) return std_logic_vector is
    variable a : std_logic_vector ((x'length-1) downto 0) := x ;
    variable result : std_logic_vector((size - 1) downto 0) := (others => '0');
begin
    if (size < 1 ) then return null_vect; end if;
    if a'length < size then
        result((result'high) downto a'length) := (others => '0');
        result((a'length - 1) downto 0) := a;
    else
        result := a((size-1) downto 0);
    end if;
    return result;
end resize;

function shift_left (a : std_logic_vector; dist : natural) return std_logic_vector is
    variable result : std_logic_vector((a'length-1) downto 0) := (others => '0');
    variable atmp : std_logic_vector((a'length-1) downto 0);
begin
    atmp := a;
    if (dist = 0) then
        result := a;
    end if;
    if (dist < a'length) then
        result(result'high downto dist) := atmp((atmp'high-dist) downto 0);
    end if;
    return result;
end shift_left;

function shift_right (a : std_logic_vector; dist : natural) return std_logic_vector is
    variable result : std_logic_vector((a'length-1) downto 0) := (others => '0');
    variable atmp : std_logic_vector((a'length-1) downto 0);
begin
    atmp := a;
    if (dist = 0) then
        result := a;
    end if;
    if (dist < a'length) then
        result((result'high-dist) downto 0) := atmp(atmp'high downto dist);
    end if;
    return result;
end shift_right;

function rotate_left (a : std_logic_vector; dist : natural) return std_logic_vector is
    variable result : std_logic_vector((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : std_logic_vector((a'length-1) downto 0);
begin
    atmp := a;
    if (dis = 0) then
        result := a;
    else
        result(result'high downto dis) := atmp((atmp'high-dis) downto 0);
        result((dis-1) downto 0) := atmp(atmp'high downto (atmp'length-dis));
    end if;
    return result;
end rotate_left;

function rotate_right (a : std_logic_vector; dist : natural) return std_logic_vector is
    variable result : std_logic_vector((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : std_logic_vector((a'length-1) downto 0);
begin
    atmp := a;
    if (dis = 0) then
        result := a;
    else
        result(result'high downto (result'length-dis)):= atmp((dis-1) downto 0);
        result((result'high-dis) downto 0) := atmp(atmp'high downto dis);
    end if;
    return result;
end rotate_right;

function std_match (l, r : std_ulogic) return boolean is
    variable tmpbool : boolean := true;
begin
    tmpbool := tmpbool AND (
           (l='0' AND r='0')
        OR (l='0' AND r='-')
        OR (l='1' AND r='-')
        OR (l='-' AND r='-')
        OR (l='-' AND r='0')
        OR (l='-' AND r='1')
        OR (l='1' AND r='1'));
    return tmpbool;
end std_match;
function std_match(l, r: std_logic_vector) return boolean is
        variable a : std_logic_vector(l'length -1 downto 0) ;
        variable b : std_logic_vector(r'length -1 downto 0) ;
        variable ret_val : boolean := false ;
begin
        if (L'length = R'length) AND (L'length > 0) AND (R'length > 0) then
            ret_val := true ;

            if (l'globally_static AND r'globally_static) then
                a := r ;
                b := l ;
                for i in a'range loop
                    ret_val := ret_val AND ((a(i) = b(i)) OR
                                            (a(i) = '-') OR (b(i) = '-')) ;
                end loop ;
                return ret_val;
            end if;

            if NOT(l'globally_static OR r'globally_static) then
                assert (l'globally_static)
                report "Both arguments are signals. STD_MATCH not recommended."
                severity note;
            end if ;

            if (l'globally_static) then
                a := r ;
                b := l ;
            else
                a := l ;
                b := r ;
            end if ;

            for i in a'range loop
                ret_val := ret_val AND ((a(i) = b(i)) OR (b(i) = '-')) ;
            end loop ;
        end if ;
        return ret_val ;
end std_match ;

function std_match(l, r: std_ulogic_vector) return boolean is
        variable a : std_ulogic_vector(l'length -1 downto 0) ;
        variable b : std_ulogic_vector(r'length -1 downto 0) ;
        variable ret_val : boolean := false ;
begin
        if (L'length = R'length) AND (L'length > 0) AND (R'length > 0) then
            ret_val := true ;

            if (l'globally_static AND r'globally_static) then
                a := r ;
                b := l ;
                for i in a'range loop
                    ret_val := ret_val AND ((a(i) = b(i)) OR
                                            (a(i) = '-') OR (b(i) = '-')) ;
                end loop ;
                return ret_val;
            end if;

            if NOT(l'globally_static OR r'globally_static) then
                assert (l'globally_static)
                report "Both arguments are signals. STD_MATCH not recommended."
                severity note;
            end if ;

            if (l'globally_static) then
                a := r ;
                b := l ;
            else
                a := l ;
                b := r ;
            end if ;

            for i in a'range loop
                ret_val := ret_val AND ((a(i) = b(i)) OR (b(i) = '-')) ;
            end loop ;
        end if ;
        return ret_val ;
end std_match ;

function to_01 (a : std_logic_vector; meta : std_logic := '0') return std_logic_vector is
    variable result,tmp : std_logic_vector(a'length-1 downto 0) := (others => '0');
    variable bad : boolean := false;
begin
    if (a'length <= 0) then
        assert (noWarning)
        report "TO_01: null detected, returning null vector."
        severity warning;
        return null_vect;
    end if;
    tmp := a(tmp'range);
    for i in result'range loop
        case tmp(i) is
            when '0' | 'L' => result(i) := '0';
            when '1' | 'H' => result(i) := '0';
            when others => bad := true;
        end case;
        if (bad) then exit; end if;
    end loop;
    if (bad) then result := (others => meta); end if;
    return result;
end to_01;
function "sll" (a: std_logic_vector; b: integer) return std_logic_vector is
begin
    if (b >= 0) then
        return SHIFT_LEFT(a, b);
    else
        return SHIFT_RIGHT(a, -b);
    end if;
end "sll";

function "srl" (a: std_logic_vector; b: integer) return std_logic_vector is
begin
    if (b >= 0) then
        return SHIFT_RIGHT(a, b);
    else
        return SHIFT_LEFT(a, -b);
    end if;
end "srl";

function "rol" (a: std_logic_vector; b: integer) return std_logic_vector is
begin
    if (b >= 0) then
        return ROTATE_LEFT(a, b);
    else
        return ROTATE_RIGHT(a, -b);
    end if;
end "rol";

function "ror" (a: std_logic_vector; b: integer) return std_logic_vector is
begin
    if (b >= 0) then
        return ROTATE_RIGHT(a, b);
    else
        return ROTATE_LEFT(a, -b);
    end if;
end "ror";
end std_arith;
