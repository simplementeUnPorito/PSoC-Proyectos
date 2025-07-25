--
library ieee;
use ieee.std_logic_1164.all;
PACKAGE table_std IS
    TYPE ttf_table IS ARRAY (NATURAL RANGE <>,NATURAL RANGE<>) OF std_logic;

    FUNCTION ttf (
        CONSTANT tt : ttf_table;
        ci : std_logic_vector
    )
    RETURN std_logic_vector;

END table_std;

PACKAGE BODY table_std IS

    FUNCTION ttf (
        CONSTANT tt : ttf_table;
        ci : std_logic_vector
    )
    RETURN std_logic_vector IS

        VARIABLE tmpbool : BOOLEAN;
        CONSTANT csi_lim : INTEGER := tt'LENGTH(2) - ci'LENGTH - 1;
        VARIABLE tmpv : std_logic_vector(0 TO csi_lim) := (OTHERS=>'0');
    BEGIN

        FOR table_row IN tt'RANGE LOOP

            tmpbool := TRUE;

            FOR col IN ci'RANGE LOOP
                tmpbool := tmpbool AND (

                        (tt(table_row, col) = '-')

                    OR ((tt(table_row, col) = '1') AND (ci(col) = '1'))
                    OR ((tt(table_row, col) = '0') AND (ci(col) = '0'))
                );
            END LOOP;

            IF tmpbool THEN
                FOR csi IN 0 TO csi_lim LOOP
                    IF (tt(table_row, ci'LENGTH + csi) = '1') THEN
                        tmpv(csi) := '1';
                    END IF;
                END LOOP;
            END IF;
        END LOOP;

        RETURN tmpv;
    END;

END table_std;
