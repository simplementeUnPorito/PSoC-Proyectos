/*******************************************************************************
* Copyright 1997, 2009, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

`ifdef LPM_ALREADY_INCLUDED
    // Only include the rest of this file once.
`else
`define LPM_ALREADY_INCLUDED

// TYPE Shift_Type:
`define LPM_LOGICAL	0
`define LPM_ROTATE	1
`define LPM_ARITHMETIC	2

// TYPE Repre_Type:
`define LPM_SIGNED	0
`define LPM_UNSIGNED	1
`define LPM_GRAY	2

// TYPE Truth_Type:
`define LPM_F		0
`define LPM_FD		1
`define LPM_FR		2
`define LPM_FDR		3

// TYPE CtDir_Type:
`define LPM_NO_DIR	0
`define LPM_UP		1
`define LPM_DOWN	2

// TYPE Arith_Type:
`define LPM_NO_TYP	0
`define LPM_ADD		1
`define LPM_SUB		2

// TYPE Fflop_Type:
`define LPM_DFF		0
`define LPM_TFF		1

// TYPE ShDir_Type:
`define LPM_LEFT	0
`define LPM_RIGHT	1

// TYPE Regis_Type:
`define LPM_REGISTERED	0
`define LPM_UNREGISTERED 1

// TYPE Stgth_Type:
`define LPM_NO_STRENGTH	0
`define LPM_WEAK	1

// TYPE goal_type:
`define SPEED		0
`define AREA		1
`define COMBINATORIAL	2
`define MEMORY		3

`ifdef WARP
    // Don't bother with the rest if this is used for Warp synthesis.
`else
//
//	mabs
//

module mabs (data, result, overflow);

    parameter lpm_width = 1;
    parameter lpm_hint  = `SPEED;
    input   [lpm_width - 1:0] data;
    output  [lpm_width - 1:0] result;
    output  overflow;

    reg	[lpm_width - 1:0] switch;
    reg	[lpm_width - 1:0] tmp;
    integer	i;

    always @(data)
    begin
	tmp[0] = data[0];
	switch[0] = data[0] & data[lpm_width - 1];
	for (i = 1; i <= lpm_width - 1; i = i + 1)
	begin
	    switch[i] = (switch[i-1] | data[i]) & data[lpm_width - 1];
	    tmp[i] =  switch[i-1] ^ data[i];
	end
    end

    assign result = tmp;
    assign overflow = ~switch[lpm_width - 2] & tmp[lpm_width - 1];

endmodule

//
//	madd_sub
//

module madd_sub (dataa,datab,cin,add_sub,result,cout,overflow,clock,aclr);

parameter lpm_width = 1;
parameter lpm_representation = `LPM_UNSIGNED;
parameter lpm_direction = `LPM_NO_TYP;
parameter lpm_hint = `SPEED;
parameter lpm_pipeline  = 0;
input	[lpm_width-1:0] dataa; 
input	[lpm_width-1:0] datab; 
input	cin; 
input	add_sub; 
output	[lpm_width-1:0] result; 
output	cout; 
output	overflow; 
input	clock; 
input	aclr;
reg	[lpm_width:0] a,b,s,c; 
integer	h;

always @(dataa or datab or cin or add_sub)
begin
    a = dataa; b = datab;
    if (lpm_width == 1)
    begin
	s =   (((a[0] ^ b[0]) ^  cin) &  add_sub) |
	    ((~(~a[0] ^ b[0]) ^ ~cin) & ~add_sub);
	c[1]= (((a[0] & b[0]) | ( a[0] &  cin) | (b[0] &  cin)) &  add_sub) |
	     (((~a[0] & b[0]) | (~a[0] & ~cin) | (b[0] & ~cin)) & ~add_sub);
    end
    else
    begin
	s[0] = (((a[0] ^ b[0]) ^  cin) &  add_sub) |
	     (~(~(a[0] ^ b[0]) ^ ~cin) & ~add_sub);

	s[1] = (((a[1] ^ b[1]) ^ (( a[0] & b[0]) | ( a[0] &  cin) |
					(b[0]  & cin))) &  add_sub) |
	     (~(~(a[1] ^ b[1]) ^ ((~a[0] & b[0]) | (~a[0] & ~cin) |
					(b[0] & ~cin))) & ~add_sub);

	c[2] = (((a[0] & b[0] &  a[1]) |
		 (a[0] & b[0] &  b[1]) |
		 ( cin & b[0] &  a[1]) |
		 ( cin & b[0] &  b[1]) |
		 (a[0] & cin  &  a[1]) |
		 (a[0] & cin  &  b[1]) |
		 (a[1] & b[1])) &  add_sub) |
	      (((~a[0] & b[0] & ~a[1]) |
		(~a[0] & b[0] &  b[1]) |
		(~cin  & b[0] & ~a[1]) |
		(~cin  & b[0] &  b[1]) |
		(~a[0] & ~cin & ~a[1]) |
		(~a[0] & ~cin &  b[1]) |
		(~a[1] & b[1])) & ~ add_sub);

	if ((lpm_width/2) != 0 )
	begin
	    for (h = 1; h <= (lpm_width/2)-1; h = h + 1)
	    begin
		s[2*h] = ((((a[2*h] ^ b[2*h]) ^ c[2*h])) & add_sub) |
		    ((~(~(a[2*h] ^ b[2*h]) ^ c[2*h])) & ~add_sub);
		s[2*h+1] = (((a[2*h+1] ^ b[2*h+1]) ^
			    ((a[2*h]   & b[2*h]) |
			     (a[2*h]   & c[2*h]) |
			     (b[2*h]   & c[2*h]))) &  add_sub) |
			 (~(~(a[2*h+1] ^ b[2*h+1]) ^
			   ((~a[2*h]   & b[2*h]) |
			    (~a[2*h]   & c[2*h]) |
			     (b[2*h]   & c[2*h]))) & ~add_sub);

		if (lpm_hint == `SPEED)
		  c[2*h+2]  =  ((((a[2*h+1] & b[2*h+1]) |
				 ((a[2*h+1] | b[2*h+1]) &
				  (a[2*h]   & b[2*h]))) &  add_sub)
			    |  (((~a[2*h+1] & b[2*h+1]) |
				((~a[2*h+1] | b[2*h+1]) &
				 (~a[2*h]   & b[2*h]))) & ~add_sub))
		   | (c[2*h] & ((((a[2*h+1] | b[2*h+1]) &
				  (a[2*h]   | b[2*h]))  &  add_sub)
			     | (((~a[2*h+1] | b[2*h+1]) &
				 (~a[2*h]   | b[2*h]))  & ~add_sub)));
		else

		  c[2*h+2] = (((a[2*h] & b[2*h] &  a[2*h+1])
			|      (a[2*h] & b[2*h] &  b[2*h+1])
			|      (c[2*h] & b[2*h] &  a[2*h+1])
			|      (c[2*h] & b[2*h] &  b[2*h+1])
			|      (a[2*h] & c[2*h] &  a[2*h+1])
			|      (a[2*h] & c[2*h] &  b[2*h+1])
			|      (a[2*h+1]        &  b[2*h+1])) &  add_sub) |
			    (((~a[2*h] & b[2*h] & ~a[2*h+1])
			|     (~a[2*h] & b[2*h] &  b[2*h+1])
			|      (c[2*h] & b[2*h] & ~a[2*h+1])
			|      (c[2*h] & b[2*h] &  b[2*h+1])
			|     (~a[2*h] & c[2*h] & ~a[2*h+1])
			|     (~a[2*h] & c[2*h] &  b[2*h+1])
			|     (~a[2*h+1]        &  b[2*h+1])) & ~add_sub);
	    end
	end

	if ((lpm_width % 2) != 0)
	begin
	    s[lpm_width-1] = ((((a[lpm_width-1] ^ b[lpm_width-1]) ^
					     c[lpm_width-1])) &  add_sub)
			|  ((~(~(a[lpm_width-1] ^ b[lpm_width-1]) ^
					     c[lpm_width-1])) & ~add_sub);

	    c[lpm_width] = (((a[lpm_width-1] & b[lpm_width-1]) |
			     (a[lpm_width-1] & c[lpm_width-1]) |
			     (b[lpm_width-1] & c[lpm_width-1])) &  add_sub)
			| (((~a[lpm_width-1] & b[lpm_width-1]) |
			    (~a[lpm_width-1] & c[lpm_width-1]) |
			     (b[lpm_width-1] & c[lpm_width-1])) & ~add_sub);
       end
    end
end

reg[lpm_width-1:0] rpipe [lpm_pipeline:0];
reg[lpm_pipeline:0] cpipe;
reg[lpm_pipeline:0] opipe;

always @(s or c or a or b)
begin : PIPE_0
    rpipe[0] = s[lpm_width - 1:0];
    if (((lpm_direction == `LPM_NO_TYP) & (add_sub)) |
	  lpm_direction == `LPM_ADD)
    begin
	cpipe[0] =  c[lpm_width];
	opipe[0] =(( s[lpm_width - 1] & ~a[lpm_width - 1] & ~b[lpm_width - 1])
		 | (~s[lpm_width - 1] &  a[lpm_width - 1] &  b[lpm_width - 1]));
    end
    else
    begin
	cpipe[0] = ~c[lpm_width];
	opipe[0] =(( s[lpm_width - 1] & ~a[lpm_width - 1] &  b[lpm_width - 1])
		 | (~s[lpm_width - 1] &  a[lpm_width - 1] & ~b[lpm_width - 1]));
    end
end

always @(posedge aclr or posedge clock)
begin : PIPE_N
    integer i;
    for(i = lpm_pipeline; i >= 1; i = i - 1)
    begin
	if (aclr)
	begin
	    rpipe[i] = {1{1'b0}};
	    cpipe[i] = 1'b0;
	    opipe[i] = 1'b0;
	end
	else
	begin
	    rpipe[i] = rpipe[i - 1];
	    cpipe[i] = cpipe[i - 1];
	    opipe[i] = opipe[i - 1];
	end
    end
end

assign   result = rpipe[lpm_pipeline];
assign     cout = cpipe[lpm_pipeline];
assign overflow = opipe[lpm_pipeline];

endmodule

//
//	mand
//

module mand (data, result);

    parameter	lpm_width = 1;
    parameter	lpm_size = 1;
    parameter	lpm_hint = `SPEED;
    parameter	lpm_data_pol = "NULL";
    parameter	lpm_result_pol = "NULL";
    input	[lpm_width * lpm_size - 1:0] data;
    output	[lpm_width - 1:0] result;
    reg		[lpm_width - 1:0] result;
    wire	[lpm_width * lpm_size - 1:0] d_pol;
    wire	[lpm_width - 1:0] r_pol;
    integer	n;
    integer	m;
    reg		[lpm_width * lpm_size - 1:0] tmp;

    assign d_pol = (lpm_data_pol == "NULL") ?
			{(lpm_width*lpm_size){1'b1}} : lpm_data_pol;
    assign r_pol = (lpm_result_pol == "NULL") ?
			{(lpm_width){1'b1}} : lpm_result_pol;

    always @data
	for (n = 0; n <= lpm_width - 1; n = n + 1)
	begin
	    tmp[n * lpm_size] = data[n] ^ ~d_pol[n];	

	    for (m = 1; m <= lpm_size - 1; m = m + 1)
		tmp[n * lpm_size + m] = tmp[n * lpm_size + m - 1] &
		    (data[m * lpm_width + n] ^ ~ d_pol[m * lpm_width + n]);
	    result[n] = tmp[(n + 1) * lpm_size - 1] ^ ~ r_pol[n];	
	end

endmodule

//
//	mbipad
//

module mbipad (data, enable, result, pad);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    input   enable;
    output  [lpm_width - 1:0] result;
    inout   [lpm_width - 1:0] pad;

    reg     [lpm_width - 1:0] ytemp;

    always @(data or enable)
	if (enable == 1'b1)
	    ytemp <= data;
	else
	    ytemp = {(lpm_width){1'bZ}};

    assign pad = ytemp;
    assign result = pad;

endmodule

//
//	mbuf
//

module mbuf (data, result);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    output  [lpm_width - 1:0] result;

    assign result = data;

endmodule

//
//	mbustri
//

module mbustri (tridata, data, enabletr, enabledt, result);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    inout   [lpm_width - 1:0] tridata;
    input   [lpm_width - 1:0] data;
    input   enabletr;
    input   enabledt;
    output  [lpm_width - 1:0] result;

    reg    [lpm_width - 1:0] ttridata;
    reg    [lpm_width - 1:0] tresult;
    reg    [lpm_width - 1:0] yfb;
    integer	i;

    always @(data or enabledt)
	for (i = 0; i < lpm_width; i = i + 1)
	    if (enabledt == 1'b1)
		if (data[i] == 1'b0)
		    ttridata[i] = 1'b0; 
		else if (data[i] == 1'b1)
		    ttridata[i] = 1'b1; 
		else
		    ttridata[i] = 1'bx; 
	    else
		ttridata[i] = 1'bZ;     

    always @(tridata)
	for (i = 0; i < lpm_width; i = i + 1)
	    if (tridata[i] == 1'b1)
		yfb[i] = 1'b1;       
	    else if (tridata[i] == 1'b0)
		yfb[i] = 1'b0;       
	    else
		yfb[i] = 1'bx;       

    always @(yfb or enabletr)
	for (i = 0; i < lpm_width; i = i + 1)
	    if (enabletr == 1'b1)
		if (yfb[i] == 1'b0)
		    tresult[i] = 1'b0;     
		else if (yfb[i] == 1'b1)
		    tresult[i] = 1'b1;     
		else
		    tresult[i] = 1'bx;     
	    else
		tresult[i] = 1'bZ;

    assign tridata = ttridata;
    assign result = tresult;

endmodule

//
//	mclshift
//

module mclshift (data, distance, direction, result, overflow, underflow);

    parameter lpm_width = 1;
    parameter lpm_widthdist = 1;
    parameter lpm_shifttype = `LPM_LOGICAL;
    parameter lpm_hint = `SPEED;
    input   [lpm_width-1:0] data;
    input   [lpm_widthdist-1:0] distance;
    input   direction;
    output  [lpm_width-1:0] result;
    output  overflow;
    output  underflow;

    wire [lpm_width-1:0] boutput;
    reg	 [lpm_width*lpm_width-1:0] barrel;
    reg	 [lpm_width-1:0] left,right,sign,mask,routput,loutput,aoutput,un,ov;
    integer	selval,index,i,j,k;

    wire OK = (distance <= lpm_width) ? 1 : 0;

    always @(data or direction)
	for (j = 0; j < lpm_width; j = j + 1)
	    for (k = 0; k < lpm_width; k = k + 1)
		barrel[j * lpm_width + k] = (direction == 1'b1) ?
		data[(j + k) % lpm_width] :
		data[((j*lpm_width)+k-j) % lpm_width];

    mmux #(lpm_width, lpm_width, lpm_widthdist, lpm_hint)
	U0 (barrel, distance, boutput);

    always @(distance or direction)
    begin
	for (i = 0 ; i < lpm_width; i = i + 1)
	begin
	    left[i]              = (i < distance) ? 1 : 0;
	    right[lpm_width-1-i] = (i < distance) ? 1 : 0;
	end
	mask = (direction == 1'b0) ? left : right;
    end

    always @(data or boutput or mask or right)
    begin
	sign = {lpm_width{data[lpm_width-1]}};
	routput = boutput;
	loutput = boutput & ~mask;
	aoutput[lpm_width-1] = (direction == 1'b0) ?
				data[lpm_width-1] :
				boutput[lpm_width-1] & ~mask[lpm_width-1] |
				right[lpm_width-1] & sign[lpm_width-1];
	aoutput[lpm_width-2:0] = (direction == 1'b0) ?
				boutput[lpm_width-2:0] & ~mask[lpm_width-2:0] :
				boutput[lpm_width-2:0] & ~mask[lpm_width-2:0] |
				right[lpm_width-2:0] & sign[lpm_width-2:0];

	ov[0] = (lpm_shifttype == `LPM_LOGICAL) ? boutput[0] & mask[0] :
					    (boutput[0] ^ sign[0]) & mask[0];
	un[0] = (lpm_shifttype == `LPM_LOGICAL) ? loutput[0] :
					    aoutput[0] ^ ~sign[0];
	for (i = 1 ; i < lpm_width; i = i + 1)
	begin
	    ov[i] = (lpm_shifttype == `LPM_LOGICAL) ?
		    ov[i-1] | (boutput[i] & mask[i]) :
		    ov[i-1] | (boutput[i] ^ sign[i]) & mask[i];
	    un[i] = (lpm_shifttype == `LPM_LOGICAL) ?
		    un[i-1] | loutput[i] :
		    un[i-1] & (aoutput[i] ^ ~sign[i]);
	end
    end

    assign result = lpm_shifttype == `LPM_ARITHMETIC & OK ? aoutput :
		    lpm_shifttype == `LPM_LOGICAL & OK ? loutput :
		    lpm_shifttype == `LPM_ROTATE ? routput :
		    lpm_shifttype == `LPM_ARITHMETIC & ~OK ?
				{(lpm_width){data[lpm_width-1]}} :
				{(lpm_width){1'b0}};

    assign overflow = lpm_shifttype == `LPM_ARITHMETIC ?
    ~direction & (ov[lpm_width-1] | boutput[lpm_width-1] ^ data[lpm_width-1]) :
	  lpm_shifttype == `LPM_LOGICAL ? ~direction & ov[lpm_width-1]: 1'b0;

    assign underflow = lpm_shifttype == `LPM_ARITHMETIC ?
	    direction &  un[lpm_width-1] :
	    lpm_shifttype == `LPM_LOGICAL ?
	    direction & ~un[lpm_width-1] : 1'b0;

endmodule

//
//	mcnstnt
//

module mcnstnt (result);

    parameter lpm_width = 1;
    parameter lpm_cvalue = "NULL";
    parameter lpm_hint = `SPEED;
    parameter lpm_strength = `LPM_NO_STRENGTH;
    output  [lpm_width - 1:0] result;

    assign result = lpm_cvalue;

endmodule

//
//	mcompare
//

module mcompare (dataa, datab, alb, aeb, agb, ageb, aleb, aneb, clock, aclr);

    parameter lpm_width = 1;
    parameter lpm_representation = `LPM_UNSIGNED;
    parameter lpm_hint = `SPEED;
    parameter lpm_pipeline = 0;
    input   [lpm_width - 1:0] dataa;
    input   [lpm_width - 1:0] datab;
    output  alb;
    output  aeb;
    output  agb;
    output  ageb;
    output  aleb;
    output  aneb;
    input   clock;
    input   aclr;

    reg [lpm_width-1:0]		a,b,xnor_array,lt,eq,gt;
    reg [(lpm_width-1):0]	eqi;
    reg [(lpm_width-1)+1:0]	aeqb;
    reg [(lpm_width-1):0]	lti,gti;
    reg [(lpm_width-1)+1:0]	albi,agbi;
    reg	[0:0]			sa,sb;
    integer	i,j;

    always @(dataa or datab)
    begin
	a = dataa;
	b = datab;
	sa = dataa[lpm_width-1];
	sb = datab[lpm_width-1];
	if (lpm_representation == `LPM_SIGNED)
	begin
	    a[lpm_width-1] = sb;
	    b[lpm_width-1] = sa;
	end
    end

    always @(a or b)
    begin
	xnor_array = ~(a ^ b);
	aeqb[0] = 1'b1;
	for (j = 0; j <= (lpm_width-1); j = j + 1)
	begin
	    eq[j] = xnor_array[j];

	    if (j != (lpm_width-1))
		eqi[j] = eq[(j)];
	    else
		eqi[j] = eq[lpm_width-1];

	    aeqb[j+1] = aeqb[j] & eqi[j];
	end

	albi[(lpm_width-1)+1] = 1'b0;
	agbi[(lpm_width-1)+1] = 1'b0;
	for (j = (lpm_width-1); j >= 0; j = j - 1)
	begin
	    lt[j] = b[j] & ~(a[j] & b[j]);
	    gt[j] = a[j] & ~(a[j] & b[j]);

	    if (j != (lpm_width-1))
	    begin
		lti[j] = lt[j];
		gti[j] = gt[j];
	    end
	    else
	    begin
		lti[j] = lt[lpm_width-1];
		gti[j] = gt[lpm_width-1];
	    end

	    albi[j] = albi[j+1] | (lti[j] & ~agbi[j+1]);
	    agbi[j] = agbi[j+1] | (gti[j] & ~albi[j+1]);
	end
    end

    reg[lpm_pipeline:0] eqpipe;
    reg[lpm_pipeline:0] ltpipe;
    reg[lpm_pipeline:0] gtpipe;

    always @(aeqb or albi or agbi)
    begin : PIPE_0
        eqpipe[0] = aeqb[lpm_width];
        ltpipe[0] = albi[0];
        gtpipe[0] = agbi[0];
    end

    always @(posedge aclr or posedge clock)
    begin : PIPE_N
	integer i;
	for(i = lpm_pipeline; i >= 1; i = i - 1)
	begin
	    if (aclr)
	    begin
		eqpipe[i] = 1'b0;
		ltpipe[i] = 1'b0;
		gtpipe[i] = 1'b0;
	    end
	    else
	    begin
		eqpipe[i] = eqpipe[i - 1];
		ltpipe[i] = ltpipe[i - 1];
		gtpipe[i] = gtpipe[i - 1];
	    end
	end
    end

    assign aeb  =  eqpipe[lpm_pipeline];
    assign aneb = ~eqpipe[lpm_pipeline];
    assign alb  =  ltpipe[lpm_pipeline];
    assign aleb = ~gtpipe[lpm_pipeline];
    assign agb  =  gtpipe[lpm_pipeline];
    assign ageb = ~ltpipe[lpm_pipeline];

endmodule

//
//	mcounter
//

module mcounter (data, clock, clk_en, cnt_en, updown, q, aset, aclr, aload,
		   sset, sclr, sload, testenab, testin, testout);

    parameter lpm_width = 1;
    parameter lpm_direction = `LPM_NO_DIR;
    parameter lpm_avalue = "NULL";
    parameter lpm_svalue = "NULL";
    parameter lpm_pvalue = "NULL";
    parameter lpm_hint = `SPEED;

    input   [lpm_width - 1:0] data;
    input   clock;
    input   clk_en;
    input   cnt_en;
    input   updown;
    output  [lpm_width - 1:0] q;
    input   aset;
    input   aclr;
    input   aload;
    input   sset;
    input   sclr;
    input   sload;
    input   testenab;
    input   testin;
    output  testout;

    reg     [lpm_width - 1:0] qtmp;
    reg     [lpm_width - 1:0] t;
    integer	i;

    initial qtmp = 0;
    initial t = 0;

    always @(data or clk_en or cnt_en or updown or qtmp or sset or sclr or sload
						    or t or testenab or testin)
	if (testenab == 1'b1)
	    t <= qtmp ^ {qtmp, testin};
	else if (sclr == 1'b1 & clk_en == 1'b1 )
	    t <= qtmp;	
	else if (sset == 1'b1 & clk_en == 1'b1 )
	    t <= ((lpm_svalue=="NULL")?{(lpm_width){1'b1}}:lpm_svalue) ^ qtmp;
	else if (sload == 1'b1 & clk_en == 1'b1 )
	    t <= data ^ qtmp;	
	else if (cnt_en == 1'b1 & clk_en == 1'b1 )
	begin
	    t[0] = 1;
	    for (i = 1; i < lpm_width; i = i + 1)
		if ((lpm_direction == `LPM_UP) |
				(lpm_direction == `LPM_NO_DIR & updown == 1'b1))
		    t[i] = t[i-1] && qtmp[i-1];
		else if ((lpm_direction == `LPM_DOWN) |
				(lpm_direction == `LPM_NO_DIR & updown == 1'b0))
		    t[i] = t[i-1] && ~qtmp[i-1];
	end
	else
	    t <= {(lpm_width){1'b0}};	

    always @(posedge aclr or posedge aset or posedge aload or posedge clock)
	if (aclr == 1'b1)
	    qtmp <= {(lpm_width){1'b0}};	
	else if (aset == 1'b1)
	    qtmp <= (lpm_avalue=="NULL") ? {(lpm_width){1'b1}} : lpm_avalue;
	else if (aload == 1'b1)
	    qtmp <= data;
	else
	    qtmp <= t ^ qtmp;

    assign testout = qtmp[lpm_width - 1];
    assign q = qtmp;

endmodule

//
//	mdecode
//

module mdecode (data, enable, eq);

    parameter lpm_width = 1;
    parameter lpm_decodes = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    input   enable;
    output  [lpm_decodes - 1:0] eq;

    reg	[lpm_decodes - 1:0] o;
    integer	i;

    always @(data or enable)
	for (i = 0; i < lpm_decodes; i = i + 1)
	    o[i] = (enable == 1'b1 & i == data) ? 1'b1 : 1'b0;

    assign eq = o;

endmodule

//
//	mff
//

module mff (data, clock, enable, q, aset, aclr, aload, sset, sclr, sload,
	    testenab, testin, testout);

    parameter lpm_width = 1;
    parameter lpm_fftype = `LPM_DFF;
    parameter lpm_avalue = "NULL";
    parameter lpm_svalue = "NULL";
    parameter lpm_pvalue = "NULL";
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    input   clock;
    input   enable;
    output  [lpm_width - 1:0] q;
    input   aset;
    input   aclr;
    input   aload;
    input   sset;
    input   sclr;
    input   sload;
    input   testenab;
    input   testin;
    output  testout;
    reg     [lpm_width - 1:0] qtmp;
    reg     [lpm_width - 1:0] d;

    always @(data or sset or sclr or sload or enable or testin or testenab or qtmp)
       if (testenab == 1'b1)
	  begin
	  d <= {qtmp, testin};
	  end
       else if (sclr == 1'b1 & enable == 1'b1)
	  d <= {(lpm_width){1'b0}};	
       else if (sset == 1'b1 & enable == 1'b1)
	  if (lpm_svalue == "NULL")
	      d <= {(lpm_width){1'b1}};	
	  else
	      d <= lpm_svalue;
       else if (sload == 1'b1 & enable == 1'b1)
	  d <= data;	
       else if (enable == 1'b1)
	  if (lpm_fftype == `LPM_TFF)
	     d <= data ^ qtmp;	
	  else
	     d <= data;	
       else
	  d <= qtmp;	

    always @(posedge aclr or posedge aset or aload or posedge clock)
	if (aclr == 1'b1)
	    qtmp <= {(lpm_width){1'b0}};	
	else if (aset == 1'b1)
	    if (lpm_avalue == "NULL")
		qtmp <= {(lpm_width){1'b1}};	
	    else
		qtmp <= lpm_avalue;
	else if (aload == 1'b1)
	    qtmp <= data;
	else
	    qtmp <= d;

    assign testout = qtmp[lpm_width - 1];
    assign q = qtmp;

endmodule

//
//	mgnd
//

module mgnd (x);

    parameter lpm_width = 1;
    output  [lpm_width - 1:0] x;

    assign x = {(lpm_width){1'b0}};

endmodule

//
//	minpad
//

module minpad (result, pad);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    output  [lpm_width - 1:0] result;
    input   [lpm_width - 1:0] pad;

    assign result = pad;

endmodule

//
//	minv
//

module minv (data, result);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    output  [lpm_width - 1:0] result;

    assign result = ~data;

endmodule

//
//	mlatch
//

module mlatch (data, gate, q, aset, aclr);

    parameter lpm_width = 1;
    parameter lpm_avalue = "NULL";
    parameter lpm_pvalue = "NULL";
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    input   gate;
    output  [lpm_width - 1:0] q;
    input   aset;
    input   aclr;

    reg	[lpm_width - 1:0] qtmp;
    reg	[lpm_width - 1:0] set;
    integer	i;

    initial qtmp = 0;

    always @(data or gate or aset or aclr)
    begin
	if (lpm_avalue == "NULL")
	    set <= {(lpm_width){1'b1}};       
	else
	    set <= lpm_avalue;

	for (i = 0; i < lpm_width; i = i + 1)
	    qtmp[i] = ~aclr &
		    ((aset & set[i]) | (data[i] & gate) | (qtmp[i] & ~gate));

    end

    assign q = qtmp;

endmodule

//
//	mmult
//

module mmult (dataa, datab, sum, result);

    parameter lpm_widtha = 1;
    parameter lpm_widthb = 1;
    parameter lpm_widths = 0;
    parameter lpm_widthp = 2;
    parameter lpm_representation = `LPM_UNSIGNED;
    parameter lpm_hint = `SPEED;
    parameter lpm_avalue = "NULL";
    input   [lpm_widtha-1:0] dataa;
    input   [lpm_widthb-1:0] datab;
    input   [lpm_widths-1:0] sum;
    output  [lpm_widthp-1:0] result;

    reg	[lpm_widtha-1:0] a,swa;
    reg	[lpm_widthb-1:0] b,swb;
    integer	tp,p,swp;
    integer	i;

    integer	x;
    reg	[lpm_widthp-1:0] r;

    initial
	if ((lpm_representation == `LPM_SIGNED) &
		((lpm_widtha <= 1) | (lpm_widthb <= 1)))
	begin
	    $display("Signed multiply with input lengths of 1 are illegal.\n");
	    $finish;
	end

    always @(dataa or datab or sum)
    begin
	if (lpm_representation == `LPM_SIGNED)
	begin
	    a[0] = dataa[0];
	    swa[0] = dataa[0] & dataa[lpm_widtha-1];
	    for (i = 1; i <= lpm_widtha-1; i = i + 1)
	    begin
		swa[i] = (swa[i-1] | dataa[i]) & dataa[lpm_widtha-1];
		a[i] =  swa[i-1] ^ dataa[i];
	    end

	    b[0] = datab[0];
	    swb[0] = datab[0] & datab[lpm_widthb-1];
	    for (i = 1; i <= lpm_widthb-1; i = i + 1)
	    begin
		swb[i] = (swb[i-1] | datab[i]) & datab[lpm_widthb-1];
		b[i] =  swb[i-1] ^ datab[i];
	    end

	    tp = a * b;

	    if (dataa[lpm_widtha-1] != datab[lpm_widthb-1])
	    begin
		p[0] = tp[0];
		swp[0] = tp[0];
		for (i = 1; i <= lpm_widthp-1; i = i + 1)
		begin
		    swp[i] = (swp[i-1] | tp[i]);
		    p[i] =  swp[i-1] ^ tp[i];
		end
	    end
	    else
		p = a * b;
	end
	else
	    p = dataa * datab;

	if (lpm_widths == 0)
	    x = p;
	else
	    x = p + sum;

	if (((lpm_widtha+lpm_widthb) > lpm_widthp) | (lpm_widths > lpm_widthp))
	    if ((lpm_widtha+lpm_widthb) > lpm_widths)
		for (i = 0; i <= lpm_widthp-1; i = i + 1)
		    r[i] = x[i+lpm_widtha+lpm_widthb-lpm_widthp];
	    else
		for (i = 0; i <= lpm_widthp-1; i = i + 1)
		    r[i] = x[i+lpm_widths-lpm_widthp];
	else
	    r = x;
    end

    assign result = r;

endmodule

//
//	mmux
//

module mmux (data, sel, result);

    parameter lpm_width = 1;
    parameter lpm_size = 1;
    parameter lpm_widths = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width * lpm_size - 1:0] data;
    input   [lpm_widths - 1:0] sel;
    output  [lpm_width - 1:0] result;

    reg     [lpm_width - 1:0] result;
    integer selval;
    integer index;
    integer i;

    always @(data or sel)
    begin 
	index = 0;
	for (selval = 0; selval <= (2 << lpm_widths - 1) - 1; selval = selval+1)
	if(((lpm_width*(selval+1)-1) <= (lpm_width*lpm_size-1)) & (selval==sel))
	    for (i = (lpm_width*selval); i <= ((lpm_width*(selval+1))-1); i=i+1)
	    begin
		result[index] = data[i];
		index = index + 1;
	    end
    end

endmodule

//
//	mor
//

module mor (data, result);

    parameter	lpm_width = 1;
    parameter	lpm_size = 1;
    parameter	lpm_hint = `SPEED;
    parameter	lpm_data_pol = "NULL";
    parameter	lpm_result_pol = "NULL";
    input	[lpm_width * lpm_size - 1:0] data;
    output	[lpm_width - 1:0] result;
    reg		[lpm_width - 1:0] result;
    wire	[lpm_width * lpm_size - 1:0] d_pol;
    wire	[lpm_width - 1:0] r_pol;
    integer	n;
    integer	m;
    reg		[lpm_width * lpm_size - 1:0] tmp;

    assign d_pol = (lpm_data_pol == "NULL") ?
			{(lpm_width*lpm_size){1'b1}} : lpm_data_pol;
    assign r_pol = (lpm_result_pol == "NULL") ?
			{(lpm_width){1'b1}} : lpm_result_pol;

    always @data
	for (n = 0; n <= lpm_width - 1; n = n + 1)
	begin
	    tmp[n * lpm_size] = data[n] ^ ~d_pol[n];	

	    for (m = 1; m <= lpm_size - 1; m = m + 1)
		tmp[n * lpm_size + m] = tmp[n * lpm_size + m - 1] |
		    (data[m * lpm_width + n] ^ ~ d_pol[m * lpm_width + n]);
	    result[n] = tmp[(n + 1) * lpm_size - 1] ^ ~ r_pol[n];	
	end

endmodule

//
//	moutpad
//

module moutpad (data, pad);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    output  [lpm_width - 1:0] pad;

    assign pad = data;

endmodule

//
//	mparity
//

module mparity (data, even, odd, clock, aclr);

    parameter lpm_width = 1;
    parameter lpm_hint = `SPEED;
    parameter lpm_pipeline = 0;
    input   [lpm_width - 1:0] data;
    output  even;
    output  odd;
    input   clock;
    input   aclr;

    reg[lpm_pipeline:0] oddpipe;

    always @(data)
    begin : PIPE_0
	integer i;
	oddpipe[0] = data[0];
	for (i = 1; i < lpm_width; i = i + 1)
		oddpipe[0] = oddpipe[0] ^ data[i];
    end

    always @(posedge aclr or posedge clock)
    begin : PIPE_N
	integer i;
	for(i = lpm_pipeline; i >= 1; i = i - 1)
	begin
	    if (aclr)
	    begin
		oddpipe[i] = 1'b0;
	    end
	    else
	    begin
		oddpipe[i] = oddpipe[i - 1];
	    end
	end
    end

    assign odd =  oddpipe[lpm_pipeline];
    assign even= ~oddpipe[lpm_pipeline];

endmodule

//
//	mshiftreg
//

module mshiftreg (data, clock, enable, shiftin, load, q, shiftout, aset, aclr,
		    sset, sclr, testenab, testin, testout);

    parameter lpm_width = 1;
    parameter lpm_direction = `LPM_LEFT;
    parameter lpm_avalue = "NULL";
    parameter lpm_svalue = "NULL";
    parameter lpm_pvalue = "NULL";
    parameter lpm_hint = `SPEED;
    input   [lpm_width - 1:0] data;
    input   clock;
    input   enable;
    input   shiftin;
    input   load;
    output  [lpm_width - 1:0] q;
    output  shiftout;
    input   aset;
    input   aclr;
    input   sset;
    input   sclr;
    input   testenab;
    input   testin;
    output  testout;

    reg     [lpm_width - 1:0] qtmp;
    reg     [lpm_width - 1:0] d;

    always @(data or sset or sclr or load or enable
	     or shiftin or testin or testenab or qtmp)
	if (testenab == 1'b1)
	begin
	    d[0] <= testin;	
	    if (lpm_width > 1)
		d[lpm_width - 1:1] <= qtmp[lpm_width - 1 - 1:0];	
	end
	else if (sclr == 1'b1 & enable == 1'b1 )
	    d <= {(lpm_width - 1 - 0 + 1){1'b0}};	
	else if (sset == 1'b1 & enable == 1'b1 )
	    if (lpm_svalue == "NULL")
		d <= {(lpm_width){1'b1}};	
	    else
		d <= lpm_svalue;
	else if (load == 1'b1 & enable == 1'b1 )
	    d <= data;	
	else if (enable == 1'b1 )
	    if (lpm_direction == `LPM_LEFT)
	    begin
		d[0] <= shiftin;	
		if (lpm_width > 1)
		    d[lpm_width - 1:1] <= qtmp[lpm_width - 2:0];	
	    end
	    else
	    begin
		d[lpm_width - 1] <= shiftin;	
		if (lpm_width > 1)
		    d[lpm_width - 2:0] <= qtmp[lpm_width - 1:1];	
	    end
	else
	    d <= qtmp;	

    always @(posedge aclr or posedge aset or posedge clock)
	if (aclr == 1'b1)
	    qtmp <= {(lpm_width){1'b0}};	
	else if (aset == 1'b1)
	    if (lpm_avalue == "NULL")
		qtmp <= {(lpm_width){1'b1}};	
	    else
		qtmp <= lpm_avalue;
	else
	    qtmp <= d;

    assign shiftout = lpm_direction == `LPM_LEFT ?
	qtmp[lpm_width - 1] & ~load & ~testenab : qtmp[0] & ~load & ~ testenab;
    assign testout = qtmp[lpm_width - 1];
    assign q = qtmp;

endmodule

//
//	mvcc
//

module mvcc (x);

    parameter lpm_width = 1;
    output  [lpm_width - 1:0] x;

    assign x = {(lpm_width){1'b1}};

endmodule

//
//	mxor
//

module mxor (data, result);

    parameter	lpm_width = 1;
    parameter	lpm_size = 1;
    parameter	lpm_hint = `SPEED;
    parameter	lpm_data_pol = "NULL";
    parameter	lpm_result_pol = "NULL";
    input	[lpm_width * lpm_size - 1:0] data;
    output	[lpm_width - 1:0] result;
    reg		[lpm_width - 1:0] result;
    wire	[lpm_width * lpm_size - 1:0] d_pol;
    wire	[lpm_width - 1:0] r_pol;
    integer	n;
    integer	m;
    reg		[lpm_width * lpm_size - 1:0] tmp;

    assign d_pol = (lpm_data_pol == "NULL") ?
			{(lpm_width*lpm_size){1'b1}} : lpm_data_pol;
    assign r_pol = (lpm_result_pol == "NULL") ?
			{(lpm_width){1'b1}} : lpm_result_pol;

    always @data
	for (n = 0; n <= lpm_width - 1; n = n + 1)
	begin
	    tmp[n * lpm_size] = data[n] ^ ~d_pol[n];	

	    for (m = 1; m <= lpm_size - 1; m = m + 1)
		tmp[n * lpm_size + m] = tmp[n * lpm_size + m - 1] ^
		    (data[m * lpm_width + n] ^ ~ d_pol[m * lpm_width + n]);
	    result[n] = tmp[(n + 1) * lpm_size - 1] ^ ~ r_pol[n];	
	end

endmodule

//
//	cy_fifo
//

module cy_fifo(data,q,enr,enw,readclock,writeclock,mrb,efb,hfb,pafeb);

parameter lpm_width = 1;
parameter lpm_numwords = 1;
parameter lpm_pafe_length = 0;
parameter lpm_hint = `SPEED;

input   [lpm_width - 1:0] data;
output  [lpm_width - 1:0] q;
input   enr;
input   enw;
input   readclock;
input   writeclock;
input   mrb;
output  efb;
output  hfb;
output  pafeb;

reg	[lpm_width - 1:0] q;
wire	efb;
reg	hfb;
wire	pafeb;
reg	[lpm_width-1:0] mem [lpm_numwords-1:0];
reg	empty;
reg	full;
reg	paem;
reg	pafl;

integer  index;
integer  wadd;
integer  radd;

initial
begin
    radd = 0;
    wadd = 0;
    index = 0;
    full = 1'b 1;
    pafl = 1'b 1;
    paem = 1'b 0;
    empty = 1'b 0;
end

always @(negedge mrb)
begin
    index = 0;
    wadd  = 0;
    radd  = 0;
    full = 1'b 1;
    pafl = 1'b 1;
    paem = 1'b 0;
    empty = 1'b 0;
    hfb <= 1'b 1;
    q <= {lpm_width{1'b 0}};
end

always @(posedge writeclock)
begin
    if ((enw == 1'b1) && (index < lpm_numwords) && (mrb == 1'b1)
						&& (full != 1'b0))
    begin
	index = index + 1;
	mem[wadd] = data;
	wadd = wadd + 1;
	if (wadd >= lpm_numwords)
	    wadd = 0;
    end
    if (index >= lpm_numwords)
	full = 1'b0;
    else
	full = 1'b1;
    if (index >= lpm_numwords / 2)
	hfb <= 1'b 0;
    else
	hfb <= 1'b 1;
    if (lpm_numwords-index <= lpm_pafe_length)
    	pafl = 1'b 0;
    else
    	pafl = 1'b 1;
end

always @(posedge readclock)
begin
    if ((enr == 1'b1) && (index > 0) && (mrb == 1'b1)
				     && (empty != 1'b0))
    begin
	index = index - 1;
	q <= mem[radd];
	radd = radd + 1;
	if (radd >= lpm_numwords)
	    radd = 0;
    end
    if (index <= 0)
	empty = 1'b0;
    else
	empty = 1'b1;
    if (index >= lpm_numwords / 2)
	hfb <= 1'b 0;
    else
	hfb <= 1'b1;
    if (index <= lpm_pafe_length)
    	paem = 1'b0;
    else
    	paem = 1'b1;
end

assign   efb = empty & full;
assign pafeb = full & empty & pafl & paem;

endmodule

//
//	cy_ram_dp
//

module cy_ram_dp(data_a,data_b,address_a,address_b,q_a,q_b,addr_matchb,wea,web,
       inclock_a, inclock_b, outclock_a, outclock_b, outrega_ar, outregb_ar);

parameter lpm_width = 1;
parameter lpm_widthad = 1;
parameter lpm_numwords = 1;
parameter lpm_indata = `LPM_REGISTERED;
parameter lpm_address_control = `LPM_REGISTERED;
parameter lpm_outdata_a = `LPM_REGISTERED;
parameter lpm_outdata_b = `LPM_REGISTERED;
parameter lpm_file = "NULL";
parameter lpm_hint = `SPEED;

input   [lpm_width-1:0] data_a;
input   [lpm_width-1:0] data_b;
input   [lpm_widthad-1:0] address_a;
input   [lpm_widthad-1:0] address_b;
output  [lpm_width-1:0] q_a;
output  [lpm_width-1:0] q_b;
output	addr_matchb;
input   wea;
input   web;
input   inclock_a;
input   inclock_b;
input   outclock_a;
input   outclock_b;
input   outrega_ar;
input   outregb_ar;

reg	[lpm_width-1:0] q_a;
reg	[lpm_width-1:0] q_b;
reg	[lpm_width-1:0] dtmp_a;
reg	[lpm_width-1:0] dtmp_b;
reg	[lpm_width-1:0] qtmp_a;
reg	[lpm_width-1:0] qtmp_b;
reg	[lpm_width-1:0] mem [(2 << lpm_widthad-1)-1:0];
reg	wreg_a;
reg	wreg_b;
reg	wtmp_a;
reg	wtmp_b;
reg	busy;

integer atmp_a;
integer atmp_b;
integer i_a,i_b;

initial
    if (lpm_numwords != (2 << lpm_widthad-1))
    $display ("Note: lpm_widthad and lpm_numwords don't agree, lpm_widthad being used.");

initial		// Pre-load the memory
begin
    busy <= 1;
    if (lpm_file != "NULL")
    begin
	$cy_hex2ver(lpm_file, lpm_width);
	$readmemh("vlg_data.ver", mem);
    end
end

assign addr_matchb = busy;

always @(posedge inclock_a or address_a)
    if (lpm_address_control == `LPM_REGISTERED)
	@(posedge inclock_a) atmp_a = address_a;
    else
	atmp_a <= address_a;

always @(posedge inclock_a or data_a)
    if (lpm_indata == `LPM_REGISTERED)
	@(posedge inclock_a) dtmp_a = data_a;
    else
	dtmp_a <= data_a;

always @(posedge inclock_a or wea)
    if (lpm_address_control == `LPM_REGISTERED)
    begin
	@(posedge inclock_a) wreg_a = wea;
	assign wtmp_a = wreg_a & inclock_a;
    end
    else
	wtmp_a <= wea;

always @(posedge outrega_ar or posedge outclock_a or qtmp_a)
    if (lpm_outdata_a == `LPM_REGISTERED)
	if (outrega_ar == 1'b 1)
	    @(posedge outclock_a) q_a <= {lpm_width{1'b 0}};
	else
	    @(posedge outclock_a) q_a <= qtmp_a;
    else
	q_a <= qtmp_a;

always @(dtmp_a or atmp_a or wtmp_a or dtmp_b or atmp_b or wtmp_b)
begin
    if (atmp_a == atmp_b)
    begin
    	busy <= 1'b0;
	if (wtmp_a == 1'b1)
	    mem[atmp_a] <= dtmp_a;
	else
	if (wtmp_b == 1'b1)
	    mem[atmp_b] <= dtmp_b;
    end
    else
    begin
    	busy <= 1'b1;
	if (wtmp_a == 1'b1)
	    mem[atmp_a] <= dtmp_a;

	if (wtmp_b == 1'b1)
	    mem[atmp_b] <= dtmp_b;
    end
    qtmp_a <= mem[atmp_a];
    qtmp_b <= mem[atmp_b];
end

always @(posedge inclock_b or address_b)
    if (lpm_address_control == `LPM_REGISTERED)
	@(posedge inclock_b) atmp_b = address_b;
    else
	atmp_b <= address_b;

always @(posedge inclock_b or data_b)
    if (lpm_indata == `LPM_REGISTERED)
	@(posedge inclock_b) dtmp_b = data_b;
    else
	dtmp_b <= data_b;

always @(posedge inclock_b or web)
    if (lpm_address_control == `LPM_REGISTERED)
    begin
	@(posedge inclock_b) wreg_b = web;
	assign wtmp_b = wreg_b & inclock_b;
    end
    else
	wtmp_b <= web;

always @(posedge outregb_ar or posedge outclock_b or qtmp_b)
    if (lpm_outdata_b == `LPM_REGISTERED)
	if (outregb_ar == 1'b 1)
	    @(posedge outclock_b) q_b <= {lpm_width{1'b 0}};
	else
	    @(posedge outclock_b) q_b <= qtmp_b;
    else
	q_b <= qtmp_b;

endmodule

//
//	mram_dq
//

module mram_dq (data, address, q, inclock, outclock, we, outreg_ar);

parameter lpm_width = 1;
parameter lpm_widthad = 1;
parameter lpm_numwords = 1;
parameter lpm_indata = `LPM_REGISTERED;
parameter lpm_address_control = `LPM_REGISTERED;
parameter lpm_outdata = `LPM_REGISTERED;
parameter lpm_file = "NULL";
parameter lpm_hint = `SPEED;

input   [lpm_width-1:0] data;
input   [lpm_widthad-1:0] address;
output  [lpm_width-1:0] q;
input   inclock;
input   outclock;
input   we;
input   outreg_ar;

reg	[lpm_width-1:0] q;
reg	[lpm_width-1:0] dtmp;
reg	[lpm_width-1:0] qtmp;
reg	[lpm_width-1:0] mem [(2 << lpm_widthad-1)-1:0];
reg	wreg;
reg	wtmp;

integer	atmp;

initial
    if (lpm_numwords != (2 << lpm_widthad-1))
    $display ("Note: lpm_widthad and lpm_numwords don't agree, lpm_widthad being used.");

initial		// Pre-load the memory
    if (lpm_file != "NULL")
    begin
	$cy_hex2ver(lpm_file, lpm_width);
	$readmemh("vlg_data.ver", mem);
    end

always @(posedge inclock or address)
    if (lpm_address_control == `LPM_REGISTERED)
	@(posedge inclock) atmp = address;
    else
	atmp <= address;

always @(posedge inclock or data)
    if (lpm_indata == `LPM_REGISTERED)
	@(posedge inclock) dtmp = data;
    else
	dtmp <= data;

always @(posedge inclock or we)
    if (lpm_address_control == `LPM_REGISTERED)
    begin
	@(posedge inclock) wreg = we;
	assign wtmp = wreg & inclock;
    end
    else
	wtmp <= we;

always @(dtmp or atmp or wtmp)
begin
    if (wtmp == 1'b 1)
	mem[atmp] <= dtmp;
    qtmp <= mem[atmp];
end

always @(posedge outreg_ar or posedge outclock or qtmp)
    if (lpm_outdata == `LPM_REGISTERED)
	if (outreg_ar == 1'b 1)
	    @(posedge outclock) q = {lpm_width{1'b 0}};
	else
	    @(posedge outclock) q = qtmp;
    else
	q <= qtmp;

endmodule

//
//	mram_io
//

module mram_io (dio,address,inclock,outclock,memenab,outenab,we,outreg_ar);

parameter lpm_width = 1;
parameter lpm_widthad = 1;
parameter lpm_numwords = 1;
parameter lpm_indata = `LPM_REGISTERED;
parameter lpm_address_control = `LPM_REGISTERED;
parameter lpm_outdata = `LPM_REGISTERED;
parameter lpm_file = "NULL";
parameter lpm_hint = `SPEED;

inout   [lpm_width-1:0] dio;
input   [lpm_widthad-1:0] address;
input   inclock;
input   outclock;
input   memenab;
input   outenab;
input   we;
input   outreg_ar;

reg	[lpm_width-1:0] qio;
reg	[lpm_width-1:0] q;
reg	[lpm_width-1:0] dtmp;
reg	[lpm_width-1:0] qtmp;
reg	[lpm_width-1:0] mem [(2 << lpm_widthad-1)-1:0];
reg	wreg;
reg	wtmp;
wire	mw, mr;

integer	atmp;

assign (pull1,pull0) memenab = 1;

initial
    if (lpm_numwords != (2 << lpm_widthad-1))
    $display ("Note: lpm_widthad and lpm_numwords don't agree, lpm_widthad being used.");

assign mw = memenab & (we & ~outenab);
assign mr = memenab & ~(we & ~outenab);

initial		// Pre-load the memory
    if (lpm_file != "NULL")
    begin
	$cy_hex2ver(lpm_file, lpm_width);
	$readmemh("vlg_data.ver", mem);
    end

always @(posedge inclock or address)
    if (lpm_address_control == `LPM_REGISTERED)
	@(posedge inclock) atmp = address;
    else
	atmp <= address;

always @(posedge inclock or dio)
    if (lpm_indata == `LPM_REGISTERED)
	@(posedge inclock) dtmp = dio;
    else
	dtmp <= dio;

always @(posedge inclock or mw)
    if (lpm_address_control == `LPM_REGISTERED)
    begin
	@(posedge inclock) wreg = mw;
	assign wtmp = wreg & inclock;
    end
    else
	wtmp <= mw;

always @(dtmp or atmp or wtmp)
begin
    if (wtmp == 1'b 1)
	mem[atmp] <= dtmp;
    qtmp <= mem[atmp];
end

always @(posedge outreg_ar or posedge outclock or qtmp)
    if (lpm_outdata == `LPM_REGISTERED)
	if (outreg_ar == 1'b 1)
	    @(posedge outclock) q = {lpm_width{1'b 0}};
	else
	    @(posedge outclock) q = qtmp;
    else
	q <= qtmp;

always @(q or mr)
    if (mr == 1'b 1)
	qio <= q;
    else
	qio <= {lpm_width{1'b z}};

assign dio = qio;

endmodule

//
//	mrom
//

module mrom (address,q,inclock,outclock,memenab,outreg_ar);

parameter lpm_width = 1;
parameter lpm_widthad = 1;
parameter lpm_numwords = 1;
parameter lpm_address_control = `LPM_REGISTERED;
parameter lpm_outdata = `LPM_REGISTERED;
parameter lpm_file = "NULL";
parameter lpm_hint = `SPEED;

input   [lpm_widthad-1:0] address;
output  [lpm_width-1:0] q;
input   inclock;
input   outclock;
input   memenab;
input   outreg_ar;

reg	[lpm_width-1:0] q;
reg	[lpm_width-1:0] qx;
reg	[lpm_width-1:0] qtmp;
reg	[lpm_width-1:0] mem [(2 << lpm_widthad-1)-1:0];

integer	atmp;

assign (pull1,pull0) memenab = 1;

initial
    if (lpm_numwords != (2 << lpm_widthad-1))
    $display ("Note: lpm_widthad and lpm_numwords don't agree, lpm_widthad being used.");

initial		// Pre-load the memory
    if (lpm_file != "NULL")
    begin
	$cy_hex2ver(lpm_file, lpm_width);
	$readmemh("vlg_data.ver", mem);
    end

always @(posedge inclock or address)
    if (lpm_address_control == `LPM_REGISTERED)
	@(posedge inclock) atmp = address;
    else
	atmp <= address;

always @(atmp)
    qtmp <= mem[atmp];

always @(posedge outreg_ar or posedge outclock or qtmp)
    if (lpm_outdata == `LPM_REGISTERED)
	if (outreg_ar == 1'b 1)
	    @(posedge outclock) qx = {lpm_width{1'b 0}};
	else
	    @(posedge outclock) qx = qtmp;
    else
	qx <= qtmp;

always @(qx or memenab)
    if (memenab == 1'b 1)
	q <= qx;
    else
	q <= {lpm_width{1'b z}};

endmodule
`endif
`endif
