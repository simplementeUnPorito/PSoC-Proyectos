/*******************************************************************************
* Copyright 2008-2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;
using System.ComponentModel;
using System.Drawing;

namespace QuadDec_v3_0
{
    class CyTab4 : UserControl, ICyParamEditingControl
    {
        private CyParameters m_params;

        public CyTab4(CyParameters newParams)
        {
            InitializeComponent();
            m_params = newParams;
            Dock = DockStyle.Fill;
            UpdateFromParam();
        }

        #region ICyParamEditingControl Members
        public Control DisplayControl
        {
            get { return this; }
        }

        /// <summary>
        /// Gets any errors that exist for parameters on the DisplayControl.
        /// </summary>
        /// <returns></returns>
        public IEnumerable<CyCustErr> GetErrors()
        {
            List<CyCustErr> errs = new List<CyCustErr>();

            ICyInstEdit_v1 edit = m_params.m_instance;

            if (edit != null)
                foreach (string paramName in edit.GetParamNames())
                {
                    CyCompDevParam param = edit.GetCommittedParam(paramName);
                    if (param.IsVisible && Properties.Resources.TabEnableGlitchFiltering.Contains(param.TabName))
                    {
                        if (param.ErrorCount > 0)
                        {
                            foreach (string errMsg in param.Errors)
                            {
                                errs.Add(new CyCustErr(errMsg));
                            }
                        }
                    }
                }

            return errs;
        }
        #endregion     

        public void UpdateFromParam()
        {
            m_chbUsingGL.Checked = m_params.UseGF;      
            cyDiagram1.CounterResolution = m_params.CounterResolution;
            cyDiagram1.UseFiltering = m_params.UseGF;
        }

        private void enableChB_CheckedChanged(object sender, EventArgs e)
        {
            m_params.UseGF = m_chbUsingGL.Checked;
            cyDiagram1.UseFiltering = m_chbUsingGL.Checked;
        }

        #region Component Designer generated code

        private Label descriptionLabel;
        private CyDiagram cyDiagram1;
        private CheckBox m_chbUsingGL;

        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CyTab4));
            this.descriptionLabel = new System.Windows.Forms.Label();
            this.m_chbUsingGL = new System.Windows.Forms.CheckBox();
            this.cyDiagram1 = new QuadDec_v3_0.CyDiagram();
            this.SuspendLayout();
            // 
            // descriptionLabel
            // 
            this.descriptionLabel.Location = new System.Drawing.Point(3, 3);
            this.descriptionLabel.Name = "descriptionLabel";
            this.descriptionLabel.Size = new System.Drawing.Size(463, 58);
            this.descriptionLabel.TabIndex = 1;
            this.descriptionLabel.Text = resources.GetString("descriptionLabel.Text");
            // 
            // m_chbUsingGL
            // 
            this.m_chbUsingGL.AutoSize = true;
            this.m_chbUsingGL.Location = new System.Drawing.Point(6, 81);
            this.m_chbUsingGL.Name = "m_chbUsingGL";
            this.m_chbUsingGL.Size = new System.Drawing.Size(158, 21);
            this.m_chbUsingGL.TabIndex = 2;
            this.m_chbUsingGL.Text = "Enable glitch filtering";
            this.m_chbUsingGL.UseVisualStyleBackColor = true;
            this.m_chbUsingGL.CheckedChanged += new System.EventHandler(this.enableChB_CheckedChanged);
            // 
            // cyDiagram1
            // 
            this.cyDiagram1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.cyDiagram1.AutoSize = true;
            this.cyDiagram1.BackColor = System.Drawing.Color.White;
            this.cyDiagram1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.cyDiagram1.CounterResolution = ((byte)(4));
            this.cyDiagram1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.cyDiagram1.Location = new System.Drawing.Point(3, 109);
            this.cyDiagram1.Margin = new System.Windows.Forms.Padding(4);
            this.cyDiagram1.MinimumSize = new System.Drawing.Size(475, 0);
            this.cyDiagram1.Name = "cyDiagram1";
            this.cyDiagram1.Size = new System.Drawing.Size(475, 196);
            this.cyDiagram1.TabIndex = 3;
            this.cyDiagram1.UseFiltering = false;
            this.cyDiagram1.UseIndex = false;
            // 
            // CyTab4
            // 
            this.AutoScroll = true;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.Controls.Add(this.cyDiagram1);
            this.Controls.Add(this.m_chbUsingGL);
            this.Controls.Add(this.descriptionLabel);
            this.Name = "CyTab4";
            this.Size = new System.Drawing.Size(482, 309);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

    }
    
}
