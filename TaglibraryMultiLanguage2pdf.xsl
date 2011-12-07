<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:eac-cpf="urn:isbn:1-931666-33-4"
    xmlns:ex="http://www.tei-c.org/ns/Examples"
    xmlns:exml="http://workaround for xml namespace restriction/namespace"
    xmlns:xlink="http://www.w3c.org/1999/xlink" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:example="example"
    exclude-result-prefixes="xs xlink eac-cpf ex exml example"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output indent="yes"/>
    
    <xsl:variable name="currentLanguage">eng</xsl:variable><!-- xml:lang from taglibrary -->
    <xsl:variable name="toctype">short</xsl:variable><!-- long | short -->
    <xsl:param name="spaceCharacter"> </xsl:param> <!-- For egxml formatting -->

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="Taglibrary"
                    page-height="29.7cm"
                    page-width="21cm"
                    margin-top="2.5cm"    
                    margin-bottom="2.5cm"
                    margin-left="2.5cm"
                    margin-right="1.5cm">
                    <fo:region-body
                        margin-top="2.4cm"      margin-bottom="0cm"   
                        margin-left="0cm"       margin-right="0cm"
                        column-count="1"/>
                    <fo:region-before 
                        region-name="taglibrary-region-before" extent="1.3cm" />  
                    
                    <fo:region-after 
                        region-name="taglibrary-region-after" extent="1.3cm" /> 
                </fo:simple-page-master>
             
                <fo:simple-page-master master-name="Frontmatter"
                    page-height="29.7cm"
                    page-width="21cm"
                    margin-top="2.5cm"    
                    margin-bottom="2.5cm"
                    margin-left="2.5cm"
                    margin-right="2.5cm">
                    <fo:region-body
                        margin-top="2.4cm"      margin-bottom="2.4cm"   
                        margin-left="0cm"       margin-right="2.4cm"
                        column-count="1" display-align="centre"/>
                    <fo:region-before 
                        region-name="frontmatter-region-before" extent="2.3cm" />  
                    
                    <fo:region-after 
                        region-name="frontmatter-region-after" extent="2.3cm" /> 
                </fo:simple-page-master>
            </fo:layout-master-set>
           
            <fo:page-sequence master-reference="Frontmatter">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates mode="title" select="tei:TEI/tei:text/tei:front/tei:titlePage[@xml:lang = $currentLanguage]"/>
                </fo:flow>
            </fo:page-sequence>
            
            

            <fo:page-sequence master-reference="Taglibrary">
                <fo:static-content flow-name="taglibrary-region-before" >    
                    <fo:block font-family="Arial, Garamond, serif" font-size="10pt" text-align="right" alignment-adjust="middle"
                        >
                        <fo:retrieve-marker retrieve-class-name="taglibrary-head"/>                        
                    </fo:block>      
                </fo:static-content>
                
                <fo:static-content flow-name="taglibrary-region-after" >      
                    <fo:block font-family="Arial, Garamond, serif" 
                        font-size="10pt"
                        text-align="end"
                        >
                        <fo:page-number/>
                    </fo:block>      
                </fo:static-content>
                
                
                <fo:flow flow-name="xsl-region-body">
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
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center"
            page-break-before="always">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                <xsl:text>Table of Contents</xsl:text>
                </fo:block>
            </fo:marker>
            <xsl:text>Table of Contents</xsl:text>
        </fo:block>
        <fo:block>
            <xsl:if test="$toctype='long'">
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:front"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:back"/>
            </xsl:if>
            <xsl:if test="$toctype='short'">
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:front"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:back"/>
            </xsl:if>
         </fo:block>
    </xsl:template>

    <xsl:template match="tei:front" mode="toclong">
        <xsl:if test="tei:div[@xml:lang=$currentLanguage]">
        <xsl:for-each select="tei:div/tei:div">
            <fo:block
                font-family="Times"
                font-size="14pt"
                font-weight="bold"
                space-before="8pt"
                space-after="6pt"
                text-align="left"
                >
                <fo:inline>
                <fo:basic-link internal-destination="{@xml:id}"><xsl:value-of select="tei:head"/></fo:basic-link>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt">
                    <fo:inline>
                        <fo:basic-link internal-destination="{@xml:id}"><xsl:value-of select="tei:head"/></fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:front" mode="tocshort">

          <xsl:for-each select="tei:div[@xml:lang=$currentLanguage]/tei:div">
                    <fo:block
                font-family="Times"
                font-size="14pt"
                font-weight="bold"
                space-before="8pt"
                space-after="6pt"
                text-align="left"
                text-align-last="justify">
                <fo:inline>
                    <xsl:value-of select="tei:head"/>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{@xml:id}"/>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt"
                    text-align-last="justify">
                    <fo:inline>
                        <xsl:value-of select="tei:head"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{@xml:id}"/>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        
            </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:front/tei:titlePage" mode="title">
        <fo:block
            font-family="Times"
            font-size="24pt"
            font-weight="bold"
            space-before="18pt"
            space-after="12pt"
            text-align="center">
            <xsl:apply-templates select="tei:docTitle/tei:titlePart"/>
        </fo:block>
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:docEdition"/>
        </fo:block>
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:byline"/>
        </fo:block>
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:docAuthor[1]"/>
        </fo:block>
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:docAuthor[2]"/>
        </fo:block>
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="center"
            page-break-after="always">
            <xsl:apply-templates select="tei:note"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:body | tei:back" mode="toclong">
        <xsl:for-each select="tei:div">
            <xsl:choose>
                <xsl:when test="@type='elements'">
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left"
                        >
                        <xsl:text>Elements: </xsl:text>          
                    </fo:block>
                    <fo:block>
                        <xsl:for-each select="tei:div[@type='element']">
                        <fo:inline>
                            <fo:basic-link internal-destination="{@xml:id}"><xsl:value-of select="tei:head[@type='tag']/tei:tag"/></fo:basic-link>
                        </fo:inline>
                        </xsl:for-each>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='attributes'">
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left">
                        <xsl:text>Attributes: </xsl:text></fo:block>
                    <fo:block>
                    <xsl:for-each select="tei:div[@type='attribute']">
                        <fo:inline>
                            <fo:basic-link internal-destination="{@xml:id}"><xsl:value-of select="tei:head[@type='attribute']/tei:att"/></fo:basic-link>
                        </fo:inline>
                    </xsl:for-each>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='appendix'">
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left">
                        <fo:inline>
                            <fo:basic-link internal-destination="{@xml:id}"><xsl:value-of select="tei:head"/></fo:basic-link>
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
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left"
                        text-align-last="justify"
                        >
                        <fo:inline>
                            <xsl:text>Elements</xsl:text>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{@xml:id}"/>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type='attributes'">
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left"
                        text-align-last="justify">
                        <fo:inline>
                            <xsl:text>Attributes</xsl:text>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{@xml:id}"/>
                        </fo:inline></fo:block>
                </xsl:when>
                <xsl:when test="@type='appendix'">
                    <fo:block
                        font-family="Times"
                        font-size="14pt"
                        font-weight="bold"
                        space-before="8pt"
                        space-after="6pt"
                        text-align="left"
                        text-align-last="justify">
                        <fo:inline>
                            <xsl:value-of select="tei:head"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{@xml:id}"/>
                        </fo:inline></fo:block>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    

    <xsl:template match="tei:front/tei:div">
        <xsl:if test="@xml:lang = $currentLanguage">
            <xsl:apply-templates />
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:front/tei:div/tei:div">
        <fo:block
            page-break-before="always"
            id="{@xml:id}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="tei:head"/>
                </fo:block>
            </fo:marker>
            <xsl:apply-templates />
        </fo:block>      
    </xsl:template>

    <xsl:template match="tei:front/tei:div/tei:div/tei:div">
        <fo:block id="{@xml:id}"/>
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
                        <fo:block><xsl:text>&#xA0;</xsl:text></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:list[@type='simple']">
        <!-- List with only text -->
        <xsl:if test="tei:head">
            <fo:block
                font-family="Times"
                font-size="18pt"
                font-weight="bold"
                space-before="18pt"
                space-after="12pt"
                text-align="left"><xsl:value-of select="tei:head"/></fo:block>
        </xsl:if>
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
                        <fo:block><xsl:text>&#xA0;</xsl:text></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type='elements']">
        <fo:block
            font-family="Times"
            font-size="24pt"
            font-weight="bold"
            space-before="18pt"
            space-after="12pt"
            text-align="left"
            page-break-before="always"
            id="{@xml:id}"
            >
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
            <xsl:text>Elements</xsl:text>
                </fo:block>
        </fo:marker>
            <xsl:text>Elements: </xsl:text>
        </fo:block>
        <xsl:for-each select="tei:div[@type='element']">
            <fo:block
                font-family="Times"
                font-size="18pt"
                font-weight="bold"
                space-before="18pt"
                space-after="12pt"
                text-align="left"
                page-break-before="always"
                id="{@xml:id}">
                <fo:marker marker-class-name="taglibrary-head">
                    <fo:block><xsl:text>&lt;</xsl:text>
                        <xsl:value-of select="tei:head[@type='tag']/tei:tag"/>
                        <xsl:text>&gt;</xsl:text>
                    </fo:block>
                </fo:marker>
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="tei:head[@type='tag']/tei:tag"/>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:head[@type='name']"/>
            </fo:block>
            <xsl:apply-templates select="tei:list[@xml:lang=$currentLanguage]"/>
            <xsl:apply-templates select="ex:egXML"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div[@type='attributes']">
        <fo:block
            font-family="Times"
            font-size="24pt"
            font-weight="bold"
            space-before="18pt"
            space-after="12pt"
            text-align="left"
            page-break-before="always"
            id="{@xml:id}">
            
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                <xsl:text>Attributes</xsl:text>
                </fo:block>
            </fo:marker>
            <xsl:text>Attributes:</xsl:text> 
        </fo:block>
        
        <xsl:for-each select="tei:div[@type='attribute']">
            <fo:block
                font-family="Times"
                font-size="18pt"
                font-weight="bold"
                space-before="18pt"
                space-after="12pt"
                text-align="left"
                page-break-before="always"
                id="{@xml:id}">
                <fo:marker marker-class-name="taglibrary-head">
                    <fo:block>
                        <xsl:text>@</xsl:text>
                        <xsl:value-of select="tei:head[@type='attribute']/tei:att"/>
                    </fo:block>
                </fo:marker>
                <xsl:text>@</xsl:text>
                <xsl:value-of select="tei:head[@type='attribute']/tei:att"/>
                <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:head[@type='name']"/>
            </fo:block>
            <xsl:apply-templates select="tei:list[@xml:lang=$currentLanguage]"/>
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

    <xsl:template match="tei:list[parent::tei:div[@type='element'] or parent::tei:div[@type='attribute']]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:item[@n='summary']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>Summary: </xsl:text>
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

    <xsl:template match="tei:item[@n='description']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>Description: </xsl:text>
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

    <xsl:template match="tei:item[@n='mayContain']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>May contain: </xsl:text>
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

    <xsl:template match="tei:item[@n='mayOccurIn']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>May occur within: </xsl:text>
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

    <xsl:template match="tei:item[@n='attributes']">
        <xsl:choose>
            <xsl:when test="tei:list">
                <fo:list-block provisional-distance-between-starts="40mm">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:text>Attributes: </xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                             <fo:table start-indent="body-start()-20mm" table-layout="">
                                    <fo:table-body>
                                        <xsl:for-each select="tei:list/tei:label[1]">
                                        <fo:table-row>
                                    <fo:table-cell width="50mm"><fo:block>
                                        <xsl:apply-templates/></fo:block></fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:apply-templates select="following-sibling::tei:item[1]"/>
                                            </fo:block></fo:table-cell>
                                        </fo:table-row> 
                                        </xsl:for-each>
                                        <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                        <fo:table-row>
                                            <fo:table-cell><fo:block>
                                                <xsl:apply-templates/>
                                            </fo:block></fo:table-cell>
                                            <fo:table-cell><fo:block>
                                                <xsl:apply-templates select="following-sibling::tei:item[1]"/>
                                            </fo:block></fo:table-cell>
                                        </fo:table-row>
                                        </xsl:for-each>
                                    </fo:table-body>
                                </fo:table>
                                                           
                            <!--<fo:block>
                                <xsl:for-each select="tei:list/tei:label[1]">
                                    <xsl:apply-templates/>
                                    <xsl:text>&#xA0;</xsl:text>
                                    <xsl:apply-templates select="following-sibling::tei:item[1]"/>
                                    <fo:block/>
                                </xsl:for-each>
                                <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                    <xsl:apply-templates/>
                                    <xsl:text>&#xA0;</xsl:text>
                                    <xsl:apply-templates select="following-sibling::tei:item[1]"/>
                                    <fo:block/>
                                </xsl:for-each>
                            </fo:block>-->
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Attributes: </xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:item[@n='occurrence']">
        <fo:list-block provisional-distance-between-starts="40mm">
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
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:item[@n='reference']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>References: </xsl:text>
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

    <xsl:template match="tei:item[@n='datatype']">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text>Datatype: </xsl:text>
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
        <fo:block>
        <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:tag">
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
        <fo:block
            font-family="Times"
            font-size="24pt"
            font-weight="bold"
            space-before="18pt"
            space-after="12pt"
            text-align="left"
            page-break-before="always" id="{@xml:id}">  
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:text>Appendix </xsl:text><xsl:value-of select="@n"/>
                </fo:block>
            </fo:marker>
        <xsl:text>Appendix </xsl:text><xsl:value-of select="@n"/><xsl:text>:</xsl:text>
        </fo:block>
          <xsl:apply-templates/>
       
    </xsl:template>

    <xsl:template match="tei:back/tei:div/tei:list">
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
    </xsl:template>

    <xsl:template match="tei:hi">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:front/tei:div/tei:div/ex:egXML">
        <fo:block><xsl:text> </xsl:text></fo:block>
        <fo:list-block provisional-distance-between-starts="0">
            <fo:list-item>
                <fo:list-item-label start-indent="0" end-indent="0">
                    <fo:block>
                    <xsl:text> </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:for-each select="*">
            <xsl:variable name="myDepth" select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*5"/>
            <fo:block start-indent="body-start() + {$myDepth}">
            <xsl:call-template name="eg"/>
            </fo:block>
        </xsl:for-each>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block><xsl:text> </xsl:text></fo:block>
    </xsl:template>

    <xsl:template match="ex:egXML">
        <fo:list-block provisional-distance-between-starts="40mm">
            <fo:list-item>
                <fo:list-item-label  end-indent="label-end()">
                    <fo:block>
                    <xsl:choose>
            <xsl:when test="count(*) &gt; 1">
                <xsl:text>Examples:</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Example:</xsl:text>
            </xsl:otherwise>
                    </xsl:choose>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body  start-indent="body-start()">
                    <fo:block>
                        <xsl:call-template name="newLine"/>
                    <xsl:for-each select="*">
                       <fo:block>
                        <!--<xsl:text>&#x20;</xsl:text>-->
                        <xsl:call-template name="eg"/>
                        <xsl:call-template name="newLine"/>
                        </fo:block> 
                    </xsl:for-each>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
   </xsl:template>

    <xsl:template name="eg">
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
    </xsl:template>

    <xsl:template match="eac-cpf:*|example:*">
        <xsl:variable name="myDepth" select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])*5"/>
        <!-- start-indent="{70 + $myDepth}" end-indent="{$myDepth}" -->
        <fo:block start-indent="body-start() + {$myDepth}mm" wrap-option="wrap">
            <xsl:call-template name="newLine"/>
            <!--<xsl:call-template name="makeIndent"/>-->
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
                    <!-- Need away to discover a different namespace and add the values! -->
                    <!-- Can you with help of the schemalocation descide the namespace? -->
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
            <fo:inline keep-together.within-line="always"  keep-with-previous.within-line="">
                <xsl:text>&lt;/</xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&gt;</xsl:text>
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="makeIndent">
        <xsl:variable name="depth" select="count(ancestor::*[not(namespace-uri()='http://www.tei-c.org/ns/1.0')])+5"/>
        <xsl:call-template name="makeSpace">
            <xsl:with-param name="d">
                <xsl:value-of select="$depth"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
  
    <xsl:template name="newLine">
        <xsl:text>&#x000D;&#x000A;</xsl:text>
    </xsl:template>
    
    <xsl:template name="lineBreak">
        <xsl:text>
</xsl:text>
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
        <fo:block
            font-family="Times"
            font-size="14pt"
            font-weight="bold"
            space-before="8pt"
            space-after="6pt"
            text-align="left"
            >
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>