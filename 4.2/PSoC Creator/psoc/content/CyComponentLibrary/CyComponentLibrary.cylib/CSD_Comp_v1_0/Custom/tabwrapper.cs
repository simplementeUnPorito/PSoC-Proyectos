﻿/*******************************************************************************
* Copyright 2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided. 
********************************************************************************/

using System;
using System.Collections.Generic;
using System.Windows.Forms;
using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;

namespace CSD_Comp_v1_0
{
    public abstract class CyTabWrapper : UserControl, ICyParamEditingControl
    {
        protected CyParameters m_params = null;
        protected ErrorProvider m_errorProvider = null;

        public abstract string TabName
        {
            get;
        }

        #region Constructor(s)

        public CyTabWrapper() { }
        public CyTabWrapper(CyParameters parameters)
        {
            m_params = parameters;
            m_errorProvider = new ErrorProvider();
            m_errorProvider.BlinkStyle = ErrorBlinkStyle.NeverBlink;
            this.Dock = DockStyle.Fill;
            this.AutoScroll = true;
        }

        #endregion

        #region ICyParamEditingControl Members

        public Control DisplayControl
        {
            get { return this; }
        }

        public virtual IEnumerable<CyCustErr> GetErrors()
        {
            List<CyCustErr> errs = new List<CyCustErr>();

            // Check error providers on GUI
            if (m_errorProvider != null)
                errs.AddRange(CheckControlForErrors(this.Controls));

            // Check symbol parameters validators
            foreach (string paramName in m_params.InstQuery.GetParamNames())
            {
                CyCompDevParam param = m_params.InstQuery.GetCommittedParam(paramName);
                if (param.TabName.Equals(TabName) && param.ErrorCount > 0)
                {
                    foreach (string errMsg in param.Errors)
                        errs.Add(new CyCustErr(errMsg));
                }
            }

            return errs;
        }

        #endregion

        #region Controls errors check method(s)

        protected virtual List<CyCustErr> CheckControlForErrors(ControlCollection controls)
        {
            string errorMessage = String.Empty;
            List<CyCustErr> errs = new List<CyCustErr>();
            foreach (Control control in controls)
            {
                errorMessage = m_errorProvider.GetError(control);
                if (String.IsNullOrEmpty(errorMessage) == false)
                    errs.Add(new CyCustErr(errorMessage));
                // Recursively call itself again to make sure that nested controls does not contain errors
                if (control.Controls.Count > 0)
                    errs.AddRange(CheckControlForErrors(control.Controls));
            }
            return errs;
        }

        #endregion
    }
}
