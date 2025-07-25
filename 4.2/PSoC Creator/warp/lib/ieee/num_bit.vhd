--

--------------------------------------------------------------------------------
--
-- Ultragen Component Package
--
--------------------------------------------------------------------------------
package ultragenpkg_ub is

    TYPE unsigned is array (natural range <>) of bit;
    component add_vv_ub

 generic (goal : goal_type := speed);

 port (a,b : in unsigned; s : out unsigned);
    end component;

    component add_vi_ub

 generic (goal : goal_type := speed);

 port (a : in unsigned; i : in integer; s : out unsigned);
    end component;

    component add_iv_ub

 generic (goal : goal_type := speed);

 port (i: in integer; b : in unsigned; s : out unsigned);
    end component;
    component sub_vv_ub

 generic (goal : goal_type := speed);

 port (a,b : in unsigned; s : out unsigned);
    end component;

    component sub_vi_ub

 generic (goal : goal_type := speed);

 port (a : in unsigned; i : in integer; s : out unsigned);
    end component;

    component sub_iv_ub

 generic (goal : goal_type := speed);

 port (i: in integer; b : in unsigned; s : out unsigned);
    end component;
    component cmp_vv_ub

 generic (goal : goal_type := speed);

 port (a,b : in unsigned; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_vi_ub

 generic (goal : goal_type := speed);

 port (a : in unsigned; i : in integer; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iv_ub

 generic (goal : goal_type := speed);

 port (i: in integer; b : in unsigned; lt,lte,gt,gte,eq,neq : out boolean);
    end component;
    component mul_vv_ub

 generic (goal : goal_type := speed);

 port (a,b : in unsigned; p : out unsigned);
    end component;

    component mul_vi_ub

 generic (goal : goal_type := speed);

 port (a : in unsigned; i : in integer; p : out unsigned);
    end component;

    component mul_iv_ub

 generic (goal : goal_type := speed);

 port (i: in integer; b : in unsigned; p : out unsigned);
    end component;
end package ultragenpkg_ub;
--

--------------------------------------------------------------------------------
--
-- Ultragen Component Package
--
--------------------------------------------------------------------------------
package ultragenpkg_gb is

    TYPE signed is array (natural range <>) of bit;
    component add_vv_gb

 generic (goal : goal_type := speed);

 port (a,b : in signed; s : out signed);
    end component;

    component add_vi_gb

 generic (goal : goal_type := speed);

 port (a : in signed; i : in integer; s : out signed);
    end component;

    component add_iv_gb

 generic (goal : goal_type := speed);

 port (i: in integer; b : in signed; s : out signed);
    end component;
    component sub_vv_gb

 generic (goal : goal_type := speed);

 port (a,b : in signed; s : out signed);
    end component;

    component sub_vi_gb

 generic (goal : goal_type := speed);

 port (a : in signed; i : in integer; s : out signed);
    end component;

    component sub_iv_gb

 generic (goal : goal_type := speed);

 port (i: in integer; b : in signed; s : out signed);
    end component;
    component cmp_vv_gb

 generic (goal : goal_type := speed);

 port (a,b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_vi_gb

 generic (goal : goal_type := speed);

 port (a : in signed; i : in integer; lt,lte,gt,gte,eq,neq : out boolean);
    end component;

    component cmp_iv_gb

 generic (goal : goal_type := speed);

 port (i: in integer; b : in signed; lt,lte,gt,gte,eq,neq : out boolean);
    end component;
    component mul_vv_gb

 generic (goal : goal_type := speed);

 port (a,b : in signed; p : out signed);
    end component;

    component mul_vi_gb

 generic (goal : goal_type := speed);

 port (a : in signed; i : in integer; p : out signed);
    end component;

    component mul_iv_gb

 generic (goal : goal_type := speed);

 port (i: in integer; b : in signed; p : out signed);
    end component;
end package ultragenpkg_gb;
--

--------------------------------------------------------------------------------
-- Module generation package components
--------------------------------------------------------------------------------
library cypress;
use cypress.cypress.all;
use work.ultragenpkg_ub.all;

use work.ultragenpkg_gb.all;
PACKAGE numeric_bit is

TYPE unsigned is array (natural range <>) of bit;
TYPE signed is array (natural range <>) of bit;
constant null_svec : signed (0 downto 1) := (others => '0');

constant noWarning : boolean := false;
constant null_vect : unsigned (0 downto 1) := (others => '0');

function resize (x : unsigned; size : natural) return unsigned;
function shift_left (a : unsigned; dist : natural) return unsigned;
function shift_right (a : unsigned; dist : natural) return unsigned;
function rotate_left (a : unsigned; dist : natural) return unsigned;
function rotate_right (a : unsigned; dist : natural) return unsigned;
function to_integer (a : unsigned) return natural;
function to_unsigned (a, size : natural) return unsigned;

function "not" (a : unsigned) return unsigned;
function "or" (a, b : unsigned) return unsigned;
function "nor" (a, b : unsigned) return unsigned;
function "and" (a, b : unsigned) return unsigned;
function "nand" (a, b : unsigned) return unsigned;
function "xor" (a, b : unsigned) return unsigned;
function "xnor" (a, b : unsigned) return unsigned;

function resize (x : signed; size : natural) return signed;
function shift_left (a : signed; dist : natural) return signed;
function shift_right (a : signed; dist : natural) return signed;
function rotate_left (a : signed; dist : natural) return signed;
function rotate_right (a : signed; dist : natural) return signed;
function to_integer (a : signed) return integer;
function to_signed (a : integer; size : natural) return signed;

function "not" (a : signed) return signed;
function "or" (a, b : signed) return signed;
function "nor" (a, b : signed) return signed;
function "and" (a, b : signed) return signed;
function "nand" (a, b : signed) return signed;
function "xor" (a, b : signed) return signed;
function "xnor" (a, b : signed) return signed;

attribute no_op of "not", "or", "nor", "and", "nand", "xor", "xnor"
        : function is true; -- For CYPRESS synthesis.
function rising_edge (signal a: bit) return boolean;
function falling_edge (signal a: bit) return boolean;

function "+" (a,b : unsigned) return unsigned;
function "+" (a : unsigned; b : natural) return unsigned;
function "+" (a : natural; b : unsigned) return unsigned;
function "-" (a,b : unsigned) return unsigned;
function "-" (a : unsigned; b : natural) return unsigned;
function "-" (a : natural; b : unsigned) return unsigned;
function "*" (a,b : unsigned) return unsigned;
function "*" (a : unsigned; b : natural) return unsigned;
function "*" (a : natural; b : unsigned) return unsigned;
function "=" (a,b : unsigned) return boolean;
function "=" (a : unsigned; b : natural) return boolean;
function "=" (a : natural; b : unsigned) return boolean;
function ">" (a,b : unsigned) return boolean;
function ">" (a : unsigned; b : natural) return boolean;
function ">" (a : natural; b : unsigned) return boolean;
function "<" (a,b : unsigned) return boolean;
function "<" (a : unsigned; b : natural) return boolean;
function "<" (a : natural; b : unsigned) return boolean;
function "/=" (a,b : unsigned) return boolean;
function "/=" (a : unsigned; b : natural) return boolean;
function "/=" (a : natural; b : unsigned) return boolean;
function ">=" (a,b : unsigned) return boolean;
function ">=" (a : unsigned; b : natural) return boolean;
function ">=" (a : natural; b : unsigned) return boolean;
function "<=" (a,b : unsigned) return boolean;
function "<=" (a : unsigned; b : natural) return boolean;
function "<=" (a : natural; b : unsigned) return boolean;
function "sll" (a: unsigned; b: integer) return unsigned;
function "srl" (a: unsigned; b: integer) return unsigned;
function "rol" (a: unsigned; b: integer) return unsigned;
function "ror" (a: unsigned; b: integer) return unsigned;
function "abs" (a: signed) return signed;
function "-" (a: signed) return signed;
function "+" (a,b : signed) return signed;
function "+" (a : signed; b : integer) return signed;
function "+" (a : integer; b : signed) return signed;
function "-" (a,b : signed) return signed;
function "-" (a : signed; b : integer) return signed;
function "-" (a : integer; b : signed) return signed;
function "*" (a,b : signed) return signed;
function "*" (a : signed; b : integer) return signed;
function "*" (a : integer; b : signed) return signed;
function "=" (a,b : signed) return boolean;
function "=" (a : signed; b : integer) return boolean;
function "=" (a : integer; b : signed) return boolean;
function ">" (a,b : signed) return boolean;
function ">" (a : signed; b : integer) return boolean;
function ">" (a : integer; b : signed) return boolean;
function "<" (a,b : signed) return boolean;
function "<" (a : signed; b : integer) return boolean;
function "<" (a : integer; b : signed) return boolean;
function "/=" (a,b : signed) return boolean;
function "/=" (a : signed; b : integer) return boolean;
function "/=" (a : integer; b : signed) return boolean;
function ">=" (a,b : signed) return boolean;
function ">=" (a : signed; b : integer) return boolean;
function ">=" (a : integer; b : signed) return boolean;
function "<=" (a,b : signed) return boolean;
function "<=" (a : signed; b : integer) return boolean;
function "<=" (a : integer; b : signed) return boolean;
function "sll" (a: signed; b: integer) return signed;
function "srl" (a: signed; b: integer) return signed;
function "rol" (a: signed; b: integer) return signed;
function "ror" (a: signed; b: integer) return signed;

attribute ultragen of "+" [unsigned, unsigned return unsigned] :
    function is "add_vv_ub";
attribute ultragen of "+" [unsigned, integer return unsigned] :
    function is "add_vi_ub";
attribute ultragen of "+" [integer, unsigned return unsigned] :
    function is "add_iv_ub";
attribute ultragen of "-" [unsigned, unsigned return unsigned] :
    function is "sub_vv_ub";
attribute ultragen of "-" [unsigned, integer return unsigned] :
    function is "sub_vi_ub";
attribute ultragen of "-" [integer, unsigned return unsigned] :
    function is "sub_iv_ub";
attribute ultragen of "*" [unsigned, unsigned return unsigned] :
    function is "mul_vv_ub";
attribute ultragen of "*" [unsigned, integer return unsigned] :
    function is "mul_vi_ub";
attribute ultragen of "*" [integer, unsigned return unsigned] :
    function is "mul_iv_ub";
attribute ultragen of "=" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of "=" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of "=" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of ">" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of ">" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of ">" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of "<" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of "<" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of "<" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of "/=" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of "/=" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of "/=" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of ">=" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of ">=" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of ">=" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of "<=" [unsigned, unsigned return boolean] :
    function is "cmp_vv_ub";
attribute ultragen of "<=" [unsigned, integer return boolean] :
    function is "cmp_vi_ub";
attribute ultragen of "<=" [integer, unsigned return boolean] :
    function is "cmp_iv_ub";
attribute ultragen of "+" [signed, signed return signed] :
    function is "add_vv_gb";
attribute ultragen of "+" [signed, integer return signed] :
    function is "add_vi_gb";
attribute ultragen of "+" [integer, signed return signed] :
    function is "add_iv_gb";
attribute ultragen of "-" [signed, signed return signed] :
    function is "sub_vv_gb";
attribute ultragen of "-" [signed, integer return signed] :
    function is "sub_vi_gb";
attribute ultragen of "-" [integer, signed return signed] :
    function is "sub_iv_gb";
attribute ultragen of "*" [signed, signed return signed] :
    function is "mul_vv_gb";
attribute ultragen of "*" [signed, integer return signed] :
    function is "mul_vi_gb";
attribute ultragen of "*" [integer, signed return signed] :
    function is "mul_iv_gb";
attribute ultragen of "=" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of "=" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of "=" [integer, signed return boolean] :
    function is "cmp_iv_gb";
attribute ultragen of ">" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of ">" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of ">" [integer, signed return boolean] :
    function is "cmp_iv_gb";
attribute ultragen of "<" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of "<" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of "<" [integer, signed return boolean] :
    function is "cmp_iv_gb";
attribute ultragen of "/=" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of "/=" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of "/=" [integer, signed return boolean] :
    function is "cmp_iv_gb";
attribute ultragen of ">=" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of ">=" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of ">=" [integer, signed return boolean] :
    function is "cmp_iv_gb";
attribute ultragen of "<=" [signed, signed return boolean] :
    function is "cmp_vv_gb";
attribute ultragen of "<=" [signed, integer return boolean] :
    function is "cmp_vi_gb";
attribute ultragen of "<=" [integer, signed return boolean] :
    function is "cmp_iv_gb";

end numeric_bit;

--------------------------------------------------------------------------------

package body numeric_bit is

function to_integer (a : unsigned) return natural is
    variable tmp : unsigned(a'length-1 downto 0);
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

function to_unsigned (a, size : natural) return unsigned is
    variable result : unsigned(size-1 downto 0) := (others => '0');
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
end to_unsigned;

function resize (x : unsigned; size : natural) return unsigned is
    variable a : unsigned ((x'length-1) downto 0) := x ;
    variable result : unsigned((size - 1) downto 0) := (others => '0');
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

function shift_left (a : unsigned; dist : natural) return unsigned is
    variable result : unsigned((a'length-1) downto 0) := (others => '0');
    variable atmp : unsigned((a'length-1) downto 0);
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

function shift_right (a : unsigned; dist : natural) return unsigned is
    variable result : unsigned((a'length-1) downto 0) := (others => '0');
    variable atmp : unsigned((a'length-1) downto 0);
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

function rotate_left (a : unsigned; dist : natural) return unsigned is
    variable result : unsigned((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : unsigned((a'length-1) downto 0);
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

function rotate_right (a : unsigned; dist : natural) return unsigned is
    variable result : unsigned((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : unsigned((a'length-1) downto 0);
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
function rising_edge (signal a : bit) return boolean is
begin
    return a'event AND (a = '1');
end rising_edge;

function falling_edge (signal a : bit) return boolean is
begin
    return a'event AND (a = '0');
end falling_edge;

function "sll" (a: unsigned; b: integer) return unsigned is
begin
    if (b >= 0) then
 return SHIFT_LEFT(a, b);
    else
 return SHIFT_RIGHT(a, -b);
    end if;
end "sll";

function "srl" (a: unsigned; b: integer) return unsigned is
begin
    if (b >= 0) then
 return SHIFT_RIGHT(a, b);
    else
 return SHIFT_LEFT(a, -b);
    end if;
end "srl";

function "rol" (a: unsigned; b: integer) return unsigned is
begin
    if (b >= 0) then
 return ROTATE_LEFT(a, b);
    else
 return ROTATE_RIGHT(a, -b);
    end if;
end "rol";

function "ror" (a: unsigned; b: integer) return unsigned is
begin
    if (b >= 0) then
 return ROTATE_RIGHT(a, b);
    else
 return ROTATE_LEFT(a, -b);
    end if;
end "ror";
function "abs" (a: signed) return signed is
    variable switch,tmp : signed(a'length-1 downto 0);
begin
    switch(0) := a(0) AND a(a'high);
    tmp(0) := a(0);

    for i in (a'low + 1) to a'high loop
 switch(i) := (switch(i-1) OR a(i)) AND a(a'high);
 tmp(i) := switch(i-1) XOR a(i);
    end loop;

    return tmp;
end "abs";

function "-" (a: signed) return signed is
    variable switch,tmp : signed(a'length-1 downto 0);
begin
    switch(0) := a(0);
    tmp(0) := a(0);

    for i in (a'low + 1) to a'high loop
 switch(i) := (switch(i-1) OR a(i));
 tmp(i) := switch(i-1) XOR a(i);
    end loop;

    return tmp;
end "-";

function to_integer (a : signed) return integer is
    variable tmp : signed(a'length-1 downto 0);
    variable result, abit: integer := 0;
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

function to_signed (a : integer; size : natural) return signed is
    variable result : signed(size-1 downto 0) := (others => '0');
    variable aa : integer := a;
    variable bb : bit := '0';
begin
    if (size < 1 ) then return null_svec; end if;
    if (a < 0) then bb := '1'; aa := -(a+1); end if;
    for i in result'reverse_range loop
 if ((aa/(2**i)) mod 2) = 1 then
     result(i) := not bb;
 else
     result(i) := bb;
 end if;
    end loop;
    return result;
end to_signed;

function resize (x : signed; size : natural) return signed is
    variable a : signed ((x'length-1) downto 0) := x ;
    variable result : signed((size - 1) downto 0) := (others => '0');
begin
    if (size < 1 ) then return null_svec; end if;
    if a'length < size then
 result((result'high) downto a'length) := (others => x(x'high));
 result((a'length - 1) downto 0) := a;
    else
 result := a((size-1) downto 0);
    end if;
    return result;
end resize;

function shift_left (a : signed; dist : natural) return signed is
    variable result : signed((a'length-1) downto 0) := (others => '0');
    variable atmp : signed((a'length-1) downto 0);
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

function shift_right (a : signed; dist : natural) return signed is
    variable result : signed((a'length-1) downto 0) := (others => '0');
    variable atmp : signed((a'length-1) downto 0);
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

function rotate_left (a : signed; dist : natural) return signed is
    variable result : signed((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : signed((a'length-1) downto 0);
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

function rotate_right (a : signed; dist : natural) return signed is
    variable result : signed((a'length-1) downto 0);
    variable dis : integer := dist mod a'length;
    variable atmp : signed((a'length-1) downto 0);
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

function "sll" (a: signed; b: integer) return signed is
begin
    if (b >= 0) then
 return SHIFT_LEFT(a, b);
    else
 return SHIFT_RIGHT(a, -b);
    end if;
end "sll";

function "srl" (a: signed; b: integer) return signed is
begin
    if (b >= 0) then
 return SHIFT_RIGHT(a, b);
    else
 return SHIFT_LEFT(a, -b);
    end if;
end "srl";

function "rol" (a: signed; b: integer) return signed is
begin
    if (b >= 0) then
 return ROTATE_LEFT(a, b);
    else
 return ROTATE_RIGHT(a, -b);
    end if;
end "rol";

function "ror" (a: signed; b: integer) return signed is
begin
    if (b >= 0) then
 return ROTATE_RIGHT(a, b);
    else
 return ROTATE_LEFT(a, -b);
    end if;
end "ror";

end numeric_bit;
