-- /*******************************************************************************
-- * Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

-----------------------------------------------------------------------------
--                                                                         --
-- Primitive library for post synthesis simulation                         --
-- These models are not intended for efficient synthesis                   --
--                                                                         --
-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
package synplify is

    signal zero : std_logic := '0';
    signal one  : std_logic := '1';

    component CYPBUF 
	    port(A :  in  std_logic;
		 B :  out std_logic); 
    end component;
    component prim_counter
	    generic (w : integer);
	    port (q    : buffer std_logic_vector(w - 1 downto 0);
		  cout : out    std_logic;
		  d    : in     std_logic_vector(w - 1 downto 0);
		  cin  : in     std_logic;
		  clk  : in     std_logic;
		  rst  : in     std_logic;
		  load : in     std_logic;
		  en   : in     std_logic;
		  updn : in     std_logic);
    end component;
    component prim_dff
	    port (q   : out std_logic;
		  d   : in  std_logic;
		  clk : in  std_logic;
		  r   : in  std_logic := '0';
		  s   : in  std_logic := '0');
    end component;
    component prim_latch
	    port (q   : out std_logic;
		  d   : in  std_logic;
		  clk : in  std_logic;
		  r   : in  std_logic := '0';
		  s   : in  std_logic := '0');
    end component;

    TYPE fdbk_source IS (DIRECT, CLOCK_TREE, EXTERNAL);

    component sy_c39kpll
	generic(lpm_feedback	: fdbk_source	:= DIRECT;
		lpm_multiply	: positive	:= 1;
		lpm_gclk0_phase	: natural	:= 0;
		lpm_gclk0_divide: positive	:= 1;
		lpm_gclk1_phase	: natural	:= 0;
		lpm_gclk1_divide: positive	:= 1;
		lpm_gclk2_phase	: natural	:= 0;
		lpm_gclk2_divide: positive	:= 1;
		lpm_gclk3_phase	: natural	:= 0;
		lpm_gclk3_divide: positive	:= 1);
	port   (pll_in		: in  std_logic;
		ext_fdbk	: in  std_logic	:= '0';
		lock_detect	: out std_logic;
		gclk0		: out std_logic;
		gclk1		: out std_logic;
		gclk2		: out std_logic;
		gclk3		: out std_logic);
    end component;

end synplify;

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.all;
entity CYPBUF is
	port(
		A :  in std_logic;
		B :  out std_logic
	); 
end CYPBUF;

architecture beh of CYPBUF is
begin
	bx : cy_buf port map (x=>a,y=>b);
end beh;

library ieee;
use ieee.std_logic_1164.all;
entity prim_counter is
	generic (w : integer := 8);
	port (
		q    : buffer std_logic_vector(w - 1 downto 0);
		cout : out    std_logic;
		d    : in     std_logic_vector(w - 1 downto 0);
		cin  : in     std_logic;
		clk  : in     std_logic;
		rst  : in     std_logic;
		load : in     std_logic;
		en   : in     std_logic;
		updn : in     std_logic
	);
end prim_counter;

architecture beh of prim_counter is
	signal nextq : std_logic_vector(w - 1 downto 0);
begin
	nxt: process (q, cin, updn)
		variable i : integer;
		variable nextc, c : std_logic;
	begin
		nextc := cin;
		for i in 0 to w - 1 loop
			c := nextc;
			nextq(i) <= c xor (not updn) xor q(i);
			nextc := (c and (not updn)) or 
				 (c and q(i)) or
				 ((not updn) and q(i));
		end loop;
		cout <= nextc;
	end process;

	ff : process (clk, rst)
	begin
		if rst = '1' then
			q <= (others => '0');
		elsif rising_edge(clk) then
			q <= nextq;
		end if;
	end process ff;
end beh;

library ieee;
use ieee.std_logic_1164.all;
entity prim_dff is
	port (q   : out std_logic;
	      d   : in  std_logic;
	      clk : in  std_logic;
	      r   : in  std_logic := '0';
	      s   : in  std_logic := '0');
end prim_dff;

architecture beh of prim_dff is
begin
	ff : process (clk, r, s)
	begin
		if r = '1' then
			q <= '0';
		elsif s = '1' then
			q <= '1';
		elsif rising_edge(clk) then
			q <= d;
		end if;
	end process ff;
end beh;

library ieee;
use ieee.std_logic_1164.all;
entity prim_latch is
	port (q   : out std_logic;
	      d   : in  std_logic;
	      clk : in  std_logic;
	      r   : in  std_logic := '0';
	      s   : in  std_logic := '0');
end prim_latch;

architecture beh of prim_latch is
begin
	q <= '0' when r = '1' else
	     '1' when s = '1' else
	     d when clk = '1';
end beh;

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.rtlpkg.all;

entity sy_c39kpll is
    generic(lpm_feedback	: fdbk_source	:= DIRECT;
	    lpm_multiply	: positive	:= 1;
	    lpm_gclk0_phase	: natural	:= 0;
	    lpm_gclk0_divide	: positive	:= 1;
	    lpm_gclk1_phase	: natural	:= 0;
	    lpm_gclk1_divide	: positive	:= 1;
	    lpm_gclk2_phase	: natural	:= 0;
	    lpm_gclk2_divide	: positive	:= 1;
	    lpm_gclk3_phase	: natural	:= 0;
	    lpm_gclk3_divide	: positive	:= 1);
    port   (pll_in		: in  std_logic;
	    ext_fdbk		: in  std_logic	:= '0';
	    lock_detect		: out std_logic;
	    gclk0		: out std_logic;
	    gclk1		: out std_logic;
	    gclk2		: out std_logic;
	    gclk3		: out std_logic);
end sy_c39kpll;

architecture beh of sy_c39kpll is
begin
    U0: cy_c39kpll generic map (feedback	=> lpm_feedback,
				multiply	=> lpm_multiply,
				gclk0_phase	=> lpm_gclk0_phase,
				gclk0_divide	=> lpm_gclk0_divide,
				gclk1_phase	=> lpm_gclk1_phase,
				gclk1_divide	=> lpm_gclk1_divide,
				gclk2_phase	=> lpm_gclk2_phase,
				gclk2_divide	=> lpm_gclk2_divide,
				gclk3_phase	=> lpm_gclk3_phase,
				gclk3_divide	=> lpm_gclk3_divide)
		      port map (pll_in		=> pll_in,
				ext_fdbk	=> ext_fdbk,
				lock_detect	=> lock_detect,
				gclk0		=> gclk0,
				gclk1		=> gclk1,
				gclk2		=> gclk2,
				gclk3		=> gclk3);
end beh;
