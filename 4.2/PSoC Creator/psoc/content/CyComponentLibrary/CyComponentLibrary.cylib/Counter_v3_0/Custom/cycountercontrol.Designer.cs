namespace Counter_v3_0
{
    partial class CyCounterControl
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
            this.components = new System.ComponentModel.Container();
            this.m_rbResolution16 = new System.Windows.Forms.RadioButton();
            this.m_rbResolution8 = new System.Windows.Forms.RadioButton();
            this.m_lblResolution = new System.Windows.Forms.Label();
            this.m_rbResolution32 = new System.Windows.Forms.RadioButton();
            this.m_rbResolution24 = new System.Windows.Forms.RadioButton();
            this.m_rbUDB = new System.Windows.Forms.RadioButton();
            this.m_rbFixedFunction = new System.Windows.Forms.RadioButton();
            this.m_lblImplementation = new System.Windows.Forms.Label();
            this.m_cbClockMode = new System.Windows.Forms.ComboBox();
            this.m_lblClockMode = new System.Windows.Forms.Label();
            this.m_lblPeriod = new System.Windows.Forms.Label();
            this.m_tooltips = new System.Windows.Forms.ToolTip(this.components);
            this.m_bMaxPeriod = new System.Windows.Forms.Button();
            this.m_lblCompareValue = new System.Windows.Forms.Label();
            this.m_bMaxCompareValue = new System.Windows.Forms.Button();
            this.m_cbCompareMode = new System.Windows.Forms.ComboBox();
            this.m_lblCompareMode = new System.Windows.Forms.Label();
            this.ep_Errors = new System.Windows.Forms.ErrorProvider(this.components);
            this.m_numCompare1 = new Counter_v3_0.CyNumericUpDown();
            this.m_numPeriod = new Counter_v3_0.CyNumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this.ep_Errors)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numPeriod)).BeginInit();
            this.SuspendLayout();
            // 
            // m_rbResolution16
            // 
            this.m_rbResolution16.AutoCheck = false;
            this.m_rbResolution16.AutoSize = true;
            this.m_rbResolution16.Location = new System.Drawing.Point(189, 9);
            this.m_rbResolution16.Name = "m_rbResolution16";
            this.m_rbResolution16.Size = new System.Drawing.Size(52, 17);
            this.m_rbResolution16.TabIndex = 2;
            this.m_rbResolution16.TabStop = true;
            this.m_rbResolution16.Text = "16-Bit";
            this.m_rbResolution16.UseVisualStyleBackColor = true;
            this.m_rbResolution16.Click += new System.EventHandler(this.m_rbResolution16_Click);
            // 
            // m_rbResolution8
            // 
            this.m_rbResolution8.AutoCheck = false;
            this.m_rbResolution8.AutoSize = true;
            this.m_rbResolution8.Location = new System.Drawing.Point(129, 9);
            this.m_rbResolution8.Name = "m_rbResolution8";
            this.m_rbResolution8.Size = new System.Drawing.Size(46, 17);
            this.m_rbResolution8.TabIndex = 1;
            this.m_rbResolution8.TabStop = true;
            this.m_rbResolution8.Text = "8-Bit";
            this.m_rbResolution8.UseVisualStyleBackColor = true;
            this.m_rbResolution8.MouseClick += new System.Windows.Forms.MouseEventHandler(this.m_rbResolution8_Click);
            // 
            // m_lblResolution
            // 
            this.m_lblResolution.AutoSize = true;
            this.m_lblResolution.Location = new System.Drawing.Point(47, 11);
            this.m_lblResolution.Name = "m_lblResolution";
            this.m_lblResolution.Size = new System.Drawing.Size(60, 13);
            this.m_lblResolution.TabIndex = 14;
            this.m_lblResolution.Text = "Resolution:";
            this.m_lblResolution.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_rbResolution32
            // 
            this.m_rbResolution32.AutoCheck = false;
            this.m_rbResolution32.AutoSize = true;
            this.m_rbResolution32.Location = new System.Drawing.Point(321, 9);
            this.m_rbResolution32.Name = "m_rbResolution32";
            this.m_rbResolution32.Size = new System.Drawing.Size(52, 17);
            this.m_rbResolution32.TabIndex = 4;
            this.m_rbResolution32.TabStop = true;
            this.m_rbResolution32.Text = "32-Bit";
            this.m_rbResolution32.UseVisualStyleBackColor = true;
            this.m_rbResolution32.Click += new System.EventHandler(this.m_rbResolution32_Click);
            // 
            // m_rbResolution24
            // 
            this.m_rbResolution24.AutoCheck = false;
            this.m_rbResolution24.AutoSize = true;
            this.m_rbResolution24.Location = new System.Drawing.Point(255, 9);
            this.m_rbResolution24.Name = "m_rbResolution24";
            this.m_rbResolution24.Size = new System.Drawing.Size(52, 17);
            this.m_rbResolution24.TabIndex = 3;
            this.m_rbResolution24.TabStop = true;
            this.m_rbResolution24.Text = "24-Bit";
            this.m_rbResolution24.UseVisualStyleBackColor = true;
            this.m_rbResolution24.Click += new System.EventHandler(this.m_rbResolution24_Click);
            // 
            // m_rbUDB
            // 
            this.m_rbUDB.AutoCheck = false;
            this.m_rbUDB.AutoSize = true;
            this.m_rbUDB.Location = new System.Drawing.Point(238, 32);
            this.m_rbUDB.Name = "m_rbUDB";
            this.m_rbUDB.Size = new System.Drawing.Size(48, 17);
            this.m_rbUDB.TabIndex = 6;
            this.m_rbUDB.TabStop = true;
            this.m_rbUDB.Text = "UDB";
            this.m_rbUDB.UseVisualStyleBackColor = true;
            this.m_rbUDB.Click += new System.EventHandler(this.m_rbUDB_Click);
            // 
            // m_rbFixedFunction
            // 
            this.m_rbFixedFunction.AutoCheck = false;
            this.m_rbFixedFunction.AutoSize = true;
            this.m_rbFixedFunction.Location = new System.Drawing.Point(129, 32);
            this.m_rbFixedFunction.Name = "m_rbFixedFunction";
            this.m_rbFixedFunction.Size = new System.Drawing.Size(94, 17);
            this.m_rbFixedFunction.TabIndex = 5;
            this.m_rbFixedFunction.TabStop = true;
            this.m_rbFixedFunction.Text = "Fixed Function";
            this.m_rbFixedFunction.UseVisualStyleBackColor = true;
            this.m_rbFixedFunction.Click += new System.EventHandler(this.m_rbFixedFunction_Click);
            // 
            // m_lblImplementation
            // 
            this.m_lblImplementation.AutoSize = true;
            this.m_lblImplementation.Location = new System.Drawing.Point(26, 34);
            this.m_lblImplementation.Name = "m_lblImplementation";
            this.m_lblImplementation.Size = new System.Drawing.Size(81, 13);
            this.m_lblImplementation.TabIndex = 19;
            this.m_lblImplementation.Text = "Implementation:";
            this.m_lblImplementation.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_cbClockMode
            // 
            this.m_cbClockMode.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.m_cbClockMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbClockMode.FormattingEnabled = true;
            this.m_cbClockMode.Location = new System.Drawing.Point(129, 134);
            this.m_cbClockMode.Name = "m_cbClockMode";
            this.m_cbClockMode.Size = new System.Drawing.Size(283, 21);
            this.m_cbClockMode.TabIndex = 12;
            this.m_cbClockMode.SelectedIndexChanged += new System.EventHandler(this.m_cbClockMode_SelectedIndexChanged);
            // 
            // m_lblClockMode
            // 
            this.m_lblClockMode.AutoSize = true;
            this.m_lblClockMode.Location = new System.Drawing.Point(40, 137);
            this.m_lblClockMode.Name = "m_lblClockMode";
            this.m_lblClockMode.Size = new System.Drawing.Size(67, 13);
            this.m_lblClockMode.TabIndex = 54;
            this.m_lblClockMode.Text = "Clock Mode:";
            this.m_lblClockMode.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblPeriod
            // 
            this.m_lblPeriod.AutoSize = true;
            this.m_lblPeriod.Location = new System.Drawing.Point(67, 57);
            this.m_lblPeriod.Name = "m_lblPeriod";
            this.m_lblPeriod.Size = new System.Drawing.Size(40, 13);
            this.m_lblPeriod.TabIndex = 150;
            this.m_lblPeriod.Text = "Period:";
            this.m_lblPeriod.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_bMaxPeriod
            // 
            this.m_bMaxPeriod.Location = new System.Drawing.Point(226, 51);
            this.m_bMaxPeriod.Name = "m_bMaxPeriod";
            this.m_bMaxPeriod.Size = new System.Drawing.Size(58, 25);
            this.m_bMaxPeriod.TabIndex = 8;
            this.m_bMaxPeriod.Text = "Max";
            this.m_bMaxPeriod.UseVisualStyleBackColor = true;
            this.m_bMaxPeriod.Click += new System.EventHandler(this.m_bMaxPeriod_Click);
            // 
            // m_lblCompareValue
            // 
            this.m_lblCompareValue.AutoSize = true;
            this.m_lblCompareValue.Location = new System.Drawing.Point(25, 110);
            this.m_lblCompareValue.Name = "m_lblCompareValue";
            this.m_lblCompareValue.Size = new System.Drawing.Size(82, 13);
            this.m_lblCompareValue.TabIndex = 173;
            this.m_lblCompareValue.Text = "Compare Value:";
            this.m_lblCompareValue.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_bMaxCompareValue
            // 
            this.m_bMaxCompareValue.Location = new System.Drawing.Point(226, 105);
            this.m_bMaxCompareValue.Name = "m_bMaxCompareValue";
            this.m_bMaxCompareValue.Size = new System.Drawing.Size(58, 25);
            this.m_bMaxCompareValue.TabIndex = 11;
            this.m_bMaxCompareValue.Text = "Max";
            this.m_bMaxCompareValue.UseVisualStyleBackColor = true;
            this.m_bMaxCompareValue.Click += new System.EventHandler(this.m_bMaxCompareValue_Click);
            // 
            // m_cbCompareMode
            // 
            this.m_cbCompareMode.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.m_cbCompareMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbCompareMode.FormattingEnabled = true;
            this.m_cbCompareMode.Location = new System.Drawing.Point(129, 81);
            this.m_cbCompareMode.Name = "m_cbCompareMode";
            this.m_cbCompareMode.Size = new System.Drawing.Size(283, 21);
            this.m_cbCompareMode.TabIndex = 9;
            this.m_cbCompareMode.SelectedIndexChanged += new System.EventHandler(this.m_cbCompareMode_SelectedIndexChanged);
            // 
            // m_lblCompareMode
            // 
            this.m_lblCompareMode.AutoSize = true;
            this.m_lblCompareMode.Location = new System.Drawing.Point(25, 84);
            this.m_lblCompareMode.Name = "m_lblCompareMode";
            this.m_lblCompareMode.Size = new System.Drawing.Size(82, 13);
            this.m_lblCompareMode.TabIndex = 175;
            this.m_lblCompareMode.Text = "Compare Mode:";
            this.m_lblCompareMode.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // ep_Errors
            // 
            this.ep_Errors.ContainerControl = this;
            // 
            // m_numCompare1
            // 
            this.ep_Errors.SetIconAlignment(this.m_numCompare1, System.Windows.Forms.ErrorIconAlignment.MiddleLeft);
            this.m_numCompare1.Location = new System.Drawing.Point(129, 108);
            this.m_numCompare1.Maximum = new decimal(new int[] {
            0,
            1,
            0,
            0});
            this.m_numCompare1.Name = "m_numCompare1";
            this.m_numCompare1.Size = new System.Drawing.Size(91, 20);
            this.m_numCompare1.TabIndex = 10;
            this.m_numCompare1.ValueChanged += new System.EventHandler(this.m_numCompare1_ValueChanged);
            this.m_numCompare1.Validating += new System.ComponentModel.CancelEventHandler(this.m_numCompare1_Validating);
            // 
            // m_numPeriod
            // 
            this.ep_Errors.SetIconAlignment(this.m_numPeriod, System.Windows.Forms.ErrorIconAlignment.MiddleLeft);
            this.m_numPeriod.Location = new System.Drawing.Point(129, 55);
            this.m_numPeriod.Maximum = new decimal(new int[] {
            0,
            1,
            0,
            0});
            this.m_numPeriod.Name = "m_numPeriod";
            this.m_numPeriod.Size = new System.Drawing.Size(91, 20);
            this.m_numPeriod.TabIndex = 7;
            this.m_numPeriod.ValueChanged += new System.EventHandler(this.m_numPeriod_ValueChanged);
            this.m_numPeriod.KeyUp += new System.Windows.Forms.KeyEventHandler(this.m_numPeriod_KeyUp);
            this.m_numPeriod.Validating += new System.ComponentModel.CancelEventHandler(this.m_numPeriod_Validating);
            // 
            // CyCounterControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.m_cbCompareMode);
            this.Controls.Add(this.m_lblCompareMode);
            this.Controls.Add(this.m_bMaxCompareValue);
            this.Controls.Add(this.m_lblCompareValue);
            this.Controls.Add(this.m_numCompare1);
            this.Controls.Add(this.m_bMaxPeriod);
            this.Controls.Add(this.m_lblPeriod);
            this.Controls.Add(this.m_numPeriod);
            this.Controls.Add(this.m_cbClockMode);
            this.Controls.Add(this.m_lblClockMode);
            this.Controls.Add(this.m_rbUDB);
            this.Controls.Add(this.m_rbFixedFunction);
            this.Controls.Add(this.m_lblImplementation);
            this.Controls.Add(this.m_rbResolution32);
            this.Controls.Add(this.m_rbResolution24);
            this.Controls.Add(this.m_rbResolution16);
            this.Controls.Add(this.m_rbResolution8);
            this.Controls.Add(this.m_lblResolution);
            this.Name = "CyCounterControl";
            this.Size = new System.Drawing.Size(429, 180);
            this.Load += new System.EventHandler(this.CyCounterControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ep_Errors)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numPeriod)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label m_lblResolution;
        private System.Windows.Forms.RadioButton m_rbUDB;
        private System.Windows.Forms.RadioButton m_rbFixedFunction;
        private System.Windows.Forms.Label m_lblImplementation;
        private System.Windows.Forms.ComboBox m_cbClockMode;
        private System.Windows.Forms.Label m_lblClockMode;
        private System.Windows.Forms.Label m_lblPeriod;
        private Counter_v3_0.CyNumericUpDown m_numPeriod;
        private System.Windows.Forms.ToolTip m_tooltips;
        private System.Windows.Forms.RadioButton m_rbResolution8;
        private System.Windows.Forms.RadioButton m_rbResolution24;
        private System.Windows.Forms.RadioButton m_rbResolution16;
        private System.Windows.Forms.RadioButton m_rbResolution32;
        private System.Windows.Forms.Button m_bMaxPeriod;
        private System.Windows.Forms.Label m_lblCompareValue;
        private Counter_v3_0.CyNumericUpDown m_numCompare1;
        private System.Windows.Forms.Button m_bMaxCompareValue;
        private System.Windows.Forms.ComboBox m_cbCompareMode;
        private System.Windows.Forms.Label m_lblCompareMode;
        private System.Windows.Forms.ErrorProvider ep_Errors;
    }
}
