/*******************************************************************************
* Copyright 2008-2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Windows.Forms;
using System.Diagnostics;

using CyDesigner.Common.Base.Controls;
using CyDesigner.Extensions.Common;

using ActiproSoftware.UIStudio.TabStrip;

namespace Cypress.Comps.PinsAndPorts.cy_pins_v2_20
{
    /// <summary>
    /// Contains a SplitContainer with a tree on the left and params on the right.
    /// </summary>
    public partial class CyPinsControl : UserControl, ICyParamEditingControl
    {
        private readonly CyPinData m_port;
        private readonly CyErrorManager m_errMgr;
        private readonly int PinImageIndex;
        private readonly int SIOPinImageIndex;

        private CyNumPinsToolStripTextBox m_numPinsTextBox;
        private ToolStripButton m_moveUpButton;
        private ToolStripButton m_moveDownButton;
        private ToolStripButton m_deleteButton;
        private ToolStripButton m_renameButton;
        private ToolStripButton m_groupSIOButton;
        private ToolStripButton m_ungroupSIOButton;

        private const int AllPinsTag = -2;
        private const int SIOPairTag = -3;
        private CyPerPinDataControl m_perPinDataControl;
        // Controls that break forms designer
        private CyPinPicture m_pinPicture;
        private CyDesigner.Common.Base.Controls.CyMultiSelectTreeView m_treeView;

        public CyPinsControl(CyDeviceSupport deviceSupport, CyErrorManager errMgr, CyPinData pins, bool isSysBuilder)
        {
            InitializeComponent();
            InitPinPicture();
            InitTreeView();

            m_port = pins;
            m_errMgr = errMgr;
            Dock = DockStyle.Fill;

            m_treeView.CheckBoxes = CyTreeView.CheckBoxDisplay.SHOW_NONE;
            m_treeView.ShowRootLines = false;
            m_treeView.HideSelection = false;
            m_treeView.ShowNodeToolTips = true;
            m_treeView.ImageList = new CyTableViewBase.CyImageList();
            PinImageIndex = m_treeView.ImageList.AddImage(Resource1.PinImage);
            SIOPinImageIndex = m_treeView.ImageList.AddImage(Resource1.SIOPinImage);

            m_toolStrip.CanOverflow = true;
            m_toolStrip.GripStyle = ToolStripGripStyle.Hidden;
            m_toolStrip.RenderMode = ToolStripRenderMode.System;
            m_toolStrip.ShowItemToolTips = true;

            ToolStripLabel numPinsLabel = new ToolStripLabel("Number of pins:");
            m_toolStrip.Items.Add(numPinsLabel);

            m_numPinsTextBox = new CyNumPinsToolStripTextBox(pins);
            m_toolStrip.Items.Add(m_numPinsTextBox);

            m_toolStrip.Items.Add(new ToolStripSeparator());

            m_deleteButton = 
                new ToolStripButton("Delete Selected Pin/s (Delete)", Resource1.DeleteImage, DeletePinClicked);
            m_deleteButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_deleteButton);

            m_renameButton = 
                new ToolStripButton("Change Selected Pin's Alias... (F2)", Resource1.PinAliasImage, RenamePinClicked);
            m_renameButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_renameButton);

            m_moveUpButton = new ToolStripButton("Move Selected Pin/s Up", Resource1.MoveUpImage, MovePinUpClicked);
            m_moveUpButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_moveUpButton);

            m_moveDownButton = 
                new ToolStripButton("Move Selected Pin/s Down", Resource1.MoveDownImage, MovePinDownClicked);
            m_moveDownButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_moveDownButton);

            m_toolStrip.Items.Add(new ToolStripSeparator());

            m_groupSIOButton = new ToolStripButton("Pair Selected SIOs", Resource1.PairSIOsImage, PairSIOsClicked);
            m_groupSIOButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_groupSIOButton);

            m_ungroupSIOButton = 
                new ToolStripButton("Un-pair Selected SIOs", Resource1.UnpairSIOsImage, UnpairSIOsClicked);
            m_ungroupSIOButton.DisplayStyle = ToolStripItemDisplayStyle.Image;
            m_toolStrip.Items.Add(m_ungroupSIOButton);

            m_toolStrip.Items.Add(new ToolStripSeparator());

            m_perPinDataControl = new CyPerPinDataControl(deviceSupport, errMgr, pins, m_pinPicture, PinSIOStateChanged, isSysBuilder);
            m_perPinDataControl.Dock = DockStyle.Fill;
            m_perPinDataControl.TabStripSelectionChanged += m_perPinControl_TabStripSelectedIndexChanged;
            m_splitContainer.Panel2.Controls.Add(m_perPinDataControl);

            RebuildTree();
            UpdateMinSize();
            UpdateData();
            UpdatePerPinDataDisplayed();

            m_treeView.BeforeCollapse += m_treeView_BeforeCollapse;
            m_treeView.AfterMultiSelect += m_treeView_AfterMultiSelect;
            m_treeView.NodeMouseDoubleClick += m_treeView_NodeMouseDoubleClick;
            m_numPinsTextBox.Validated += m_numPinsTextBox_Validated;
        }

        private void InitTreeView()
        {
            ComponentResourceManager resources = new ComponentResourceManager(typeof(CyPinsControl));
            m_treeView = new CyMultiSelectTreeView();
            m_treeView.BackColor = System.Drawing.SystemColors.Window;
            m_treeView.CheckBoxes = CyDesigner.Common.Base.Controls.CyTreeView.CheckBoxDisplay.SHOW_NONE;
            m_treeView.CyTreeViewNodeSorter = null;
            m_treeView.Dock = System.Windows.Forms.DockStyle.Fill;
            m_treeView.FocusWhenSelectedNodeChanged = false;
            m_treeView.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            m_treeView.ForeColor = System.Drawing.SystemColors.WindowText;
            m_treeView.FullRowSelect = false;
            m_treeView.HideSelection = true;
            m_treeView.HotTracking = false;
            m_treeView.HotTrackingFont = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Underline);
            m_treeView.HotTrackingForeColor = System.Drawing.SystemColors.HotTrack;
            m_treeView.ImageIndex = -1;
            m_treeView.ImageKey = null;
            CyTableViewBase.CyImageList cyImageList1 = new CyTableViewBase.CyImageList();
            cyImageList1.ImageSize = new System.Drawing.Size(16, 16);
            m_treeView.ImageList = cyImageList1;
            m_treeView.Indent = 19;
            m_treeView.ItemHeight = 18;
            m_treeView.LineColor = System.Drawing.SystemColors.GrayText;
            m_treeView.Location = new System.Drawing.Point(0, 0);
            m_treeView.MakeId = ((CyTreeView.MakeUniqueIdDelegate)(resources.GetObject("m_treeView.MakeId")));
            m_treeView.Name = "m_treeView";
            m_treeView.PathSeperator = "\\";
            m_treeView.Scrollable = true;
            m_treeView.SelectedNode = null;
            m_treeView.ShowHorizontalScrollBar = true;
            m_treeView.ShowLines = true;
            m_treeView.ShowNodeToolTips = false;
            m_treeView.ShowPlusMinus = true;
            m_treeView.ShowRootLines = true;
            m_treeView.Size = new Size(136, 286);
            m_treeView.Sorted = false;
            m_treeView.TabIndex = 0;
            m_treeView.TabStop = false;
            m_treeView.Text = "cyTreeView1";

            m_splitContainer1.SuspendLayout();
            m_splitContainer1.Panel1.SuspendLayout();
            m_splitContainer1.Panel1.Controls.Add(m_treeView);
            m_splitContainer1.Panel1.ResumeLayout(false);
            m_splitContainer1.Panel1.PerformLayout();
            m_splitContainer1.ResumeLayout(false);
        }

        private void InitPinPicture()
        {
            // Can't initialize CyPinPicture from designer.cs; forms designer chokes trying to instantiate it
            m_pinPicture = new CyPinPicture();
            ((ISupportInitialize)(m_pinPicture)).BeginInit();
            this.m_pinPicture.BackColor = System.Drawing.Color.White;
            this.m_pinPicture.BorderStyle = BorderStyle.None;
            this.m_pinPicture.Name = "m_pinPicture";
            this.m_pinPicture.ShowAnalog = false;
            this.m_pinPicture.ShowBidirectional = false;
            this.m_pinPicture.ShowDigitalInput = false;
            this.m_pinPicture.ShowDigitalInputConnection = false;
            this.m_pinPicture.ShowDigitalOutput = false;
            this.m_pinPicture.ShowDigitalOutputConnection = false;
            this.m_pinPicture.ShowOutputEnable = false;
            this.m_pinPicture.ShowAnnotation = false;
            this.m_pinPicture.Size = new System.Drawing.Size(200, 100);
            this.m_pinPicture.TabIndex = 8;
            this.m_pinPicture.TabStop = false;
            ((System.ComponentModel.ISupportInitialize)(this.m_pinPicture)).EndInit();
            m_splitContainer1.SuspendLayout();
            m_splitContainer1.Panel2.SuspendLayout();
            m_splitContainer1.Panel2.Controls.Add(m_pinPicture);
            m_splitContainer1.Panel2.ResumeLayout(false);
            m_splitContainer1.Panel2.PerformLayout();
            m_splitContainer1.ResumeLayout(false);
        }

        private void PerformDispose()
        {
            m_treeView.BeforeCollapse -= m_treeView_BeforeCollapse;
            m_treeView.AfterMultiSelect -= m_treeView_AfterMultiSelect;
            m_treeView.NodeMouseDoubleClick -= m_treeView_NodeMouseDoubleClick;
            m_numPinsTextBox.Validated -= m_numPinsTextBox_Validated;
        }

        void m_perPinControl_TabStripSelectedIndexChanged(object sender, EventArgs args)
        {
            UpdateMinSize();
        }

        void UpdateMinSize()
        {
            const int LEFT_PANE_SIZE = 205; // 5 px for borders, 200 for content
            Size minSize = m_perPinDataControl.GetPreferredSize(Size.Empty);
            minSize.Width += LEFT_PANE_SIZE;
            minSize.Height = Math.Max(minSize.Height, m_splitContainer.MinimumSize.Height);
            AutoScrollMinSize = minSize;
        }

        void m_treeView_AfterMultiSelect(object sender, CyMultiSelectTreeViewEventArgs e)
        {
            //The event is raised twice as part of setting the selection. Once to clear the selection and again to 
            //set the selected items. The first call needs to be ignored.
            if (m_treeView.SelectedNodesCount > 0)
            {
                UpdateToolStripItemsEnabled();
                UpdatePerPinDataDisplayed();
            }
        }

        static void m_treeView_BeforeCollapse(object sender, CyTreeViewCancelEventArgs e)
        {
            //Don't allow the root node to be collapsed
            if (e.Action == CyTreeViewAction.Collapse && e.Node.FullPath.Equals(Resource1.AllPins))
                e.Cancel = true;
        }

        public void UpdateData()
        {
            m_numPinsTextBox.Text = m_port.PinCount.ToString();
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            IList<CyPinData.PerPin> selectedPins = GetSelectedPins(selectedPinIndexes);
            m_perPinDataControl.UpdateData(selectedPins);
            UpdateToolStripItemsEnabled();
            RebuildTree();
        }

        public void RebuildTree()
        {
            m_treeView.SuspendLayout();
            m_treeView.BeginUpdate();

            IEnumerable<int> prevSelectedIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            m_treeView.Nodes.Clear();

            //Need to create [All Pins] node, SIO Pair nodes, SIO nodes, and pin nodes.
            CyTreeNode rootNode = new CyTreeNode(Resource1.AllPins);
            rootNode.Tag = AllPinsTag;

            CyTreeNode sioGroupNode = null;
            for (int i = 0; i < m_port.PinCount; i++)
            {
                CyTreeNode leafNode = new CyTreeNode(m_port.GetPinPoundDefineName(i));
                leafNode.Tag = i; //the tag stores the pin index

                if (m_port[i].RequiresSIO())
                {
                    if (m_port[i].SIOPairID >= 0)
                    {
                        if (null == sioGroupNode || sioGroupNode.Nodes.Count == 2)
                        {
                            sioGroupNode = new CyTreeNode(Resource1.SIOPair);
                            sioGroupNode.Tag = SIOPairTag;
                            rootNode.Nodes.Add(sioGroupNode);
                        }

                        leafNode.ImageIndex = SIOPinImageIndex;
                        sioGroupNode.Nodes.Add(leafNode);
                    }
                    else
                    {
                        leafNode.ImageIndex = SIOPinImageIndex;
                        rootNode.Nodes.Add(leafNode);
                    }
                }
                else
                {
                    leafNode.ImageIndex = PinImageIndex;
                    rootNode.Nodes.Add(leafNode);
                }
            }

            m_treeView.Nodes.Add(rootNode);

            SelectPins(prevSelectedIndexes);
            if (m_treeView.SelectedNodesCount == 0)
                m_treeView.SelectedNodes = new CyTreeNode[] { rootNode };

            m_treeView.EndUpdate();
            m_treeView.ResumeLayout();
        }

        static int GetPinIndex(CyTreeNode node)
        {
            if (node != null)
            {
                Debug.Assert(node.Tag is int);
                return (int)node.Tag;
            }
            return -1;
        }

        List<int> GetPinIndexes(IEnumerable<CyTreeNode> nodes)
        {
            List<int> indexes = new List<int>();

            foreach (CyTreeNode node in nodes)
            {
                if (node != null)
                {
                    Debug.Assert(node.Tag is int);
                    int tagInt = (int)node.Tag;

                    if (tagInt == AllPinsTag)
                    {
                        for (int i = 0; i < m_port.PinCount; i++)
                        {
                            if (!indexes.Contains(i))
                                indexes.Add(i);
                        }
                        break;
                    }
                    else if (tagInt == SIOPairTag)
                    {
                        foreach (CyTreeNode childNode in node.Nodes)
                        {
                            int childIndex = GetPinIndex(childNode);
                            if (!indexes.Contains(childIndex))
                                indexes.Add(childIndex);
                        }
                    }
                    else
                    {
                        if (!indexes.Contains(tagInt))
                            indexes.Add(tagInt);
                    }
                }
            }

            return indexes;
        }

        private int GetNumLeafNodes()
        {
            int cnt = 0;
            foreach (CyTreeNode node in m_treeView.GetAllNodesInTree())
            {
                if (node.Nodes.Count == 0)
                    cnt++;
            }
            return cnt;
        }

        private void SelectPin(int index)
        {
            if (index >= 0)
            {
                foreach (CyTreeNode node in m_treeView.GetAllNodesInTree())
                {
                    int nodesPinIndex = GetPinIndex(node);
                    if (nodesPinIndex == index)
                    {
                        m_treeView.SelectedNodes = new CyTreeNode[] { node };
                        return;
                    }
                }
            }

            //Select the root node if the selection failed
            Debug.Assert(m_treeView.Nodes.Count == 1);
            m_treeView.SelectedNodes = new CyTreeNode[] { m_treeView.Nodes[0] };
        }

        private void SelectPins(IEnumerable<int> indexes)
        {
            List<CyTreeNode> nodes = new List<CyTreeNode>();
            foreach (int index in indexes)
            {
                if (index >= 0)
                {
                    foreach (CyTreeNode node in m_treeView.GetAllNodesInTree())
                    {
                        if (index == GetPinIndex(node))
                        {
                            nodes.Add(node);
                        }
                    }
                }
            }

            if (nodes.Count == 0)
            {
                //Select the root node if the selection failed
                Debug.Assert(m_treeView.Nodes.Count == 1);
                m_treeView.SelectedNodes = new CyTreeNode[] { m_treeView.Nodes[0] };
            }
            else
            {
                m_treeView.SelectedNodes = nodes;
            }
        }

        CyTreeNode GetAssociatedNode(int index)
        {
            foreach (CyTreeNode node in m_treeView.GetAllNodesInTree())
            {
                int nodesPinIndex = GetPinIndex(node);
                if (nodesPinIndex == index)
                   return node;
            }

            return null;
        }

        private IList<CyPinData.PerPin> GetSelectedPins(IList<int> pinIndexes)
        {
            CyPinData.PerPin[] pins = new CyPinData.PerPin[pinIndexes.Count];
            for (int i = 0; i < pinIndexes.Count; i++)
                pins[i] = m_port[pinIndexes[i]];
            return pins;
        }

        #region Per Pin Data

        private void UpdatePerPinDataDisplayed()
        {
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            IList<CyPinData.PerPin> selectedPins = GetSelectedPins(selectedPinIndexes);
            m_perPinDataControl.UpdateData(selectedPins);

            m_perPinDataControl.InputTabEnabled = InputUsed(selectedPins);
            m_perPinDataControl.OutputTabEnabled = OutputUsed(selectedPins);
        }

        private static bool InputUsed(ICollection<CyPinData.PerPin> selectedPins)
        {
            bool used = false;
            foreach (CyPinData.PerPin pin in selectedPins)
                used |= ((pin.Type & (CyPinType.BIDIRECTIONAL | CyPinType.DIGITAL_IN)) > 0);
            return used;
        }

        private static bool OutputUsed(ICollection<CyPinData.PerPin> selectedPins)
        {
            bool used = false;
            foreach (CyPinData.PerPin pin in selectedPins)
                used |= ((pin.Type & (CyPinType.BIDIRECTIONAL | CyPinType.DIGITAL_OUT)) > 0);
            return used;
        }

        #endregion

        #region ToolStrip Handlers

        private void UpdateToolStripItemsEnabled()
        {
            int numLeafNodes = GetNumLeafNodes();

            m_deleteButton.Enabled = false;
            m_renameButton.Enabled = false;
            m_moveUpButton.Enabled = false;
            m_moveDownButton.Enabled = false;
            m_groupSIOButton.Enabled = false;
            m_ungroupSIOButton.Enabled = false;

            m_groupSIOButton.ToolTipText = "Pair SIOs cannot be performed. SIOs can only be paired if " +
                "they are adjacent to each other and not already in a pair.";
            m_deleteButton.ToolTipText = String.Empty;

            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            if (selectedPinIndexes.Count > 0)
            {
                if (selectedPinIndexes.Count == 1)
                {
                    m_renameButton.Enabled = true;
                }
                else if (selectedPinIndexes.Count == 2)
                {
                    int index1 = Math.Min(selectedPinIndexes[0], selectedPinIndexes[1]);
                    int index2 = Math.Max(selectedPinIndexes[0], selectedPinIndexes[1]);

                    CyPinData.PerPin pin1 = m_port[index1];
                    CyPinData.PerPin pin2 = m_port[index2];

                    //If adjacent and both are SIOs then they can be paired or unpaired
                    if ((index2 - index1) == 1 && pin1.RequiresSIO() && pin2.RequiresSIO())
                    {
                        if (pin1.SIOPairID == 0 && pin2.SIOPairID == 1)
                            m_ungroupSIOButton.Enabled = true;
                        else if (pin1.SIOPairID == -1 && pin2.SIOPairID == -1)
                        {
                            m_groupSIOButton.Enabled = true;
                            m_groupSIOButton.ToolTipText = String.Empty;
                        }
                    }
                }

                m_deleteButton.Enabled = numLeafNodes - selectedPinIndexes.Count > 0;
                m_deleteButton.ToolTipText = (m_deleteButton.Enabled) 
                    ? String.Empty 
                    : "Delete Selected Pin/s cannot be performed. Cannot have less than one pin remaining.";

                //otherwise already as low as it can go
                m_moveDownButton.Enabled = (selectedPinIndexes.Contains(numLeafNodes - 1) == false);

                //otherwise already as high as it can go
                m_moveUpButton.Enabled = (selectedPinIndexes.Contains(0) == false);
            }
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (m_treeView.ContainsFocus)
            {
                switch (keyData)
                {
                    case Keys.F2:
                        m_renameButton.PerformClick();
                        break;

                    case Keys.Delete:
                        m_deleteButton.PerformClick();
                        break;

                    case Keys.Control | Keys.A:
                        m_treeView.SelectAll();
                        break;
                }
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        void m_treeView_NodeMouseDoubleClick(object sender, CyTreeNodeMouseClickEventArgs e)
        {
            m_renameButton.PerformClick();
        }

        void m_numPinsTextBox_Validated(object sender, EventArgs e)
        {
            RebuildTree();
        }

        void RenamePinClicked(object sender, EventArgs e)
        {
            Debug.Assert(m_treeView.SelectedNodesCount == 1);
            int pinIndex = GetPinIndex(m_treeView.SelectedNode);

            if (pinIndex >= 0)
            {
                CyTreeNode node = GetAssociatedNode(pinIndex);
                if (node != null)
                {
                    using (CyPinAliasDialog dialog = new CyPinAliasDialog(node.Text, m_port[pinIndex].Alias, pinIndex))
                    {
                        Form parent = this.FindForm();
                        if (dialog.ShowDialog(parent) == DialogResult.OK)
                        {
                            m_port[pinIndex].Alias = dialog.Alias;
                            node.Text = m_port.GetPinPoundDefineName(pinIndex);
                        }
                    }
                }
                else
                    Debug.Fail("Could not find node");
            }
            else
                Debug.Fail("Invalid node selected for rename");
        }

        void DeletePinClicked(object sender, EventArgs e)
        {
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            Debug.Assert(selectedPinIndexes.Count >= 1);

            selectedPinIndexes.Sort();
            for (int i = selectedPinIndexes.Count - 1; i >= 0; i--)
                m_port.DeletePin(selectedPinIndexes[i]);

            m_numPinsTextBox.Text = m_port.PinCount.ToString();
            RebuildTree();
        }

        void MovePinUpClicked(object sender, EventArgs e)
        {
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            Debug.Assert(selectedPinIndexes.Count >= 1);

            selectedPinIndexes.Sort();
            List<int> newSelectedPins = new List<int>();
            foreach (int i in selectedPinIndexes)
                newSelectedPins.Add(i - 1);

            for (int i = 0; i < selectedPinIndexes.Count; i++)
                m_port.MoveUp(selectedPinIndexes[i]);

            RebuildTree();
            SelectPins(newSelectedPins);
        }

        void MovePinDownClicked(object sender, EventArgs e)
        {
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            Debug.Assert(selectedPinIndexes.Count >= 1);

            selectedPinIndexes.Sort();
            List<int> newSelectedPins = new List<int>();
            foreach (int i in selectedPinIndexes)
                newSelectedPins.Add(i + 1);

            for (int i = selectedPinIndexes.Count - 1; i >= 0; i--)
                m_port.MoveDown(selectedPinIndexes[i]);

            RebuildTree();
            SelectPins(newSelectedPins);
        }

        void PairSIOsClicked(object sender, EventArgs e)
        {
            SetSioGroup(true);
        }

        void UnpairSIOsClicked(object sender, EventArgs e)
        {
            SetSioGroup(false);
        }

        void PinSIOStateChanged()
        {
            RebuildTree();
        }

        void SetSioGroup(bool pair)
        {
            List<int> selectedPinIndexes = GetPinIndexes(m_treeView.SelectedNodes);
            selectedPinIndexes.Sort(); // GetPinIndexes returns indexes in the order they were selected
            Debug.Assert(selectedPinIndexes.Count == 2);

            m_port[selectedPinIndexes[0]].SIOPairID = pair ? 0 : -1;
            m_port[selectedPinIndexes[1]].SIOPairID = pair ? 1 : -1;

            RebuildTree();
        }

        #endregion

        #region ICyParamEditingControl Members

        public Control DisplayControl
        {
            get { return this; }
        }

        public IEnumerable<CyCustErr> GetErrors()
        {
            foreach (string errMsg in m_errMgr.GetErrors(CyGeneralControl.OwnedSettings))
                yield return new CyCustErr(errMsg);
            foreach (string errMsg in m_errMgr.GetErrors(CyInputControl.OwnedSettings))
                yield return new CyCustErr(errMsg);
            foreach (string errMsg in m_errMgr.GetErrors(CyOutputControl.OwnedSettings))
                yield return new CyCustErr(errMsg);
        }

        #endregion
    }

    public class CyNumPinsToolStripTextBox : ToolStripTextBox
    {
        CyPinData m_port;

        public CyNumPinsToolStripTextBox(CyPinData port)
        {
            m_port = port;
        }

        public override Size GetPreferredSize(Size constrainingSize)
        {
            Size size = base.GetPreferredSize(constrainingSize);
            size.Width = 40;
            return size;
        }

        protected override void OnValidating(CancelEventArgs e)
        {
            byte pinCount;
            string errMsg = string.Empty;
            if (byte.TryParse(Text, out pinCount))
            {
                if (pinCount > 64 || pinCount < 1 )
                    errMsg = Resource1.Err_PinCountOutOfRange;
                else if (pinCount > CyPinData.PINS_PER_PORT)
                {
                    if (pinCount > 8 && !m_port.MappingSpanning)
                    {
                        errMsg = Resource1.Err_PinCountRequiresSpanning;
                    }
                    else
                    {
                        for (int i = 0; i < Math.Min((byte)CyPinData.PINS_PER_PORT, m_port.PinCount); i++)
                        {
                            if (m_port[i].InputInterrupt != CyInputInterruptTrigger.NONE)
                                errMsg = Resource1.Err_TooManyPinsForInterrupt;
                        }
                    }
                }
            }
            else
                errMsg = Resource1.Err_PinCountOutOfRange;


            if (!string.IsNullOrEmpty(errMsg))
            {
                e.Cancel = true;
                MessageBox.Show(errMsg, "Invalid Number of Pins", MessageBoxButtons.OK, MessageBoxIcon.Error,
                    MessageBoxDefaultButton.Button1);
            }
            else
                m_port.PinCount = pinCount;

            base.OnValidating(e);
        }
    }

    public class CyPerPinDataControl : UserControl
    {
        public delegate void SIOStateChangedHandler();

        CyGeneralControl m_generalControl;
        CyInputControl m_inputControl;
        CyOutputControl m_outputControl;

        TabStripPage m_generalTab;
        TabStripPage m_inputTab;
        TabStripPage m_outputTab;

        TabStrip m_tabStrip;

        public CyPerPinDataControl(CyDeviceSupport deviceSupport, CyErrorManager errMgr, CyPinData pins,
                                    CyPinPicture pinPicture, SIOStateChangedHandler onSIOStateChanged, 
                                    bool isSysBuilder)
        {
            Dock = DockStyle.Fill;

            m_tabStrip = new TabStrip();
            m_tabStrip.PageValidationEnabled = true;
            m_tabStrip.Renderer = new VisualStudio2005DocumentWindowTabStripRenderer();

            m_generalTab = new TabStripPage();
            m_generalTab.Text = "General";
            m_generalControl = new CyGeneralControl(deviceSupport, errMgr, pins, PinTypeChanged, onSIOStateChanged, pinPicture, isSysBuilder);
            m_generalControl.Dock = DockStyle.Fill;
            m_generalTab.Controls.Add(m_generalControl);
            m_tabStrip.Pages.Add(m_generalTab);

            m_inputTab = new TabStripPage();
            m_inputTab.Text = "Input";
            m_inputControl = new CyInputControl(deviceSupport, errMgr, pins, onSIOStateChanged);
            m_inputControl.Dock = DockStyle.Fill;
            m_inputTab.Controls.Add(m_inputControl);
            m_tabStrip.Pages.Add(m_inputTab);

            m_outputTab = new TabStripPage();
            m_outputTab.Text = "Output";
            m_outputControl = new CyOutputControl(deviceSupport, errMgr, pins, onSIOStateChanged, isSysBuilder);
            m_outputControl.Dock = DockStyle.Fill;
            m_outputTab.Controls.Add(m_outputControl);
            m_tabStrip.Pages.Add(m_outputTab);

            m_tabStrip.Dock = DockStyle.Fill;
            Controls.Add(m_tabStrip);
        }

        public event TabStripPageEventHandler TabStripSelectionChanged 
        { 
            add { m_tabStrip.SelectionChanged += value; } 
            remove { m_tabStrip.SelectionChanged -= value; } 
        }

        private void PinTypeChanged(CyPinType pinType, IList<CyPinData.PerPin> pins)
        {
            InputTabEnabled = ((pinType & (CyPinType.BIDIRECTIONAL | CyPinType.DIGITAL_IN)) > 0);
            OutputTabEnabled = ((pinType & (CyPinType.BIDIRECTIONAL | CyPinType.DIGITAL_OUT)) > 0);
            m_inputControl.UpdateData(pins); // Input sync may change when pin type changes
        }

        public void UpdateData(IList<CyPinData.PerPin> selectedPins)
        {
            Debug.Assert(selectedPins.Count > 0);

            m_generalControl.UpdateData(selectedPins);
            m_inputControl.UpdateData(selectedPins);
            m_outputControl.UpdateData(selectedPins);
        }

        public bool InputTabEnabled
        {
            get { return m_inputTab.Enabled; }
            set
            {
                m_inputTab.Enabled = value;
                m_inputTab.ToolTipText = (value) 
                    ? string.Empty 
                    : "None of the selected pins have their PinType configured to use input settings.";
                // Some settings (e.g. CMOS) revert to default when Input isn't selected; make sure we're using
                // the real values now that we are actually an input
                if (value)
                    m_inputControl.UpdateData();
            }
        }

        public bool OutputTabEnabled
        {
            get { return m_outputTab.Enabled; }
            set
            {
                m_outputTab.Enabled = value;
                m_outputTab.ToolTipText = (value) 
                    ? string.Empty 
                    : "None of the selected pins have their PinType configured to use output settings.";
                // Some settings (e.g. CMOS) revert to default when Input isn't selected; make sure we're using
                // the real values now that we are actually an input
                if (value)
                    m_outputControl.UpdateData();
            }
        }

        public override Size GetPreferredSize(Size proposedSize)
        {
            // The controls we embed don't seem to report their preferred sizes particularly effectively,
            // so we will compute them directly here
            const int TAB_STRIP_HEIGHT = 20; // Tab strip is 20 pixels high at 120 DPI
            Control selectedControl = null;
            if (m_inputTab.IsSelected)
                selectedControl = m_inputControl;
            else if (m_outputTab.IsSelected)
                selectedControl = m_outputControl;
            else if (m_generalTab.IsSelected)
                selectedControl = m_generalControl;

            Debug.Assert(selectedControl != null, "Unknown control selected");

            Rectangle boundingBox = new Rectangle(0, 0, 0, 0);
            foreach (Control control in selectedControl.Controls)
            {
                boundingBox = Rectangle.Union(boundingBox, control.Bounds);
            }

            boundingBox.Height += TAB_STRIP_HEIGHT;
            return boundingBox.Size;
        }
    }
}
