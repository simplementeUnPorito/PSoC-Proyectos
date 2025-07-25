--

--
-- MPARITY
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mparity is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (data : in std_logic_vector (lpm_width - 1 downto 0);
     even : out std_logic;
     odd : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end mparity;

architecture archlpmstd of Mparity is

    CONSTANT slice : integer := 4;

    signal result : std_logic_vector (((Data'length+slice-1)/slice*
                                 (Data'length+slice-1)/slice) downto 0);
    attribute synthesis_off of result:signal is true;

begin

    Parity_Gen: process (Data,clock,aclr)
        variable datain : std_logic_vector (Data'range);
        variable length : integer; -- Length of the next parity tree
        variable pLength: integer; -- Length of the current parity tree
        variable index : integer; -- Loop count
        variable offset : integer; -- Offset for each level of parity tree
        variable last : std_logic; -- Stores the last XOR ever done

    begin
        pLength := Data'length;
        offset := (Data'length+(slice-1)) / slice;
        index := 0;
        last := '0';
        while ( pLength > 0 ) loop
            length := (plength+(slice-1)) / slice;
            if (index = 0) then
                datain := Data;
            else
                for i in plength-1 downto 0 loop
                    datain(i) := result(((index-1) * offset) + i);
                end loop;
            end if;
            for i in 0 to length - 1 loop
                last := datain(i*slice);
                for j in 1 to slice-1 loop
                    if (i*slice+j) < plength then
                        last := last XOR datain(i*slice+j);
                    end if;
                end loop;

                result((index * offset) + i) <= last;

            end loop;
            if (length = 1) then
                plength := 0;
            else
                plength := length;
            end if;
            index := index + 1;
        end loop;
        assert (lpm_pipeline <= 0)
        report "Mparity pipeline not allowed for this device.  Disabling pipe."
        severity note;
        odd <= last;
        even <= NOT last;

    end process parity_gen;

end archlpmstd;
