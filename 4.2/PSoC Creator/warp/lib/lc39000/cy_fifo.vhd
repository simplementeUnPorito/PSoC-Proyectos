--

--
-- CY_FIFO
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;
use work.rtlpkg.all;
use cypress.lpmpkg.all;
entity cy_fifo is
    generic(lpm_width : positive := 1;
     lpm_numwords: positive := 1;
     lpm_pafe_length : natural := 0;
     lpm_hint : goal_type := SPEED);
    port (data : in std_logic_vector(lpm_width-1 downto 0);
     q : out std_logic_vector(lpm_width-1 downto 0);
     enr : in std_logic;
     enw : in std_logic;
     readclock : in std_logic;
     writeclock : in std_logic;
     mrb : in std_logic;
     efb : out std_logic;
     hfb : out std_logic;
     pafeb : out std_logic);
end cy_fifo;

architecture c39k of cy_fifo is
begin

    u1: cy_C39KFIFO
    generic map(datawidth => lpm_width,
                numwords => lpm_numwords,
                pafe_distance => lpm_pafe_length)
    port map( din => data,
                dout => q,
                enr => enr,
                enw => enw,
                ckr => readclock,
                ckw => writeclock,
                mrb => mrb,
                efb => efb,
                hfb => hfb,
                pafeb => pafeb);
end c39k;
