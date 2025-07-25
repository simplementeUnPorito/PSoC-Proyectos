-- /*******************************************************************************
-- * Copyright 1992-1996, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

PACKAGE TEXTIO IS

--  Type definitions for Text I/O.
  TYPE Line IS access String;
  TYPE Text IS file of String;
  TYPE Side IS (Right, Left);
  SUBTYPE Width IS Natural;

--  Standard text files.
  FILE Input : Text IS in "STD_INPUT";
  FILE Output : Text IS out "STD_OUTPUT";

--  Input routines for standard types.
  PROCEDURE Readline (F:in Text; L:out Line);

  PROCEDURE Read (L:inout Line; Value:out Bit; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out Bit);
  
  PROCEDURE Read (L:inout Line; Value:out Bit_vector; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out Bit_vector);

  PROCEDURE Read (L:inout Line; Value:out Boolean; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out Boolean);
  
  PROCEDURE Read (L:inout Line; Value:out Character; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out Character);
  
  PROCEDURE Read (L:inout Line; Value:out Integer; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out Integer);
  
  PROCEDURE Read (L:inout Line; Value:out String; Good:out Boolean);
  PROCEDURE Read (L:inout Line; Value:out String);

--  Output routines for standard types.
  PROCEDURE Writeline(F:out Text; L:in Line);

  PROCEDURE Write (L:inout Line; Value:in Bit;
                       Justified:in Side := Right; Field:in Width := 0);
  
  PROCEDURE Write (L:inout Line; Value:in Bit_vector;
                       Justified:in Side := Right; Field:in Width := 0);
  
  PROCEDURE Write (L:inout Line; Value:in Boolean;
                       Justified:in Side := Right; Field:in Width := 0);
  
  PROCEDURE Write (L:inout Line; Value:in Character;
                       Justified:in Side := Right; Field:in Width := 0);
  
  PROCEDURE Write (L:inout Line; Value:in Integer;
                       Justified:in Side := Right; Field:in Width := 0);
  
  PROCEDURE Write (L:inout Line; Value:in String;
                       Justified:in Side := Right; Field:in Width := 0);
  
-------------------------------------------------------------------------------
--  Attributes for identifying the above as builtins:
-------------------------------------------------------------------------------
attribute fileio_builtin of Readline:procedure is FR_read_line;
attribute fileio_builtin of Read:procedure is FR_textio_read;
attribute fileio_builtin of Writeline:procedure is FR_write_line;
attribute fileio_builtin of Write:procedure is FR_textio_write;

END TEXTIO;
