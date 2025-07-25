/*******************************************************************************
* Copyright 2011-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

using System;
using System.Collections.Generic;
using System.Text;
using CyDesigner.Extensions.Gde;
using CyDesigner.Extensions.Common;

namespace cy_psoc4_sarmux_v1_0
{
    class CyCustomizer : ICyShapeCustomize_v1
    {
        const string MUXIN_PLUS_BASE_TERM_NAME = "muxin_plus";
        const string MUXIN_MINUS_BASE_TERM_NAME = "muxin_minus";
		const string TERM_NAME_CHANGE_PATTERN = "{0}[{1}:0]";

        public CyCustErr CustomizeShapes(ICyInstQuery_v1 instQuery, ICySymbolShapeEdit_v1 shapeEdit,
            ICyTerminalEdit_v1 termEdit)
        {
            CyCustErr err;

            // We leave the symbol as it is for symbol preview
            if (instQuery.IsPreviewCanvas)
                return CyCustErr.OK;

            // Read Parameters
            CyCompDevParam muxinWidthParam = instQuery.GetCommittedParam("muxin_width");
            byte muxinWidth = byte.Parse(muxinWidthParam.Value);

            string muxInPlusTermName = termEdit.GetTermName(MUXIN_PLUS_BASE_TERM_NAME);
            string muxInMinusTermName = termEdit.GetTermName(MUXIN_MINUS_BASE_TERM_NAME);

            byte maxBitIndex = (byte)(muxinWidth - 1);

            err = termEdit.TerminalRename(muxInPlusTermName, string.Format(TERM_NAME_CHANGE_PATTERN,
                MUXIN_PLUS_BASE_TERM_NAME, maxBitIndex.ToString()));
            if (err.IsNotOK)
            {
                return err;
            }

            err = termEdit.TerminalRename(muxInMinusTermName, string.Format(TERM_NAME_CHANGE_PATTERN,
                MUXIN_MINUS_BASE_TERM_NAME, maxBitIndex.ToString()));
            if (err.IsNotOK)
            {
                return err;
            }

            return CyCustErr.OK;
        }
    }
}
