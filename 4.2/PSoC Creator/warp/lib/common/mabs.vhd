--

--
-- MABS
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use cypress.lpmpkg.all;
entity mabs is
    generic(lpm_width : positive := 1;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     result : out std_logic_vector(lpm_width-1 downto 0);
     overflow : out std_logic);
end mabs;

architecture archlpmstd of Mabs is

    signal switch,tmp : std_logic_vector(result'high downto 0);

begin

    switch(0) <= data(0) AND data(data'high);
    tmp(0) <= data(0);

    G0:for i in 1 to lpm_width-1 generate
        switch(i) <= (switch(i-1) OR data(i)) AND data(data'high);
        tmp(i) <= switch(i-1) XOR data(i);
    end generate;

    result <= tmp;
    overflow <= NOT switch(switch'high-1) AND tmp(tmp'high);

end archlpmstd;
