<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://cypress.com/xsd/cyp3timingreport"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="t">
  
    <xsl:output method="xml"
        media-type="text/html"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/t:stareport">
        <html>
            <head>
                <title><xsl:value-of select="t:Project" /> - Static Timing Analysis Report</title>
                <style type="text/css">
                    <xsl:comment><![CDATA[
table.sta_tsu > thead > tr > th.Delay,
table.sta_tsu > tbody > tr > td.Delay,
table.sta_tscs > thead > tr > th.Period,
table.sta_tscs > tbody > tr > td.Period,
table.sta_tscs > thead > tr > th.MaxFreq,
table.sta_tscs > tbody > tr > td.MaxFreq,
table.sta_tscs > thead > tr > th.Frequency,
table.sta_tscs > tbody > tr > td.Frequency,
table.sta_tco > thead > tr > th.Delay,
table.sta_tco > tbody > tr > td.Delay,
table.sta_tpd > thead > tr > th.Delay,
table.sta_tpd > tbody > tr > td.Delay,
table.sta_toe > thead > tr > th.Delay,
table.sta_toe > tbody > tr > td.Delay,
table.sta_tcoe > thead > tr > th.Delay,
table.sta_tcoe > tbody > tr > td.Delay,
table.sta_path > thead > tr > th.Delay,
table.sta_path > tbody > tr > td.Delay,
table.sta_path > thead > tr > th.Total,
table.sta_path > tbody > tr > td.Total,
table.sta_clocksummary > thead > tr > th.ActualFreq,
table.sta_clocksummary > tbody > tr > td.ActualFreq,
table.sta_clocksummary > thead > tr > th.MaxFreq,
table.sta_clocksummary > tbody > tr > td.MaxFreq
{
   text-align: right;
}

table.sta_tsu {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

table.sta_tpd {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

table.sta_tscs {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

table.sta_tco {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

table.sta_toe {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

table.sta_tcoe {
   border: solid 2px;
   border-collapse: collapse;
   width: 90%;
}

th {
   border: solid 1px;
   vertical-align: top;
   text-align: left;
   white-space: pre-line;
}

td {
   border: solid 1px;
   vertical-align: top;
   font-family: monospace;
   white-space: pre-line;
}

table.sta_tpd > tbody > tr:hover,
table.sta_tsu > tbody > tr:hover,
table.sta_tscs > tbody > tr:hover,
table.sta_tco > tbody > tr:hover,
table.sta_toe > tbody > tr:hover,
table.sta_tcoe > tbody > tr:hover
{
   background-color: #e8e8ff;
}

table.sta_path > tbody > tr:hover {
   background-color: #e8e8ff;
}

table.sta_path {
   background-color: #f8f8f8;
   border: none;
   border-collapse: collapse;
   width: 90%;
   margin-left: 1em;
   margin-right: 1em;
}

table.sta_clocksummary {
   border: solid 2px;
   border-collapse: collapse;
}

div.sta_sec {
   padding: 0.5em;
}

div.sta_sec div.sta_sec {
   margin-left: 0.75em;
}

.sec_head {
   display: block;
   font-size: 1.17em;
   font-weight: bolder;
   margin: .83em 0;
}

div.sta_secbody {
   margin-left: 0.75em;
}

.sta_sec_desc {
   margin-bottom: 0.5em;
   white-space: pre-line;
}

]]></xsl:comment>
                </style>
                <script type="text/javascript">
                    <xsl:comment><![CDATA[
function initialize() {
    if (document.ELEMENT_NODE == null)
    {
        /* IE workaround */
        document.ELEMENT_NODE = 1;
        document.ATTRIBUTE_NODE = 2;
        document.TEXT_NODE = 3;
        document.CDATA_SECTION_MODE = 4;
        document.ENTITY_REFERENCE_MODE = 5;
        document.ENTITY_NODE = 6;
        document.PROCESSING_INSTRUCTION_NODE = 7;
        document.COMMENT_NODE = 8;
        document.DOCUMENT_NODE = 9;
        document.DOCUMENT_TYPE_NODE = 10;
        document.DOCUMENT_FRAGMENT_NODE = 11;
        document.NOTATION_NODE = 12;
    }

    var allDiv = document.getElementsByTagName("div");
    for (var i = 0; i < allDiv.length; i++)
    {
        if (allDiv[i].className == "sta_sec")
        {
            var headerDiv = getChildElementsByTagName(allDiv[i], "div")[0];
            var expandLink = getChildElementsByTagName(headerDiv, "a")[0];
            expandLink.onclick = clicked;
            var children = allDiv[i].childNodes;
            var secBody = null;
            for (var j = 0; j < children.length; j++)
            {
                if (children[j].nodeType == document.ELEMENT_NODE &&
                    children[j].className == "sta_secbody")
                {
                    secBody = children[j];
                    secBody.style.display = "none";
                }
            }
        }
    }

    var allTables = document.getElementsByTagName("table");
    for (var i = 0; i < allTables.length; i++)
    {
        var table = allTables[i];
        if (table.className == "sta_tpd" ||
            table.className == "sta_tsu" ||
            table.className == "sta_tscs" ||
            table.className == "sta_tco" ||
            table.className == "sta_toe" ||
            table.className == "sta_tcoe")
        {
            tbodyList = getChildElementsByTagName(table, "tbody");
            if (tbodyList.length != 0)
            {
                for (var row = tbodyList[0].firstChild; row != null; row = row.nextSibling)
                {
                    if (row.nodeName.toLowerCase() == "tr")
                    {
                        if (row.className == "sta_path")
                        {
                            row.style.display = "none";
                        }
                        else
                        {
                            row.style.cursor = "pointer";
                            row.onclick = rowClicked;
                        }
                    }
                }
            }
        }
    }
}

function clicked()
{
    var parent = findAncestorByClass(this, "sta_sec");
    if (parent == null)
        return false;

    var siblings = parent.childNodes;
    for (var i = 0; i < siblings.length; i++)
    {
        if (siblings[i].nodeType == document.ELEMENT_NODE &&
            siblings[i].className == "sta_secbody")
            toggleVisible(siblings[i]);
    }
    return false;
}

function findAncestorByClass(node, className)
{
    var parent;
    for (parent = node; parent != null; parent = parent.parentNode)
    {
        if (parent.nodeType == document.ELEMENT_NODE &&
            parent.className == className)
        {
            return parent;
        }
    }

    return null;
}

function rowClicked()
{
    for (var next = this.nextSibling; next != null; next = next.nextSibling)
    {
        if (next.nodeType == document.ELEMENT_NODE &&
            next.nodeName.toLowerCase() == "tr" &&
            next.className == "sta_path")
        {
            if (next.style.display == "none")
                next.style.display = "table-row";
            else
                next.style.display = "none";
            break;
        }
    }
    return false;
}

function toggleVisible(elem)
{
    if (elem.style.display == "none")
        elem.style.display = "block";
    else
        elem.style.display = "none";

    headerDiv = getChildElementsByTagName(elem.parentNode, "div")[0];
    link = getChildElementsByTagName(headerDiv, "a")[0];
    innerSpan = getChildElementsByTagName(link, "span")[0];
    textNode = getChildElementsByTagName(innerSpan, "span")[0].firstChild;
    textNode.data = (elem.style.display == "none") ? "+" : "-";
}

function getChildElementsByTagName(node, name)
{
    var result = new Array(), i = 0;
    name = name.toLowerCase();
    for (var child = node.firstChild; child != null; child = child.nextSibling)
    {
        if (child.nodeType == document.ELEMENT_NODE &&
            child.nodeName.toLowerCase() == name)
        {
            result[i++] = child;
        }
    }

    return result;
}

function expandAllPaths(rootNode, show)
{
    var show = show ? "table-row" : "none";
    var elements = getElementsByClass(rootNode, "tr", "sta_path");
    for (var i = 0; i < elements.length; i++)
    {
        elements[i].style.display = show;
    }
}

function expandAllSections(show)
{
    var show = show ? "block" : "none";
    var elements = getElementsByClass(document, "div", "sta_secbody");
    for (var i = 0; i < elements.length; i++)
    {
        if (elements[i].style.display != show)
            toggleVisible(elements[i]);
    }
}

function getElementsByClass(rootNode, elemName, className)
{
    var result = new Array(), idx = 0;
    var elements = rootNode.getElementsByTagName(elemName);
    for (var i = 0; i < elements.length; i++)
    {
        if (elements[i].className == className)
            result[idx++] = elements[i];
    }
    return result;
}

//]]></xsl:comment>
                </script>
            </head>
            <body onload="initialize();">
                <h1>Static Timing Analysis</h1>
                <div class="prop"><strong>Project: </strong> <xsl:value-of select="t:Project" /></div>
                <div class="prop"><strong>Build time: </strong> <xsl:value-of select="t:BuildTime" /></div>
                <div class="prop"><strong>Device: </strong> <xsl:value-of select="t:Device" /></div>
                <div class="prop"><strong>Revision: </strong> <xsl:value-of select="t:DeviceRev" /></div>
                <xsl:apply-templates select="t:Condition" />
                <div>
                    <a href="#" onclick="expandAllSections(1);return false;">Expand All</a> |
                    <a href="#" onclick="expandAllSections(0);return false;">Collapse All</a> |
                    <a href="#" onclick="expandAllPaths(document, 1);return false;">Show All Paths</a> |
                    <a href="#" onclick="expandAllPaths(document, 0);return false;">Hide All Paths</a>
                </div>
                <xsl:apply-templates select="t:section" />
            </body>
        </html>
    </xsl:template>

    <xsl:template match="t:Condition">
        <div class="condition">
            <xsl:for-each select="*">
                <div class="prop"><strong><xsl:choose>
                  <xsl:when test="name() = 'SpeedGrade'">Speed grade</xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="name()" />
                  </xsl:otherwise>
                </xsl:choose>: </strong> <xsl:value-of select="." /></div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="t:section">
        <xsl:if test="count(t:table|t:section) != 0">
            <div class="sta_sec">
                <div>
                    <a href="#" style="text-decoration: none; color: inherit;">
                        <span class="sec_head"><span style="font-family: monospace;">+</span> <xsl:value-of select="@name" /></span>
                    </a>
                </div>
                <div class="sta_secbody">
                    <xsl:apply-templates select="t:description" />
                    <xsl:apply-templates select="t:table|t:section" />
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="t:table">
        <xsl:choose>
            <xsl:when test="@type='sta_path'">
                <tr class="sta_path"><td class="sta_path">
                    <xsl:attribute name="colspan">
                        <xsl:value-of select="count(../t:row[1]/*)" />
                    </xsl:attribute>
                    <xsl:call-template name="maketable">
                        <xsl:with-param name="type" select="@type" />
                    </xsl:call-template>
                </td></tr>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="maketable">
                    <xsl:with-param name="type" select="@type" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="t:row">
        <xsl:param name="coldefs" />
        <tr>
            <xsl:for-each select="*">
                <xsl:variable name="pos" select="position()" />
                <xsl:variable name="colname" select="$coldefs/t:col[$pos]/@name" />
                <xsl:variable name="colValue" select="." />
                <td>
                    <xsl:choose>
                        <xsl:when test="$colname != 'Violation' or $colValue = '' or $colValue = 'SYNC'">
                            <xsl:attribute name="class">
                                <xsl:value-of select="$coldefs/t:col[$pos]/@name" />
                            </xsl:attribute>
                            <xsl:apply-templates />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates />
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </xsl:for-each>
        </tr>
    </xsl:template>

    <xsl:template match="t:description">
        <div class="sta_sec_desc">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="t:columns">
        <thead>
            <tr>
                <xsl:for-each select="*">
                    <th>
                        <xsl:attribute name="class">
                            <xsl:value-of select="@name" />
                        </xsl:attribute>
                        <xsl:value-of select="@displayName" />
                    </th>
                </xsl:for-each>
            </tr>
        </thead>
    </xsl:template>

    <xsl:template name="maketable">
        <xsl:param name="type" />
        <table>
            <xsl:attribute name="class">
                <xsl:value-of select="$type" />
            </xsl:attribute>
            <xsl:apply-templates select="t:columns" />
            <tbody>
                <xsl:apply-templates select="t:table|t:row" >
                    <xsl:with-param name="coldefs" select="t:columns" />
                </xsl:apply-templates>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
