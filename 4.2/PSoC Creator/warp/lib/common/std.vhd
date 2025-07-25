-- /*******************************************************************************
-- * Copyright 1995, 1996, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

--
--	Std.vhd - Standard library.
--
--	Note:  Many standard definitions are built into the WARP program.
--

package STANDARD is

TYPE boolean IS (false, true);
TYPE bit IS ('0', '1');
TYPE character IS (                      --  > 0x20 are built-in.
    NUL,  SOH,  STX,  ETX,  EOT,  ENQ,  ACK,  BEL,
    BS,   HT,   LF,   VT,   FF,   CR,   SO,   SI,
    DLE,  DC1,  DC2,  DC3,  DC4,  NAK,  SYN,  ETB,
    CAN,  EM,   SUB,  ESC,  FSP,  GSP,  RSP,  USP
);
TYPE severity_level IS (note, warning, error, failure);
TYPE real IS range -1.0E38 to 1.0E38;
TYPE time IS range -2147483647 to 2147483647
  units
    fs;
    ps = 1000 fs;
    ns = 1000 ps;
    us = 1000 ns;
    ms = 1000 us;
    sec = 1000 ms;
    min = 60 sec;
    hr = 60 min;
  end units;

FUNCTION now RETURN TIME;

--  Predefined numeric subtypes:

SUBTYPE Natural  IS Integer RANGE 0 to Integer'high;
SUBTYPE Positive IS Integer RANGE 1 to Integer'high;

--  Predefined array types:

TYPE String IS array (Positive RANGE <>) of CHARACTER;
TYPE Bit_vector IS ARRAY (Natural RANGE <>) OF BIT;


end STANDARD;
