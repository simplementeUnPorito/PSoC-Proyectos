-- /*******************************************************************************
-- * Copyright 1993-2001, 2009, Cypress Semiconductor Corporation.  All rights reserved.
-- * You may use this file only in accordance with the license, terms, conditions, 
-- * disclaimers, and limitations in the end user license agreement accompanying 
-- * the software package with which this file was provided.
-- ********************************************************************************/

PACKAGE cypress IS

    TYPE rtl IS (
	DLTCH_type,
	DFF_type,
	XDFF_type,
	JKFF_type,
	BUF_type,
	BUFOE_type,
        SRL_type,
	SRFF_type,
	DSRFF_type,
	DPRFF_type,
	DPCFF_type,
	TFF_type,
	MC_C22V10_type,
	MC_C22VP10_type,
	MC_C610_type,
        MC_C330_type,
        IR_C330_type,
	MC_C333_type,
	MC_C335_type,
        IR_C335_type,
        MC_C340_type,
        MC_C340_B_type,
        FB_C340_type,
	IDFF_type,
	XBUF_type,
	TRIOUT_type,
        DSRLCH_type,
        TSRFF_type,
	IR_C331_type,
	PApbc_type,		-- unused
	PAincell_type,		-- unused
	PAbicell_type,		-- unused
	PAckcell_type,		-- unused
	PAfrag_a_type,		-- unused
	PAfrag_f_type,		-- unused
	PAfrag_m_type,		-- unused
	PAfrag_q_type,		-- unused
	PAlcell_type,		-- unused
        PAmacro_type,		-- unused
        PAclkbuf_type,		-- unused
	RTL_generic,		-- For special purposes, highly experimental
	NOT_RTL_type,
        NOT_ALLOWED_type
    );

-------------------------------------------------------------------------------
--  For internal Warp use:
-------------------------------------------------------------------------------
    ATTRIBUTE atomic_rtl	: RTL;		-- Used on RTL components.
    attribute replacement_rtl	: string;	-- Mark impending obsolesence.
    ATTRIBUTE no_op		: BOOLEAN;	-- used on type conversion
    --  Builtin FILE I/O routine attributes:
    TYPE fileio_types IS (
	FR_none,			-- Not one of ours.
	FR_read_file,			-- Read value into a file.
	FR_write_file,			-- Write value to a file.
	FR_end_file,			-- Function to test EOF.
	FR_read_line,			-- Read a line.
	FR_textio_read,			-- One of the formatted readers.
	FR_write_line,			-- Write a line.
	FR_textio_write			-- Formatted write.
    );
    ATTRIBUTE fileio_builtin	: fileio_types;
    CONSTANT  nd_auto	: NATURAL := 3201;	-- automaticly assigned node.
    CONSTANT  nd_delete	: NATURAL := 3202;	-- force node to be deleted.

    TYPE port_state_type IS (
        ps_tied_low,    -- Tied to '0'.
        ps_tied_high,   -- Tied to '1'.
        ps_open,        -- Unconnected.
        ps_connected    -- Connected to a signal.
    );
    ATTRIBUTE port_state_att : port_state_type;
    ATTRIBUTE ultragen : string;         --  Module to subst.
    ATTRIBUTE globally_static : boolean; --  Magic att. for testing ports.

---------------------------------------------------------------------------
--  Synthesis attributes: -- Will not be available in Warp 5.0
---------------------------------------------------------------------------
    ATTRIBUTE soft		: BOOLEAN;	-- force to expander
    ATTRIBUTE mcell		: BOOLEAN;	-- force to macrocell

---------------------------------------------------------------------------
--  Synthesis attributes: -- The following are Obsolete as of 4.2
---------------------------------------------------------------------------
    ATTRIBUTE dont_touch        : BOOLEAN;      -- Don't optimize. (Obsolete)
    ATTRIBUTE fixed_ff          : STRING;       -- Fixed Flip-Flop.
    ATTRIBUTE max_load          : INTEGER;      -- Max. load on a signal.
    TYPE pad_gen_type IS (
        pad_none,       -- pad generation off (really forces an IO)
        pad_auto,       -- software selects best one (the default)
	pad_clock,	-- force clock pad
	pad_hd1,	-- force input pad (hd1 pad)
	pad_hd2,	-- force hd2 pad
	pad_hd3,	-- force hd3 pad
	pad_hd4,	-- force hd4 pad
	pad_io		-- force a normal io pad
    );
    ATTRIBUTE pad_gen : pad_gen_type ;

    TYPE buffer_type IS (
	buf_none,	-- No buffer
	buf_auto,	-- Software selects buffer type (the default)
	buf_normal,	-- Force normal buffering
	buf_split,	-- UNSUPPORTED **DO NOT USE**
	buf_duplicate,	-- Force duplicate logic
	buf_register	-- Force register duplication
    );
    ATTRIBUTE buffer_gen : buffer_type ;

---------------------------------------------------------------------------
--  Synthesis attributes:
---------------------------------------------------------------------------


    --  Default Unit Delay for simulation.
    CONSTANT unit_delay	: TIME	:= 1 ns;


------------- %%BEGIN AUTOSECTION -----------------------------------------
	ATTRIBUTE bus_hold : boolean ;

	ATTRIBUTE channel_mem_loc : string ;

	ATTRIBUTE clock_driver : string ;

	ATTRIBUTE cluster_group : string ;

	ATTRIBUTE cluster_mem_loc : string ;

	ATTRIBUTE cpu_access : boolean ;

	TYPE cy_mem_types IS (
		cy_mem_auto,
		cy_mem_channel,
		cy_mem_cluster
	);
	ATTRIBUTE cy_memory_type : cy_mem_types ;

	ATTRIBUTE enum_encoding : string ;

	TYPE flipflop_type IS (
		ff_d,		-- "Forces flip flop selection to D type"
		ff_t,		-- "Forces flip flop selection to T type"
		ff_opt,		-- "Allows software to select optimum flip flop"
		ff_default		-- "Flip flop is assigned based on default"
	);
	ATTRIBUTE ff_type : flipflop_type ;

	TYPE goal_type IS (
		speed,
		area,
		combinatorial,
		memory
	);
	ATTRIBUTE goal : goal_type ;

	TYPE IO_reg_type IS (
		ioreg_auto,		-- "Software determines the proper mapping"
		ioreg_iocell,		-- "Force reg. to an IO cell when legal"
		ioreg_macrocell,		-- "Force reg. to a macro-cell"
		ioreg_duplicate		-- "Reserved for future use"
	);
	ATTRIBUTE input_reg : IO_reg_type ;

	ATTRIBUTE io_bank : string ;

	ATTRIBUTE io_type : string ;

	ATTRIBUTE lab_force : string ;

	ATTRIBUTE lab_group : string ;

	ATTRIBUTE locked_mux_route : string ;

	ATTRIBUTE locked_route : string ;

	ATTRIBUTE locked_superroute : string ;

	ATTRIBUTE low_power : string ;

	ATTRIBUTE macrocell_loc : string ;

	TYPE Map_to_memory_type IS (
		mmap_auto,		-- "Software follows the global defaul"
		mmap_none,		-- "Do not map logic to memory"
		mmap_area,		-- "Map for area even at the expense of speed"
		mmap_speed		-- "Map for area without sacrificing speed"
	);
	ATTRIBUTE map_to_memory : Map_to_memory_type ;

	ATTRIBUTE no_factor : boolean ;

	ATTRIBUTE no_latch : boolean ;

	ATTRIBUTE node_cost : natural ;

	ATTRIBUTE node_num : integer ;

	ATTRIBUTE oe_reg : IO_reg_type ;

	ATTRIBUTE opt_level : integer ;

	ATTRIBUTE order_code : string ;

	ATTRIBUTE output_reg : IO_reg_type ;

	ATTRIBUTE part_name : string ;

	ATTRIBUTE pin_avoid : string ;

	ATTRIBUTE pin_numbers : string ;

	ATTRIBUTE placement_force : string ;

	ATTRIBUTE placement_group : string ;

	TYPE polarity_select IS (
		pl_keep,		-- "Keep polarity of signal as specified"
		pl_opt,		-- "Optimize polarity of signal"
		pl_default		-- "Allowance of software to optomize polarity"
	);
	ATTRIBUTE polarity : polarity_select ;

	ATTRIBUTE port_location : string ;

	TYPE Slew_rate_type IS (
		fast,
		slow
	);
	ATTRIBUTE slew_rate : Slew_rate_type ;

	TYPE FSM_synth_type IS (
		sequential,
		one_hot_zero,
		one_hot_one,
		gray,
		user_codes
	);
	ATTRIBUTE state_encoding : FSM_synth_type ;

	TYPE Sum_split_type IS (
		balanced,
		cascaded
	);
	ATTRIBUTE sum_split : Sum_split_type ;

	ATTRIBUTE synchronization_needed : string ;

	ATTRIBUTE synthesis_off : boolean ;



------------- %%END AUTOSECTION -------------------------------------------


---------------------------------------------------------------------------
--  General utils:
---------------------------------------------------------------------------
    --  Cypress types:
    --  This is provided only for compatibility with V3.5. Starting
    --  with V4.0, the std_logic type should be used instead and it is
    --  defined in the ieee.std_logic_1164 package
    TYPE x01z IS (
	'x',
	'0',
	'1',
	'z'
    );
    TYPE x01z_vector	IS ARRAY (INTEGER RANGE <>) OF x01z;

    -- Resolution function for simulation:
    FUNCTION wired_or	(source : x01z_vector) RETURN x01z;

    -- functions for type conversions in port maps:
    FUNCTION fbx (in1 : BIT)	RETURN x01z;
    FUNCTION fxb (in1 : x01z)	RETURN BIT;
    FUNCTION bit2bool (in1 : BIT)	RETURN boolean;
    FUNCTION bool2bit (in1 : boolean)	RETURN BIT;

    -- global signals for constants
    -- these belong in here with the RTL types
    SIGNAL one	: BIT	:= '1';
    SIGNAL zero	: BIT	:= '0';

END cypress;

PACKAGE BODY cypress IS

    FUNCTION fbx (in1 : BIT)	RETURN x01z IS
    BEGIN
	IF (in1='1')
	    THEN RETURN '1';
	    ELSE RETURN '0';
	END IF;
    END fbx;

    FUNCTION fxb (in1 : x01z)	RETURN BIT IS
    BEGIN
	IF (in1='0')
	    THEN RETURN '0';
	    ELSE RETURN '1';
	END IF;
    END fxb;

    FUNCTION bit2bool (in1 : BIT)	RETURN boolean IS
    BEGIN
        RETURN (in1='1');
    END bit2bool;

    FUNCTION bool2bit (in1 : boolean)	RETURN BIT IS
    BEGIN
	IF (in1)
	    THEN RETURN '1';
	    ELSE RETURN '0';
	END IF;
    END bool2bit;

    -- Resolution Fucntion wired_or:
    -- Assumes 1 wins conflict.  Passes x, does not generate x.
    -- Any drive 1, bus is 1.
    -- Else any drive X, bus is X.
    -- Else any drive 0, bus is 0.
    -- Else, Z.
    FUNCTION wired_or (source : x01z_vector) RETURN x01z IS
	VARIABLE bus_level : x01z := 'z';
    BEGIN
	FOR i IN source'RANGE LOOP
	    CASE bus_level IS
		WHEN 'x' =>
		    IF source(i) = '1' THEN	bus_level := '1';
		    ELSE			NULL;
		    END IF;
		WHEN '0' =>
		    IF source(i) = 'z' THEN	NULL;
		    ELSE			bus_level := source(i);
		    END IF;
		WHEN '1' =>			NULL;
		WHEN 'z' =>			bus_level := source(i);
	    END CASE;
	END LOOP;
	RETURN bus_level;
    END wired_or;

END cypress;
