namespace PWM_v3_30
{
    partial class CyConfigureTab
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
            this.m_cbPWMMode = new System.Windows.Forms.ComboBox();
            this.m_lblPwmMode = new System.Windows.Forms.Label();
            this.m_lblPeriod = new System.Windows.Forms.Label();
            this.m_lblResolution = new System.Windows.Forms.Label();
            this.m_pbDrawing = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.m_lblCmpType1 = new System.Windows.Forms.Label();
            this.m_cbCompareType1 = new System.Windows.Forms.ComboBox();
            this.m_cbCompareType2 = new System.Windows.Forms.ComboBox();
            this.m_rbResolution8 = new System.Windows.Forms.RadioButton();
            this.m_rbResolution16 = new System.Windows.Forms.RadioButton();
            this.m_lblCmpValue2 = new System.Windows.Forms.Label();
            this.m_lblCmpType2 = new System.Windows.Forms.Label();
            this.m_lblCalcFrequency = new System.Windows.Forms.Label();
            this.m_cbDitherAlign = new System.Windows.Forms.ComboBox();
            this.m_cbDitherOffset = new System.Windows.Forms.ComboBox();
            this.m_lblDeadBandMode = new System.Windows.Forms.Label();
            this.m_cbDeadBandMode = new System.Windows.Forms.ComboBox();
            this.m_cbFFDeadBandMode = new System.Windows.Forms.ComboBox();
            this.m_bMaxPeriod = new System.Windows.Forms.Button();
            this.m_rbUDB = new System.Windows.Forms.RadioButton();
            this.m_rbFixedFunction = new System.Windows.Forms.RadioButton();
            this.m_lblImplementation = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.m_numPeriod = new System.Windows.Forms.NumericUpDown();
            this.m_numCompare1 = new System.Windows.Forms.NumericUpDown();
            this.m_numCompare2 = new System.Windows.Forms.NumericUpDown();
            this.m_numDeadBandCounts = new System.Windows.Forms.NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this.m_pbDrawing)).BeginInit();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.m_numPeriod)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numDeadBandCounts)).BeginInit();
            this.SuspendLayout();
            // 
            // m_cbPWMMode
            // 
            this.m_cbPWMMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbPWMMode.FormattingEnabled = true;
            this.m_cbPWMMode.Location = new System.Drawing.Point(108, 170);
            this.m_cbPWMMode.Name = "m_cbPWMMode";
            this.m_cbPWMMode.Size = new System.Drawing.Size(316, 21);
            this.m_cbPWMMode.TabIndex = 2;
            this.m_cbPWMMode.SelectedIndexChanged += new System.EventHandler(this.m_cbPWMMode_SelectedIndexChanged);
            // 
            // m_lblPwmMode
            // 
            this.m_lblPwmMode.AutoSize = true;
            this.m_lblPwmMode.Location = new System.Drawing.Point(29, 173);
            this.m_lblPwmMode.Name = "m_lblPwmMode";
            this.m_lblPwmMode.Size = new System.Drawing.Size(67, 13);
            this.m_lblPwmMode.TabIndex = 99;
            this.m_lblPwmMode.Text = "PWM Mode:";
            this.m_lblPwmMode.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblPeriod
            // 
            this.m_lblPeriod.AutoSize = true;
            this.m_lblPeriod.Location = new System.Drawing.Point(56, 201);
            this.m_lblPeriod.Name = "m_lblPeriod";
            this.m_lblPeriod.Size = new System.Drawing.Size(40, 13);
            this.m_lblPeriod.TabIndex = 99;
            this.m_lblPeriod.Text = "Period:";
            this.m_lblPeriod.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblResolution
            // 
            this.m_lblResolution.AutoSize = true;
            this.m_lblResolution.Location = new System.Drawing.Point(36, 150);
            this.m_lblResolution.Name = "m_lblResolution";
            this.m_lblResolution.Size = new System.Drawing.Size(60, 13);
            this.m_lblResolution.TabIndex = 99;
            this.m_lblResolution.Text = "Resolution:";
            this.m_lblResolution.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_pbDrawing
            // 
            this.m_pbDrawing.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.m_pbDrawing.BackColor = System.Drawing.Color.White;
            this.m_pbDrawing.Location = new System.Drawing.Point(6, 3);
            this.m_pbDrawing.Name = "m_pbDrawing";
            this.m_pbDrawing.Size = new System.Drawing.Size(436, 111);
            this.m_pbDrawing.TabIndex = 20;
            this.m_pbDrawing.TabStop = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(24, 226);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(72, 13);
            this.label1.TabIndex = 99;
            this.label1.Text = "CMP Value 1:";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblCmpType1
            // 
            this.m_lblCmpType1.AutoSize = true;
            this.m_lblCmpType1.Location = new System.Drawing.Point(27, 251);
            this.m_lblCmpType1.Name = "m_lblCmpType1";
            this.m_lblCmpType1.Size = new System.Drawing.Size(69, 13);
            this.m_lblCmpType1.TabIndex = 99;
            this.m_lblCmpType1.Text = "CMP Type 1:";
            this.m_lblCmpType1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_cbCompareType1
            // 
            this.m_cbCompareType1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbCompareType1.FormattingEnabled = true;
            this.m_cbCompareType1.Location = new System.Drawing.Point(108, 247);
            this.m_cbCompareType1.Name = "m_cbCompareType1";
            this.m_cbCompareType1.Size = new System.Drawing.Size(124, 21);
            this.m_cbCompareType1.TabIndex = 8;
            this.m_cbCompareType1.SelectedIndexChanged += new System.EventHandler(this.m_cbCompareType1_SelectedIndexChanged);
            // 
            // m_cbCompareType2
            // 
            this.m_cbCompareType2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbCompareType2.FormattingEnabled = true;
            this.m_cbCompareType2.Location = new System.Drawing.Point(322, 247);
            this.m_cbCompareType2.Name = "m_cbCompareType2";
            this.m_cbCompareType2.Size = new System.Drawing.Size(102, 21);
            this.m_cbCompareType2.TabIndex = 10;
            this.m_cbCompareType2.SelectedIndexChanged += new System.EventHandler(this.m_cbCompareType2_SelectedIndexChanged);
            // 
            // m_rbResolution8
            // 
            this.m_rbResolution8.AutoSize = true;
            this.m_rbResolution8.Location = new System.Drawing.Point(0, 1);
            this.m_rbResolution8.Name = "m_rbResolution8";
            this.m_rbResolution8.Size = new System.Drawing.Size(46, 17);
            this.m_rbResolution8.TabIndex = 1;
            this.m_rbResolution8.Text = "8-Bit";
            this.m_rbResolution8.UseVisualStyleBackColor = true;
            this.m_rbResolution8.CheckedChanged += new System.EventHandler(this.m_rbResolution_CheckedChanged);
            // 
            // m_rbResolution16
            // 
            this.m_rbResolution16.AutoSize = true;
            this.m_rbResolution16.Location = new System.Drawing.Point(127, 1);
            this.m_rbResolution16.Name = "m_rbResolution16";
            this.m_rbResolution16.Size = new System.Drawing.Size(52, 17);
            this.m_rbResolution16.TabIndex = 1;
            this.m_rbResolution16.Text = "16-Bit";
            this.m_rbResolution16.UseVisualStyleBackColor = true;
            this.m_rbResolution16.CheckedChanged += new System.EventHandler(this.m_rbResolution_CheckedChanged);
            // 
            // m_lblCmpValue2
            // 
            this.m_lblCmpValue2.AutoSize = true;
            this.m_lblCmpValue2.Location = new System.Drawing.Point(245, 226);
            this.m_lblCmpValue2.Name = "m_lblCmpValue2";
            this.m_lblCmpValue2.Size = new System.Drawing.Size(72, 13);
            this.m_lblCmpValue2.TabIndex = 99;
            this.m_lblCmpValue2.Text = "CMP Value 2:";
            this.m_lblCmpValue2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblCmpType2
            // 
            this.m_lblCmpType2.AutoSize = true;
            this.m_lblCmpType2.Location = new System.Drawing.Point(248, 251);
            this.m_lblCmpType2.Name = "m_lblCmpType2";
            this.m_lblCmpType2.Size = new System.Drawing.Size(69, 13);
            this.m_lblCmpType2.TabIndex = 99;
            this.m_lblCmpType2.Text = "CMP Type 2:";
            this.m_lblCmpType2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_lblCalcFrequency
            // 
            this.m_lblCalcFrequency.AutoSize = true;
            this.m_lblCalcFrequency.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.m_lblCalcFrequency.Location = new System.Drawing.Point(246, 201);
            this.m_lblCalcFrequency.Name = "m_lblCalcFrequency";
            this.m_lblCalcFrequency.Size = new System.Drawing.Size(95, 13);
            this.m_lblCalcFrequency.TabIndex = 99;
            this.m_lblCalcFrequency.Text = "Frequency = ??";
            // 
            // m_cbDitherAlign
            // 
            this.m_cbDitherAlign.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbDitherAlign.FormattingEnabled = true;
            this.m_cbDitherAlign.Location = new System.Drawing.Point(108, 247);
            this.m_cbDitherAlign.Name = "m_cbDitherAlign";
            this.m_cbDitherAlign.Size = new System.Drawing.Size(124, 21);
            this.m_cbDitherAlign.TabIndex = 9;
            this.m_cbDitherAlign.SelectedIndexChanged += new System.EventHandler(this.m_cbDitherAlign_SelectedIndexChanged);
            // 
            // m_cbDitherOffset
            // 
            this.m_cbDitherOffset.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbDitherOffset.FormattingEnabled = true;
            this.m_cbDitherOffset.Location = new System.Drawing.Point(182, 221);
            this.m_cbDitherOffset.Name = "m_cbDitherOffset";
            this.m_cbDitherOffset.Size = new System.Drawing.Size(52, 21);
            this.m_cbDitherOffset.TabIndex = 6;
            this.m_cbDitherOffset.SelectedIndexChanged += new System.EventHandler(this.m_cbDitherOffset_SelectedIndexChanged);
            // 
            // m_lblDeadBandMode
            // 
            this.m_lblDeadBandMode.AutoSize = true;
            this.m_lblDeadBandMode.Location = new System.Drawing.Point(32, 280);
            this.m_lblDeadBandMode.Name = "m_lblDeadBandMode";
            this.m_lblDeadBandMode.Size = new System.Drawing.Size(64, 13);
            this.m_lblDeadBandMode.TabIndex = 99;
            this.m_lblDeadBandMode.Text = "Dead Band:";
            this.m_lblDeadBandMode.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m_cbDeadBandMode
            // 
            this.m_cbDeadBandMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbDeadBandMode.FormattingEnabled = true;
            this.m_cbDeadBandMode.Location = new System.Drawing.Point(108, 276);
            this.m_cbDeadBandMode.Name = "m_cbDeadBandMode";
            this.m_cbDeadBandMode.Size = new System.Drawing.Size(222, 21);
            this.m_cbDeadBandMode.TabIndex = 12;
            this.m_cbDeadBandMode.SelectedIndexChanged += new System.EventHandler(this.m_cbDeadBandMode_SelectedIndexChanged);
            // 
            // m_cbFFDeadBandMode
            // 
            this.m_cbFFDeadBandMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.m_cbFFDeadBandMode.FormattingEnabled = true;
            this.m_cbFFDeadBandMode.Location = new System.Drawing.Point(108, 276);
            this.m_cbFFDeadBandMode.Name = "m_cbFFDeadBandMode";
            this.m_cbFFDeadBandMode.Size = new System.Drawing.Size(222, 21);
            this.m_cbFFDeadBandMode.TabIndex = 11;
            this.m_cbFFDeadBandMode.Tag = "Invisible";
            this.m_cbFFDeadBandMode.Visible = false;
            this.m_cbFFDeadBandMode.SelectedIndexChanged += new System.EventHandler(this.m_cbFFDeadBandMode_SelectedIndexChanged);
            // 
            // m_bMaxPeriod
            // 
            this.m_bMaxPeriod.Location = new System.Drawing.Point(202, 197);
            this.m_bMaxPeriod.Name = "m_bMaxPeriod";
            this.m_bMaxPeriod.Size = new System.Drawing.Size(45, 20);
            this.m_bMaxPeriod.TabIndex = 4;
            this.m_bMaxPeriod.Text = "Max";
            this.m_bMaxPeriod.UseVisualStyleBackColor = true;
            this.m_bMaxPeriod.Click += new System.EventHandler(this.m_bMaxPeriod_Click);
            // 
            // m_rbUDB
            // 
            this.m_rbUDB.AutoSize = true;
            this.m_rbUDB.Location = new System.Drawing.Point(127, -2);
            this.m_rbUDB.Name = "m_rbUDB";
            this.m_rbUDB.Size = new System.Drawing.Size(48, 17);
            this.m_rbUDB.TabIndex = 1;
            this.m_rbUDB.Text = "UDB";
            this.m_rbUDB.UseVisualStyleBackColor = true;
            this.m_rbUDB.CheckedChanged += new System.EventHandler(this.m_rbUDB_CheckedChanged);
            // 
            // m_rbFixedFunction
            // 
            this.m_rbFixedFunction.AutoSize = true;
            this.m_rbFixedFunction.Location = new System.Drawing.Point(0, -2);
            this.m_rbFixedFunction.Name = "m_rbFixedFunction";
            this.m_rbFixedFunction.Size = new System.Drawing.Size(94, 17);
            this.m_rbFixedFunction.TabIndex = 0;
            this.m_rbFixedFunction.Text = "Fixed Function";
            this.m_rbFixedFunction.UseVisualStyleBackColor = true;
            this.m_rbFixedFunction.CheckedChanged += new System.EventHandler(this.m_rbFixedFunction_CheckedChanged);
            // 
            // m_lblImplementation
            // 
            this.m_lblImplementation.AutoSize = true;
            this.m_lblImplementation.Location = new System.Drawing.Point(15, 126);
            this.m_lblImplementation.Name = "m_lblImplementation";
            this.m_lblImplementation.Size = new System.Drawing.Size(81, 13);
            this.m_lblImplementation.TabIndex = 103;
            this.m_lblImplementation.Text = "Implementation:";
            this.m_lblImplementation.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.m_rbFixedFunction);
            this.panel1.Controls.Add(this.m_rbUDB);
            this.panel1.Location = new System.Drawing.Point(109, 126);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(190, 18);
            this.panel1.TabIndex = 0;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.m_rbResolution8);
            this.panel2.Controls.Add(this.m_rbResolution16);
            this.panel2.Location = new System.Drawing.Point(109, 147);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(190, 18);
            this.panel2.TabIndex = 1;
            // 
            // m_numPeriod
            // 
            this.m_numPeriod.Location = new System.Drawing.Point(108, 197);
            this.m_numPeriod.Name = "m_numPeriod";
            this.m_numPeriod.Size = new System.Drawing.Size(79, 20);
            this.m_numPeriod.TabIndex = 3;
            // 
            // m_numCompare1
            // 
            this.m_numCompare1.Location = new System.Drawing.Point(109, 222);
            this.m_numCompare1.Name = "m_numCompare1";
            this.m_numCompare1.Size = new System.Drawing.Size(68, 20);
            this.m_numCompare1.TabIndex = 5;
            // 
            // m_numCompare2
            // 
            this.m_numCompare2.Location = new System.Drawing.Point(322, 222);
            this.m_numCompare2.Name = "m_numCompare2";
            this.m_numCompare2.Size = new System.Drawing.Size(102, 20);
            this.m_numCompare2.TabIndex = 7;
            // 
            // m_numDeadBandCounts
            // 
            this.m_numDeadBandCounts.Location = new System.Drawing.Point(348, 277);
            this.m_numDeadBandCounts.Name = "m_numDeadBandCounts";
            this.m_numDeadBandCounts.Size = new System.Drawing.Size(76, 20);
            this.m_numDeadBandCounts.TabIndex = 13;
            // 
            // CyConfigureTab
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.m_numDeadBandCounts);
            this.Controls.Add(this.m_numCompare2);
            this.Controls.Add(this.m_numCompare1);
            this.Controls.Add(this.m_numPeriod);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.m_lblImplementation);
            this.Controls.Add(this.m_bMaxPeriod);
            this.Controls.Add(this.m_cbFFDeadBandMode);
            this.Controls.Add(this.m_lblDeadBandMode);
            this.Controls.Add(this.m_cbDeadBandMode);
            this.Controls.Add(this.m_cbDitherOffset);
            this.Controls.Add(this.m_cbDitherAlign);
            this.Controls.Add(this.m_lblCalcFrequency);
            this.Controls.Add(this.m_lblCmpType2);
            this.Controls.Add(this.m_lblCmpValue2);
            this.Controls.Add(this.m_cbCompareType2);
            this.Controls.Add(this.m_lblCmpType1);
            this.Controls.Add(this.m_cbCompareType1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.m_pbDrawing);
            this.Controls.Add(this.m_lblResolution);
            this.Controls.Add(this.m_lblPeriod);
            this.Controls.Add(this.m_lblPwmMode);
            this.Controls.Add(this.m_cbPWMMode);
            this.Name = "CyConfigureTab";
            this.Size = new System.Drawing.Size(450, 310);
            this.Load += new System.EventHandler(this.CyPWMControl_Load);
            this.SizeChanged += new System.EventHandler(this.CyPWMControl_SizeChanged);
            ((System.ComponentModel.ISupportInitialize)(this.m_pbDrawing)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.m_numPeriod)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numCompare2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_numDeadBandCounts)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox m_cbPWMMode;
        private System.Windows.Forms.Label m_lblPwmMode;
        private System.Windows.Forms.Label m_lblPeriod;
        private System.Windows.Forms.Label m_lblResolution;
        private System.Windows.Forms.PictureBox m_pbDrawing;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label m_lblCmpType1;
        private System.Windows.Forms.ComboBox m_cbCompareType1;
        private System.Windows.Forms.ComboBox m_cbCompareType2;
        private System.Windows.Forms.RadioButton m_rbResolution16;
        protected internal System.Windows.Forms.RadioButton m_rbResolution8;
        private System.Windows.Forms.Label m_lblCmpValue2;
        private System.Windows.Forms.Label m_lblCmpType2;
        private System.Windows.Forms.Label m_lblCalcFrequency;
        private System.Windows.Forms.ComboBox m_cbDitherAlign;
        private System.Windows.Forms.ComboBox m_cbDitherOffset;
        private System.Windows.Forms.Label m_lblDeadBandMode;
        private System.Windows.Forms.ComboBox m_cbDeadBandMode;
        private System.Windows.Forms.ComboBox m_cbFFDeadBandMode;
        private System.Windows.Forms.Button m_bMaxPeriod;
        private System.Windows.Forms.RadioButton m_rbUDB;
        private System.Windows.Forms.RadioButton m_rbFixedFunction;
        private System.Windows.Forms.Label m_lblImplementation;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.NumericUpDown m_numPeriod;
        private System.Windows.Forms.NumericUpDown m_numCompare1;
        private System.Windows.Forms.NumericUpDown m_numCompare2;
        private System.Windows.Forms.NumericUpDown m_numDeadBandCounts;
    }
}
