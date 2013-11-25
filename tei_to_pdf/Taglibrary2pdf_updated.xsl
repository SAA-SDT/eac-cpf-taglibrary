<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:eac-cpf="urn:isbn:1-931666-33-4"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ex="http://www.tei-c.org/ns/Examples"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:exml="http://workaround for xml namespace restriction/namespace"
    xmlns:xlink="http://www.w3c.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:text="http://www.tei.org/ns/1.0"
    xmlns:example="example"
    xmlns:term="term"
    xmlns:exslt="http://exslt.org/common"
    exclude-result-prefixes="xs xlink eac-cpf ex eg exml example ead mods text term"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    extension-element-prefixes="exslt"
    version="2.0">
    
    <xsl:output indent="yes"/>
    <xsl:variable name="currentLanguage">en</xsl:variable>
    <!-- xml:lang from taglibrary -->
    <xsl:variable name="toctype">long</xsl:variable>
    <!-- long | short -->
    <xsl:param name="spaceCharacter"> </xsl:param>
    <!-- For egxml formatting -->
    <xsl:variable name="bulletpoint">&#x2022;</xsl:variable>
    
    <!-- Headingtranslations in an own xml-file using the currentLanguage to fetch them -->
    <!-- This only works with XSLT-enginee Saxon 6.5.5 -->
    <xsl:variable name="headingtranslations" select="document('../tei/Headingtranslation.xml')"/>
    <!-- All translated headings -->
    <xsl:variable name="summary" select="$headingtranslations//terms/term[@name='summary']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="description" select="$headingtranslations//terms/term[@name='description']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="mayoccurwithin" select="$headingtranslations//terms/term[@name='mayoccurwithin']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="mandatory" select="$headingtranslations//terms/term[@name='mandatory']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="optional" select="$headingtranslations//terms/term[@name='optional']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="repeatable" select="$headingtranslations//terms/term[@name='repeatable']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="nonrepeatable" select="$headingtranslations//terms/term[@name='nonrepeatable']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="attributes" select="$headingtranslations//terms/term[@name='attributes']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="references" select="$headingtranslations//terms/term[@name='references']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="datatype" select="$headingtranslations//terms/term[@name='datatype']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="toc" select="$headingtranslations//terms/term[@name='toc']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="elements" select="$headingtranslations//terms/term[@name='elements']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="maycontain" select="$headingtranslations//terms/term[@name='maycontain']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="occurrence" select="$headingtranslations//terms/term[@name='occurrence']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="appendix" select="$headingtranslations//terms/term[@name='appendix']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="examples" select="$headingtranslations//terms/term[@name='examples']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="example" select="$headingtranslations//terms/term[@name='example']/translation[@lang=$currentLanguage]"/>
    <xsl:variable name="usage" select="$headingtranslations//terms/term[@name='usage']/translation[@lang=$currentLanguage]"/>
    
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-selection-strategy="character-by-character" font-family="Times, Pala">
            <fo:layout-master-set>
                    <fo:simple-page-master master-name="taglibrary-even"
                        page-height="297mm" page-width="210mm"
                        margin-top="1.5cm"
                        margin-bottom="1.5cm"
                        margin-left="1.5cm"
                        margin-right="1.5cm"
                        column-count="1">
                        <fo:region-body region-name="taglibrary-region-body" margin-top="2.0cm"
                            margin-bottom="1.5cm"
                            margin-left="1.5cm"
                            margin-right="1.5cm"
                            column-count="1"/>
                        <fo:region-before region-name="taglibrary-region-before-even" extent="1.3cm"/>
                        <fo:region-after region-name="taglibrary-region-after-even" extent="0.5cm"/>
                    </fo:simple-page-master>
                    <fo:simple-page-master master-name="taglibrary-odd"
                        page-height="297mm" page-width="210mm"
                        margin-top="1.5cm"
                        margin-bottom="1.5cm"
                        margin-left="1.5cm"
                        margin-right="1.5cm"
                        column-count="1">
                        <fo:region-body region-name="taglibrary-region-body" margin-top="2.0cm"
                            margin-bottom="1.5cm"
                            margin-left="1.5cm"
                            margin-right="1.5cm"
                            column-count="1"/>
                        <fo:region-before region-name="taglibrary-region-before-odd" extent="1.3cm"/>
                        <fo:region-after region-name="taglibrary-region-after-odd" extent="0.5cm"/>
                    </fo:simple-page-master>
                    <fo:page-sequence-master master-name="frames">
                        <fo:repeatable-page-master-alternatives>
                            <fo:conditional-page-master-reference master-reference="taglibrary-even" odd-or-even="even"/>
                            <fo:conditional-page-master-reference master-reference="taglibrary-odd" odd-or-even="odd"/>
                        </fo:repeatable-page-master-alternatives>
                    </fo:page-sequence-master>
                <fo:simple-page-master master-name="Frontmatter" page-height="29.7cm"
                    page-width="21cm" margin-top="2.5cm" margin-bottom="2.5cm" margin-left="2.5cm"
                    margin-right="2.5cm">
                    <fo:region-body region-name="frontmatter-body" margin-top="2.4cm" margin-bottom="2.4cm" margin-left="0cm"
                        margin-right="2.4cm" column-count="1" display-align="center" />
                    <fo:region-before region-name="frontmatter-region-before" extent="2.3cm"/>
                    <fo:region-after region-name="frontmatter-region-after" extent="2.3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="Frontmatter">
                <fo:flow flow-name="frontmatter-body">
                    <xsl:apply-templates mode="title"
                        select="tei:TEI/tei:text/tei:front/tei:titlePage"/>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="frames" force-page-count="end-on-even">
                <fo:static-content flow-name="taglibrary-region-before-even">
                    <fo:block font-size="10pt"
                        text-align="start" alignment-adjust="middle">
                        <fo:retrieve-marker retrieve-class-name="taglibrary-head"/>
                    </fo:block>
                </fo:static-content>
            <fo:static-content flow-name="taglibrary-region-after-even">
                <fo:block font-size="10pt" text-align="start">
                    <fo:page-number/>
                </fo:block>
            </fo:static-content>
                <fo:static-content flow-name="taglibrary-region-before-odd">
                    <fo:block font-size="10pt"
                        text-align="end" alignment-adjust="middle">
                        <fo:retrieve-marker retrieve-class-name="taglibrary-head"/>
                    </fo:block>
                </fo:static-content>
            <fo:static-content flow-name="taglibrary-region-after-odd">
                <fo:block font-size="10pt" text-align="end">
                    <fo:page-number/>
                </fo:block>
            </fo:static-content>
               <fo:flow flow-name="taglibrary-region-body">
                        <xsl:apply-templates select="tei:TEI"/>
               </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:call-template name="toc"/>
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:front/tei:div"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:body"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:back"/>
        </fo:block>
    </xsl:template>

    <xsl:template name="toc">
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
            space-after="6pt" text-align="center" page-break-before="always">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$toc"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$toc"/>
        </fo:block>
        <fo:block>
            <xsl:if test="$toctype='long'">
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:front/tei:div"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:back"/>
            </xsl:if>
            <xsl:if test="$toctype='short'">
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:front/tei:div"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:back"/>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:div" mode="toclong">
        <xsl:for-each select="tei:div">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                space-after="6pt" text-align="left">
                <fo:inline>
                    <fo:basic-link internal-destination="{generate-id()}">
                        <xsl:value-of select="tei:head"/>
                    </fo:basic-link>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt">
                    <fo:inline>
                        <fo:basic-link internal-destination="{generate-id(.)}">
                            <xsl:value-of select="tei:head"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div" mode="tocshort">
        <xsl:for-each select="tei:div">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                space-after="6pt" text-align="left" text-align-last="justify">
                <fo:inline>
                    <fo:basic-link internal-destination="{generate-id(.)}">
                        <xsl:value-of select="tei:head"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:basic-link>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt" text-align-last="justify">
                    <fo:inline>
                        <fo:basic-link internal-destination="{generate-id(.)}">
                            <xsl:value-of select="tei:head"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:front/tei:titlePage" mode="title">
        
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt"
            space-after="12pt" text-align="center">
            <xsl:for-each select="tei:docTitle/tei:titlePart">
                <xsl:apply-templates select="."/>
                <xsl:call-template name="newLine"/>
            </xsl:for-each>
        </fo:block>
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
            space-after="6pt" text-align="center">
            <xsl:apply-templates select="tei:docEdition"/>
        </fo:block>
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
            space-after="6pt" text-align="center">
            <xsl:apply-templates select="tei:byline"/>
        </fo:block>
        <xsl:for-each select="tei:docAuthor">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                space-after="6pt" text-align="center">
                <xsl:apply-templates select="."/>
            </fo:block>
        </xsl:for-each>
        <!--<fo:block font-size="14pt" font-weight="bold" space-before="8pt"
space-after="6pt" text-align="center">
<xsl:apply-templates select="tei:docAuthor[2]"/>
</fo:block>-->
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
            space-after="6pt" text-align="center">
            <xsl:apply-templates select="tei:note"/>
        </fo:block>
        <!-- No [] in filename -->
        <fo:block text-align="center" page-break-after="always" padding-before="150">
            <fo:external-graphic src="../images/SAAVert540.jpg" alignment-adjust="middle"/>
            <fo:block>Chicago</fo:block>
        </fo:block>
        <!-- Page 2 with SAA info -->
        <xsl:call-template name="secondpage"/>
    </xsl:template>

    <xsl:template name="secondpage">
        <fo:block padding-after="5cm">
            <xsl:value-of select="tei:docTitle/tei:titlePart"/>, <xsl:value-of
                select="tei:docEdition"/>
            <fo:inline border-color=""/>
        </fo:block>
        <xsl:variable name="TheWholeDocument" select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc"/>
        <!-- How to handle this when it comes to translations!!!!! -->
        <fo:block>
            <fo:table>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width="3.5cm">
                            <fo:block>Available from:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-weight="bold">The Society of American
                                Archivists</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>17 North State Street, Suite 1425</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Chicago, IL 60602-3315 USA</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>312/606-0722 Toll Free 866/722-7858</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell><fo:block/>Fax: 312/606-0728</fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>http://www.archivists.org</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block>
            <fo:table>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width=".5cm">
                            <fo:block>&#169;</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block><xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:date/@when"/>
                                by <xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:publisher"
                                /></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <!-- After here some text for making it generic and fit all TL should be in the TL file -->
                        <fo:table-cell>
                            <fo:block>All rights reserved. First edition <xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:date/@when"
                                /></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <!-- Should be in the TL file -->
                        <fo:table-cell><fo:block/>Revised 2012</fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>Printed in the United States of America</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block padding-before="1cm">
            <fo:table>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width="1.5cm">
                            <fo:block>ISBN: </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:idno[@type='ISBN']"
                                />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block page-break-after="always"/>


    </xsl:template>

    <xsl:template match="tei:body | tei:back" mode="toclong">
        <xsl:for-each select="tei:div">
            <xsl:choose>
                <xsl:when test="@type='elements'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left">
                        <xsl:value-of select="$elements"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:for-each select="tei:div[@type='elementDocumentation']">
                            <fo:inline>
                                <fo:basic-link internal-destination="{generate-id(.)}">
                                    <xsl:value-of select="tei:head/tei:gi"/>
                                </fo:basic-link>
                            </fo:inline>
                        </xsl:for-each>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='attributes'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left">
                        <xsl:value-of select="$attributes"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:for-each select="tei:div[@type='attributeDocumentation']">
                            <fo:inline>
                                <fo:basic-link internal-destination="{generate-id(.)}">
                                    <xsl:value-of select="tei:head/tei:att"/>
                                </fo:basic-link>
                            </fo:inline>
                        </xsl:for-each>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='appendix'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="tei:head"/>
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:body | tei:back" mode="tocshort">
        <xsl:for-each select="tei:div">
            <xsl:choose>
                <xsl:when test="@type='elements'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left"
                        text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="$elements"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                            <!--<xsl:value-of select="$elements"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>-->
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='attributes'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left"
                        text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="$attributes"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                            <!--<xsl:value-of select="$attributes"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>-->
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='appendix'">
                    <fo:block font-size="14pt" font-weight="bold"
                        space-before="8pt" space-after="6pt" text-align="left"
                        text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="tei:head"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                           <!-- <xsl:value-of select="tei:head"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>-->
                        </fo:inline>
                    </fo:block>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="tei:front/tei:div/tei:div">
        <fo:block page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="tei:head"/>
                </fo:block>
            </fo:marker>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:front/tei:div/tei:div/tei:div">
        <fo:block id="{generate-id(.)}"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:list[@type='ordered']">
        <!-- Numbered list -->
        <xsl:apply-templates select="tei:head"/>
        <fo:list-block>
            <xsl:for-each select="tei:item">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>
                            <fo:inline>
                                <xsl:value-of select="@n"/>
                                <xsl:text>.</xsl:text>
                            </fo:inline>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                        <fo:block>
                            <xsl:text>&#xA0;</xsl:text>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:list[@type='simple']">
        <!-- List with only text -->
        <xsl:if test="tei:head">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt"
                space-after="12pt" text-align="left">
                <xsl:value-of select="tei:head"/>
            </fo:block>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="tei:label">
                <fo:list-block provisional-distance-between-starts="70mm">
                    <xsl:for-each select="tei:label">
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>
                                    <xsl:apply-templates/>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <xsl:for-each select="following-sibling::tei:item[1]">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block provisional-distance-between-starts="20mm">
            <xsl:for-each select="tei:item">
                <fo:list-item>
                    <fo:list-item-label font-weight="bold" end-indent="label-end()">
                        <fo:block>
                            <xsl:text/>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                        <fo:block>
                            <xsl:text>&#xA0;</xsl:text>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="tei:div[@type='elements']">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt"
            space-after="12pt" text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$elements"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$elements"/>
        </fo:block>
        <xsl:for-each select="tei:div[@type='elementDocumentation']">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt"
                space-after="12pt" text-align="left" page-break-before="always"
                id="{generate-id()}">
                <fo:marker marker-class-name="taglibrary-head">
                    <fo:block id="{tei:head/tei:gi}">
                        <xsl:text>&lt;</xsl:text>
                        <xsl:value-of select="tei:head/tei:gi"/>
                        <xsl:text>&gt;</xsl:text>
                    </fo:block>
                </fo:marker>
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="tei:head/tei:gi"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:div[@type='fullName']/tei:p"/>
            </fo:block>
            <!-- Should add check if div type exist -->
            <xsl:apply-templates select="tei:div[@type='summary']"/>
            <xsl:apply-templates select="tei:div[@type='description']"/>
            <xsl:apply-templates select="tei:div[@type='usage']"/>
            <xsl:apply-templates select="tei:div[@type='mayContain']"/>
            <xsl:apply-templates select="tei:div[@type='mayOccurWithin']"/>
            <xsl:apply-templates select="tei:div[@type='reference']"/>
            <xsl:apply-templates select="tei:div[@type='attributes']"/>
            <xsl:apply-templates select="tei:div[@type='occurrence']"/>
            <xsl:apply-templates select="tei:div[@type='mandatory']"/>
            <xsl:apply-templates select="tei:div[@type='repetable']"/>
            <xsl:apply-templates select="tei:div[@type='examples']"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div[@type='attributes' and parent::tei:body]">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt"
            space-after="12pt" text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$attributes"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$attributes"/>
        </fo:block>
        <xsl:for-each select="tei:div[@type='attributeDocumentation']">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt"
                space-after="12pt" text-align="left" page-break-before="always"
                id="{generate-id(.)}">
                <fo:marker marker-class-name="taglibrary-head">
                    <fo:block id="{@xml:id}">
                        <xsl:text>@</xsl:text>
                        <xsl:value-of select="tei:head/tei:att"/>
                    </fo:block>
                </fo:marker>
                <xsl:text>@</xsl:text>
                <xsl:value-of select="tei:head/tei:att"/>
                <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:div[@type='fullName']/tei:p"/>
            </fo:block>
            <xsl:apply-templates select="tei:div[@type='summary']"/>
            <xsl:apply-templates select="tei:div[@type='description']"/>
            <xsl:apply-templates select="tei:div[@type='datatype']"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div[@type='element']">
        <fo:list-block provisional-distance-between-starts="30mm">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type='attribute']">
        <fo:list-block provisional-distance-between-starts="30mm">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='fullName']">
        
    </xsl:template>

    <xsl:template
        match="tei:list[parent::tei:div[@type='element'] or parent::tei:div[@type='attribute']]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:div[@type='summary']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$summary"/><xsl:text>: </xsl:text>
                     </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    
    
    

    <xsl:template match="tei:div[@type='description']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$description"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='usage']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$usage"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type='mayContain']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$maycontain"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <!--<xsl:apply-templates/>-->
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="text" select="tei:p"/>
                        </xsl:call-template>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='mayOccurWithin']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$mayoccurwithin"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
<!-- <xsl:apply-templates/>-->
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="text" select="tei:p"/>
                        </xsl:call-template>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='mandatory']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block break-after="auto">
                        <xsl:value-of select="$mandatory"/>
                        <xsl:text>/</xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="$optional"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='repeatable']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block break-after="auto">
                        <xsl:value-of select="$repeatable"/>
                        <xsl:text>/</xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="$nonrepeatable"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type='attributes']/tei:p">
        <xsl:choose>
            <xsl:when test="tei:list[@type='gloss']">
                <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:value-of select="$attributes"/>
                                <xsl:text>: </xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:table start-indent="body-start()-20mm" table-layout="">
                                <fo:table-body>
                                    <xsl:for-each select="tei:list/tei:label[1]">
                                        <fo:table-row>
                                            <fo:table-cell width="50mm">
                                                <fo:block>
                                                    <xsl:call-template name="tokenize">
                                                        <xsl:with-param name="text" select="."/>
                                                    </xsl:call-template>
                                                  <!--<xsl:apply-templates/>-->
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                    <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <xsl:call-template name="tokenize">
                                                        <xsl:with-param name="text" select="."/>
                                                    </xsl:call-template>
                                                  <!--<xsl:apply-templates/>-->
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </fo:table-body>
                            </fo:table>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$attributes"/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
     
    <xsl:template match="tei:list[@type='bulleted']">
        <fo:list-block provisional-distance-between-starts="20mm">
                <xsl:for-each select="tei:item">
                    <fo:list-item>
                        <fo:list-item-label font-weight="bold" end-indent="label-end()">
                            <fo:block>
                                <xsl:value-of select="$bulletpoint"/>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </xsl:for-each>
            </fo:list-block>
        
    </xsl:template>

    <xsl:template match="tei:div[@type='occurrence']">
        <xsl:apply-templates/>
        <!-- Changed due to the alternative ways of stating occurances that are in the latest version -->
        <!-- If added Occurance need to be collected from the variable -->
        <!--<fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
<fo:list-item>
<fo:list-item-label end-indent="label-end()">
<fo:block>
<xsl:text>Occurrence: </xsl:text>
</fo:block>
</fo:list-item-label>
<fo:list-item-body start-indent="body-start()">
<fo:block>
<xsl:apply-templates/>
</fo:block>
</fo:list-item-body>
</fo:list-item>
</fo:list-block>-->
    </xsl:template>

    <xsl:template match="tei:div[@type='reference']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$references"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type='datatype']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$datatype"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:p">
        <fo:block space-after="6pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:tag">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:gi">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:att">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:att" mode="toclong">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:att" mode="tocshort">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:back/tei:div">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt"
            space-after="12pt" text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$appendix"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@n"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$appendix"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>:</xsl:text>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:hi">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <fo:footnote>
            <fo:inline font-size="10" vertical-align="text-top"><xsl:value-of select="@n"/></fo:inline>
            <fo:footnote-body>
                <fo:list-block font-size="9">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block><xsl:value-of select="@n"/></fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block space-after="8">
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:footnote-body>
        </fo:footnote>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <fo:inline color="blue" keep-together.within-line="always">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="tei:front/tei:div/tei:div/tei:div/ex:egXML">
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
        <fo:list-block provisional-distance-between-starts="0">
            <fo:list-item>
                <fo:list-item-label start-indent="0" end-indent="0">
                    <fo:block>
                        <xsl:text> </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:for-each select="*">
                        <xsl:variable name="myDepth"
                            select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*5"/>
                        <fo:block start-indent="body-start() + {$myDepth}">
                            <xsl:call-template name="eg"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:div[@type='examples']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:choose>
                            <xsl:when test="count(*) &gt; 1">
                                <xsl:value-of select="$examples"/>
                                <xsl:text>:</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$example"/>
                                <xsl:text>:</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:for-each select="eg:egXML">
                        <fo:block>
                            <xsl:call-template name="newLine"/>
                            <xsl:apply-templates/>
                        </fo:block>
                    </xsl:for-each>
                    <fo:block>
                        <xsl:call-template name="newLine"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template name="eg">
        <xsl:choose>
           <xsl:when test="name()!='eac-cpf:objectXMLWrap'">
               <fo:block>
                    <xsl:call-template name="newLine"/>
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:for-each select="@*">
                        <xsl:text>&#x20;</xsl:text>
                        <xsl:choose>
                            <xsl:when
                                test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
                                <xsl:text>xml:</xsl:text>
                                <xsl:value-of select="local-name()"/>
                            </xsl:when>
                            <xsl:when test="namespace-uri()='http://www.w3c.org/1999/xlink'">
                                <xsl:text>xlink:</xsl:text>
                                <xsl:value-of select="local-name()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="local-name()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>="</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>"</xsl:text>
                    </xsl:for-each>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:apply-templates select="* | text()"/>
                    <xsl:text>&lt;/</xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:call-template name="newLine"/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&lt;objectXMLWrap&gt;</xsl:text>
                <fo:block>
                    <xsl:apply-templates mode="escape"/>
                </fo:block>
                <xsl:text>&lt;/objectXMLWrap&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
<!-- In this template all occuring other namespaceprefixis needs to be added -->
    <xsl:template match="eac-cpf:* |example:* | ead:* | mods:* | text:*">
        <xsl:variable name="myDepth"
            select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*5"/>
        <fo:block start-indent="body-start() + {$myDepth}mm" wrap-option="wrap">
            <xsl:call-template name="newLine"/>
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:for-each select="@*">
                <xsl:text>&#x20;</xsl:text>
                <xsl:choose>
                    <xsl:when
                        test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
                        <xsl:text>xml:</xsl:text>
                        <xsl:value-of select="local-name()"/>
                    </xsl:when>
                    <xsl:when test="namespace-uri()='http://www.w3c.org/1999/xlink'">
                        <xsl:text>xlink:</xsl:text>
                        <xsl:value-of select="local-name()"/>
                    </xsl:when>
                    <xsl:when test="local-name()='schemaLocation'">
                        <xsl:text>xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" </xsl:text>
                        <xsl:text>xsi:schemaLocation</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="local-name()"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>="</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
            <xsl:text>&gt;</xsl:text>
            <xsl:apply-templates select="* | text()"/>
            <fo:inline keep-together.within-line="always" keep-with-previous.within-line="">
                <xsl:text>&lt;/</xsl:text>
                <xsl:value-of select="local-name()"/>
                <xsl:text>&gt;</xsl:text>
            </fo:inline>
        </fo:block>
    </xsl:template>

<!-- Templeted not used -->
    <xsl:template match="eac-cpf:objectXMLWrapp" name="objectXMLWrapp">
        <xsl:variable name="myDepth"
            select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*1"/>
        <fo:block start-indent="body-start() + {$myDepth}mm" wrap-option="wrap">
            <xsl:text>&lt;objectXMLWrap&gt;</xsl:text>
            <fo:block>
            <xsl:apply-templates mode="escape"/>
            </fo:block>
            <xsl:text>&lt;/objectXMLWrap&gt;</xsl:text>
        </fo:block>
    </xsl:template>

    <xsl:template match="*" mode="escape">
        <xsl:variable name="myDepth"
            select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*5"/>
        <fo:block start-indent="body-start() + {$myDepth}mm" wrap-option="wrap">
            <!-- Begin opening tag -->
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="name()"/>

            <!-- Namespaces -->
            <xsl:variable name="curnode" select="."/>
            <xsl:for-each select="namespace::*">
                <xsl:variable name="nsuri" select="."/>
                <xsl:if
                    test="$curnode/descendant-or-self::*[namespace-uri()=$nsuri] and
$curnode/descendant-or-self::*[namespace-uri()!='http://www.tei-c.org/ns/Examples']
">

                    <xsl:text> xmlns</xsl:text>
                    <xsl:if test="name() != ''">
                        <xsl:text>:</xsl:text>
                        <xsl:value-of select="name()"/>
                    </xsl:if>
                    <xsl:text>='</xsl:text>
                    <xsl:call-template name="escape-xml">
                        <xsl:with-param name="text" select="."/>
                    </xsl:call-template>
                    <xsl:text>'</xsl:text>
                </xsl:if>
            </xsl:for-each>

            <!-- Attributes -->
            <xsl:for-each select="@*">
                <xsl:text> </xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>='</xsl:text>
                <xsl:call-template name="escape-xml">
                    <xsl:with-param name="text" select="."/>
                </xsl:call-template>
                <xsl:text>'</xsl:text>
            </xsl:for-each>

            <!-- End opening tag -->
            <xsl:text>&gt;</xsl:text>

            <!-- Content (child elements, text nodes, and PIs) -->
            <xsl:apply-templates select="node()" mode="escape"/>

            <!-- Closing tag -->
            <fo:inline keep-together.within-line="always" keep-with-previous.within-line="">
                <xsl:text>&lt;/</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>&gt;</xsl:text>
            </fo:inline>
        </fo:block>

    </xsl:template>

    <xsl:template name="escape-xml">
        <xsl:param name="text"/>
        <xsl:if test="$text != ''">
            <xsl:variable name="head" select="substring($text, 1, 1)"/>
            <xsl:variable name="tail" select="substring($text, 2)"/>
            <xsl:choose>
                <xsl:when test="$head = '&amp;'">&amp;amp;</xsl:when>
                <xsl:when test="$head = '&lt;'">&amp;lt;</xsl:when>
                <xsl:when test="$head = '&gt;'">&amp;gt;</xsl:when>
                <xsl:when test="$head = '&quot;'">&amp;quot;</xsl:when>
                <xsl:when test="$head = &quot;&apos;&quot;">&amp;apos;</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$head"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="escape-xml">
                <xsl:with-param name="text" select="$tail"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="makeIndent">
        <xsl:variable name="depth"
            select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])+5"/>
        <xsl:call-template name="makeSpace">
            <xsl:with-param name="d">
                <xsl:value-of select="$depth"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <xsl:template name="newLine">
        <xsl:text>&#x000D;&#x000A;</xsl:text>
    </xsl:template>

    <xsl:template name="makeSpace">
        <xsl:param name="d"/>
        <xsl:if test="number($d)&gt;1">
            <xsl:value-of select="$spaceCharacter"/>
            <xsl:call-template name="makeSpace">
                <xsl:with-param name="d">
                    <xsl:value-of select="$d -1"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:head">
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
            space-after="6pt" text-align="left">
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>
    
    
    
    <xsl:template name="tokenize">
        <xsl:param name="text" select="."/>
        <xsl:param name="separator" select="','"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:choose>
                    <xsl:when test="not(contains($text, '['))">
                        <fo:basic-link internal-destination="{translate(normalize-space($text), ':','')}">
                            <xsl:value-of select="normalize-space($text)"/>
                        </fo:basic-link>
                        
<!-- <a href="#{translate(normalize-space($text), ':','')}">
<xsl:value-of select="normalize-space($text)"/>
</a>-->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($text)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="not(contains($text, '['))">
                        <fo:basic-link internal-destination="{translate(normalize-space(substring-before($text, $separator)), ':','')}">
                            <xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
                        </fo:basic-link>
                        <!--<a href="#{translate(normalize-space(substring-before($text, $separator)), ':','')}">
<xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
</a>-->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>