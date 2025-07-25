// ========================================
//
// Copyright Cypress Semiconductor Corporation, 2008, 2009
// All Rights Reserved
// UNPUBLISHED, LICENSED SOFTWARE.
//
// CONFIDENTIAL AND PROPRIETARY INFORMATION
// WHICH IS THE PROPERTY OF CYPRESS.
//
// Use of this file is governed
// by the license agreement included in the file
//
//     <install>/license/license.txt
//
// where <install> is the Cypress software
// installation root directory path.
//
// ========================================
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CyDesigner.Extensions.Gde;
using CyDesigner.Extensions.Common;

namespace My.Personal.SimpleDialog
{
    public partial class Form1 : UserControl, ICyParamEditingControl
    {
	    ICyInstEdit_v1 m_inst;
        public Form1(ICyInstEdit_v1 obj)
        {
		    m_inst = obj;
            InitializeComponent();

            // make a visible change using our "usual" resources
            this.label1.Text = "Silly Rabbit";
            this.label1.Text = Resource1.HelloWorld;

            // get control on a button click -- should be able to do it with Windows Forms Designer ...
            // ah, I can, by double-clicking on the object -- it created button1_Click below.  Off we go.
            // But first, set the label to something meaningful ...
            this.label2.Text = "0";

        }

        int m_counter = 0;

        private void button1_Click(object sender, EventArgs e)
        {
            m_counter++;
            this.label2.Text = m_counter.ToString();
        }
		
		#region ICyParamEditingControl Members

        Control ICyParamEditingControl.DisplayControl
        {
            get { return this; }
        }

        IEnumerable<CyCustErr> ICyParamEditingControl.GetErrors()
        {
            // Hack : Update this method to return actual errors?
            return new CyCustErr[] { };
        }

        #endregion
    }
}