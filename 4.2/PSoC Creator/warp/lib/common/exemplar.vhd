-- el_gates.vhd -- --
--

------------------------------------------------------------------------
-- Exemplar Lgen Component Declarations --
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library cypress;
use cypress.lpmpkg.all;

package exemplar_gates is

    component fdec
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                bin : in std_logic;
                dif : out std_logic_vector(width-1 downto 0));
    end component;

    component finc
        generic(width : natural);
        port( dataA : in std_logic_vector(width-1 downto 0);
                cin : in std_logic;
                sum : out std_logic_vector(width-1 downto 0));
    end component;

    component and2
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component and3
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component and4
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component and5
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component and6
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component and7
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             RESULT: OUT std_logic);
    end component;
    component and8
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             DATA7: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component inv1 -- Exemplar gate
        port(DATA1: IN std_logic; -- DATA -> DATA1 (CKC)
             RESULT: OUT std_logic);
    end component;

    component nand2 -- Exemplar gate
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component xr2 -- Exemplar gate
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nand3
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nand4
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nand8
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             DATA7: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nor2
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nor3
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nor4
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component nor8
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             DATA7: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or2 -- Exemplar gate
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or3
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or4
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or5
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or6
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or7
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component or8
        port(DATA0: IN std_logic;
             DATA1: IN std_logic;
             DATA2: IN std_logic;
             DATA3: IN std_logic;
             DATA4: IN std_logic;
             DATA5: IN std_logic;
             DATA6: IN std_logic;
             DATA7: IN std_logic;
             RESULT: OUT std_logic);
    end component;

    component vcc
        port(Y: OUT std_logic);
    end component;

    component gnd
        port(Y: OUT std_logic);
    end component;

    component bustri1
      port(DATA1: IN std_logic;
           ENABLEDT: IN std_logic;
           TRIDATA: INOUT std_logic);
    end component;

   component leos_dff
      port (
         q : OUT std_logic ;
         d : IN std_logic ;
         clk : IN std_logic) ;
   end component ;

   component leos_dsrff
      port (
         q : OUT std_logic ;
         d : IN std_logic ;
         s : IN std_logic;
         r : IN std_logic;
         clk : IN std_logic) ;
   end component ;

   component leos_dltch
    port (d : in std_logic;
            e : in std_logic;
            q : out std_logic);
   end component;

    component leos_dsrlch
      port (d : in std_logic;
              e : in std_logic;
              s : in std_logic;
              r : in std_logic;
              q : out std_logic);
    end component;

    component leos_triout
      port (
        y : OUT std_logic ;
        x : IN std_logic ;
        oe : IN std_logic) ;
    end component;

    component exm_add
      generic(lpm_width : positive;
              lpm_representation : repre_type := LPM_UNSIGNED;
              lpm_hint : goal_type := SPEED);
      port(dataa : in std_logic_vector(lpm_width-1 downto 0);
           datab : in std_logic_vector(lpm_width-1 downto 0);
           cin : in std_logic := '0';
           result : out std_logic_vector(lpm_width-1 downto 0);
           cout : out std_logic;
           overflow : out std_logic);
    end component;

end exemplar_gates;

--------------------------------------------------------------------------------
-- Simple Gate definitions --
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity and2 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         RESULT: OUT std_logic);
end and2;

architecture archand2 of and2 is
begin

        RESULT <= DATA0 AND DATA1;
end archand2;

library ieee;
use ieee.std_logic_1164.all;

entity and3 is
    port(DATA0 : IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         RESULT: OUT std_logic);
end and3;

architecture archand3 of and3 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2;
end archand3;

library ieee;
use ieee.std_logic_1164.all;

entity and4 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         RESULT: OUT std_logic);
end and4;

architecture archand4 of and4 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2 AND DATA3;
end archand4;

library ieee;
use ieee.std_logic_1164.all;

entity and5 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         RESULT: OUT std_logic);
end and5;

architecture archand5 of and5 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2 AND DATA3 AND DATA4 ;
end archand5;

library ieee;
use ieee.std_logic_1164.all;

entity and6 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         RESULT: OUT std_logic);
end and6;

architecture archand6 of and6 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2 AND DATA3 AND DATA4 AND DATA5 ;
end archand6;

library ieee;
use ieee.std_logic_1164.all;

entity and7 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         RESULT: OUT std_logic);
end and7;

architecture archand7 of and7 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2 AND DATA3 AND DATA4 AND DATA5 AND DATA6 ;
end archand7;

library ieee;
use ieee.std_logic_1164.all;

entity and8 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         DATA7: IN std_logic;
         RESULT: OUT std_logic);
end and8;

architecture archand8 of and8 is
begin
        RESULT <= DATA0 AND DATA1 AND DATA2 AND DATA3 AND DATA4 AND DATA5 AND DATA6 AND DATA7;
end archand8;

library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         RESULT: OUT std_logic);
end or2;

architecture archor2 of or2 is
begin
        RESULT <= DATA0 OR DATA1 ;
end archor2;

library ieee;
use ieee.std_logic_1164.all;

entity or3 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         RESULT: OUT std_logic);
end or3;

architecture archor3 of or3 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 ;
end archor3;

library ieee;
use ieee.std_logic_1164.all;

entity or4 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         RESULT: OUT std_logic);
end or4;

architecture archor4 of or4 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 OR DATA3 ;
end archor4;

library ieee;
use ieee.std_logic_1164.all;

entity or5 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         RESULT: OUT std_logic);
end or5;

architecture archor5 of or5 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 OR DATA3 OR DATA4 ;
end archor5;

library ieee;
use ieee.std_logic_1164.all;

entity or6 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         RESULT: OUT std_logic);
end or6;

architecture archor6 of or6 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 OR DATA3 OR DATA4 OR DATA5 ;
end archor6;

library ieee;
use ieee.std_logic_1164.all;

entity or7 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         RESULT: OUT std_logic);
end or7;

architecture archor7 of or7 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 OR DATA3 OR DATA4 OR DATA5 OR DATA6;
end archor7;

library ieee;
use ieee.std_logic_1164.all;

entity or8 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         DATA7: IN std_logic;
         RESULT: OUT std_logic);
end or8;

architecture archor8 of or8 is
begin
        RESULT <= DATA0 OR DATA1 OR DATA2 OR DATA3 OR DATA4 OR DATA5 OR DATA6 OR DATA7 ;
end archor8;

library ieee;
use ieee.std_logic_1164.all;

entity inv1 is
    port(DATA1: IN std_logic; -- DATA -> DATA1 (CKC)
         RESULT: OUT std_logic);
end inv1;

architecture archinv1 of inv1 is
begin
    RESULT <= NOT DATA1 ;
end archinv1;

library ieee;
use ieee.std_logic_1164.all;

entity nand2 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         RESULT: OUT std_logic);
end nand2;

architecture archnand2 of nand2 is
begin
        RESULT <= NOT (DATA0 AND DATA1) ;
end archnand2;

library ieee;
use ieee.std_logic_1164.all;

entity xr2 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         RESULT: OUT std_logic);
end xr2;

architecture archxr2 of xr2 is
begin

        RESULT <= DATA0 xor DATA1;
end archxr2;

library ieee;
use ieee.std_logic_1164.all;

entity nand3 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         RESULT: OUT std_logic);
end nand3;

architecture archnand3 of nand3 is
begin
        RESULT <= NOT (DATA0 AND DATA1 AND DATA2) ;
end archnand3;

library ieee;
use ieee.std_logic_1164.all;

entity nand4 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         RESULT: OUT std_logic);
end nand4;

architecture archnand4 of nand4 is
begin
        RESULT <= NOT (DATA0 AND DATA1 AND DATA2 AND DATA3) ;
end archnand4;

library ieee;
use ieee.std_logic_1164.all;

entity nand8 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         DATA7: IN std_logic;
         RESULT: OUT std_logic);
end nand8;

architecture archnand8 of nand8 is
begin
        RESULT <= NOT (DATA0 AND DATA1 AND DATA2 AND DATA3) ;
end archnand8;

library ieee;
use ieee.std_logic_1164.all;

entity nor2 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         RESULT: OUT std_logic);
end nor2;

architecture archnor2 of nor2 is
begin
        RESULT <= NOT ( DATA0 OR DATA1) ;
end archnor2;

library ieee;
use ieee.std_logic_1164.all;

entity nor3 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         RESULT: OUT std_logic);
end nor3;

architecture archnor3 of nor3 is
begin
        RESULT <= NOT (DATA0 OR DATA1 OR DATA2) ;
end archnor3;

library ieee;
use ieee.std_logic_1164.all;

entity nor4 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         RESULT: OUT std_logic);
end nor4;

architecture archnor4 of nor4 is
begin
        RESULT <= NOT (DATA0 OR DATA1 OR DATA2 OR DATA3) ;
end archnor4;

library ieee;
use ieee.std_logic_1164.all;

entity nor8 is
    port(DATA0: IN std_logic;
         DATA1: IN std_logic;
         DATA2: IN std_logic;
         DATA3: IN std_logic;
         DATA4: IN std_logic;
         DATA5: IN std_logic;
         DATA6: IN std_logic;
         DATA7: IN std_logic;
         RESULT: OUT std_logic);
end nor8;

architecture archnor8 of nor8 is
begin
        RESULT <= NOT (DATA0 OR DATA1 OR DATA2 OR DATA3 OR DATA4 OR DATA5 OR DATA6 OR DATA7) ;
end archnor8;

library ieee;
use ieee.std_logic_1164.all;

entity vcc is
    port(Y: OUT std_logic);
end vcc;

architecture archvcc of vcc is
begin
        y <= '1';
end archvcc;

library ieee;
use ieee.std_logic_1164.all;

entity gnd is
    port(Y: OUT std_logic);
end gnd;

architecture archgnd of gnd is
begin
        y <= '0';
end archgnd;

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity bustri1 is
    port(DATA1: IN std_logic;
         ENABLEDT: IN std_logic;
         TRIDATA: OUT std_logic);
end bustri1;

architecture archbustri1 of bustri1 is
begin
  PROCESS (data1, enabledt)
  BEGIN
    IF (enabledt = '1') THEN
      if (data1 = '0') then tridata <= '0';
      elsif (data1 = '1') then tridata <= '1';
      else tridata <= 'X';
      end if;
    ELSE
                                   tridata <= 'Z';
    END IF;
  END PROCESS;

end archbustri1;

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity leos_dff is
  port (
    q : OUT std_logic ;
    d : IN std_logic ;
    clk : IN std_logic) ;
end leos_dff ;

architecture archdff1 of leos_dff is
begin
  PROCESS
  BEGIN
    WAIT UNTIL clk = '1';
              q <= d;
  END PROCESS;
end archdff1;

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity leos_dsrff is
      port (
         q : OUT std_logic ;
         d : IN std_logic ;
         s : IN std_logic;
         r : IN std_logic;
         clk : IN std_logic) ;
end leos_dsrff ;

architecture archdff1 of leos_dsrff is
begin
    PROCESS (r, s, clk)
    BEGIN
        IF (r = '1') THEN
            q <= '0';
        ELSIF (s = '1') THEN
            q <= '1';
        ELSIF (clk = '1' AND clk'event) THEN
            q <= d;
        END IF;
    END PROCESS;
end archdff1;

--

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity leos_dltch is
  port (d : in std_logic;
          e : in std_logic;
          q : out std_logic);
end leos_dltch;

ARCHITECTURE archRTL OF leos_DLTCH IS
  SIGNAL qx : std_logic;
BEGIN
  qx <= (d and e) or (d and qx) or (not(e) and qx);
  q <= qx;
END archRTL;

--

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity leos_dsrlch is
  port (d : in std_logic;
          e : in std_logic;
          s : in std_logic;
          r : in std_logic;
          q : out std_logic);
end leos_dsrlch;

ARCHITECTURE archRTL OF leos_DsrLCH IS
  signal qi: std_logic;
BEGIN
  qi <= (NOT(R) AND (S OR (D AND E) OR (qi AND NOT(E))));
  Q <= qi;
END archRTL;

--

library ieee;
use ieee.std_logic_1164.all;
use work.rtlpkg.all;

entity leos_triout is
  port (
         y : OUT std_logic ;
         x : IN std_logic ;
         oe : IN std_logic) ;
end leos_triout ;

architecture archdff1 of leos_triout is
begin
  PROCESS (x, oe)
  BEGIN
    IF (oe = '1') THEN
      if (x = '0') then y <= '0';
      elsif (x = '1') then y <= '1';
      else y <= 'X';
      end if;
    ELSE
                                   y <= 'Z';
    END IF;
  END PROCESS;
end archdff1;

library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;

entity exm_add is
  generic(lpm_width : positive;
          lpm_representation : repre_type := LPM_UNSIGNED;
          lpm_hint : goal_type := SPEED);
  port(dataa : in std_logic_vector(lpm_width-1 downto 0);
       datab : in std_logic_vector(lpm_width-1 downto 0);
       cin : in std_logic := '0';
       result : out std_logic_vector(lpm_width-1 downto 0);
       cout : out std_logic;
       overflow : out std_logic);
end exm_add;

architecture arch of exm_add is

begin -- arch

  uo : madd_sub generic map (
    lpm_width => lpm_width,
    lpm_representation => lpm_representation,
    lpm_direction => LPM_ADD)
    port map (
      Dataa => dataa,
      Datab => datab,
      Cin => cin,
      Result => result,
      Cout => cout,
      Overflow => overflow);

end arch;
