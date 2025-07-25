/*******************************************************************************
* Copyright 2008-2015, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;

namespace SegLCD_v3_40
{
    public partial class CyCustomizer :ICyAPICustomize_v2
    {
        public const string GROUP_NAME = "SegLcdPort";

        #region ICyAPICustomize_v2 Members

        public IEnumerable<CyAPICustomizer> CustomizeAPIs(ICyAPICustomizeArgs_v2 args,
                                                          IEnumerable<CyAPICustomizer> apis)
        {
            List<CyAPICustomizer> customizers = new List<CyAPICustomizer>(apis);
            ICyInstQuery_v1 instQuery = args.InstQuery;
            Dictionary<string, string> paramDict = new Dictionary<string, string>();

            CyLCDParameters parameters = new CyLCDParameters();
            if (customizers.Count > 0)
            {
                paramDict = customizers[0].MacroDictionary;
            }

            string instanceName = instQuery.GetCommittedParam("INSTANCE_NAME").Value;

            string paramHelpers;
            paramDict.TryGetValue(CyLCDParameters.PARAM_HELPERS, out paramHelpers);

            string sNumCommonLines;
            string sNumSegmentLines;

            paramDict.TryGetValue(CyLCDParameters.PARAM_NUMCOMMONLINES, out sNumCommonLines);
            paramDict.TryGetValue(CyLCDParameters.PARAM_NUMSEGMENTLINES, out sNumSegmentLines);

            int pNumCommonLines = Convert.ToInt32(sNumCommonLines);
            int pNumSegmentLines = Convert.ToInt32(sNumSegmentLines);

            parameters.DeserializeHelpers(paramHelpers);

            for (int i = 0; i < parameters.m_helpersConfig.Count; i++)
            {
                for (int j = 0; j < parameters.m_helpersConfig[i].m_helpSegInfo.Count; j++)
                {
                    parameters.m_helpersConfig[i].m_helpSegInfo[j].Name = string.Format("{0}_{1}",
                        instanceName, parameters.m_helpersConfig[i].m_helpSegInfo[j].Name);
                }
            }

            CyAPIGenerator apiGen = new CyAPIGenerator(instanceName);

            apiGen.CollectApiCore(instQuery, ref parameters.m_helpersConfig, ref paramDict, pNumCommonLines,
                                  pNumSegmentLines);
            apiGen.CollectApiHeader(args, ref parameters.m_helpersConfig, ref paramDict, pNumCommonLines,
                                    pNumSegmentLines);

            for (int i = 0; i < customizers.Count; i++)
            {
                CyAPICustomizer api = customizers[i];
                api.MacroDictionary = paramDict;
            }
            return customizers;
        }
        #endregion
    }
}
