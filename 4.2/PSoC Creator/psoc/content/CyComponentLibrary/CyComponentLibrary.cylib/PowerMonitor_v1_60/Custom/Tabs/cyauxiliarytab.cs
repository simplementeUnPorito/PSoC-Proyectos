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
    public partial class CyAuxiliaryTab : CyEditingWrapperControl
    {
        private int m_dataGridRowCount;

        #region Class properties
        public override string TabName
        {
            get { return "Auxiliary Voltages"; }
        }

        public int DataGridRowCount
        {
            get { return m_dataGridRowCount; }
            set
            {
                m_dataGridRowCount = value;
                dataGridView1.RowCount = m_dataGridRowCount;
            }
        }

        public int DataGridFirstSelectedRow
        {
            get { return GetLessSelectedRow(dataGridView1.SelectedRows); }
        }
        #endregion

        #region Constructor(s)
        public CyAuxiliaryTab(CyParameters param)
            : base(param)
        {
            // Initialize parameters objects
            m_params.m_auxTab = this;

            InitializeComponent();

            // Initialize toolstrip
            cyToolStrip1.SetParameters(param);
            cyToolStrip1.m_dgv = dataGridView1;

            // Initialize wrapper objects
            m_wrapperToolStrip = cyToolStrip1;
            m_wrapperDataGridView = dataGridView1;

            // Initialize data grid view
            dataGridView1.EditMode = DataGridViewEditMode.EditOnEnter;
            dataGridView1.AllowUserToOrderColumns = false;
            dataGridView1.AllowUserToResizeRows = false;
            dataGridView1.AllowUserToAddRows = false;

            foreach (DataGridViewColumn item in dataGridView1.Columns)
                item.SortMode = DataGridViewColumnSortMode.Programmatic;

            
            dataGridView1.AllowUserToOrderColumns = false;
            dataGridView1.AllowUserToResizeRows = false;
            dataGridView1.AllowUserToAddRows = false;

            // Fill data grid view
            UpdateUIFromTable();
        }
        #endregion

        #region Communication between table object and UI
        public void UpdateUIFromTable()
        {
            bool prevGEM = m_params.GlobalEditMode;
            m_params.GlobalEditMode = false;
            string voltageMeasurementType;
            m_dataGridRowCount = m_params.NumAuxChannels;
            dataGridView1.Rows.Clear();

            UpdateComboBoxRange();

            for (int i = 0; i < m_dataGridRowCount; i++)
            {
                voltageMeasurementType = CyEnumConverter.GetEnumDesc(m_params.AuxTable[i].m_adcRange);

                dataGridView1.Rows.Add(new object[] { 
                    CyAuxTableRow.GetAuxInputNumber(i), 
                    m_params.AuxTable[i].m_auxInputName, 
                    voltageMeasurementType
                });
            }

            m_params.GlobalEditMode = prevGEM;
        }

        public void UpdateTableFromUI()
        {
            for (int i = 0; i < m_dataGridRowCount; i++)
            {
                try
                {
                    m_params.AuxTable[i].m_auxInputName = dataGridView1.Rows[i].Cells[colAuxInputName.Index].
                        Value.ToString();
                }
                catch
                {
                    m_params.AuxTable[i].m_auxInputName = string.Empty;
                }

                m_params.AuxTable[i].m_adcRange = (CyEAdcRangeInternalType)CyEnumConverter.GetEnumValue(
                    dataGridView1.Rows[i].Cells[colVoltageMeasurementType.Index].Value,
                    typeof(CyEAdcRangeInternalType));
            }
        }

        private void UpdateComboBoxRange()
        {
            this.colVoltageMeasurementType.Items.Clear();
            if (m_params.LowVoltageMode == CyELowVoltageMode.Range_2048mV)
            {
                this.colVoltageMeasurementType.Items.Add(CyEnumConverter.GetEnumDesc(
                CyEAdcRangeInternalType.SignleEnded_2V));
            }
            else if (m_params.LowVoltageMode == CyELowVoltageMode.Range_4096mV)
            {
                this.colVoltageMeasurementType.Items.Add(CyEnumConverter.GetEnumDesc(
                CyEAdcRangeInternalType.SignleEnded_4V));
            }
            this.colVoltageMeasurementType.Items.Add(CyEnumConverter.GetEnumDesc(
            CyEAdcRangeInternalType.Differential_2048mV));
            if (m_params.DiffCurrentRange == CyEDiffCurrentRangeType.Range_128mV)
            {
                this.colVoltageMeasurementType.Items.Add(CyEnumConverter.GetEnumDesc(
                CyEAdcRangeInternalType.Differential_128mV));

            }
            else if (m_params.DiffCurrentRange == CyEDiffCurrentRangeType.Range_64mV)
            {
                this.colVoltageMeasurementType.Items.Add(CyEnumConverter.GetEnumDesc(
                CyEAdcRangeInternalType.Differential_64mV));
            }
        }

        public void UpdateVoltageMeasurementTypeColumnRange()
        {
            // It is necessary to clear datagrid before its combobox range update.
            // After updating combobox, its range will be different from values 
            // selected in datagrid and will cause an exception.
            dataGridView1.Rows.Clear();
            m_params.SetAuxTable();
            UpdateComboBoxRange();
            UpdateUIFromTable();
        }

        public void SelectDataGridViewRows(int fromRow, int toRow)
        {
            SelectRows(dataGridView1, fromRow, toRow);
        }
        #endregion

        #region Event handlers
        private void dataGridView1_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            if (m_params.GlobalEditMode)
            {
                UpdateTableFromUI();
                m_params.SetAuxTable();
            }
        }

        private void dataGridView1_CurrentCellDirtyStateChanged(object sender, EventArgs e)
        {
            CommitCellValueImmediately(dataGridView1);
        }

        private void dataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            cyToolStrip1.ChangeCopyPasteEnabling(dataGridView1.SelectedRows.Count > 0);
        }
        #endregion
    }
}
