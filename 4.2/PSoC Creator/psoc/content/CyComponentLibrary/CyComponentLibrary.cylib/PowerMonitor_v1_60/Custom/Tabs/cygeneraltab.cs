/*******************************************************************************
* Copyright 2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided. 
********************************************************************************/

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;

namespace PowerMonitor_v1_60
{
    public partial class CyGeneralTab : CyEditingWrapperControl
    {
        private const string FILE_EXTENSION_XML = "xml";
        private const string FILE_FILTER_XML = "XML files (*.xml)|*.xml|All files (*.*)|*.*";

        private byte m_previousNumConverters;
        private byte m_previousNumAuxChannels;

        public override string TabName
        {
            get { return "General"; }
        }

        #region Constructor(s)
        public CyGeneralTab(CyParameters param)
            : base(param)
        {            
            m_params.m_generalTab = this;
            m_previousNumConverters = m_params.NumConverters;
            m_previousNumAuxChannels = m_params.NumAuxChannels;

            InitializeComponent();

            cbLowVoltageMode.SelectedIndexChanged += cbDiffCurrentRange_SelectedIndexChanged;

            m_errorProvider = new ErrorProvider();
            m_errorProvider.BlinkStyle = ErrorBlinkStyle.NeverBlink;

            cbVoltageFilterType.DataSource = m_params.m_filterTypeList.ToArray();
            cbCurrentFilterType.DataSource = m_params.m_filterTypeList.ToArray();
            cbAuxFilterType.DataSource = m_params.m_filterTypeList.ToArray();
            cbDiffCurrentRange.DataSource = m_params.m_diffCurrentRangeList.ToArray();
            cbPgoodConfig.Items.AddRange(CyEnumConverter.GetEnumDescList(typeof(CyEPgoodType)));
            cbLowVoltageMode.Items.AddRange(CyEnumConverter.GetEnumDescList(typeof(CyELowVoltageMode)));
            m_cbAdcBufferMode.Items.AddRange(CyEnumConverter.GetEnumDescList(typeof(CyEInputBufferMode)));
            m_cbEocConfig.Items.AddRange(CyEnumConverter.GetEnumDescList(typeof(CyEEOCConfiguration)));

            numNumConverters.TextChanged += new EventHandler(numNumConverters_TextChanged);
            numNumConverters.Validating += new CancelEventHandler(numNumConverters_Validating);

            m_cbAdcBufferMode.SelectedIndexChanged += new EventHandler(m_cbAdcBufferMode_SelectedIndexChanged);
            m_cbEocConfig.SelectedIndexChanged += new EventHandler(m_cbEocConfig_SelectedIndexChanged);

            numAuxChannels.TextChanged += new EventHandler(numAuxChannels_TextChanged);
            numNumConverters.Minimum = 0;
            numNumConverters.Maximum = decimal.MaxValue;
            numAuxChannels.Minimum = 0;
            numAuxChannels.Maximum = decimal.MaxValue;
        }

        #endregion

        #region Assigning parameters values to controls
        public void UpdateUI(bool validateConvertersNumber)
        {
            numNumConverters.Value = m_params.NumConverters;
            numAuxChannels.Value = m_params.NumAuxChannels;

            cbVoltageFilterType.SelectedItem = CyDictParser.GetDictValue(m_params.m_displayNameDict,
                m_params.VoltageFilterType);

            cbCurrentFilterType.SelectedItem = CyDictParser.GetDictValue(m_params.m_displayNameDict,
                m_params.CurrentFilterType);

            cbAuxFilterType.SelectedItem = CyDictParser.GetDictValue(m_params.m_displayNameDict,
                m_params.AuxFilterType);

            cbDiffCurrentRange.SelectedItem = CyDictParser.GetDictValue(m_params.m_displayNameDict,
                m_params.DiffCurrentRange);

            chbExposeCalibration.Checked = m_params.ExposeCalibration;

            cbPgoodConfig.SelectedItem = CyEnumConverter.GetEnumDesc(m_params.PgoodConfig);

            cbLowVoltageMode.SelectedItem = CyEnumConverter.GetEnumDesc(m_params.LowVoltageMode);

            chbFaultOv.Checked = m_params.FaultSourcesOV;
            chbFaultUv.Checked = m_params.FaultSourcesUV;
            chbFaultOc.Checked = m_params.FaultSourcesOC;

            chbWarningOv.Checked = m_params.WarningSourcesOV;
            chbWarningUv.Checked = m_params.WarningSourcesUV;
            chbWarningOc.Checked = m_params.WarningSourcesOC;

            if (validateConvertersNumber)
                numNumConverters_Validating(numNumConverters, null);

            m_params.m_voltagesTab.UpdateColumnsState();
            m_params.m_currentsTab.UpdateColumnsState();

            UpdateInputBufferMode();

            m_cbEocConfig.SelectedItem = CyEnumConverter.GetEnumDesc(m_params.EOCConfiguration);
        }

        private void UpdateInputBufferMode()
        {
            m_params.GlobalEditMode = false;
            string valueDescription = CyEnumConverter.GetEnumDesc(m_params.InputBufferMode);

            List<string> descr = new List<string>(CyEnumConverter.GetEnumDescList(typeof(CyEInputBufferMode)));
            m_cbAdcBufferMode.Items.Clear();

            if (m_params.InputBufferMode != CyEInputBufferMode.ADC_DelSig__Rail_to_Rail)
            {
                descr.Remove(CyEnumConverter.GetEnumDesc(CyEInputBufferMode.ADC_DelSig__Rail_to_Rail));
            }
            m_cbAdcBufferMode.Items.AddRange(descr.ToArray());

            m_cbAdcBufferMode.SelectedItem = valueDescription;
            m_params.GlobalEditMode = true;
        }
        #endregion

        #region Event Handlers
        void numNumConverters_TextChanged(object sender, EventArgs e)
        {
            NumericUpDown currentControl = (NumericUpDown)sender;
            byte value = 0;
            try
            {
                value = byte.Parse(currentControl.Text);
                if (value < CyParamRanges.NUM_CONVERTERS_MIN || value > CyParamRanges.NUM_CONVERTERS_MAX)
                    throw new Exception();

                m_params.NumConverters = value;

                m_errorProvider.SetError(currentControl, string.Empty);
            }
            catch (Exception)
            {
                m_errorProvider.SetError(currentControl, string.Format(Resources.NumConvertersError,
                    CyParamRanges.NUM_CONVERTERS_MIN, CyParamRanges.NUM_CONVERTERS_MAX));
            }
        }
        void numNumConverters_Validating(object sender, CancelEventArgs e)
        {
            NumericUpDown currentControl = (NumericUpDown)sender;

            if (string.IsNullOrEmpty(m_errorProvider.GetError(currentControl)))
            {
                if (m_previousNumConverters >= CyParamRanges.NUM_CONVERTERS_MIN &&
                    m_previousNumConverters <= CyParamRanges.NUM_CONVERTERS_MAX &&
                    m_previousNumConverters != m_params.NumConverters)
                {
                    // Create new row in Voltages table
                    if (m_params.NumConverters > m_previousNumConverters)
                    {
                        int missingItemsCount = m_params.NumConverters - m_params.VoltagesTable.Count;
                        if (m_params.VoltagesTable.Count < m_params.NumConverters)
                        {
                            for (int i = 0; i < missingItemsCount; i++)
                            {
                                m_params.VoltagesTable.Add(new CyVoltagesTableRow());
                            }
                        }
                    }

                    // Create new row in Currents table
                    if (m_params.NumConverters > m_previousNumConverters)
                    {
                        int missingItemsCount = m_params.NumConverters - m_params.CurrentsTable.Count;
                        if (m_params.CurrentsTable.Count < m_params.NumConverters)
                        {
                            for (int i = 0; i < missingItemsCount; i++)
                            {
                                int nextIndex = m_params.CurrentsTable.Count;
                                m_params.CurrentsTable.Add(new CyCurrentsTableRow());
                            }
                        }
                    }

                    m_params.SetVoltagesTable(false);
                    m_params.SetCurrentsTable();

                    m_params.m_voltagesTab.UpdateUIFromTable();
                    m_params.m_currentsTab.UpdateUIFromTable();
                    SyncTables();
                    if (m_params.NumConverters > m_previousNumConverters)
                    {
                        m_params.m_voltagesTab.ValidateAllCells();
                        m_params.m_currentsTab.ValidateAllCells();
                    }
                }
                m_previousNumConverters = m_params.NumConverters;
            }
        }

        void numAuxChannels_TextChanged(object sender, EventArgs e)
        {
            NumericUpDown currentControl = (NumericUpDown)sender;
            byte value = 0;
            try
            {
                value = byte.Parse(currentControl.Text);
                if (value < CyParamRanges.NUM_AUX_CHANNELS_MIN || value > CyParamRanges.NUM_AUX_CHANNELS_MAX)
                    throw new Exception();
                m_errorProvider.SetError(currentControl, string.Empty);
                m_params.NumAuxChannels = value;
            }
            catch (Exception)
            {
                m_errorProvider.SetError(currentControl, string.Format(Resources.NumAuxChannelsError,
                    CyParamRanges.NUM_AUX_CHANNELS_MAX));
            }

            // Create new row in Aux table
            if (string.IsNullOrEmpty(m_errorProvider.GetError(currentControl)))
            {
                if (m_previousNumAuxChannels >= CyParamRanges.NUM_AUX_CHANNELS_MIN &&
                    m_previousNumAuxChannels <= CyParamRanges.NUM_AUX_CHANNELS_MAX)
                {
                    if (value > m_previousNumAuxChannels)
                    {
                        int missingItemsCount = value - m_params.AuxTable.Count;
                        if (m_params.AuxTable.Count < value)
                        {
                            for (int i = 0; i < missingItemsCount; i++)
                            {
                                // Set default voltage measurement type of new row in Aux table depending 
                                // on voltage sensing ADC range from general tab
                                CyEAdcRangeInternalType adcRange =
                                    (m_params.LowVoltageMode == CyELowVoltageMode.Range_2048mV) ?
                                    CyEAdcRangeInternalType.SignleEnded_2V : CyEAdcRangeInternalType.SignleEnded_4V;
                                m_params.AuxTable.Add(new CyAuxTableRow(adcRange));
                            }
                        }
                    }
                }
                m_params.SetAuxTable();
                m_params.m_auxTab.UpdateUIFromTable();
                m_previousNumAuxChannels = value;
            }
        }

        private void cbVoltageFilterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            m_params.VoltageFilterType = (CyEFilterType)CyDictParser.GetDictKey(m_params.m_displayNameDict,
                ((ComboBox)sender).Text);
        }

        private void cbCurrentFilterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            m_params.CurrentFilterType = (CyEFilterType)CyDictParser.GetDictKey(m_params.m_displayNameDict,
                ((ComboBox)sender).Text);
        }

        private void cbAuxFilterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            m_params.AuxFilterType = (CyEFilterType)CyDictParser.GetDictKey(m_params.m_displayNameDict,
                ((ComboBox)sender).Text);
        }

        private void m_cbAdcBufferMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (m_params.GlobalEditMode)
            {
                m_params.InputBufferMode = (CyEInputBufferMode)CyEnumConverter.GetEnumValue(((ComboBox)sender).Text,
                    typeof(CyEInputBufferMode));
                UpdateInputBufferMode();
            }
        }

        private void m_cbEocConfig_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (m_params.GlobalEditMode)
            {
                m_params.EOCConfiguration = (CyEEOCConfiguration)CyEnumConverter.GetEnumValue(((ComboBox)sender).Text,
                    typeof(CyEEOCConfiguration));
            }
        }

        private void cbDiffCurrentRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (sender == cbLowVoltageMode)
            {
                m_params.LowVoltageMode = (CyELowVoltageMode)CyEnumConverter.GetEnumValue(((ComboBox)sender).Text,
                    typeof(CyELowVoltageMode));
            }
            else if (sender == cbDiffCurrentRange)
            {
                m_params.DiffCurrentRange = (CyEDiffCurrentRangeType)CyDictParser.GetDictKey(
                    m_params.m_displayNameDict, ((ComboBox)sender).Text);
            }

            SyncAuxTable();

            if (m_params.GlobalEditMode)
            {
                m_params.m_auxTab.UpdateVoltageMeasurementTypeColumnRange();
                // OC and OV Fault Thresholds depend on ADC range, so should be validated after its change
                m_params.m_voltagesTab.ValidateAllCells();
                m_params.m_currentsTab.ValidateAllCells();
            }
        }

        private void chbExposeCalibration_CheckedChanged(object sender, EventArgs e)
        {
            m_params.ExposeCalibration = ((CheckBox)sender).Checked;
        }

        private void cbPgoodConfig_SelectedIndexChanged(object sender, EventArgs e)
        {
            CyEPgoodType pgoodValue = (CyEPgoodType)CyEnumConverter.GetEnumValue(((ComboBox)sender).Text,
                typeof(CyEPgoodType));
            m_params.PgoodConfig = pgoodValue;
        }

        private void chbFaultOv_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.FaultSourcesOV != ((CheckBox)sender).Checked)
            {
                m_params.FaultSourcesOV = ((CheckBox)sender).Checked;
                m_params.m_voltagesTab.UpdateColumnsVisibility();
                m_params.m_voltagesTab.UpdateColumnsState();
                m_params.m_voltagesTab.ValidateAllCells();
            }
        }

        private void chbFaultUv_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.FaultSourcesUV != ((CheckBox)sender).Checked)
            {
                m_params.FaultSourcesUV = ((CheckBox)sender).Checked;
                m_params.m_voltagesTab.UpdateColumnsVisibility();
                m_params.m_voltagesTab.UpdateColumnsState();
                m_params.m_voltagesTab.ValidateAllCells();
            }
        }

        private void chbFaultOc_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.FaultSourcesOC != ((CheckBox)sender).Checked)
            {
                m_params.FaultSourcesOC = ((CheckBox)sender).Checked;
                m_params.m_currentsTab.UpdateColumnsVisibility();
                m_params.m_currentsTab.UpdateColumnsState();
                m_params.m_currentsTab.ValidateAllCells();
            }
        }

        private void chbWarningOv_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.WarningSourcesOV != ((CheckBox)sender).Checked)
            {
                m_params.WarningSourcesOV = ((CheckBox)sender).Checked;
                m_params.m_voltagesTab.UpdateColumnsVisibility();
                m_params.m_voltagesTab.UpdateColumnsState();
                m_params.m_voltagesTab.ValidateAllCells();
            }
        }

        private void chbWarningUv_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.WarningSourcesUV != ((CheckBox)sender).Checked)
            {
                m_params.WarningSourcesUV = ((CheckBox)sender).Checked;
                m_params.m_voltagesTab.UpdateColumnsVisibility();
                m_params.m_voltagesTab.UpdateColumnsState();
                m_params.m_voltagesTab.ValidateAllCells();
            }
        }

        private void chbWarningOc_CheckedChanged(object sender, EventArgs e)
        {
            if (m_params.WarningSourcesOC != ((CheckBox)sender).Checked)
            {
                m_params.WarningSourcesOC = ((CheckBox)sender).Checked;
                m_params.m_currentsTab.UpdateColumnsVisibility();
                m_params.m_currentsTab.UpdateColumnsState();
                m_params.m_currentsTab.ValidateAllCells();
            }
        }

        private void CyBasicTab_Load(object sender, EventArgs e)
        {
            if (m_params.IsVoltagesTableDefault)
                m_params.SetVoltagesTable();
            if (m_params.IsCurrentsTableDefault)
                m_params.SetCurrentsTable();
            if (m_params.IsAuxTableDefault)
                m_params.SetAuxTable();
        }
        #endregion

        #region Sync dependent tables
        public void SyncTables()
        {
            for (int i = 0; i < m_params.VoltagesTable.Count; i++)
            {
                if (m_params.VoltagesTable[i].m_voltageMeasurementType == CyEVInternalType.Differential)
                    m_params.CurrentsTable[i].m_currentMeasurementType = CyECurrentMeasurementInternalType.None;
            }
        }

        public void SyncAuxTable()
        {
            for (int i = 0; i < m_params.AuxTable.Count; i++)
            {
                SyncAuxTableItem(i);
            }
        }

        public void SyncAuxTableItem(int i)
        {
            if (m_params.DiffCurrentRange == CyEDiffCurrentRangeType.Range_64mV)
            {
                if (m_params.AuxTable[i].m_adcRange == CyEAdcRangeInternalType.Differential_128mV)
                {
                    m_params.AuxTable[i].m_adcRange = CyEAdcRangeInternalType.Differential_64mV;
                }
            }
            else if (m_params.DiffCurrentRange == CyEDiffCurrentRangeType.Range_128mV)
            {
                if (m_params.AuxTable[i].m_adcRange == CyEAdcRangeInternalType.Differential_64mV)
                {
                    m_params.AuxTable[i].m_adcRange = CyEAdcRangeInternalType.Differential_128mV;
                }
            }

            if (m_params.LowVoltageMode == CyELowVoltageMode.Range_2048mV)
            {
                if (m_params.AuxTable[i].m_adcRange == CyEAdcRangeInternalType.SignleEnded_4V)
                {
                    m_params.AuxTable[i].m_adcRange = CyEAdcRangeInternalType.SignleEnded_2V;
                }
            }
            else if (m_params.LowVoltageMode == CyELowVoltageMode.Range_4096mV)
            {
                if (m_params.AuxTable[i].m_adcRange == CyEAdcRangeInternalType.SignleEnded_2V)
                {
                    m_params.AuxTable[i].m_adcRange = CyEAdcRangeInternalType.SignleEnded_4V;
                }
            }
        }
        #endregion

        #region Toolbar
        public override void LoadConfig(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Title = Resources.LoadDialogHeader;
            openFileDialog.FileName = string.Empty;
            openFileDialog.CheckFileExists = true;
            openFileDialog.CheckPathExists = true;
            openFileDialog.DefaultExt = FILE_EXTENSION_XML;
            openFileDialog.Filter = FILE_FILTER_XML;
            openFileDialog.FilterIndex = 1;
            openFileDialog.RestoreDirectory = true;
            openFileDialog.Multiselect = false;

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                DialogResult dr = MessageBox.Show(Resources.LoadConfirmation, m_params.m_inst.ComponentName,
                    MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                if (dr == DialogResult.Yes)
                {
                    string fileContent = CyImportExport.GetFileText(openFileDialog.FileName);
                    m_params.LoadAllParametersFromFile(fileContent);
                }
            }
        }

        public override void SaveConfig(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Title = Resources.SaveDialogHeader;
            saveFileDialog.DefaultExt = FILE_EXTENSION_XML;
            saveFileDialog.Filter = FILE_FILTER_XML;
            saveFileDialog.FilterIndex = 1;
            saveFileDialog.RestoreDirectory = true;
            saveFileDialog.FileName = m_params.m_inst.InstanceName;

            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                CyImportExport.SaveToFile(saveFileDialog.FileName, m_params.Serialize(m_params));
            }
        }
        #endregion Toolbar
    }
}
