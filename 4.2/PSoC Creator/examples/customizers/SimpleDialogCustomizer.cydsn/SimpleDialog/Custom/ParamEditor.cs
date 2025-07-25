/*******************************************************************************
* Copyright 2009, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

using System;
using System.Collections.Generic;
using System.Text;
using CyDesigner.Extensions.Gde;
using CyDesigner.Extensions.Common;
using System.Windows.Forms;
using System.Diagnostics;

namespace My.Personal.SimpleDialog
{    
    public partial class CyCustomizer : ICyParamEditHook_v1
    {
        #region ICyParamEditHook_v1 Members

        // Type of dialog box.  Advanced opens with a button on the generic form.  Complete opens immediately
        CyCompDevParamEditorMode m_mode = CyCompDevParamEditorMode.COMPLETE;
        // Run Instance Customizer on Instance Selection
        bool m_editOnDrop = false;
        

        /// <summary>
        /// Edit Params initializes the data in the customizer as well as 
        /// instantiating the dialog.  
        /// </summary>
        /// <param name="obj"> Is a component object containing the parameter information for the object. </param>
        /// <returns>A DialogResult object associated with the form.  OK means accept changes.  Cancel means reject changes.</returns>
        DialogResult ICyParamEditHook_v1.EditParams(ICyInstEdit_v1 obj, ICyTerminalQuery_v1 termQuery, ICyExpressMgr_v1 mgr)
        {			
            ICyParamEditor editor = obj.CreateParamEditor(new Form1(obj));
            System.Windows.Forms.DialogResult result = editor.ShowDialog();
            
            return result;
        }

        CyCompDevParamEditorMode ICyParamEditHook_v1.GetEditorMode()
        {
            return m_mode;
        }

        bool ICyParamEditHook_v1.EditParamsOnDrop
        {
            get { return m_editOnDrop; }
        }
        #endregion
    }
}