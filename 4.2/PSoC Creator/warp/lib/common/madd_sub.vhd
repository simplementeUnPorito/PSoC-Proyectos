--

--
-- MADD_SUB
--
library ieee;
use ieee.std_logic_1164.all;
library cypress;

use cypress.rtlpkg.cy_buf;

use cypress.lpmpkg.all;
entity madd_sub is
    generic(lpm_width : positive := 1;
     lpm_representation : repre_type := LPM_UNSIGNED;
     lpm_direction : arith_type := LPM_NO_TYP;
     lpm_hint : goal_type := SPEED;
     lpm_pipeline: natural := 0);
    port (dataa : in std_logic_vector(lpm_width-1 downto 0);
     datab : in std_logic_vector(lpm_width-1 downto 0);
     cin : in std_logic := zero;
     add_sub : in std_logic := one;
     result : out std_logic_vector(lpm_width-1 downto 0);
     cout : out std_logic;
     overflow : out std_logic;
     clock : in std_logic := zero;
     aclr : in std_logic := zero);
end madd_sub;

architecture archlpmstd of Madd_sub is

    signal c,ci,e,ei,r,ri,rtmp : std_logic_vector(result'length downto 0);

begin

    GA: if (((port_state(add_sub) = ps_tied_high)
               AND (lpm_direction = lpm_no_typ))
                OR (lpm_direction = lpm_add)) generate
        G0: if (lpm_width = 1) generate
            rtmp(0) <= (dataA(0) XOR dataB(0)) XOR cin;
            c(1) <= (dataA(0) AND dataB(0)) OR
                    (dataA(0) AND cin) OR
                    (dataB(0) AND cin);
        end generate;
        G1: if (lpm_width > 1) generate
            rtmp(0) <= (dataA(0) XOR dataB(0)) XOR cin;
            rtmp(1) <= (dataA(1) XOR dataB(1)) XOR
                        ((dataA(0) AND dataB(0)) OR (dataA(0) AND cin) OR
                                      (dataB(0) AND cin));
            c(0) <= ((dataA(0) AND dataB(0) AND dataA(1)) OR
                         (dataA(0) AND dataB(0) AND dataB(1)) OR
                              (cin AND dataB(0) AND dataA(1)) OR
                              (cin AND dataB(0) AND dataB(1)) OR
                         (dataA(0) AND cin AND dataA(1)) OR
                         (dataA(0) AND cin AND dataB(1)) OR
                         (dataA(1) AND dataB(1)));

            UA0: cy_buf port map (c(0), c(2));
            ci(2) <= c(2);
        end generate;

        T1: if (result'length/2) /= 0 generate
            GA0: for h in 1 to ((result'length/2)-1) generate
                rtmp(2*h) <= ((dataA(2*h) XOR dataB(2*h)) XOR c(2*h));
                rtmp(2*h+1) <= ((dataA(2*h+1) XOR dataB(2*h+1)) XOR
                                  ((dataA(2*h) AND dataB(2*h)) OR
                                   (dataA(2*h) AND c(2*h)) OR
                                   (dataB(2*h) AND c(2*h))));
                GAS: if (lpm_hint = SPEED) generate
                    ei(2*h+2) <= ((dataA(2*h+1) AND dataB(2*h+1)) OR
                                  ((dataA(2*h+1) OR dataB(2*h+1)) AND
                                   (dataA(2*h) AND dataB(2*h))));
                    ri(2*h+2) <= ((dataA(2*h+1) OR dataB(2*h+1)) AND
                                   (dataA(2*h) OR dataB(2*h)));
                    ci(2*h+2) <= e(2*h+2) OR (ci(2*h) AND r(2*h+2));
                    U1: cy_buf port map (ei(2*h+2),e(2*h+2));
                    U2: cy_buf port map (ri(2*h+2),r(2*h+2));
                end generate;
                GAA: if (lpm_hint /= SPEED) generate
                    ci(2*h+2) <=((dataA(2*h) AND dataB(2*h) AND dataA(2*h+1)) OR
                                 (dataA(2*h) AND dataB(2*h) AND dataB(2*h+1)) OR
                                     (c(2*h) AND dataB(2*h) AND dataA(2*h+1)) OR
                                     (c(2*h) AND dataB(2*h) AND dataB(2*h+1)) OR
                                 (dataA(2*h) AND c(2*h) AND dataA(2*h+1)) OR
                                 (dataA(2*h) AND c(2*h) AND dataB(2*h+1)) OR
                                 (dataA(2*h+1) AND dataB(2*h+1)));
                end generate;
                U3: cy_buf port map (ci(2*h+2),c(2*h+2));
            end generate;
        end generate;

        GA1: if (((result'length rem 2) /= 0) AND result'length /= 1) generate
            rtmp(result'high) <= ((dataA(result'high) XOR dataB(result'high))
                                        XOR c(result'high));
            c(result'length) <= ((dataA(result'high) AND dataB(result'high)) OR
                                 (dataA(result'high) AND c(result'high)) OR
                                 (dataB(result'high) AND c(result'high)));
        end generate;
   end generate;

    GS: if (((port_state(add_sub) = ps_tied_low)
               AND (lpm_direction = lpm_no_typ))
                OR (lpm_direction = lpm_sub)) generate
        G0: if (lpm_width = 1) generate
            rtmp(0) <= NOT(NOT dataA(0) XOR dataB(0)) XOR NOT cin;
            c(1) <= (NOT dataA(0) AND dataB(0)) OR
                    (NOT dataA(0) AND NOT cin) OR
                    (dataB(0) AND NOT cin);
        end generate;
        G1: if (lpm_width > 1) generate
            rtmp(0) <= (NOT(NOT(dataA(0) XOR dataB(0)) XOR NOT cin));
            rtmp(1) <= (NOT(NOT(dataA(1) XOR dataB(1)) XOR
                     ((NOT dataA(0) AND dataB(0)) OR
                      (NOT dataA(0) AND NOT cin) OR (dataB(0) AND NOT cin))));
            c(0) <= ((NOT dataA(0) AND dataB(0) AND NOT dataA(1)) OR
                      (NOT dataA(0) AND dataB(0) AND dataB(1)) OR
                           (NOT cin AND dataB(0) AND NOT dataA(1)) OR
                           (NOT cin AND dataB(0) AND dataB(1)) OR
                      (NOT dataA(0) AND NOT cin AND NOT dataA(1)) OR
                      (NOT dataA(0) AND NOT cin AND dataB(1)) OR
                      (NOT dataA(1) AND dataB(1)));
            US0: cy_buf port map (c(0), c(2));
            ci(2) <= c(2);
        end generate;

        T1: if (result'length/2) /= 0 generate
            GS0: for h in 1 to ((result'length/2)-1) generate
                rtmp(2*h)<= (NOT(NOT(dataA(2*h) XOR dataB(2*h)) XOR c(2*h)));
                rtmp(2*h+1) <= (NOT(NOT(dataA(2*h+1) XOR dataB(2*h+1)) XOR
                                 ((NOT dataA(2*h) AND dataB(2*h)) OR
                                  (NOT dataA(2*h) AND c(2*h)) OR
                                      (dataB(2*h) AND c(2*h)))));
                GSS: if (lpm_hint = SPEED) generate
                    ei(2*h+2) <= ((NOT dataA(2*h+1) AND dataB(2*h+1)) OR
                                 ((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                                  (NOT dataA(2*h) AND dataB(2*h))));
                    ri(2*h+2) <= ((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                                  (NOT dataA(2*h) OR dataB(2*h)));
                    ci(2*h+2) <= e(2*h+2) OR (ci(2*h) AND r(2*h+2));
                    U1: cy_buf port map (ei(2*h+2),e(2*h+2));
                    U2: cy_buf port map (ri(2*h+2),r(2*h+2));
                end generate;
                GSA: if (lpm_hint /= SPEED) generate
                ci(2*h+2)<=(NOT dataA(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h+1) AND dataB(2*h+1));
                end generate;
                U3: cy_buf port map (ci(2*h+2),c(2*h+2));
            end generate;
        end generate;

        GS1: if (((result'length rem 2) /= 0) AND result'length /= 1) generate
            rtmp(result'high) <= (NOT(NOT(dataA(result'high)
                                   XOR dataB(result'high)) XOR c(result'high)));
            c(result'length) <= ((NOT dataA(result'high) AND dataB(result'high))
                                OR (NOT dataA(result'high) AND c(result'high))
                                OR (dataB(result'high) AND c(result'high)));
        end generate;
    end generate;

    GB: if ((port_state(add_sub) = ps_connected)
              AND (lpm_direction = lpm_no_typ)) generate

        G0: if (lpm_width = 1) generate
            rtmp(0) <= (((dataA(0) XOR dataB(0)) XOR cin) AND add_sub) OR
                ((NOT(NOT dataA(0) XOR dataB(0)) XOR NOT cin) AND NOT add_sub);
            c(1) <= (((dataA(0) AND dataB(0)) OR
                    (dataA(0) AND cin) OR
                    (dataB(0) AND cin)) AND add_sub) OR
              (((NOT dataA(0) AND dataB(0)) OR
                    (NOT dataA(0) AND NOT cin) OR
                    (dataB(0) AND NOT cin)) AND NOT add_sub);
        end generate;
        G1: if (lpm_width > 1) generate
            rtmp(0) <= (((dataA(0) XOR dataB(0)) XOR cin) AND add_sub) OR
                (NOT(NOT(dataA(0) XOR dataB(0)) XOR NOT cin) AND NOT add_sub);

            rtmp(1) <= (((dataA(1) XOR dataB(1)) XOR
                       ((dataA(0) AND dataB(0)) OR ( dataA(0) AND cin) OR
                                     (dataB(0) AND cin))) AND add_sub) OR
                (NOT(NOT(dataA(1) XOR dataB(1)) XOR
                   ((NOT dataA(0) AND dataB(0)) OR (NOT dataA(0) AND NOT cin) OR
                                     (dataB(0) AND NOT cin))) AND NOT add_sub);

            c(0) <= (((dataA(0) AND dataB(0) AND dataA(1)) OR
                        (dataA(0) AND dataB(0) AND dataB(1)) OR
                             (cin AND dataB(0) AND dataA(1)) OR
                             (cin AND dataB(0) AND dataB(1)) OR
                        (dataA(0) AND cin AND dataA(1)) OR
                        (dataA(0) AND cin AND dataB(1)) OR
                        (dataA(1) AND dataB(1))) AND add_sub) OR
                  (((NOT dataA(0) AND dataB(0) AND NOT dataA(1)) OR
                    (NOT dataA(0) AND dataB(0) AND dataB(1)) OR
                         (NOT cin AND dataB(0) AND NOT dataA(1)) OR
                         (NOT cin AND dataB(0) AND dataB(1)) OR
                    (NOT dataA(0) AND NOT cin AND NOT dataA(1)) OR
                    (NOT dataA(0) AND NOT cin AND dataB(1)) OR
                    (NOT dataA(1) AND dataB(1))) AND NOT add_sub);

            UB0: cy_buf port map (c(0), c(2));

            ci(2) <= c(2);
        end generate;

        T1: if (lpm_width/2) /= 0 generate
            GB0: for h in 1 to ((lpm_width/2)-1) generate
                rtmp(2*h)<=((((dataA(2*h) XOR dataB(2*h)) XOR c(2*h)))
                        AND add_sub) OR
                    ((NOT(NOT(dataA(2*h) XOR dataB(2*h)) XOR c(2*h)))
                        AND NOT add_sub);
                rtmp(2*h+1) <= (((dataA(2*h+1) XOR dataB(2*h+1)) XOR
                               ((dataA(2*h) AND dataB(2*h)) OR
                                (dataA(2*h) AND c(2*h)) OR
                                (dataB(2*h) AND c(2*h)))) AND add_sub) OR
                        (NOT(NOT(dataA(2*h+1) XOR dataB(2*h+1)) XOR
                           ((NOT dataA(2*h) AND dataB(2*h)) OR
                            (NOT dataA(2*h) AND c(2*h)) OR
                                (dataB(2*h) AND c(2*h)))) AND NOT add_sub);

                GSS: if (lpm_hint = SPEED) generate
                  ei(2*h+2)<=(((dataA(2*h+1) AND dataB(2*h+1)) OR
                              ((dataA(2*h+1) OR dataB(2*h+1)) AND
                               (dataA(2*h) AND dataB(2*h)))) AND add_sub)
                      OR (((NOT dataA(2*h+1) AND dataB(2*h+1)) OR
                          ((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                           (NOT dataA(2*h) AND dataB(2*h)))) AND NOT add_sub);
                  ri(2*h+2)<=(((dataA(2*h+1) OR dataB(2*h+1)) AND
                               (dataA(2*h) OR dataB(2*h))) AND add_sub)
                      OR (((NOT dataA(2*h+1) OR dataB(2*h+1)) AND
                           (NOT dataA(2*h) OR dataB(2*h))) AND NOT add_sub);

-- If this is a multiple of 32, then use the buffered version of C.
                    GBX: if ((2*h rem 32) = 0) generate
                        ci(2*h+2) <= e(2*h+2) OR ( c(2*h) AND r(2*h+2));
                    end generate;
                    GBY: if ((2*h rem 32) /= 0) generate
                        ci(2*h+2) <= e(2*h+2) OR (ci(2*h) AND r(2*h+2));
                    end generate;
                    U1: cy_buf port map (ei(2*h+2),e(2*h+2));
                    U2: cy_buf port map (ri(2*h+2),r(2*h+2));

                end generate;
                GAA: if (lpm_hint /= SPEED) generate
                  ci(2*h+2)<=(((dataA(2*h) AND dataB(2*h) AND dataA(2*h+1))
                        OR (dataA(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataA(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (dataA(2*h) AND c(2*h) AND dataA(2*h+1))
                        OR (dataA(2*h) AND c(2*h) AND dataB(2*h+1))
                        OR (dataA(2*h+1) AND dataB(2*h+1)))
                                                AND add_sub) OR
                         (((NOT dataA(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND NOT dataA(2*h+1))
                        OR (c(2*h) AND dataB(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND NOT dataA(2*h+1))
                        OR (NOT dataA(2*h) AND c(2*h) AND dataB(2*h+1))
                        OR (NOT dataA(2*h+1) AND dataB(2*h+1)))
                                                AND NOT add_sub);
                end generate;

                U3: cy_buf port map (ci(2*h+2),c(2*h+2));

            end generate;
        end generate;

        GB1: if (((lpm_width rem 2) /= 0) AND lpm_width /= 1) generate
            rtmp(result'high) <= ((((dataA(result'high) XOR
                                         dataB(result'high)) XOR
                                             c(result'high))) AND add_sub)
                            OR ((NOT(NOT(dataA(result'high) XOR
                                         dataB(result'high)) XOR
                                             c(result'high))) AND NOT add_sub);

            c(result'length) <= (((dataA(result'high) AND dataB(result'high)) OR
                           (dataA(result'high) AND c(result'high)) OR
                           (dataB(result'high) AND c(result'high))) AND add_sub)

                  OR (((NOT dataA(result'high) AND dataB(result'high)) OR
                       (NOT dataA(result'high) AND c(result'high)) OR
                           (dataB(result'high) AND c(result'high))) AND NOT add_sub);
        end generate;

    end generate;
    assert (lpm_pipeline <= 0)
    report "Madd_sub pipeline not allowed for this device.  Disabling pipe."
    severity note;

    result <= rtmp(lpm_width-1 downto 0);
    cout <= c(result'length)
        when (((lpm_direction = lpm_no_typ) AND (add_sub = '1')) OR
                lpm_direction = lpm_add) else
        NOT c(result'length);
    overflow <= ((rtmp(result'high) AND
             NOT dataA(result'high) AND NOT dataB(result'high)) OR
             (NOT rtmp(result'high) AND
                 dataA(result'high) AND dataB(result'high)))
        when (((lpm_direction = lpm_no_typ) AND (add_sub = '1')) OR
                lpm_direction = lpm_add) else
                ((rtmp(result'high) AND
             NOT dataA(result'high) AND dataB(result'high)) OR
             (NOT rtmp(result'high) AND
                 dataA(result'high) AND NOT dataB(result'high)));

end archlpmstd;
