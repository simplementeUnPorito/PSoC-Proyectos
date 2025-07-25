-- /*******************************************************************************
-- * Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/
package BIT_ARITH is
  --============================================================================
  -- Arithmetic Operators:
  --===========================================================================

  -- Id:
  function "+" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
  -- Result: Adds two BIT_VECTOR vectors that may be of different lengths.

  -- Id:
  function "+" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0).
  -- Result: Adds an BIT_VECTOR vector, L, with a non-negative INTEGER, R.

  -- Id:
  function "+" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0).
  -- Result: Adds a non-negative INTEGER, L, with an BIT_VECTOR vector, R.

  --============================================================================

  -- Id:
  function "-" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
  -- Result: Subtracts two BIT_VECTOR vectors that may be of different lengths.

  -- Id:
  function "-" (L: BIT_VECTOR;R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0).
  -- Result: Subtracts a non-negative INTEGER, R, from an BIT_VECTOR vector, L.

  -- Id:
  function "-" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0).
  -- Result: Subtracts an BIT_VECTOR vector, R, from a non-negative INTEGER, L.

  --============================================================================

  -- Id:
  function "*" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR((L'LENGTH+R'LENGTH-1) downto 0).
  -- Result: Performs the multiplication operation on two BIT_VECTOR vectors
  --         that may possibly be of different lengths.

  -- Id:
  function "*" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR((L'LENGTH+L'LENGTH-1) downto 0).
  -- Result: Multiplies an BIT_VECTOR vector, L, with a non-negative
  --         INTEGER, R. R is converted to an BIT_VECTOR vector of
  --         SIZE L'LENGTH before multiplication.

  -- Id:
  function "*" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR((R'LENGTH+R'LENGTH-1) downto 0).
  -- Result: Multiplies an BIT_VECTOR vector, R, with a non-negative
  --         INTEGER, L. L is converted to an BIT_VECTOR vector of
  --         SIZE R'LENGTH before multiplication.

  --============================================================================
  --
  -- NOTE: If second argument is zero for "/" operator, a severity level
  --       of ERROR is issued.

  -- Id:
  function "/" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Divides an BIT_VECTOR vector, L, by another BIT_VECTOR vector, R.

  -- Id:
  function "/" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Divides an BIT_VECTOR vector, L, by a non-negative INTEGER, R.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.

  -- Id:
  function "/" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Divides a non-negative INTEGER, L, by an BIT_VECTOR vector, R.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.

  --============================================================================
  --
  -- NOTE: If second argument is zero for "rem" operator, a severity level
  --       of ERROR is issued.

  -- Id:
  function "rem" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where L and R are BIT_VECTOR vectors.

  -- Id:
  function "rem" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where L is an BIT_VECTOR vector and R is a
  --         non-negative INTEGER.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.

  -- Id:
  function "rem" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where R is an BIT_VECTOR vector and L is a
  --         non-negative INTEGER.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.

  --============================================================================
  --
  -- NOTE: If second argument is zero for "mod" operator, a severity level
  --       of ERROR is issued.

  -- Id:
  function "mod" (L, R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where L and R are BIT_VECTOR vectors.

  -- Id:
  function "mod" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where L is an BIT_VECTOR vector and R
  --         is a non-negative INTEGER.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.

  -- Id:
  function "mod" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where R is an BIT_VECTOR vector and L
  --         is a non-negative INTEGER.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.

  --============================================================================
  -- Comparison Operators
  --============================================================================

  -- Id:
  function ">" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L > R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function ">" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L > R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function ">" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L > R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================

  -- Id:
  function "<" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L < R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function "<" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L < R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function "<" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L < R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================

  -- Id:
  function "<=" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L <= R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function "<=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L <= R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function "<=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L <= R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================

  -- Id:
  function ">=" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L >= R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function ">=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L >= R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function ">=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L >= R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================

  -- Id:
  function "=" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L = R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function "=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L = R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function "=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L = R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================

  -- Id:
  function "/=" (L, R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L /= R" where L and R are BIT_VECTOR vectors possibly
  --         of different lengths.

  -- Id:
  function "/=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L /= R" where L is a non-negative INTEGER and
  --         R is an BIT_VECTOR vector.

  -- Id:
  function "/=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN;
  -- Result subtype: BOOLEAN
  -- Result: Computes "L /= R" where L is an BIT_VECTOR vector and
  --         R is a non-negative INTEGER.

  --============================================================================
  -- Shift and Rotate Functions
  --============================================================================

  -- Id:
  function SHIFT_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a shift-left on an BIT_VECTOR vector COUNT times.
  --         The vacated positions are filled with '0'.
  --         The COUNT leftmost elements are lost.

  -- Id:
  function SHIFT_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a shift-right on an BIT_VECTOR vector COUNT times.
  --         The vacated positions are filled with '0'.
  --         The COUNT rightmost elements are lost.

  --============================================================================

  -- Id:
  function ROTATE_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a rotate-left of an BIT_VECTOR vector COUNT times.

  -- Id:
  function ROTATE_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a rotate-right of an BIT_VECTOR vector COUNT times.

  --============================================================================

  -- Id:
  function "sll" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: SHIFT_LEFT(ARG, COUNT)

  -- Id:
  function "srl" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: SHIFT_RIGHT(ARG, COUNT)

  -- Id:
  function "rol" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: ROTATE_LEFT(ARG, COUNT)

  -- Id:
  function "ror" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: ROTATE_RIGHT(ARG, COUNT)

  --============================================================================
  --   RESIZE Functions
  --============================================================================

  -- Id:
  function RESIZE (ARG: BIT_VECTOR; NEW_SIZE: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(NEW_SIZE-1 downto 0)
  -- Result: Resizes the BIT_VECTOR ARG to the specified size.
  --         To create a larger vector, the new [leftmost] bit positions
  --         are filled with '0'. When truncating, the leftmost bits
  --         are dropped.

  --============================================================================
  -- Conversion Functions
  --============================================================================

  -- Id:
  function TO_INTEGER (ARG: BIT_VECTOR) return NATURAL;
  -- Result subtype: NATURAL. Value cannot be negative since parameter is an
  --             BIT_VECTOR vector.
  -- Result: Converts the BIT_VECTOR vector to an INTEGER.

  -- Id:
  function TO_BIT_VECTOR (ARG, SIZE: NATURAL) return BIT_VECTOR;
  -- Result subtype: BIT_VECTOR(SIZE-1 downto 0)
  -- Result: Converts a non-negative INTEGER to an BIT_VECTOR vector with
  --         the specified SIZE.

end BIT_ARITH;

--==============================================================================
--============================= Package Body ===================================
--==============================================================================

package body BIT_ARITH is

  -- null range array constants

  constant NAU: BIT_VECTOR(0 downto 1) := (others => '0');

  -- implementation controls

  constant NO_WARNING: BOOLEAN := FALSE; -- default to emit warnings

  --=========================Local Subprograms =================================

  function MAX (LEFT, RIGHT: INTEGER) return INTEGER is
  begin
    if LEFT > RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end MAX;

  function MIN (LEFT, RIGHT: INTEGER) return INTEGER is
  begin
    if LEFT < RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end MIN;

  function BIT_VECTOR_NUM_BITS (ARG: NATURAL) return NATURAL is
    variable NBITS: NATURAL;
    variable N: NATURAL;
  begin
    N := ARG;
    NBITS := 1;
    while N > 1 loop
      NBITS := NBITS+1;
      N := N / 2;
    end loop;
    return NBITS;
  end BIT_VECTOR_NUM_BITS;

  ------------------------------------------------------------------------

  -- this internal function computes the addition of two BIT_VECTOR
  -- with input CARRY
  -- * the two arguments are of the same length

  function ADD_BIT_VECTOR (L, R: BIT_VECTOR; C: BIT) return BIT_VECTOR is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(L_LEFT downto 0) is R;
    variable RESULT: BIT_VECTOR(L_LEFT downto 0);
    variable CBIT: BIT := C;
  begin
    for I in 0 to L_LEFT loop
      RESULT(I) := CBIT xor XL(I) xor XR(I);
      CBIT := (CBIT and XL(I)) or (CBIT and XR(I)) or (XL(I) and XR(I));
    end loop;
    return RESULT;
  end ADD_BIT_VECTOR;

  -----------------------------------------------------------------------------

  -- this internal procedure computes BIT_VECTOR division
  -- giving the quotient and remainder.
  procedure DIVMOD (NUM, XDENOM: BIT_VECTOR; XQUOT, XREMAIN: out BIT_VECTOR) is
    variable TEMP: BIT_VECTOR(NUM'LENGTH downto 0);
    variable QUOT: BIT_VECTOR(MAX(NUM'LENGTH, XDENOM'LENGTH)-1 downto 0);
    alias DENOM: BIT_VECTOR(XDENOM'LENGTH-1 downto 0) is XDENOM;
    variable TOPBIT: INTEGER;
  begin
    TEMP := "0"&NUM;
    QUOT := (others => '0');
    TOPBIT := -1;
    for J in DENOM'RANGE loop
      if DENOM(J)='1' then
        TOPBIT := J;
        exit;
      end if;
    end loop;
    assert TOPBIT >= 0 report "DIV, MOD, or REM by zero" severity ERROR;

    for J in NUM'LENGTH-(TOPBIT+1) downto 0 loop
      if TEMP(TOPBIT+J+1 downto J) >= "0"&DENOM(TOPBIT downto 0) then
        TEMP(TOPBIT+J+1 downto J) := (TEMP(TOPBIT+J+1 downto J))
            -("0"&DENOM(TOPBIT downto 0));
        QUOT(J) := '1';
      end if;
      assert TEMP(TOPBIT+J+1)='0'
          report "internal error in the division algorithm"
          severity ERROR;
    end loop;
    XQUOT := RESIZE(QUOT, XQUOT'LENGTH);
    XREMAIN := RESIZE(TEMP, XREMAIN'LENGTH);
  end DIVMOD;

  -----------------Local Subprograms - shift/rotate ops-------------------------

  function XSLL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR
      is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := (others => '0');
  begin
    if COUNT <= ARG_L then
      RESULT(ARG_L downto COUNT) := XARG(ARG_L-COUNT downto 0);
    end if;
    return RESULT;
  end XSLL;

  function XSRL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR
      is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := (others => '0');
  begin
    if COUNT <= ARG_L then
      RESULT(ARG_L-COUNT downto 0) := XARG(ARG_L downto COUNT);
    end if;
    return RESULT;
  end XSRL;

  function XROL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR
      is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := XARG;
    variable COUNTM: INTEGER;
  begin
    COUNTM := COUNT mod (ARG_L + 1);
    if COUNTM /= 0 then
      RESULT(ARG_L downto COUNTM) := XARG(ARG_L-COUNTM downto 0);
      RESULT(COUNTM-1 downto 0) := XARG(ARG_L downto ARG_L-COUNTM+1);
    end if;
    return RESULT;
  end XROL;

  function XROR (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR
      is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := XARG;
    variable COUNTM: INTEGER;
  begin
    COUNTM := COUNT mod (ARG_L + 1);
    if COUNTM /= 0 then
      RESULT(ARG_L-COUNTM downto 0) := XARG(ARG_L downto COUNTM);
      RESULT(ARG_L downto ARG_L-COUNTM+1) := XARG(COUNTM-1 downto 0);
    end if;
    return RESULT;
  end XROR;

  -----------------Local Subprograms - Relational ops---------------------------

  --
  -- General "=" for BIT_VECTOR vectors, same length
  --
  function BIT_VECTOR_EQUAL (L, R: BIT_VECTOR) return BOOLEAN is
  begin
    for j in l'range loop
      if l(j) /= r(j) then return false; end if;
    end loop;
    return true;
  end BIT_VECTOR_EQUAL;

  --
  -- General "<" for BIT_VECTOR vectors, same length
  --
  function BIT_VECTOR_LESS (L, R: BIT_VECTOR) return BOOLEAN is
  begin
    for j in l'range loop
      if l(j) /= r(j) then
	if l(j) = '1' then return false; else return true; end if;
      end if;
    end loop;
    return false;
  end BIT_VECTOR_LESS;

  --
  -- General ">" function for BIT_VECTOR vectors, same length
  --
  function BIT_VECTOR_GREATER (L, R: BIT_VECTOR) return BOOLEAN is
  begin
    for j in l'range loop
      if l(j) /= r(j) then
	if l(j) = '0' then return false; else return true; end if;
      end if;
    end loop;
    return false;
  end BIT_VECTOR_GREATER;

  --=========================Exported Functions ==========================

  -- Id:
  function "+" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(SIZE-1 downto 0);
    variable R01 : BIT_VECTOR(SIZE-1 downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    L01 := RESIZE(L, SIZE);
    R01 := RESIZE(R, SIZE);
    return ADD_BIT_VECTOR(L01, R01, '0');
  end "+";

  -- Id:
  function "+" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
  begin
    return L + TO_BIT_VECTOR(R, L'LENGTH);
  end "+";

  -- Id:
  function "+" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
  begin
    return TO_BIT_VECTOR(L, R'LENGTH) + R;
  end "+";

  --============================================================================

  -- Id:
  function "-" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(SIZE-1 downto 0);
    variable R01 : BIT_VECTOR(SIZE-1 downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    L01 := RESIZE(L, SIZE);
    R01 := RESIZE(R, SIZE);
    return ADD_BIT_VECTOR(L01, not(R01), '1');
  end "-";

  -- Id:
  function "-" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
  begin
    return L - TO_BIT_VECTOR(R, L'LENGTH);
  end "-";

  -- Id:
  function "-" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
  begin
    return TO_BIT_VECTOR(L, R'LENGTH) - R;
  end "-";

  --============================================================================

  -- Id:
  function "*" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XXL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XXR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable XL: BIT_VECTOR(L_LEFT downto 0);
    variable XR: BIT_VECTOR(R_LEFT downto 0);
    variable RESULT: BIT_VECTOR((L'LENGTH+R'LENGTH-1) downto 0) :=
        (others => '0');
    variable ADVAL: BIT_VECTOR((L'LENGTH+R'LENGTH-1) downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    XL := XXL;
    XR := XXR;
    ADVAL := RESIZE(XR, RESULT'LENGTH);
    for I in 0 to L_LEFT loop
      if XL(I)='1' then RESULT := RESULT + ADVAL;
      end if;
      ADVAL := SHIFT_LEFT(ADVAL, 1);
    end loop;
    return RESULT;
  end "*";

  -- Id:
  function "*" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
  begin
    return L * TO_BIT_VECTOR(R, L'LENGTH);
  end "*";

  -- Id:
  function "*" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
  begin
    return TO_BIT_VECTOR(L, R'LENGTH) * R;
  end "*";

  --============================================================================

  -- Id:
  function "/" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XXL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XXR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable XL: BIT_VECTOR(L_LEFT downto 0);
    variable XR: BIT_VECTOR(R_LEFT downto 0);
    variable FQUOT: BIT_VECTOR(L'LENGTH-1 downto 0);
    variable FREMAIN: BIT_VECTOR(R'LENGTH-1 downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    XL := XXL;
    XR := XXR;
    DIVMOD(XL, XR, FQUOT, FREMAIN);
    return FQUOT;
  end "/";

  -- Id:
  function "/" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
    constant R_LENGTH: NATURAL := MAX(L'LENGTH, BIT_VECTOR_NUM_BITS(R));
    variable XR, QUOT: BIT_VECTOR(R_LENGTH-1 downto 0);
  begin
    if (L'LENGTH < 1) then return NAU;
    end if;
    if (R_LENGTH > L'LENGTH) then
      QUOT := (others => '0');
      return RESIZE(QUOT, L'LENGTH);
    end if;
    XR := TO_BIT_VECTOR(R, R_LENGTH);
    QUOT := RESIZE((L / XR), QUOT'LENGTH);
    return RESIZE(QUOT, L'LENGTH);
  end "/";

  -- Id:
  function "/" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LENGTH: NATURAL := MAX(BIT_VECTOR_NUM_BITS(L), R'LENGTH);
    variable XL, QUOT: BIT_VECTOR(L_LENGTH-1 downto 0);
  begin
    if (R'LENGTH < 1) then return NAU;
    end if;
    XL := TO_BIT_VECTOR(L, L_LENGTH);
    QUOT := RESIZE((XL / R), QUOT'LENGTH);
    if L_LENGTH > R'LENGTH and QUOT(L_LENGTH-1 downto R'LENGTH)
        /= (L_LENGTH-1 downto R'LENGTH => '0')
        then
      assert NO_WARNING report "BIT_ARITH.""/"": Quotient Truncated"
          severity WARNING;
    end if;
    return RESIZE(QUOT, R'LENGTH);
  end "/";

  --============================================================================

  -- Id:
  function "rem" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XXL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XXR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable XL: BIT_VECTOR(L_LEFT downto 0);
    variable XR: BIT_VECTOR(R_LEFT downto 0);
    variable FQUOT: BIT_VECTOR(L'LENGTH-1 downto 0);
    variable FREMAIN: BIT_VECTOR(R'LENGTH-1 downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    XL := XXL;
    XR := XXR;
    DIVMOD(XL, XR, FQUOT, FREMAIN);
    return FREMAIN;
  end "rem";

  -- Id:
  function "rem" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
    constant R_LENGTH: NATURAL := MAX(L'LENGTH, BIT_VECTOR_NUM_BITS(R));
    variable XR, XREM: BIT_VECTOR(R_LENGTH-1 downto 0);
  begin
    if (L'LENGTH < 1) then return NAU;
    end if;
    XR := TO_BIT_VECTOR(R, R_LENGTH);
    XREM := L rem XR;
    if R_LENGTH > L'LENGTH and XREM(R_LENGTH-1 downto L'LENGTH)
        /= (R_LENGTH-1 downto L'LENGTH => '0')
        then
      assert NO_WARNING report "BIT_ARITH.""rem"": Remainder Truncated"
          severity WARNING;
    end if;
    return RESIZE(XREM, L'LENGTH);
  end "rem";

  -- Id:
  function "rem" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LENGTH: NATURAL := MAX(BIT_VECTOR_NUM_BITS(L), R'LENGTH);
    variable XL, XREM: BIT_VECTOR(L_LENGTH-1 downto 0);
  begin
    XL := TO_BIT_VECTOR(L, L_LENGTH);
    XREM := XL rem R;
    if L_LENGTH > R'LENGTH and XREM(L_LENGTH-1 downto R'LENGTH)
        /= (L_LENGTH-1 downto R'LENGTH => '0')
        then
      assert NO_WARNING report "BIT_ARITH.""rem"": Remainder Truncated"
          severity WARNING;
    end if;
    return RESIZE(XREM, R'LENGTH);
  end "rem";

  --============================================================================

  -- Id:
  function "mod" (L, R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XXL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XXR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable XL: BIT_VECTOR(L_LEFT downto 0);
    variable XR: BIT_VECTOR(R_LEFT downto 0);
    variable FQUOT: BIT_VECTOR(L'LENGTH-1 downto 0);
    variable FREMAIN: BIT_VECTOR(R'LENGTH-1 downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then return NAU;
    end if;
    XL := XXL;
    XR := XXR;
    DIVMOD(XL, XR, FQUOT, FREMAIN);
    return FREMAIN;
  end "mod";

  -- Id:
  function "mod" (L: BIT_VECTOR; R: NATURAL) return BIT_VECTOR is
    constant R_LENGTH: NATURAL := MAX(L'LENGTH, BIT_VECTOR_NUM_BITS(R));
    variable XR, XREM: BIT_VECTOR(R_LENGTH-1 downto 0);
  begin
    if (L'LENGTH < 1) then return NAU;
    end if;
    XR := TO_BIT_VECTOR(R, R_LENGTH);
    XREM := RESIZE((L mod XR), XREM'LENGTH);
    if R_LENGTH > L'LENGTH and XREM(R_LENGTH-1 downto L'LENGTH)
        /= (R_LENGTH-1 downto L'LENGTH => '0')
        then
      assert NO_WARNING report "BIT_ARITH.""mod"": Modulus Truncated"
          severity WARNING;
    end if;
    return RESIZE(XREM, L'LENGTH);
  end "mod";

  -- Id:
  function "mod" (L: NATURAL; R: BIT_VECTOR) return BIT_VECTOR is
    constant L_LENGTH: NATURAL := MAX(BIT_VECTOR_NUM_BITS(L), R'LENGTH);
    variable XL, XREM: BIT_VECTOR(L_LENGTH-1 downto 0);
  begin
    if (R'LENGTH < 1) then return NAU;
    end if;
    XL := TO_BIT_VECTOR(L, L_LENGTH);
    XREM := RESIZE((XL mod R), XREM'LENGTH);
    if L_LENGTH > R'LENGTH and XREM(L_LENGTH-1 downto R'LENGTH)
        /= (L_LENGTH-1 downto R'LENGTH => '0')
        then
      assert NO_WARNING report "BIT_ARITH.""mod"": Modulus Truncated"
          severity WARNING;
    end if;
    return RESIZE(XREM, R'LENGTH);
  end "mod";

  --============================================================================

  -- Id:
  function ">" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH."">"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    R01 := XR;
    return BIT_VECTOR_GREATER(RESIZE(L01, SIZE), RESIZE(R01, SIZE));
  end ">";

  -- Id:
  function ">" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH."">"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return TRUE;
    end if;
    return BIT_VECTOR_GREATER(TO_BIT_VECTOR(L, R01'LENGTH), R01);
  end ">";

  -- Id:
  function ">" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH."">"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return FALSE;
    end if;
    return BIT_VECTOR_GREATER(L01, TO_BIT_VECTOR(R, L01'LENGTH));
  end ">";

  --============================================================================

  -- Id:
  function "<" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH.""<"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    R01 := XR;
    return BIT_VECTOR_LESS(RESIZE(L01, SIZE), RESIZE(R01, SIZE));
  end "<";

  -- Id:
  function "<" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""<"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return L < 0;
    end if;
    return BIT_VECTOR_LESS(TO_BIT_VECTOR(L, R01'LENGTH), R01);
  end "<";

  -- Id:
  function "<" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""<"": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return 0 < R;
    end if;
    return BIT_VECTOR_LESS(L01, TO_BIT_VECTOR(R, L01'LENGTH));
  end "<";

  --============================================================================

  -- Id:
  function "<=" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH.""<="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    R01 := XR;
    return not BIT_VECTOR_GREATER(RESIZE(L01, SIZE), RESIZE(R01, SIZE));
  end "<=";

  -- Id:
  function "<=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""<="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return L < 0;
    end if;
    return not BIT_VECTOR_GREATER(TO_BIT_VECTOR(L,R01'LENGTH), R01);
  end "<=";

  -- Id:
  function "<=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L_LEFT < 0) then
      assert NO_WARNING
          report "BIT_ARITH.""<="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return 0 < R;
    end if;
    return not BIT_VECTOR_GREATER(L01, TO_BIT_VECTOR(R,L01'LENGTH));
  end "<=";

  --============================================================================

  -- Id:
  function ">=" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH."">="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    R01 := XR;
    return not BIT_VECTOR_LESS(RESIZE(L01, SIZE), RESIZE(R01, SIZE));
  end ">=";

  -- Id:
  function ">=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH."">="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return L > 0;
    end if;
    return not BIT_VECTOR_LESS(TO_BIT_VECTOR(L, R01'LENGTH), R01);
  end ">=";

  -- Id:
  function ">=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH."">="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return 0 > R;
    end if;
    return not BIT_VECTOR_LESS(L01, TO_BIT_VECTOR(R, L01'LENGTH));
  end ">=";

  --============================================================================

  -- Id:
  function "=" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH.""="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    R01 := XR;
    return BIT_VECTOR_EQUAL(RESIZE(L01, SIZE), RESIZE(R01, SIZE));
  end "=";

  -- Id:
  function "=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return FALSE;
    end if;
    return BIT_VECTOR_EQUAL(TO_BIT_VECTOR(L, R01'LENGTH), R01);
  end "=";

  -- Id:
  function "=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""="": null argument detected, returning FALSE"
          severity WARNING;
      return FALSE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return FALSE;
    end if;
    return BIT_VECTOR_EQUAL(L01, TO_BIT_VECTOR(R, L01'LENGTH));
  end "=";

  --============================================================================

  -- Id:
  function "/=" (L, R: BIT_VECTOR) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    constant SIZE: NATURAL := MAX(L'LENGTH, R'LENGTH);
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if ((L'LENGTH < 1) or (R'LENGTH < 1)) then
      assert NO_WARNING
          report "BIT_ARITH.""/="": null argument detected, returning TRUE"
          severity WARNING;
      return TRUE;
    end if;
    L01 := XL;
    R01 := XR;
    return not(BIT_VECTOR_EQUAL(RESIZE(L01, SIZE), RESIZE(R01, SIZE)));
  end "/=";

  -- Id:
  function "/=" (L: NATURAL; R: BIT_VECTOR) return BOOLEAN is
    constant R_LEFT: INTEGER := R'LENGTH-1;
    alias XR: BIT_VECTOR(R_LEFT downto 0) is R;
    variable R01 : BIT_VECTOR(R_LEFT downto 0);
  begin
    if (R'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""/="": null argument detected, returning TRUE"
          severity WARNING;
      return TRUE;
    end if;
    R01 := XR;
    if BIT_VECTOR_NUM_BITS(L) > R'LENGTH then return TRUE;
    end if;
    return not(BIT_VECTOR_EQUAL(TO_BIT_VECTOR(L, R01'LENGTH), R01));
  end "/=";

  -- Id:
  function "/=" (L: BIT_VECTOR; R: NATURAL) return BOOLEAN is
    constant L_LEFT: INTEGER := L'LENGTH-1;
    alias XL: BIT_VECTOR(L_LEFT downto 0) is L;
    variable L01 : BIT_VECTOR(L_LEFT downto 0);
  begin
    if (L'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.""/="": null argument detected, returning TRUE"
          severity WARNING;
      return TRUE;
    end if;
    L01 := XL;
    if BIT_VECTOR_NUM_BITS(R) > L'LENGTH then return TRUE;
    end if;
    return not(BIT_VECTOR_EQUAL(L01, TO_BIT_VECTOR(R, L01'LENGTH)));
  end "/=";

  --============================================================================

  -- Id:
  function SHIFT_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return BIT_VECTOR(XSLL(BIT_VECTOR(ARG), COUNT));
  end SHIFT_LEFT;

  -- Id:
  function SHIFT_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return BIT_VECTOR(XSRL(BIT_VECTOR(ARG), COUNT));
  end SHIFT_RIGHT;

  --============================================================================

  -- Id:
  function ROTATE_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return BIT_VECTOR(XROL(BIT_VECTOR(ARG), COUNT));
  end ROTATE_LEFT;

  -- Id:
  function ROTATE_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return BIT_VECTOR(XROR(BIT_VECTOR(ARG), COUNT));
  end ROTATE_RIGHT;

  --============================================================================

  -- Id:
  function "sll" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return SHIFT_LEFT(ARG, COUNT);
    else
      return SHIFT_RIGHT(ARG, -COUNT);
    end if;
  end "sll";

  -- Id:
  function "srl" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return SHIFT_RIGHT(ARG, COUNT);
    else
      return SHIFT_LEFT(ARG, -COUNT);
    end if;
  end "srl";

  -- Id:
  function "rol" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return ROTATE_LEFT(ARG, COUNT);
    else
      return ROTATE_RIGHT(ARG, -COUNT);
    end if;
  end "rol";

  -- Id:
  function "ror" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return ROTATE_RIGHT(ARG, COUNT);
    else
      return ROTATE_LEFT(ARG, -COUNT);
    end if;
  end "ror";

  --============================================================================

  -- Id:
  function TO_INTEGER (ARG: BIT_VECTOR) return NATURAL is
    constant ARG_LEFT: INTEGER := ARG'LENGTH-1;
    alias XXARG: BIT_VECTOR(ARG_LEFT downto 0) is ARG;
    variable XARG: BIT_VECTOR(ARG_LEFT downto 0);
    variable RESULT: NATURAL := 0;
  begin
    if (ARG'LENGTH < 1) then
      assert NO_WARNING
          report "BIT_ARITH.TO_INTEGER: null detected, returning 0"
          severity WARNING;
      return 0;
    end if;
    XARG := XXARG;
    for I in XARG'RANGE loop
      RESULT := RESULT+RESULT;
      if XARG(I) = '1' then
        RESULT := RESULT + 1;
      end if;
    end loop;
    return RESULT;
  end TO_INTEGER;

  -- Id:
  function TO_BIT_VECTOR (ARG, SIZE: NATURAL) return BIT_VECTOR is
    variable RESULT: BIT_VECTOR(SIZE-1 downto 0);
    variable I_VAL: NATURAL := ARG;
  begin
    if (SIZE < 1) then return NAU;
    end if;
    for I in 0 to RESULT'LEFT loop
      if (I_VAL mod 2) = 0 then
        RESULT(I) := '0';
      else RESULT(I) := '1';
      end if;
      I_VAL := I_VAL/2;
    end loop;
    if not(I_VAL =0) then
      assert NO_WARNING
          report "BIT_ARITH.TO_BIT_VECTOR: vector truncated"
          severity WARNING;
    end if;
    return RESULT;
  end TO_BIT_VECTOR;

  --============================================================================

  -- Id:
  function RESIZE (ARG: BIT_VECTOR; NEW_SIZE: NATURAL) return BIT_VECTOR is
    constant ARG_LEFT: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_LEFT downto 0) is ARG;
    variable RESULT: BIT_VECTOR(NEW_SIZE-1 downto 0) := (others => '0');
  begin
    if (NEW_SIZE < 1) then return NAU;
    end if;
    if XARG'LENGTH =0 then return RESULT;
    end if;
    if (RESULT'LENGTH < ARG'LENGTH) then
      RESULT(RESULT'LEFT downto 0) := XARG(RESULT'LEFT downto 0);
    else
      RESULT(RESULT'LEFT downto XARG'LEFT+1) := (others => '0');
      RESULT(XARG'LEFT downto 0) := XARG;
    end if;
    return RESULT;
  end RESIZE;

  --============================================================================

end BIT_ARITH;
