namespace SCB_P4_v4_0
{
    partial class CyGeneralTab
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.m_rbI2C = new System.Windows.Forms.RadioButton();
            this.m_rbUart = new System.Windows.Forms.RadioButton();
            this.m_rbSpi = new System.Windows.Forms.RadioButton();
            this.m_rbUnconfig = new System.Windows.Forms.RadioButton();
            this.m_rbEZI2C = new System.Windows.Forms.RadioButton();
            this.labelSFMsg = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // m_rbI2C
            // 
            this.m_rbI2C.AutoSize = true;
            this.m_rbI2C.Location = new System.Drawing.Point(3, 26);
            this.m_rbI2C.Name = "m_rbI2C";
            this.m_rbI2C.Size = new System.Drawing.Size(41, 17);
            this.m_rbI2C.TabIndex = 1;
            this.m_rbI2C.TabStop = true;
            this.m_rbI2C.Text = "I2C";
            this.m_rbI2C.UseVisualStyleBackColor = true;
            this.m_rbI2C.CheckedChanged += new System.EventHandler(this.rbconfig_CheckedChanged);
            // 
            // m_rbUart
            // 
            this.m_rbUart.AutoSize = true;
            this.m_rbUart.Location = new System.Drawing.Point(3, 95);
            this.m_rbUart.Name = "m_rbUart";
            this.m_rbUart.Size = new System.Drawing.Size(55, 17);
            this.m_rbUart.TabIndex = 4;
            this.m_rbUart.TabStop = true;
            this.m_rbUart.Text = "UART";
            this.m_rbUart.UseVisualStyleBackColor = true;
            this.m_rbUart.CheckedChanged += new System.EventHandler(this.rbconfig_CheckedChanged);
            // 
            // m_rbSpi
            // 
            this.m_rbSpi.AutoSize = true;
            this.m_rbSpi.Location = new System.Drawing.Point(3, 72);
            this.m_rbSpi.Name = "m_rbSpi";
            this.m_rbSpi.Size = new System.Drawing.Size(42, 17);
            this.m_rbSpi.TabIndex = 3;
            this.m_rbSpi.TabStop = true;
            this.m_rbSpi.Text = "SPI";
            this.m_rbSpi.UseVisualStyleBackColor = true;
            this.m_rbSpi.CheckedChanged += new System.EventHandler(this.rbconfig_CheckedChanged);
            // 
            // m_rbUnconfig
            // 
            this.m_rbUnconfig.AutoSize = true;
            this.m_rbUnconfig.Location = new System.Drawing.Point(3, 3);
            this.m_rbUnconfig.Name = "m_rbUnconfig";
            this.m_rbUnconfig.Size = new System.Drawing.Size(113, 17);
            this.m_rbUnconfig.TabIndex = 0;
            this.m_rbUnconfig.TabStop = true;
            this.m_rbUnconfig.Text = "Unconfigured SCB";
            this.m_rbUnconfig.UseVisualStyleBackColor = true;
            this.m_rbUnconfig.CheckedChanged += new System.EventHandler(this.rbconfig_CheckedChanged);
            // 
            // m_rbEZI2C
            // 
            this.m_rbEZI2C.AutoSize = true;
            this.m_rbEZI2C.Location = new System.Drawing.Point(3, 49);
            this.m_rbEZI2C.Name = "m_rbEZI2C";
            this.m_rbEZI2C.Size = new System.Drawing.Size(55, 17);
            this.m_rbEZI2C.TabIndex = 2;
            this.m_rbEZI2C.TabStop = true;
            this.m_rbEZI2C.Text = "EZI2C";
            this.m_rbEZI2C.UseVisualStyleBackColor = true;
            this.m_rbEZI2C.CheckedChanged += new System.EventHandler(this.rbconfig_CheckedChanged);
            // 
            // labelSFMsg
            // 
            this.labelSFMsg.Image = global::SCB_P4_v4_0.Resources.InformationIconPng;
            this.labelSFMsg.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.labelSFMsg.Location = new System.Drawing.Point(0, 131);
            this.labelSFMsg.Name = "labelSFMsg";
            this.labelSFMsg.Size = new System.Drawing.Size(347, 20);
            this.labelSFMsg.TabIndex = 0;
            this.labelSFMsg.Text = "The SPI and UART modes are not available for the selected device.";
            this.labelSFMsg.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.labelSFMsg.Visible = false;
            // 
            // CyGeneralTab
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.labelSFMsg);
            this.Controls.Add(this.m_rbEZI2C);
            this.Controls.Add(this.m_rbUnconfig);
            this.Controls.Add(this.m_rbSpi);
            this.Controls.Add(this.m_rbUart);
            this.Controls.Add(this.m_rbI2C);
            this.Name = "CyGeneralTab";
            this.Size = new System.Drawing.Size(433, 232);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RadioButton m_rbI2C;
        private System.Windows.Forms.RadioButton m_rbUart;
        private System.Windows.Forms.RadioButton m_rbSpi;
        private System.Windows.Forms.RadioButton m_rbUnconfig;
        private System.Windows.Forms.RadioButton m_rbEZI2C;
        private System.Windows.Forms.Label labelSFMsg;

    }
}
