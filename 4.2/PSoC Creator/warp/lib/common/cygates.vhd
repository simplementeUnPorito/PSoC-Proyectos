-- /*******************************************************************************
-- * Copyright 2000, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

library ieee ;
use ieee.std_logic_1164.all ;

PACKAGE cygates is

component cy_and2
    port(a,b	: in std_logic;
	y	: out std_logic);
end component;

component cy_and3
    port(a,b,c	: in std_logic;
	y	: out std_logic);
end component;

component cy_and4
    port(a,b,c,d: in std_logic;
	y	: out std_logic);
end component;

component cy_or2
    port(a,b	: in std_logic;
	y	: out std_logic);
end component;

component cy_or3
    port(a,b,c	: in std_logic;
	y	: out std_logic);
end component;

component cy_or4
    port(a,b,c,d: in std_logic;
	y	: out std_logic);
end component;

component cy_xor2
    port(a,b	: in std_logic;
	y	: out std_logic);
end component;

component cy_xor3
    port(a,b,c	: in std_logic;
	y	: out std_logic);
end component;

component cy_xor4
    port(a,b,c,d: in std_logic;
	y	: out std_logic);
end component;

component cy_inv
    port(a	: in std_logic;
	y	: out std_logic);
end component;

component cy_mux2x1
    port(a0,a1,s: in std_logic;
	y	: out std_logic);
end component;

component cy_mux4x1
    port(a0,a1,a2,a3,s0,s1 : in std_logic;
	y	: out std_logic);
end component;

component cy_mux8x1
    port(a0,a1,a2,a3,a4,a5,a6,a7,s0,s1,s2 : in std_logic;
	y	: out std_logic);
end component;

end cygates ;

------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_and2 is
    port   (a,b	: in std_logic;
	    y	: out std_logic);
end cy_and2;

architecture archRTL of cy_and2 is
begin
    y <= a AND b ;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_and3 is
    port   (a,b,c	: in std_logic;
	    y	: out std_logic);
end cy_and3;

architecture archRTL of cy_and3 is
begin
    y <= a AND b AND c ;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_and4 is
    port   (a,b,c,d	: in std_logic;
	    y	: out std_logic);
end cy_and4;

architecture archRTL of cy_and4 is
begin
    y <= a AND b AND c AND d ;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_or2 is
    port   (a,b	: in std_logic;
	    y	: out std_logic);
end cy_or2;

architecture archRTL of cy_or2 is
begin
    y <= a OR b ;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_or3 is
    port   (a,b,c	: in std_logic;
	    y	: out std_logic);
end cy_or3;

architecture archRTL of cy_or3 is
begin
    y <= a OR b OR c ;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_or4 is
    port   (a,b,c,d	: in std_logic;
	    y	: out std_logic);
end cy_or4;

architecture archRTL of cy_or4 is
begin
    y <= a OR b OR c OR d;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_xor2 is
    port   (a,b	: in std_logic;
	    y	: out std_logic);
end cy_xor2;

architecture archRTL of cy_xor2 is
begin
    y <= a XOR b;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_xor3 is
    port   (a,b,c	: in std_logic;
	    y	: out std_logic);
end cy_xor3;

architecture archRTL of cy_xor3 is
begin
    y <= a XOR b XOR c;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_xor4 is
    port   (a,b,c,d	: in std_logic;
	    y	: out std_logic);
end cy_xor4;

architecture archRTL of cy_xor4 is
begin
    y <= a XOR b XOR c XOR d;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_inv is
    port   (a	: in std_logic;
	    y	: out std_logic);
end cy_inv;

architecture archRTL of cy_inv is
begin
    y <= NOT a;
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_mux2x1 is
    port   (a0,a1,s	: in std_logic;
	    y	: out std_logic);
end cy_mux2x1;

architecture archRTL of cy_mux2x1 is
begin
    y <= ((s AND a1) OR
		 (NOT s AND a0));
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_mux4x1 is
    port   (a0,a1,a2,a3,s0,s1	: in std_logic;
	    y	: out std_logic);
end cy_mux4x1;

architecture archRTL of cy_mux4x1 is
begin
    y <= ((s0 AND s1 AND a3) OR
		 ((NOT s0) AND s1 AND a2) OR
		 (s0 AND (NOT s1) AND a1) OR
		 ((NOT s0) AND (NOT s1) AND a0));
end archRTL;

library ieee ;
use ieee.std_logic_1164.all ;

entity cy_mux8x1 is
    port   (a0,a1,a2,a3,a4,a5,a6,a7,s0,s1,s2	: in std_logic;
	    y	: out std_logic);
end cy_mux8x1;

architecture archRTL of cy_mux8x1 is
begin
    y <= ((s0 AND s1 AND s2 AND a7) OR
		 ((NOT s0) AND s1 AND s2 AND a6) OR
		 (s0 AND (NOT s1) AND s2 AND a5) OR
		 ((NOT s0) AND (NOT s1) AND s2 AND a4) OR
		 (s0 AND s1 AND (NOT s2) AND a3) OR
		 ((NOT s0) AND s1 AND (NOT s2) AND a2) OR
		 (s0 AND (NOT s1) AND (NOT s2) AND a1) OR
		 ((NOT s0) AND (NOT s1) AND (NOT s2) AND a0));
end archRTL;
