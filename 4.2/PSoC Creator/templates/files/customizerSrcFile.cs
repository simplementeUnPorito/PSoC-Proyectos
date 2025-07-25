/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;

// The namespace is required to have the same name as the component for a customizer.
namespace `$COMPONENT_NAME`
{
    // CyCustomizer is the required class name for a customizer.
    public class CyCustomizer : ICyParamEditHook_v1
    {
        #region ICyParamEditHook_v1 Members

        /// <summary>
        /// Gets the <see cref="CyCompDevParamEditorMode"/> that specifies the level of customization provided by
        /// this class.
        /// </summary>
        /// 
        /// <returns>
        /// Returns the <see cref="CyCompDevParamEditorMode"/> that specifies the level of customization provided by
        /// this class.
        /// </returns>
        CyCompDevParamEditorMode ICyParamEditHook_v1.GetEditorMode()
        {
            throw new NotImplementedException("GetEditorMode has not been implemented.");
        }

        /// <summary>
        /// Configures an instance.
        /// </summary>
        /// 
        /// <param name="edit">
        /// Allows editing access to the instance being edited.
        /// </param>
        /// 
        /// <param name="termQuery">
        /// Allows querying access to the terminals and their connections on the instance being edited.
        /// </param>
        /// 
        /// <param name="mgr">
        /// Allows editing access to the express instance being edited.
        /// </param>
        /// 
        /// <returns>
        /// Returns DialogResult.Ok if the changes made by calling this method should be committed, otherwise
        /// it should return DialogResult.Cancel and any changes made by this method will be discarded.
        /// </returns>
        DialogResult ICyParamEditHook_v1.EditParams(
            ICyInstEdit_v1 edit,
            ICyTerminalQuery_v1 termQuery,
            ICyExpressMgr_v1 mgr)
        {
            throw new NotImplementedException("EditParams has not been implemented.");
        }

        /// <summary>
        /// Gets whether or not to make a call to EditParams as soon as a
        /// component is dropped on to the schematic from the Component Catalog.
        /// </summary>
        bool ICyParamEditHook_v1.EditParamsOnDrop
        {
            get { throw new NotImplementedException("EditParamsOnDrop has not been implemented."); }
        }

        #endregion
    }
}

//[] END OF FILE
