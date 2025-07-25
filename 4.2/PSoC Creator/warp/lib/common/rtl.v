/*******************************************************************************
* Copyright 1997, 1999, 2009, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

`ifdef RTL_ALREADY_INCLUDED
    // Only include the rest of this file once.
`else
`define RTL_ALREADY_INCLUDED

`define DIRECT		0
`define CLOCK_TREE	1
`define EXTERNAL	2

`ifdef WARP
// This file is intended for simulation only.  Do not use for synthesis.
`else
// Some handy defines:
`define FALSE 0
`define TRUE  1

`timescale 1ps/1ps

//
// 	bufoe
//

module cy_bufoe (x, oe, y, yfb);
    input   x;
    input   oe;
    inout   y;
    output  yfb;

    reg     ytemp;
    wire    y;
    reg     yfb;

    always @(x or oe)
	if (oe == 1'b 1)
	    if (x == 1'b 0)
		ytemp <= 1'b 0;	
	    else if (x == 1'b 1)
		ytemp <= 1'b 1;	
	    else
		ytemp <= 1'b x;	
	else
	    ytemp <= 1'b Z;	

    always @(y)
	if (y == 1'b 1)
	    yfb <= 1'b 1;	
	else if (y == 1'b 0)
	    yfb <= 1'b 0;	
	else
	    yfb <= 1'b x;	
    assign y = ytemp;
endmodule


//
// 	dltch
//

module cy_dltch (d, e, q);
    input   d;
    input   e;
    output  q;

    wire    q;
    wire    qx;

    assign qx = d & e | d & qx | ~ e & qx;
    assign q = qx;
endmodule

//
// 	dff
//

module cy_dff (d, clk, q);
    input   d;
    input   clk;
    output  q;

    reg     q;

    always @(posedge clk) q <= d;	
endmodule

//
// 	xdff
//

module cy_xdff (x1, x2, clk, q);
    input   x1;
    input   x2;
    input   clk;
    output  q;

    wire    q;
    wire    dx;

    cy_dff U1 (.d(dx), .clk(clk), .q(q));
    assign dx = x1 ^ x2;
endmodule

//
//	jkff
//

module cy_jkff (j, k, clk, q);
    input   j;
    input   k;
    input   clk;
    output  q;

    wire    q;
    wire    qx;
    wire    dx;

    assign dx = j & ~qx | ~k & qx;
    cy_dff U1 (.d(dx), .clk(clk), .q(qx));
    assign q = qx;
endmodule

//
// 	buf
//

module cy_buf (x, y);
    input   x;
    output  y;

    wire    y;

    assign y = x;
endmodule

//
// 	srlch
//

module cy_srlch (s, r, q);
    input   s;
    input   r;
    output  q;

    wire    q;
    wire    qx;

    assign qx = s & ~r | qx & ~ r;
    assign q = qx;
endmodule

//
// 	srff
//

module cy_srff (s, r, clk, q);
    input   s;
    input   r;
    input   clk;
    output  q;

    wire    q;
    wire    qx;
    wire    dx;

    assign dx = ~((~s | r) & (~ qx | r));
    cy_dff U1 (.d(dx), .clk(clk), .q(qx));
    assign q = qx;
endmodule

//
// 	dsrff
//

module cy_dsrff (d, s, r, clk, q);
    input   d;
    input   s;
    input   r;
    input   clk;
    output  q;

    reg     q;

    always @(posedge r or posedge s or posedge clk)
	if (r == 1'b 1)
	    q <= 1'b 0;	
	else if (s == 1'b 1)
	    q <= 1'b 1;	
	else
	    q <= d;	
endmodule

//
// 	tsrff
//

module cy_tsrff (t, s, r, clk, q);
    input   t;
    input   s;
    input   r;
    input   clk;
    output  q;

    wire    q;
    reg     qtmp;

    initial qtmp = 1'b 0;	

    always @(posedge r or posedge s or posedge clk)
	if (r == 1'b 1)
	    qtmp <= 1'b 0;	
	else if (s == 1'b 1)
	    qtmp <= 1'b 1;	
	else
	    qtmp <= qtmp ^ t;	
    assign q = qtmp;
endmodule

//
// 	tff
//

module cy_tff (t, clk, q);
    input   t;
    input   clk;
    output  q;

    wire    q;
    wire    qx;
    wire    dx;

    assign dx = t ^ qx;
    cy_dff U1 (.d(dx), .clk(clk), .q(qx));
    assign q = qx;
endmodule

//
// 	xbuf
//

module cy_xbuf (x1, x2, q);
    input   x1;
    input   x2;
    output  q;

    wire    q;

    assign q = x1 ^ x2;
endmodule

//
// 	triout
//

module cy_triout (x, oe, y);
    input   x;
    input   oe;
    output  y;

    reg     y;

    always @(x or oe)
	if (oe == 1'b 1)
	    if (x == 1'b 0)
		y <= 1'b 0;	
	    else if (x == 1'b 1)
		y <= 1'b 1;	
	    else
		y <= 1'b x;	
	else
	    y <= 1'b Z;	
endmodule

//
// 	dsrlch
//

module cy_dsrlch (d, s, r, e, q);
    input   d;
    input   s;
    input   r;
    input   e;
    output  q;

    wire    q;
    wire    qi;

    assign qi = ~r & (s | d & e | qi & ~e);
    assign q = qi;
endmodule

//
// 	dsrffe
//

module cy_dsrffe (d, s, r, e, clk, q);
    input   d;
    input   s;
    input   r;
    input   e;
    input   clk;
    output  q;

    reg     q;

    always @(posedge r or posedge s or posedge clk)
	if (r == 1'b 1)
	    q <= 1'b 0;	
	else if (s == 1'b 1)
	    q <= 1'b 1;	
	else if (e == 1'b 1)
	    q <= d;	
endmodule

//
// 	cy_c39kcarry
//

module cy_c39kcarry (selin, cpt0, cpt1, selout);
    input   selin;
    input   cpt0;
    input   cpt1;
    output  selout;

    wire    selout;

    assign selout = (~selin & cpt0) | (selin & ~cpt1);
endmodule

//
// 	cy_c39kxor
//

module cy_c39kxor (sin, ptmpts, xorout);
    input   sin;
    input   ptmpts;
    output  xorout;

    wire    xorout;

    assign xorout = sin ^ ptmpts;
endmodule

//
// 	cy_softbuffer
//

module cy_softbuffer (bufin, bufout);
    input   bufin;
    output  bufout;

    wire    bufout;

    assign bufout = bufin;
endmodule

//
//	cy_c39kmultiply
//

module cy_c39kmultiply (data_a, data_b, product);

    parameter issigned = `FALSE;
    parameter datawidtha = 1;
    parameter datawidthb = 1;
    parameter datawidthp = 2;
    parameter hint = 3;
    input   [datawidtha-1:0] data_a;
    input   [datawidthb-1:0] data_b;
    output  [datawidthp-1:0] product;

    reg	[datawidtha-1:0] a,swa;
    reg	[datawidthb-1:0] b,swb;
    integer	tp,p,swp;
    integer	i;

    reg	[datawidthp-1:0] r;

    initial
	if ((issigned) & ((datawidtha <= 1) | (datawidthb <= 1)))
	begin
	    $display("Signed multiply with input lengths of 1 are illegal.\n");
	    $finish;
	end

    always @(data_a or data_b)
    begin
	if (issigned)
	begin
	    a[0] = data_a[0];
	    swa[0] = data_a[0] & data_a[datawidtha-1];
	    for (i = 1; i <= datawidtha-1; i = i + 1)
	    begin
		swa[i] = (swa[i-1] | data_a[i]) & data_a[datawidtha-1];
		a[i] =  swa[i-1] ^ data_a[i];
	    end

	    b[0] = data_b[0];
	    swb[0] = data_b[0] & data_b[datawidthb-1];
	    for (i = 1; i <= datawidthb-1; i = i + 1)
	    begin
		swb[i] = (swb[i-1] | data_b[i]) & data_b[datawidthb-1];
		b[i] =  swb[i-1] ^ data_b[i];
	    end

	    tp = a * b;

	    if (data_a[datawidtha-1] != data_b[datawidthb-1])
	    begin
		p[0] = tp[0];
		swp[0] = tp[0];
		for (i = 1; i <= datawidthp-1; i = i + 1)
		begin
		    swp[i] = (swp[i-1] | tp[i]);
		    p[i] =  swp[i-1] ^ tp[i];
		end
	    end
	    else
		p = a * b;
	end
	else
	    p = data_a * data_b;

	r = p;

    end

    assign product = r;

endmodule

//
//	cy_c39kpll
//

module cy_c39kpll (pll_in, ext_fdbk, lock_detect, gclk0, gclk1, gclk2, gclk3);

    parameter feedback = `DIRECT;
    parameter multiply = 1;
    parameter gclk0_phase  = 0;
    parameter gclk0_divide = 1;
    parameter gclk1_phase  = 0;
    parameter gclk1_divide = 1;
    parameter gclk2_phase  = 0;
    parameter gclk2_divide = 1;
    parameter gclk3_phase  = 0;
    parameter gclk3_divide = 1;
    parameter input_freq = 0;
    parameter ext_fdbk_delay_ps = 0;
    parameter ext_fdbk_port_out = "NULL";
    input pll_in;
    input ext_fdbk;
    output lock_detect;
    output gclk0;
    output gclk1;
    output gclk2;
    output gclk3;

    reg		feedbacksig;
    reg		int_fdbk;
    reg		tmp_fdbk;
    reg		vco;
    reg		lock;
    reg		syncb;
    time	cyc;
    wire[3:0]	tmpglclk;
    reg [3:0]	tmpgclk;
    wire[3:0]	xclk;
    reg [3:0]	pllclk;
    reg [7:0]	pllout;
    reg		clock;
    reg		tracking;
    reg		switch;
    reg		speedup;
    reg		slowdown;
    reg		killvco;

    time	clkedge;
    time	ckwidth;
    time	kpwidth;
    time	fbwidth;
    time	fbevent;
    integer	mult;

    reg [8:0] divide [3:0];
    reg [8:0] phase  [3:0];


    initial
    begin : INTIIALIZE
	parameter	LockTime= 3000000;
	clock = 1'b0;	
	syncb = 1'b1;	
	lock = 1'b0;	
	feedbacksig = 1'b0;	
	ckwidth = 0;
	killvco = 0;

	divide[3] <= gclk3_divide;
	divide[2] <= gclk2_divide;
	divide[1] <= gclk1_divide;
	divide[0] <= gclk0_divide;

	phase[3]  <= gclk3_phase;
	phase[2]  <= gclk2_phase;
	phase[1]  <= gclk1_phase;
	phase[0]  <= gclk0_phase;
    end

    // Input Clock Frequency Check
    always @(posedge pll_in)
    begin : CLK_CHK
	time ckhi;
	real freq;
	if ($time > 0)
	begin
	    freq = 1000000000000.0 / ($time - ckhi);
	    if (((freq > input_freq * 1.01)  |
		 (freq < input_freq * 0.99)) &
		 (input_freq !== 0))
	    begin
		$write("warning: ");
		$display("Input frequency is outside the specified range.");
		$display("Time: ", $time);
	    end
	end
	ckhi = $time;  
    end


    always @(int_fdbk or ext_fdbk)
    begin : FEEDBACK
	case (feedback)
	`EXTERNAL:
	    feedbacksig <= ext_fdbk;
	`CLOCK_TREE:
	    feedbacksig <= int_fdbk;
	`DIRECT:
	    feedbacksig <= int_fdbk;
	default:
	begin
	    $write("failure: ");
	    $display("Illegal PLL feedback select.");
	    $display("Time: ", $time);
	end
	endcase
    end


    time fbkedge;
    integer i;
    always @(pll_in)			clkedge = $time;
    always @(posedge feedbacksig)	fbkedge = $time;

    time ckevent;
    initial ckevent = 0;
    always @(posedge pll_in)
    begin : CLOCK_WIDTH
	if ((ckwidth == 0) || ($time != ckevent))
	begin
	    kpwidth = ckwidth;
	    ckwidth = $time - ckevent;
	    ckevent = $time;
	end
    end

    always @(posedge feedbacksig)
    begin : FEEDBACK_WIDTH
	fbwidth = $time - fbevent;
	fbevent = $time;
    end

    always @(clkedge or fbkedge)
    begin : process_1
	time	width;
	time	ckevent;
	parameter Jitter   = 0.01;
	parameter LockTime = 500000;

	case (multiply)
	16: mult = 5'b10000;	
	 8: mult = 4'b 1000;	
	 6: mult = 4'b  110;	
	 5: mult = 4'b  101;	
	 4: mult = 3'b  100;	
	 3: mult = 2'b   11;	
	 2: mult = 2'b   10;	
	 1: mult = 1'b    1;	
	default:
	begin
	    $write("failure: ");
	    $display("Illegal PLL multiply mode.");
	    $display("Time: ", $time);
	end
	endcase
	
	if (fbkedge == $time)
	begin
	    if ((((ckwidth-fbwidth > ckwidth*Jitter)
	       || (fbwidth-ckwidth > ckwidth*Jitter)) && (lock == 1'b1))
	       ||((ckwidth-kpwidth > ckwidth*Jitter)
	       || (kpwidth-ckwidth > ckwidth*Jitter))
	       || (fbevent == fbwidth))
	    begin
		lock  <= 1'b0;	
		syncb <= 1'b1;	
	    end
	end

	if (((clkedge == $time) && (pll_in == 1'b1)) || (fbkedge == $time))
	begin
	    if (fbkedge == $time && $time > 0)
		switch <= 1'b1;
	    if (switch == 1'b0)
	    begin
		speedup  <= 1'b0;
		slowdown <= 1'b0;
	    end
	    else if (fbkedge == $time)
	    begin
	    if (((ckwidth-fbwidth < ckwidth*(Jitter/10.0)) ||
		 (fbwidth-ckwidth < ckwidth*(Jitter/10.0))))
		begin
		    speedup  <= 1'b0;
		    slowdown <= 1'b0;
		    #(LockTime/10);
		    syncb   <= 1'b0;
		    #(LockTime*9/10);
		    lock <= 1'b1;
		end
		else if (ckwidth > fbwidth)
		begin
		    speedup  <= 1'b0;
		    slowdown <= 1'b1 && syncb;
		end
		else if (ckwidth < fbwidth)
		begin
		    speedup  <= 1'b1 && syncb;
		    slowdown <= 1'b0;
		end
		else
		begin
		    speedup  <= 1'b0;
		    slowdown <= 1'b0;
		    #(LockTime/10);
		    syncb   <= 1'b0;
		    #(LockTime*9/10);
		    lock <= 1'b1;
		    
		end
	    end
	end
    end

    // Let the VCO run free (at 145 MHz. initially).
    time vco_width;
    initial vco_width = 6875;
    always
    begin : VCO_GENERATION
	integer vco_i;
	if      ((speedup == 1'b1)  && (slowdown == 1'b0))
	    if (ckwidth + 1000 < fbwidth)
		vco_width = vco_width - 100;
	    else
		vco_width = vco_width - 1;
	else if ((speedup == 1'b0)  && (slowdown == 1'b1))
	    if (ckwidth - 1000 > fbwidth)
		vco_width = vco_width + 100;
	    else
		vco_width = vco_width + 1;
	else if ((speedup == 1'b0)  && (slowdown == 1'b0) && (ckwidth > 0))
	    vco_width = ckwidth/(ckwidth/(vco_width - 5));

	cyc <= vco_width / 2;	

	for (vco_i = 1; vco_i <= 32; vco_i = vco_i + 1)
	begin
	    #(vco_width/2);
	    vco <= ~vco;	
	end
	if (killvco)
	    @ ( killvco ) 
	    $stop;
    end

    assign lock_detect = (tracking | (feedback !== `EXTERNAL)) ? lock : 1'b0;

    // Stop the VCO if the input clock is > 2X too slow after it has locked.
    always @(vco or clkedge)
    begin : VCO_KILL
    	time ckevent;
	if (clkedge == $time)
	    ckevent <= $time;
	if ($time-ckevent > 160000 && lock_detect == 1'b1)
	    killvco <= 1'b1;
	else
	    killvco <= 1'b0;
    end

    // VCO Frequency Check
    always @(posedge vco)
    begin : VCO_CHK
	parameter tmax = 10000;			// Min frequency = 100 MHz
	parameter tmin =  3750;			// Max frequency = 266 MHz
	time ckhi;
	if (syncb === 1'b0)
	begin
	    if (((($time - ckhi) < tmin) | (($time - ckhi) > tmax))
		& ($time !== ckhi))
	    begin
		$write("warning: ");
		$display("VCO frequency is outside its operating range.");
		$display("Time: ", $time);
	    end
	end
	ckhi = $time;  
    end

    always @(vco)
    begin : process_2
	time	width;
	time	edges;

	if ($time == 0)
	begin
	    width <= $time;	
	    edges <= $time;	
	end

	if (edges < $time)
	begin
	    width <= $time - edges;	
	    edges <= $time;	
	    pllout[7] <= #(width * 3 / 4) ~vco;
	    pllout[6] <= #(width * 2 / 4) ~vco;
	    pllout[5] <= #(width * 1 / 4) ~vco;
	    pllout[4] <= #(width * 0 / 4) ~vco;
	    pllout[3] <= #(width * 3 / 4)  vco;
	    pllout[2] <= #(width * 2 / 4)  vco;
	    pllout[1] <= #(width * 1 / 4)  vco;
	    pllout[0] <= #(width * 0 / 4)  vco;
	end
    end

    // Generate 4 clocks depending on the phase.
    assign xclk[3] =phase[3] === 315 ? pllout[7] : 
		    phase[3] === 270 ? pllout[6] : 
		    phase[3] === 225 ? pllout[5] : 
		    phase[3] === 180 ? pllout[4] : 
		    phase[3] === 135 ? pllout[3] : 
		    phase[3] ===  90 ? pllout[2] : 
		    phase[3] ===  45 ? pllout[1] : 
		    phase[3] ===   0 ? pllout[0] : 0; 
    assign xclk[2] =phase[2] === 315 ? pllout[7] : 
		    phase[2] === 270 ? pllout[6] : 
		    phase[2] === 225 ? pllout[5] : 
		    phase[2] === 180 ? pllout[4] : 
		    phase[2] === 135 ? pllout[3] : 
		    phase[2] ===  90 ? pllout[2] : 
		    phase[2] ===  45 ? pllout[1] : 
		    phase[2] ===   0 ? pllout[0] : 0; 
    assign xclk[1] =phase[1] === 315 ? pllout[7] : 
		    phase[1] === 270 ? pllout[6] : 
		    phase[1] === 225 ? pllout[5] : 
		    phase[1] === 180 ? pllout[4] : 
		    phase[1] === 135 ? pllout[3] : 
		    phase[1] ===  90 ? pllout[2] : 
		    phase[1] ===  45 ? pllout[1] : 
		    phase[1] ===   0 ? pllout[0] : 0; 
    assign xclk[0] =phase[0] === 315 ? pllout[7] : 
		    phase[0] === 270 ? pllout[6] : 
		    phase[0] === 225 ? pllout[5] : 
		    phase[0] === 180 ? pllout[4] : 
		    phase[0] === 135 ? pllout[3] : 
		    phase[0] ===  90 ? pllout[2] : 
		    phase[0] ===  45 ? pllout[1] : 
		    phase[0] ===   0 ? pllout[0] : 0; 

    //  Apply the divide amount to the clocks.
    always @(posedge vco)
    begin
	if ($time > 0)
	begin
	    tmp_fdbk <= 1'b 1;	
	    #( mult * cyc ); 
	    tmp_fdbk <= 1'b 0;	
	    #( (mult - 1'b 1) * cyc ); 
	end
    end

    always @(posedge xclk[3])
    begin
	if ($time > 0)
	begin
	    pllclk[3] <= 1'b 1;	
	    #( divide[3] * cyc ); 
	    pllclk[3] <= 1'b 0;	
	    #( (divide[3] - 1'b 1) * cyc ); 
	end
    end

    always @(posedge xclk[2])
    begin
	if ($time > 0)
	begin
	    pllclk[2] <= 1'b 1;	
	    #( divide[2] * cyc ); 
	    pllclk[2] <= 1'b 0;	
	    #( (divide[2] - 1'b 1) * cyc ); 
	end
    end

    always @(posedge xclk[1])
    begin
	if ($time > 0)
	begin
	    pllclk[1] <= 1'b 1;	
	    #( divide[1] * cyc ); 
	    pllclk[1] <= 1'b 0;	
	    #( (divide[1] - 1'b 1) * cyc ); 
	end
    end

    always @(posedge xclk[0])
    begin
	if ($time > 0)
	begin
	    pllclk[0] <= 1'b 1;	
	    #( divide[0] * cyc ); 
	    pllclk[0] <= 1'b 0;	
	    #( (divide[0] - 1'b 1) * cyc ); 
	end
    end

    assign tmpglclk = pllclk;

    //  compensate for external feedback
    always @(tmpglclk or fbkedge or clkedge)
    begin : EXCOMP
	time ckevent;
	time half;
	time var;

	if ((clkedge == $time) && (pll_in == 1'b1))
	    ckevent = $time;	
	if ((clkedge == $time) && (pll_in == 1'b0))
	    half = $time - ckevent;	

	if (syncb === 1'b 1)
	begin
	    if (fbkedge == $time)
		if ($time - ckevent < half)
		    var = 2 * half - ($time - ckevent);	
		else
		    var = 3 * half - ($time - ckevent);	
	    tmpgclk  <= tmpglclk;
	    int_fdbk <= tmp_fdbk;
	    tracking <= `FALSE;	
	end
	else
	begin
	    if (feedback === `EXTERNAL)
	    begin
		if (fbkedge == $time)
		    if ($time - ckevent > half)
			if (~tracking & (2 * half - ($time - ckevent) > 20))
			    var = var + 20;
			else
			begin
			    if (($time - ckevent) != 0)
				var = var + 1;
			    tracking <= `TRUE;	
			end
		    else
			if (~tracking & (($time - ckevent) > 20))
			    var = var - 20;
			else
			begin
			    if (($time - ckevent) != 0)
				var = var - 1;
			    tracking <= `TRUE;	
			end
		tmpgclk <= #(var) tmpglclk;
	    end
	    else
	    begin
		int_fdbk <= #(var - half) tmp_fdbk;
		tmpgclk  <= #(var - half) tmpglclk;
		tracking <= `TRUE;
	    end
	end
    end

    assign gclk0 = tmpgclk[0];
    assign gclk1 = tmpgclk[1];
    assign gclk2 = tmpgclk[2];
    assign gclk3 = tmpgclk[3];

endmodule

//
//	cy_c39kdualport
//

module cy_c39kdualport (din_a,din_b,addr_a,addr_b, wea, web, inclk_a, outclk_a,
		    outrega_ar, inclk_b, outclk_b, outregb_ar, dout_a, dout_b,);

parameter datawidth = 1;
parameter addresswidth = 1;
parameter indata_reg = `TRUE;
parameter add_ctrl_reg = `TRUE;
parameter outdataa_reg = `FALSE;
parameter outdatab_reg = `FALSE;
parameter filename = "";

input   [datawidth-1:0] din_a;
input   [datawidth-1:0] din_b;
input   [addresswidth-1:0] addr_a;
input   [addresswidth-1:0] addr_b;
output  [datawidth-1:0] dout_a;
output  [datawidth-1:0] dout_b;
input   wea;
input   web;
input   inclk_a;
input   inclk_b;
input   outclk_a;
input   outclk_b;
input   outrega_ar;
input   outregb_ar;

reg	[datawidth-1:0] dout_a;
reg	[datawidth-1:0] dout_b;
reg	[datawidth-1:0] dtmp_a;
reg	[datawidth-1:0] dtmp_b;
reg	[datawidth-1:0] qtmp_a;
reg	[datawidth-1:0] qtmp_b;
reg	[datawidth-1:0] mem [(2 << datawidth-1)-1:0];
reg	wreg_a;
reg	wreg_b;
reg	wtmp_a;
reg	wtmp_b;

integer atmp_a;
integer atmp_b;
integer i_a,i_b;

initial		// Pre-load the memory
    if (filename != "")
    begin
	$cy_hex2ver(filename, datawidth);
	$readmemh("vlg_data.ver", mem);
    end

always @(posedge inclk_a or addr_a)
    if (add_ctrl_reg)
	@(posedge inclk_a) atmp_a = addr_a;
    else
	atmp_a <= addr_a;

always @(posedge inclk_a or din_a)
    if (indata_reg)
	@(posedge inclk_a) dtmp_a = din_a;
    else
	dtmp_a <= din_a;

always @(posedge inclk_a or wea)
    if (indata_reg | add_ctrl_reg)
    begin
	@(posedge inclk_a) wreg_a = wea;
	assign wtmp_a = wreg_a & inclk_a;
    end
    else
	wtmp_a <= wea;

always @(posedge outrega_ar or posedge outclk_a or qtmp_a)
    if (outdataa_reg)
	if (outrega_ar == 1'b 1)
	    @(posedge outclk_a) dout_a <= {datawidth{1'b 0}};
	else
	    @(posedge outclk_a) dout_a <= qtmp_a;
    else
	dout_a <= qtmp_a;

always @(dtmp_a or atmp_a or wtmp_a or dtmp_b or atmp_b or wtmp_b)
begin
    if (wtmp_a == 1'b1 & wtmp_b == 1'b1 & atmp_a == atmp_b)
	mem[atmp_a] <= {datawidth{1'bx}};
    else
    begin
	if (wtmp_a == 1'b 1)
	    mem[atmp_a] <= dtmp_a;

	if (wtmp_b == 1'b 1)
	    mem[atmp_b] <= dtmp_b;
    end
    qtmp_a <= mem[atmp_a];
    qtmp_b <= mem[atmp_b];
end

always @(posedge inclk_b or addr_b)
    if (add_ctrl_reg)
	@(posedge inclk_b) atmp_b = addr_b;
    else
	atmp_b <= addr_b;

always @(posedge inclk_b or din_b)
    if (indata_reg)
	@(posedge inclk_b) dtmp_b = din_b;
    else
	dtmp_b <= din_b;

always @(posedge inclk_b or web)
    if (indata_reg | add_ctrl_reg)
    begin
	@(posedge inclk_b) wreg_b = web;
	assign wtmp_b = wreg_b & inclk_b;
    end
    else
	wtmp_b <= web;

always @(posedge outregb_ar or posedge outclk_b or qtmp_b)
    if (outdatab_reg)
	if (outregb_ar == 1'b 1)
	    @(posedge outclk_b) dout_b <= {datawidth{1'b 0}};
	else
	    @(posedge outclk_b) dout_b <= qtmp_b;
    else
	dout_b <= qtmp_b;

endmodule

//
//	cy_c39kfifo
//

module cy_c39kfifo(din,dout,enr,enw,ckr,ckw,mrb,efb,hfb,pafeb);

parameter datawidth = 1;
parameter numwords = 1;
parameter pafe_distance = 0;

input   [datawidth - 1:0] din;
output  [datawidth - 1:0] dout;
input   enr;
input   enw;
input   ckr;
input   ckw;
input   mrb;
output  efb;
output  hfb;
output  pafeb;

reg	[datawidth - 1:0] dout;
wire	efb;
wire	hfb;
wire	pafeb;
reg	[datawidth-1:0] mem [numwords-1:0];
reg	empt;
reg	half;
reg	full;
reg	paem;
reg	pafl;

integer  index;
integer  wadd;
integer  radd;
integer  i;

initial
begin
    wadd = 0;
    radd = 0;
    index= 0;
    full = 1'b 1;
    pafl = 1'b 1;
    paem = 1'b 0;
    empt = 1'b 0;
    half = 1'b 0;
end

always @(negedge mrb)
begin
    index = 0;
    wadd  = 0;
    radd  = 0;
    dout <= {datawidth{1'b 0}};
end

always @(posedge ckw)
    if (enw == 1'b 1 & full != 1'b 1 & mrb == 1'b1)
    begin
	mem[wadd] <= din;
	index = index + 1;
	if (wadd >= numwords - 1)
	    wadd = 0;
	else
	    wadd = wadd + 1;
    end

always @(posedge ckr)
    if (enr == 1'b 1 & empt != 1'b 1 & mrb == 1'b1)
    begin
	dout <= mem[radd];
	index = index - 1;
	if (radd >= numwords - 1)
	    radd = 0;
	else
	    radd = radd + 1;
    end

always @(posedge ckr)
begin
    if (index <= 0)
	empt = 1'b 0;
    else
	empt = 1'b 1;
    if (index >= numwords / 2)
	half = 1'b 0;
    else
	half = 1'b 1;
    if (index <= pafe_distance)
	paem = 1'b 0;
    else
	paem = 1'b 1;
end

always @(posedge ckw)
begin
    if (index >= numwords)
	full = 1'b 0;
    else
	full = 1'b 1;
    if (index >= numwords / 2)
	half = 1'b 0;
    else
	half = 1'b 1;
    if (numwords-index <= pafe_distance)
	pafl = 1'b 0;
    else
	pafl = 1'b 1;
end

assign hfb   = half;
assign efb   = full & empt;
assign pafeb = full & empt & pafl & paem;

endmodule

//
//	cy_c39ksingleport
//

module cy_c39ksingleport (din, addr, we, inclk, outclk, outreg_ar, dout);

parameter datawidth = 1;
parameter addresswidth = 1;
parameter indata_reg = `TRUE;
parameter addr_ctrl_reg = `TRUE;
parameter outdata_reg = `FALSE;
parameter filename = "";

input   [datawidth-1:0] din;
input   [addresswidth-1:0] addr;
output  [datawidth-1:0] dout;
input   inclk;
input   outclk;
input   we;
input   outreg_ar;

reg	[datawidth-1:0] dout;
reg	[datawidth-1:0] dtmp;
reg	[datawidth-1:0] qtmp;
reg	[datawidth-1:0] mem [(2 << datawidth-1)-1:0];
reg	wreg;
reg	wtmp;

integer	atmp;

initial		// Pre-load the memory
    if (filename != "")
    begin
	$cy_hex2ver(filename, datawidth);
	$readmemh("vlg_data.ver", mem);
    end

always @(posedge inclk or addr)
    if (addr_ctrl_reg)
	@(posedge inclk) atmp = addr;
    else
	atmp <= addr;

always @(posedge inclk or din)
    if (indata_reg)
	@(posedge inclk) dtmp = din;
    else
	dtmp <= din;

always @(posedge inclk or we)
    if (indata_reg | addr_ctrl_reg)
    begin
	@(posedge inclk) wreg = we;
	assign wtmp = wreg & inclk;
    end
    else
	wtmp <= we;

always @(dtmp or atmp or wtmp)
begin
    if (wtmp == 1'b 1)
	mem[atmp] <= dtmp;
    qtmp <= mem[atmp];
end

always @(posedge outreg_ar or posedge outclk or qtmp)
    if (outdata_reg)
	if (outreg_ar == 1'b 1)
	    @(posedge outclk) dout = {datawidth{1'b 0}};
	else
	    @(posedge outclk) dout = qtmp;
    else
	dout <= qtmp;

endmodule

`timescale 1ps/1fs

module cy_2gserdes_core (txd, txclki, txclko, rxd, rxclk, refclk, lfib, locked,
resetb, lockrefb, sd, fifo_err, fifo_rstb, pwrdnb, diagloop, lineloop, loopa,
loop_time, td_out, rd_in);

// Transmit path signals
input [15:0]  txd;
input txclki ;
output txclko ;

// Receive path signals
output [15:0] rxd;
output rxclk ;

// Device Control and Status Signals
input refclk;
output lfib ;
inout locked;
input resetb;
input lockrefb ;
input sd;
output fifo_err ;
input fifo_rstb ;
input pwrdnb ;

// Loop Control Signals
input diagloop ;
input lineloop ;
input loopa;
input loop_time;

// Serial I/O
output td_out;
input rd_in ;

// local declarations
reg [15:0] txd_reg ;
reg [15:0] rx_dat16, rx_dat16_bak ;
wire [15:0] fifo_out ;
reg [15:0] fifo_out_d ;
reg [15:0] fifo_out_2d ;
integer rx_sd_cnt16, rx_cnt16, cnt16, shiftcnt ;
reg out_1;
integer xx;
reg retimed_data ;
reg done16_rec, done16 ;

reg rxclk, txclko ;
reg [15:0] rxd;
real timestamp_in_0, timestamp_in_1, timestamp_in_2;
real timestamp_out_0, timestamp_out_1;
real duration_recovered_clk, duration_in_0, duration_in_1, duration_in, duration_clk ;
real duration_in_0_d, duration_in_last ;
real timestamp_clk_0, timestamp_clk_1;

real duration_txclk;
wire within_range ;
wire cntrstb, fifoempty_2d_ ;

wire rd_in_d ;
wire tx_bit_clock;
wire rxpll_in;
reg lfi_1;
reg fifoempty_2d, fifoempty_3d, fifoempty_d ;
reg fifoempty_2d_tx, fifoempty_d_tx ;
reg fifoempty_3d_tx, fifoempty_4d_tx , fifoempty_4d_tx_ ;
reg sd_d, out_1_d ;
reg resetb_d ;
reg fifo_rstb_2d, fifo_rstb_d ;

reg txclk_pll, recovered_clk ;
integer vco_builduptime_approx ; 
integer vco_builduptime_approx_1 ; 

initial begin
   txclk_pll <= 0;
   recovered_clk <= 0;
   timestamp_in_0 <= 0.0;
   timestamp_in_1 <= 0.0;
   duration_clk = 1.0;
   duration_recovered_clk = 1.0;
   vco_builduptime_approx = 0; 
   vco_builduptime_approx_1 = 0; 
   fifoempty_4d_tx <= 1;
   fifoempty_4d_tx_ <= 1;
   fifoempty_2d_tx <= 1;
   fifoempty_3d_tx <= 1;
   fifoempty_d_tx <= 1;


end

assign locked = lfi_1;

//////// parallel inputting to serial output

// P1
always @ (posedge txclki)
if (pwrdnb) begin
txd_reg <= txd ;
end



cy_fifo_9532 fifo (.data_in(txd_reg), .rstb((fifo_rstb)),  .wrclk(txclki),
.out_2d(fifo_out), .rdclk(txclko), .fifoerr(fifo_err),
.fifoempty(fifoempty)) ;


// P2 
always @ (posedge txclko or negedge resetb) begin
if (!resetb) begin
fifo_rstb_d <= 0 ;
fifo_rstb_2d <= 0 ;
end
else begin
fifo_rstb_d <= fifo_rstb ;
fifo_rstb_2d <= fifo_rstb_d ;
fifoempty_d_tx <= fifoempty ;
fifoempty_2d_tx <= fifoempty_d_tx ;
fifoempty_3d_tx <= fifoempty_2d_tx ;
end
end

// P3
always @ (posedge txclko or posedge fifoempty_2d_tx) begin
if (fifoempty_2d_tx) fifo_out_d <= 'h5555 ;
else fifo_out_d <= fifo_out ;
end

// P4
always @ (negedge txclko or posedge fifoempty_2d_tx) begin
if (fifoempty_2d_tx) fifo_out_2d <= 'h5555 ;
else fifo_out_2d <= fifo_out_d ;
end

// P5
always @ (negedge txclko) fifoempty_4d_tx <= fifoempty_3d_tx ;

// P6
always @ (posedge tx_bit_clock or negedge resetb)
if (!resetb) begin
       out_1 <= 0;
       shiftcnt <= 15;
       end
else if (pwrdnb & (!fifo_rstb_2d & fifo_rstb_d)) out_1 <= 0;  // this step is 
                // to match with the device, otherwise is not necessary

else if (pwrdnb & fifoempty_4d_tx) begin
       out_1 <= ~out_1 ; // this generates 1010 pattern
       shiftcnt <= 15;
      end
else if (pwrdnb) begin
     out_1 <= fifo_out_2d[shiftcnt] ;
   if (shiftcnt == 0) shiftcnt <= 15;
   else  shiftcnt <= shiftcnt -1 ;   // 15th bit outputted first 
end

// P7
always @ (posedge tx_bit_clock or negedge resetb)
if (!resetb) begin
       cnt16 <= 0;
     end
  else if (pwrdnb) begin
   if (cnt16 == 15) cnt16 <= 0;
   else cnt16 <= cnt16 + 1; 

    end
 
assign td_out = (lineloop | loopa)  ? (lineloop ? retimed_data : rd_in  ): 
             out_1 ;   

assign tx_bit_clock = (loop_time) ? recovered_clk : txclk_pll ; 

// P7a
always @ (negedge tx_bit_clock or negedge resetb)
if (!resetb) begin
       txclko <= 0;
     end
  else if (pwrdnb) begin
   if (cnt16 == 8)  txclko <= 0 ;
   else if (cnt16 == 0)  txclko <= 1 ;
 end


////////// serial input to parallel output  ///////////////////   

reg tmp_rxpll_in;
always @(out_1_d or rd_in_d)
begin
    if (diagloop)
	@(posedge tx_bit_clock)
	    tmp_rxpll_in <= out_1_d;
    else
	tmp_rxpll_in <= rd_in_d;
end
assign rxpll_in = tmp_rxpll_in;

assign #10 rd_in_d = rd_in ;

// P8
always @ (posedge recovered_clk or negedge resetb)
if (!resetb) vco_builduptime_approx <= 0;
else if (vco_builduptime_approx != 131072) 
   vco_builduptime_approx <= vco_builduptime_approx + 1;  // from netlist
// simulation, it is seen that locktime is in the order of 53 us. 
 
// P8a
always @ (posedge rxpll_in or negedge resetb)
if (!resetb) vco_builduptime_approx_1 <= 0;
else if (vco_builduptime_approx_1 != 32768) 
   vco_builduptime_approx_1 <= vco_builduptime_approx_1 + 1;  
// above is some approximation to generate lfib so that it becomes same as 
// of netlist.

// P9
always @ (negedge recovered_clk)  begin
if (pwrdnb) begin
            out_1_d <= out_1;
            fifoempty_4d_tx_ <= fifoempty_4d_tx ;
          end
sd_d <= sd ;
end

assign within_range = ((((16*duration_in_0) / duration_clk) <= 1.0002)  &&
                    (((16*duration_in_0) / duration_clk) >= 0.9998)) ? 1'b1 : 1'b0 ;


// P10
always @ (pwrdnb or rxpll_in or diagloop or fifoempty_2d) begin
if (pwrdnb) begin
  if (diagloop ? fifoempty_2d : 1'b1) begin
//  if (diagloop ? fifoempty_2d : sd) begin
   timestamp_in_0 <= $realtime;
    timestamp_in_1 <= timestamp_in_0 ;
    timestamp_in_2 <= timestamp_in_1 ;
   end
  end
end
// it is assumed that "rd_in" does not have any glitches


// P11
always @ (posedge refclk) begin
if (pwrdnb) begin
  timestamp_clk_0 <= $realtime ;
  timestamp_clk_1 <= timestamp_clk_0 ;
end
end


// P12
always @ (negedge within_range)
#1 duration_in_last <= duration_in ;


always @ (duration_in_0)
#1 duration_in_0_d <= duration_in_0 ;


// P12a
always @ (duration_in_0_d) begin // this should be duration_in_0_d only
duration_in <= within_range ? duration_in_0 : duration_in_last ;
end

// P12b
always @ (pwrdnb or timestamp_in_0 or timestamp_in_1 or timestamp_clk_0 or
  duration_in or timestamp_clk_1 or sd or diagloop or lockrefb or
lfi_1 or within_range) begin

if (pwrdnb) begin

 duration_in_0 <= (timestamp_in_0 - timestamp_in_1) ;
// duration_in_1 = (timestamp_in_1 - timestamp_in_2) ;


 duration_clk = (timestamp_clk_0 - timestamp_clk_1) ;

// duration_recovered_clk = (lfi_1) ? duration_in : (duration_clk/16 +
//                                                   68/131072) ;

// duration_recovered_clk = (!lockrefb | (!diagloop & !sd)) ? duration_clk/16 :
//                  (lfi_1) ? duration_in : duration_clk/16 ;

if (!lockrefb | (!diagloop & !sd))
	duration_recovered_clk = duration_clk/16.0;
else if (lfi_1)
	duration_recovered_clk = duration_in;
else
	duration_recovered_clk = duration_clk/16.0;
	
// here the range is assumed to be 0.02%

 duration_txclk =  (duration_clk / 32) ;
// duration_txclk = lfi_1 ? (duration_clk / 32) : ((duration_clk/32) + 68/(2*131072)) ;
end
end


// P13
always @ (refclk or pwrdnb or done16) begin
if (pwrdnb) begin
if (duration_txclk != 0) begin
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
  #(duration_txclk)  txclk_pll = ~txclk_pll;
    done16 = 1;
end
end
end

// P14
always @ (done16) begin
#0.005;
done16 = 0;
end


// P15
always @ (pwrdnb or done16_rec or duration_recovered_clk) begin
if (pwrdnb) begin
if (duration_recovered_clk != 0) begin
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
#(duration_recovered_clk/2)  recovered_clk = ~recovered_clk ;
done16_rec = 1;
end
end
end


// P16
always @ (done16_rec) begin
#0.005;  // is in fs
done16_rec = 0;
end



// P17
always @ (posedge recovered_clk or negedge resetb)
if (!resetb) begin
       rx_cnt16 <= 0;
  fifoempty_2d <= 1 ;
  fifoempty_3d <= 1 ;
       end
else if (pwrdnb) begin
//  if (suppress1 != 4) suppress1 <= suppress1 + 1;  // this is done to match it with netlist simulation
//    suppress1d <= suppress1 ;
//   if (suppress1 == suppress1d) begin 
  if (rx_cnt16 == 15) rx_cnt16 <= 0;
   else rx_cnt16 <= rx_cnt16 +1 ;
//    end


  fifoempty_2d <= fifoempty_d ;
  fifoempty_3d <= fifoempty_2d ;
end


// P17a
always @ (negedge recovered_clk or negedge resetb)
if (!resetb) begin
        rxclk <= 1;
  end
else if (pwrdnb) begin
  if (rx_cnt16 == 8) rxclk <= 1;
  else if (rx_cnt16 == 0) rxclk <= 0;
end


// P18
always @ (posedge recovered_clk or negedge resetb)
if (!resetb) fifoempty_d <= 1;
else if (pwrdnb) fifoempty_d <= fifoempty_4d_tx_ ;
//else if (pwrdnb) fifoempty_d <= fifoempty ;


// P19
always @ (posedge refclk or negedge resetb)
  if (!resetb) lfi_1 <= 0;
  else if (within_range & pwrdnb & (vco_builduptime_approx == 131072) &
               (vco_builduptime_approx_1 == 32768))  
                   lfi_1 <= 1;
  else if (!pwrdnb & !within_range) lfi_1 <= 0;
//  else if () lfi_1 <= 0;  // may be modified later to get it out of lock

assign lfib = lfi_1 & lockrefb & (diagloop ? 1'b1 : (sd)) ;  
// as per netlist simulation, lfib is 0 if sd is 0 in normal mode


// P20
always @ (posedge recovered_clk or negedge resetb)
if (!resetb) begin
   rx_dat16 <= 16'h0 ;
   rx_dat16_bak <= 16'h0 ;
   retimed_data <= 0;
end
else if (pwrdnb) begin
   rx_dat16[rx_sd_cnt16] <= retimed_data ;

   if (rx_sd_cnt16 == 15) rx_dat16_bak <= rx_dat16 ;

   retimed_data <= rxpll_in ;
end

assign cntrstb = resetb & !(fifoempty_2d & diagloop) ;
assign #1 fifoempty_2d_ = fifoempty_2d ;  // this is in fs 

// P21
always @ (posedge recovered_clk or negedge cntrstb)
if (!cntrstb) begin
    rx_sd_cnt16 <= 15 ;
   end
else if (pwrdnb) begin

//  if (suppress2 != 3) suppress2 <= suppress2 + 1;  // this is done to match it with netlist simulation
//    suppress2d <= suppress2 ;
//   if (suppress2 == suppress2d) begin 
  if (diagloop ? !fifoempty_2d_ : 1'b1)  begin
//  if (diagloop ? !fifoempty_2d_ : sd_d)  begin
   if (rx_sd_cnt16 == 0) rx_sd_cnt16 <= 15;
   else rx_sd_cnt16 <= rx_sd_cnt16 - 1;
   end
//  end

end


// P22
always @ (negedge rxclk or negedge resetb)
if (!resetb) rxd <= 16'h0;
else if (pwrdnb) rxd <= rx_dat16_bak ;




endmodule  // cy_2gserdes_core

//  FIFO module 

module  cy_fifo_9532 (data_in, rstb, wrclk, out_2d, rdclk, fifoerr, fifoempty );
input [15:0] data_in;
output [15:0] out_2d;
input rstb, wrclk, rdclk ;
output fifoerr ;
output fifoempty; // when Low indicates 1010 is to be outputted, else
                  // "data_out" is to be outputted

reg [15:0] temp1, temp2, temp3, temp4, temp5, temp6 ;
integer wrcnt, rdcnt ;
integer wrcnt_sync1, rdcnt_sync1 ;
integer wrcnt_sync2, rdcnt_sync2 ;
integer fifoclrcnt ;
wire intrstb, fifoclr;
reg data_avl_sync1, data_avl_sync2, fifoempty, fifofull ;
reg data_avl, ovflow_err;
reg [15:0] data_out, out_d, out_2d ;
reg rstb_2d, rstb_d ;
wire undflow_err;

/////////////////////////Write side//////////////////
// PF
always @ (posedge wrclk or negedge intrstb)
if (!intrstb) begin
   wrcnt <= 0;
   rdcnt_sync1 <= 0;
   rdcnt_sync2 <= 0;
   #200 ovflow_err <= 0;  // this is in fs
   data_avl <= 0;
   fifofull <= 0;
end

else begin
 data_avl <= 1;

if (!fifofull) begin
   if (wrcnt == 5) wrcnt <= 0;
    else     wrcnt <= wrcnt +1;
   end

if (fifofull) ovflow_err <= 1;

if (((wrcnt - rdcnt_sync1) >= 5) || ( rdcnt_sync1 - wrcnt == 1)) fifofull <= 1;
  else fifofull <= 0; 

rdcnt_sync1 <= rdcnt;
rdcnt_sync2 <= rdcnt_sync1;

end


// PF1
always @ (posedge wrclk) begin
     rstb_d <= rstb ;
     rstb_2d <= rstb_d ;
     end


// PF2
always @ (posedge wrclk) begin
if (!fifofull) begin
if (wrcnt == 0) temp1 <= data_in;
else if (wrcnt == 1) temp2 <= data_in;
else if (wrcnt == 2) temp3 <= data_in;
else if (wrcnt == 3) temp4 <= data_in;
else if (wrcnt == 4) temp5 <= data_in;
else if (wrcnt == 5) temp6 <= data_in; // 6 locations because of netlist; but could have been
                                  // 5 locations because of 2 cycles
                                  // for read to change, and 3 cycles for
                                  // rdcnt to change
end

end


/////////////////////////Read side//////////////////

// PF3
always @ (posedge rdclk or negedge intrstb) 
if (!intrstb) begin
  rdcnt <= 0;
  wrcnt_sync1 <= 0;
  wrcnt_sync2 <= 0;
  data_avl_sync1 <= 0;
  data_avl_sync2 <= 0;
  fifoempty <= 1;
  fifoclrcnt <= 0;
  data_out <= 'h5555 ; 
end

else begin

   data_out <= (rdcnt == 0) ? temp1 :
             ((rdcnt == 1) ? temp2 :
             ((rdcnt == 2) ? temp3 :
             ((rdcnt == 3) ? temp4 : 
             ((rdcnt == 4) ? temp5 : temp6 )))) ;

   out_d <= data_out ;
   out_2d <= out_d ;


if ((rdcnt != wrcnt_sync1)) begin
     if (rdcnt == 5) rdcnt  <= 0;
     else rdcnt <= rdcnt +1;
   end


wrcnt_sync1 <= wrcnt;
wrcnt_sync2 <= wrcnt_sync1;

data_avl_sync1 <= data_avl ;
data_avl_sync2 <= data_avl_sync1 ;

fifoempty <= (rdcnt == wrcnt_sync1) ;

if ((undflow_err | ovflow_err)) fifoclrcnt <= 1;
else if (fifoclrcnt != 0) fifoclrcnt <= fifoclrcnt + 1;

end

wire #200 data_avl_sync2_d = data_avl_sync2 ;// this is in fs

assign fifoerr = (undflow_err | ovflow_err) ;
assign undflow_err = (fifoempty & data_avl_sync2_d) ;

assign fifoclr = (fifoclrcnt == 9) ;  // this does internal clearing
                            // of FIFO in absence of fifo_rst
assign intrstb = rstb & !fifoclr ;

endmodule  // fifo

module cy_25g01serdes (txd, fifo_rstb, loop_time, diagloop, loopa, lineloop,
    resetb, pwrdnb, lockrefb, refclk_n, refclk_p, serial_in_n, serial_in_p, sd, 
    serial_out_n, serial_out_p, fifo_err, txclk, rxd, rxclk, lfib);

// Transmit path signals
input [15:0]  txd;
output txclk ;

// Receive path signals
output [15:0] rxd;
output rxclk ;

// Device Control and Status Signals
input refclk_n, refclk_p;
output lfib ;
input resetb;
input lockrefb ;
input sd;
output fifo_err ;
input fifo_rstb ;
input pwrdnb ;

// Loop Control Signals
input diagloop ;
input lineloop ;
input loopa;
input loop_time;

// Serial I/O
output serial_out_n, serial_out_p;
input serial_in_n, serial_in_p ;

// timing enable signal
reg timing_enable;  // disabled when 0, and can be dynamically
                     // forced to 1/0 from outside this module to
                     // filter unwanted timing violation reports
wire locked;

// switch signal
wire noclock = 1;  // this is a switch. If '1' it shorts txclk to txclki,
                   // if '0', it allows txclki to pass.
wire txclki_f ;
assign txclki_f = txclk;

reg refclk ;
reg rd_in ;
wire td_out ;

// timing parameters

parameter txclk_period_min = 6380 ;
parameter txclk_period_max = 6470 ;
parameter txclk_period_vio = "ERROR-001:  TXCLK Period Violation" ;

parameter txclk_dutycy_min = 0.43 ;
parameter txclk_dutycy_max = 0.57 ;
parameter txclk_dutycy_vio = "ERROR-002:  TXCLK Duty-cycle Violation" ;

parameter rxclk_period_min = 6380 ;
parameter rxclk_period_max = 6470 ;
parameter rxclk_period_vio = "ERROR-005:  RXCLK Period Violation" ;

parameter rxclk_dutycy_min = 0.43 ;
parameter rxclk_dutycy_max = 0.57 ;
parameter rxclk_dutycy_vio = "ERROR-006:  RXCLK Duty Cycle Violation" ;

parameter refclk_period_min = 6380 ;
parameter refclk_period_max = 6470 ;
parameter refclk_period_vio = "ERROR-007:  REFCLK Period Violation" ;

parameter refclk_dutycy_min = 0.35 ;
parameter refclk_dutycy_max = 0.65 ;
parameter refclk_dutycy_vio = "ERROR-008:  REFCLK Duty Cycle Violation" ;

parameter refclk_freqtol = 0.0001 ; // +/- 100 ppm
parameter refclk_freqtol_vio = "ERROR-009:  REFCLK Frequency Tolerance Violation" ;

parameter rxpd_min = -1000 ;  // this is not implemented as it is always outputted with zero delay w.r.t. negedge of RXCLK
parameter rxpd_max = 1000 ;

real refclk_negedge, refclk_posedge, refclk_prevedge;
real refclk_dutycy, refclk_low, refclk_high, refclk_period;
real timestamp_in_0, timestamp_in_1, duration_in_0 ;
real duration_in;
reg in_there_d, in_there ;

real txclk_negedge, txclk_posedge, txclk_prevedge;
real txclk_dutycy, txclk_low, txclk_high, txclk_period;
real txclk_period_prev ;

real rxclk_negedge, rxclk_posedge, rxclk_prevedge;
real rxclk_dutycy, rxclk_low, rxclk_high, rxclk_period;
real rxclk_period_prev;

initial begin
  duration_in = 6425/16.0 ;  
   timestamp_in_0 = 0.0 ;
   in_there = 0;
   in_there_d = 0;
   refclk = 0;
   rxclk_period_prev = 0.0;
   txclk_period_prev = 0.0;
   @ (posedge resetb) timing_enable = 1;
end

//refclk gen
always @ (refclk_n or refclk_p or pwrdnb)
if (pwrdnb) begin
if (!refclk_n & refclk_p) refclk = 1;
else if (!refclk_p & refclk_n) refclk = 0;
end

//rd_in gen
always @ (serial_in_p or serial_in_n or pwrdnb)
if (pwrdnb) begin
if (!serial_in_n & serial_in_p) rd_in = 1;
else if (!serial_in_p & serial_in_n) rd_in = 0;
end

// td_out gen
assign serial_out_p = td_out ;
assign serial_out_n = ~td_out ;

/////////////////////////////////////////////////////
// TXCLK timing checks


always @ (negedge txclk) begin
  if (pwrdnb) begin
txclk_negedge <= $realtime ;
end
end

always @ (txclk_negedge or pwrdnb) begin
  if (pwrdnb) begin
if ((txclk_negedge != 0) && (txclk_posedge != 0))
       txclk_high = txclk_negedge - txclk_posedge ;
end
end

always @ (txclk_posedge or pwrdnb) begin
  if (pwrdnb) begin
if ((txclk_negedge != 0) && (txclk_posedge != 0)) begin
   txclk_low = txclk_posedge - txclk_negedge ;
   txclk_period = txclk_posedge - txclk_prevedge ;
end
end
end


always @ (posedge txclk)  begin
  if (pwrdnb) begin
    txclk_posedge <= $realtime ;
    txclk_prevedge <= txclk_posedge;
    txclk_period_prev <= txclk_period ;
  end
end

always @ (posedge txclk) begin
  if (pwrdnb) begin

  if (timing_enable) begin
  if ((txclk_period_prev != 0) & ((txclk_period < txclk_period_min) 
                  | (txclk_period > txclk_period_max))) begin
	       if (locked)
	       begin
		   $display("%s", txclk_period_vio);
		   $display("Time: ", $realtime);
	       end
              end
    
   end
    
end
end

always @ (txclk_low or txclk_high or pwrdnb) 
  if (pwrdnb) begin
 txclk_dutycy = txclk_low/ (txclk_low + txclk_high) ;
end

always @ (posedge txclk) begin
  if (pwrdnb) begin
  if (timing_enable & ((txclk_period_prev != 0) &&
                    (txclk_low !=0) && (txclk_high != 0))) begin
  if ((txclk_dutycy < txclk_dutycy_min) ||
      (txclk_dutycy > txclk_dutycy_max)) begin
	       if (locked)
	       begin
		   $display("%s", txclk_dutycy_vio);
		   $display("Time: ", $realtime);
	       end
              end
end
end
end

/////////////////////////////////////////////////////
// RXCLK timing checks


always @ (negedge rxclk) begin
  if (pwrdnb) begin
rxclk_negedge <= $realtime ;
end
end

always @ (rxclk_negedge or pwrdnb) begin
  if (pwrdnb) begin
if ((rxclk_negedge != 0) && (rxclk_posedge != 0))
       rxclk_high = rxclk_negedge - rxclk_posedge ; 
end
end

always @ (rxclk_posedge or pwrdnb) begin
  if (pwrdnb) begin
if ((rxclk_negedge != 0) && (rxclk_posedge != 0)) begin
   rxclk_low = rxclk_posedge - rxclk_negedge ; 
   rxclk_period = rxclk_posedge - rxclk_prevedge ;
end
end
end


always @ (posedge rxclk)  begin
  if (pwrdnb) begin
    rxclk_posedge <= $realtime ;
    rxclk_prevedge <= rxclk_posedge;
    rxclk_period_prev <= rxclk_period ;
  end

end

always @ (posedge rxclk) begin
  if (pwrdnb) begin
  if (timing_enable) begin
  if ((rxclk_period_prev != 0) & ((rxclk_period < rxclk_period_min) 
                  || (rxclk_period > rxclk_period_max))) begin
	       if (locked)
	       begin
		   $display("%s", rxclk_period_vio);
		   $display("Time: ", $realtime);
	       end
              end
   end    
end
    
end


always @ (rxclk_low or rxclk_high or pwrdnb )
  if (pwrdnb) begin
 rxclk_dutycy = rxclk_low/ (rxclk_low + rxclk_high) ;
end

always @ (posedge rxclk) begin
  if (pwrdnb) begin
  if (timing_enable & ((rxclk_period_prev != 0) && 
                     (rxclk_low !=0) && (rxclk_high != 0))) begin
  if ((rxclk_dutycy < rxclk_dutycy_min) ||
      (rxclk_dutycy > rxclk_dutycy_max)) begin
	       if (locked)
	       begin
		   $display("%s", rxclk_dutycy_vio);
		   $display("Time: ", $realtime);
	       end
              end
   end
end
end

/////////////////////////////////////////////////////
// REFCLK timing checks


always @ (negedge refclk) begin
  if (pwrdnb) begin
refclk_negedge <= $realtime ;
end
end


always @ (refclk_negedge or pwrdnb) begin
  if (pwrdnb) begin
if ((refclk_negedge != 0) && (refclk_posedge != 0))
       refclk_high = refclk_negedge - refclk_posedge ; 
end
end

always @ (refclk_posedge or pwrdnb) begin
  if (pwrdnb) begin
if ((refclk_negedge != 0) && (refclk_posedge != 0)) begin
   refclk_low = refclk_posedge - refclk_negedge ; 
   refclk_period = refclk_posedge - refclk_prevedge ;
end
end
end



always @ (posedge refclk)  begin
  if (pwrdnb) begin
    refclk_posedge <= $realtime ;
    refclk_prevedge <= refclk_posedge;
  end
end


always @ (posedge rd_in)  begin
  if (pwrdnb) begin
   @ (posedge rd_in) ;
    in_there_d <= in_there ;
  end
end


always @ (posedge refclk) begin
  if (pwrdnb) begin

  if (timing_enable) begin
  if ((refclk_period != 0) & ((refclk_period < refclk_period_min) 
                  || (refclk_period > refclk_period_max))) begin
	       if (locked)
	       begin
		   $display("%s", refclk_period_vio);
		   $display("Time: ", $realtime);
	       end
              end
    
  if (in_there_d  & resetb &
           ((((16*duration_in) / refclk_period) > (1 + refclk_freqtol))  ||
             (((16*duration_in) / refclk_period) < 1 - refclk_freqtol ))) begin 
	       if (locked)
	       begin
		   $display("%s", refclk_freqtol_vio);
		   $display("Time: ", $realtime);
	       end
    end
 end
end
end

always @ (refclk_low or refclk_high or pwrdnb) 
  if (pwrdnb) begin
 refclk_dutycy = refclk_low/ (refclk_low + refclk_high) ;
end

always @ (posedge refclk) begin
  if (pwrdnb) begin
  if (timing_enable & ((refclk_low !=0) && (refclk_high != 0))) begin
  if ((refclk_dutycy < refclk_dutycy_min) ||
      (refclk_dutycy > refclk_dutycy_max)) begin
	       if (locked)
	       begin
		   $display("%s", refclk_dutycy_vio);
		   $display("Time: ", $realtime);
	       end
              end
    
    end
   end
end


always @ (rd_in or pwrdnb) begin
  if (pwrdnb) begin
   timestamp_in_0 <= $realtime;
    timestamp_in_1 <= timestamp_in_0 ;
   in_there <= 1;
  end
end
// it is assumed that "rd_in" does not have any glitches

always @ (duration_in_0 or refclk_period or pwrdnb) begin
  if (pwrdnb) begin
if ((((16*duration_in_0) / refclk_period) <= (1 + refclk_freqtol))  &&
               (((16*duration_in_0) / refclk_period) >= 1 - refclk_freqtol)) 
      duration_in <= duration_in_0 ;
end
end

always @ (timestamp_in_0 or timestamp_in_1) begin
 duration_in_0 <= (timestamp_in_0 - timestamp_in_1) ;
end

wire txclko ;
assign txclk = txclko ;

cy_2gserdes_core cy_2gserdes_core ( .txd(txd), 
				    .txclki(txclki_f), 
				    .txclko(txclko), 
				    .rxd(rxd), 
				    .rxclk(rxclk), 
				    .refclk(refclk), 
				    .lfib(lfib), 
				    .locked(locked), 
				    .resetb(resetb),
				    .lockrefb(lockrefb), 
				    .sd(sd), 
				    .fifo_err(fifo_err), 
				    .fifo_rstb(fifo_rstb), 
				    .pwrdnb(pwrdnb), 
				    .diagloop(diagloop), 
				    .lineloop(lineloop), 
				    .loopa(loopa),
				    .loop_time(loop_time), 
				    .td_out(td_out), 
				    .rd_in(rd_in));

endmodule

module cy_2gserdes
    (txd, fifo_rstb, loop_time, diagloop, loopa, lineloop, 
    resetb, pwrdnb, lockrefb, refclk_n, refclk_p, serial_in_n, serial_in_p,
    sd, serial_out_n, serial_out_p, fifo_err, txclk, rxd, rxclk, lfib);

// Transmit path signals
input [15:0]  txd;
output txclk;

// Receive path signals
output [15:0] rxd;
output rxclk;

// Device Control and Status Signals
input refclk_n, refclk_p;
output lfib;
input resetb;
input lockrefb;
input sd;
output fifo_err;
input fifo_rstb;
input pwrdnb;

// Loop Control Signals
input diagloop;
input lineloop;
input loopa;
input loop_time;

// Serial I/O
output serial_out_n, serial_out_p;
input serial_in_n, serial_in_p;

cy_25g01serdes cy_25g01serdes  (.txd(txd),
				.fifo_rstb(fifo_rstb),
				.loop_time(loop_time),
				.diagloop(diagloop),
				.loopa(loopa),
				.lineloop(lineloop),
				.resetb(resetb),
				.pwrdnb(pwrdnb),
				.lockrefb(lockrefb),
				.refclk_n(refclk_n),
				.refclk_p(refclk_p),
				.serial_in_n(serial_in_n),
				.serial_in_p(serial_in_p),
				.sd(sd),
				.serial_out_n(serial_out_n),
				.serial_out_p(serial_out_p),
				.fifo_err(fifo_err),
				.txclk(txclk),
				.rxd(rxd),
				.rxclk(rxclk),
				.lfib(lfib));
endmodule

`endif
`endif
