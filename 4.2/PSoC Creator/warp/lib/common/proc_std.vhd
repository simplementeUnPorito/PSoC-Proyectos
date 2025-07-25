-- /*******************************************************************************
-- * Copyright 1995, 1996, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

library ieee;
use ieee.std_logic_1164.all;

package proc_std is

  procedure dff
    (	signal data             : in std_logic;
        signal clk              : in std_logic;
        signal q                : out std_logic);                
                
  procedure dffc
    ( signal data              : in std_logic;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic);
                
  procedure dffp
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic);
                
  procedure dffpc
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic);

  procedure dff_v
    (	signal data             : in std_logic_vector;
        signal clk              : in std_logic;
        signal q                : out std_logic_vector);                
                
  procedure dffc_v
    ( signal data              : in std_logic_vector;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector);
                
  procedure dffp_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector);
                
  procedure dffpc_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector);


  procedure dlatch
    (	signal data             : in std_logic;
        signal enable           : in std_logic;
        signal q                : out std_logic);                
                
  procedure dlatchc
    ( signal data              : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic);
                
  procedure dlatchp
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic);
                
  procedure dlatchpc
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic);

  procedure dlatch_v
    (	signal data             : in std_logic_vector;
        signal enable           : in std_logic;
        signal q                : out std_logic_vector);                
                
  procedure dlatchc_v
    ( signal data              : in std_logic_vector;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector);
                
  procedure dlatchp_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector);
                
  procedure dlatchpc_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector);

end proc_std;

package body proc_std is
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
    procedure dff
      ( signal data             : in std_logic;
        signal clk              : in std_logic;
        signal q                : out std_logic)
    is begin
     IF (clk = '1' and clk'event) THEN
          q <= data;
     END IF;
    end dff;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dffc
    ( signal data              : in std_logic;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic)
  is begin
     IF (clear  = '1') THEN
          q <= '0';
     ELSIF (clk = '1' and clk'event) THEN
          q <= data;
     END IF;
  end dffc;              
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dffp
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic)
  is begin                
     IF (preset = '1') THEN
          q <= '1';
     ELSIF (clk = '1' and clk'event) THEN
          q <= data;
     END IF;

  end dffp;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------   
  procedure dffpc
    ( signal data:  in std_logic;
      signal preset:in std_logic;
      signal clear: in std_logic;
      signal clk:   in std_logic;
      signal q:     out std_logic)
  is begin
     IF (preset  = '1') THEN
          q <= '1';
     ELSIF (clear = '1') THEN
          q <= '0';
     ELSIF (clk = '1' and clk'event) THEN
          q <= data;
     END IF;
  end dffpc;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dff_v
    (	signal data             : in std_logic_vector;
        signal clk              : in std_logic;
        signal q                : out std_logic_vector)
  is
  
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
     IF (clk = '1' and clk'event) THEN
          tmpq <= data;
     END IF;
  end dff_v;  
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
 procedure dffc_v
    ( signal data              : in std_logic_vector;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector)
  is
  
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
     IF (clear  = '1') THEN
          tmpq <= (OTHERS => '0');
     ELSIF (clk = '1' and clk'event) THEN
          tmpq <= data;
     END IF;
  end dffc_v;  
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dffp_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector)
  is
    
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
     IF (preset  = '1') THEN
          tmpq <= (OTHERS => '1');
     ELSIF (clk = '1' and clk'event) THEN
          tmpq <= data;
     END IF;
  
  end dffp_v;  
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dffpc_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal clk               : in std_logic;
      signal q                 : out std_logic_vector)
  is
  
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
     IF (clear  = '1') THEN
          tmpq <= (OTHERS => '0');
     ELSIF (preset = '1') THEN
          tmpq <= (OTHERS => '1');
     ELSIF (clk = '1' and clk'event) THEN
          tmpq <= data;
     END IF;
  
  end dffpc_v;  
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dlatch
    (	signal data             : in std_logic;
        signal enable           : in std_logic;
        signal q                : out std_logic)                
  is
  begin
    IF (enable /= '0') THEN
        q <= data;      
    END IF;
  end dlatch;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------            
  procedure dlatchc
    ( signal data              : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic)
  is
  begin
    IF (clear = '1') THEN
      q <= '0';
    ELSIF (enable = '1') THEN
      q <= data AND data;
    END IF;
    
  end dlatchc;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------                
  procedure dlatchp
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic)
  is
  begin
    IF (preset = '1') THEN
      q <= '1';
    ELSIF (enable = '1') THEN
      q <= data AND data;
    END IF;
  end dlatchp;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------            
  procedure dlatchpc
    ( signal data              : in std_logic;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic)
  is
  begin
    IF (preset = '1') THEN
      q <= '1';
    ELSIF (clear = '1') THEN
      q <= '0';
    ELSIF (enable = '1') THEN      
      q <= data AND data;
    END IF;
  end dlatchpc;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
  procedure dlatch_v
    (	signal data             : in std_logic_vector;
        signal enable           : in std_logic;
        signal q                : out std_logic_vector)
  is
    
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
    IF (enable = '1') THEN      
      tmpq <= data;
    END IF;
  end dlatch_v;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------            
  procedure dlatchc_v
    ( signal data              : in std_logic_vector;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector)
  is
    
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
    IF (clear = '1') THEN
      tmpq <= (OTHERS=>'0');
    ELSIF (enable = '1') THEN      
      tmpq <= data AND data;
    END IF;
  end dlatchc_v;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------            
  procedure dlatchp_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector)
  is
    
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
    IF (preset = '1') THEN
      tmpq <= (OTHERS=>'1');
    ELSIF (enable = '1') THEN      
      tmpq <= data AND data;
    END IF;
  end dlatchp_v;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------            
  procedure dlatchpc_v
    ( signal data              : in std_logic_vector;
      signal preset            : in std_logic;
      signal clear             : in std_logic;
      signal enable            : in std_logic;
      signal q                 : out std_logic_vector)
  is
    
    constant size: integer := q'length-1;
    alias tmpq: std_logic_vector(size downto 0) IS q;

  begin
    IF (preset = '1') THEN
      tmpq <= (OTHERS=>'1');
    ELSIF (clear = '1') THEN
      tmpq <= (OTHERS=>'0');
    ELSIF (enable = '1') THEN      
      tmpq <= data AND data;
    END IF;
  end  dlatchpc_v;
-------------------------------------------------------------------------------
--  
-------------------------------------------------------------------------------
end proc_std;
















