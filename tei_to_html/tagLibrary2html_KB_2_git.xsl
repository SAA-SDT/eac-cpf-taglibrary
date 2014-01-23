<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:eac-cpf="urn:isbn:1-931666-33-4"
        xmlns:ead="urn:isbn:1-931666-22-9" xmlns:ex="http://www.tei-c.org/ns/Examples"
        xmlns:eg="http://www.tei-c.org/ns/Examples"
        xmlns:exml="http://workaround for xml namespace restriction/namespace"
        xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns:mods="http://www.loc.gov/mods/v3" xmlns:text="http://www.tei.org/ns/1.0"
        xmlns:example="example" xmlns:term="term" xmlns:exslt="http://exslt.org/common"
        exclude-result-prefixes="xs xlink eac-cpf ex eg exml example ead mods text term"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0" extension-element-prefixes="exslt"
        version="2.0">

        <!-- Karin: order of elelemnts!!!!! -->

        <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                encoding="UTF-8" indent="yes" method="html"/>

        <xsl:strip-space elements="*"/>

        <xsl:variable name="currentLanguage">en</xsl:variable>
        <!-- xml:lang from taglibrary -->
        <xsl:variable name="toctype">short</xsl:variable>
        <!-- long | short -->
        <xsl:param name="spaceCharacter"> </xsl:param>
        <!-- For egxml formatting -->
        <xsl:variable name="bulletpoint">&#x2022;</xsl:variable>

        <!-- Headingtranslations in an own xml-file using the currentLanguage to fetch them -->
        <!-- This only works with XSLT-enginee Saxon 6.5.5 -->
        <xsl:variable name="headingtranslations" select="document('../tei/Headingtranslation.xml')"/>
        <!-- All translated headings -->
        <xsl:variable name="summary"
                select="$headingtranslations//terms/term[@name='summary']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="description"
                select="$headingtranslations//terms/term[@name='description']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="mayoccurwithin"
                select="$headingtranslations//terms/term[@name='mayoccurwithin']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="mandatory"
                select="$headingtranslations//terms/term[@name='mandatory']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="optional"
                select="$headingtranslations//terms/term[@name='optional']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="repeatable"
                select="$headingtranslations//terms/term[@name='repeatable']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="nonrepeatable"
                select="$headingtranslations//terms/term[@name='nonrepeatable']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="attributes"
                select="$headingtranslations//terms/term[@name='attributes']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="references"
                select="$headingtranslations//terms/term[@name='references']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="datatype"
                select="$headingtranslations//terms/term[@name='datatype']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="toc"
                select="$headingtranslations//terms/term[@name='toc']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="elements"
                select="$headingtranslations//terms/term[@name='elements']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="maycontain"
                select="$headingtranslations//terms/term[@name='maycontain']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="occurrence"
                select="$headingtranslations//terms/term[@name='occurrence']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="appendix"
                select="$headingtranslations//terms/term[@name='appendix']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="examples"
                select="$headingtranslations//terms/term[@name='examples']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="example"
                select="$headingtranslations//terms/term[@name='example']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="usage"
                select="$headingtranslations//terms/term[@name='usage']/translation[@lang=$currentLanguage]"/>
        <xsl:variable name="and"
                select="$headingtranslations//terms/term[@name='and']/translation[@lang=$currentLanguage]"/>

        <xsl:template match="/">
                <html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
                        <head>
                                <title>Tag Library</title>
                                <meta content="en" http-equiv="content-language"/>
                                <!-- What if we set up a page with a translation? -->
                                <meta content="text/html; charset=utf-8" http-equiv="content-type"/>
                                <link href="tagLibrary.css" rel="stylesheet" type="text/css"/>
                        </head>
                        <body>
                                <div>
                                        <div>
                                                <xsl:apply-templates mode="title"
                                                  select="//tei:text/tei:front/tei:titlePage"/>
                                        </div>
                                        <div>
                                                <div class="head03" id="toc">
                                                  <xsl:value-of select="$toc"/>
                                                </div>
                                                <xsl:apply-templates mode="toc"
                                                  select="//tei:front/tei:div"/>
                                                <xsl:apply-templates mode="toc" select="//tei:body"/>
                                                <xsl:apply-templates mode="toc" select="//tei:back"
                                                />
                                        </div>
                                        <hr/>
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:front/tei:div"/>
                                        </div>
                                        <hr/>
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:body/tei:div"/>
                                        </div>
                                        <hr/>
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:back/tei:div"/>
                                        </div>
                                </div>
                        </body>
                </html>
        </xsl:template>

        <xsl:template match="tei:front/tei:titlePage" mode="title">
                <div class="titlePage">
                        <div class="title">
                                <xsl:apply-templates select="tei:docTitle/tei:titlePart"/>
                        </div>
                        <div class="edition">
                                <xsl:apply-templates select="tei:docEdition"/>
                        </div>
                        <div class="edition">
                                <div>
                                        <xsl:apply-templates select="tei:byline"/>
                                </div>
                                <div>
                                        <xsl:apply-templates select="tei:docAuthor[1]"/>
                                </div>
                                <div>
                                        <xsl:apply-templates select="tei:docAuthor[2]"/>
                                </div>
                        </div>
                        <div>
                                <xsl:apply-templates select="tei:note"/>
                        </div>
                        <hr/>
                </div>
        </xsl:template>

        <xsl:template match="tei:ref">
                <a href="{@target}" target="new">
                        <xsl:apply-templates/>
                </a>
        </xsl:template>

        <xsl:template match="tei:front/tei:div" mode="toc">
                <xsl:for-each select="tei:div">
                        <div class="toc1">
                                <a href="#{generate-id()}">
                                        <xsl:apply-templates mode="toc" select="tei:head"/>
                                </a>
                        </div>
                        <xsl:for-each select="tei:div">
                                <div class="toc2">
                                        <a href="#{generate-id()}">
                                                <xsl:apply-templates mode="toc" select="tei:head"/>
                                        </a>
                                </div>
                        </xsl:for-each>
                </xsl:for-each>
        </xsl:template>

        <xsl:template match="tei:body | tei:back" mode="toc">
                <xsl:for-each select="tei:div">
                        <xsl:choose>
                                <xsl:when test="@type='elements'">
                                        <div class="toc1">
                                                <a href="#{generate-id()}">
                                                  <xsl:value-of select="$elements"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                                <xsl:for-each select="tei:div/tei:head/tei:gi">
                                                  <span>
                                                  <!--<a href="#{generate-id()}">
                                                                        <xsl:value-of select="."/>
                                                                </a>-->
                                                  <a href="#{translate(., ':','')}">
                                                  <xsl:value-of select="."/>
                                                  </a>
                                                  <xsl:text> &#xA0; </xsl:text>
                                                  </span>
                                                  <xsl:for-each select="parent::tei:div">
                                                  <xsl:variable name="count">
                                                  <xsl:number/>
                                                  </xsl:variable>
                                                  <xsl:if test="($count mod 6) = 0">
                                                  <br/>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                </xsl:for-each>
                                        </div>
                                </xsl:when>
                                <xsl:when test="@type='attributes'">
                                        <div class="toc1">
                                                <a href="#{generate-id()}">
                                                  <xsl:value-of select="$attributes"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                                <xsl:for-each select="tei:div/tei:head/tei:att">
                                                  <span>
                                                  <a href="#{translate(., ':','')}">
                                                  <xsl:value-of select="."/>
                                                  </a>
                                                  <xsl:text> &#xA0; </xsl:text>
                                                  </span>
                                                  <xsl:for-each select="parent::tei:div">
                                                  <xsl:variable name="count">
                                                  <xsl:number/>
                                                  </xsl:variable>
                                                  <xsl:if test="($count mod 6) = 0">
                                                  <br/>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                </xsl:for-each>
                                        </div>
                                </xsl:when>
                                <xsl:when test="@type='appendix'">
                                        <div class="toc1">
                                                <a href="#{generate-id()}">
                                                  <xsl:value-of select="tei:head"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                                <xsl:for-each select="tei:div/tei:head">
                                                  <span>
                                                  <a href="#{generate-id()}">
                                                  <xsl:value-of select="."/>
                                                  </a>
                                                  <xsl:text> &#xA0; </xsl:text>
                                                  </span>
                                                  <xsl:for-each select="parent::tei:div">
                                                  <xsl:variable name="count">
                                                  <xsl:number/>
                                                  </xsl:variable>
                                                  <xsl:if test="($count mod 6) = 0">
                                                  <br/>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                </xsl:for-each>
                                        </div>
                                </xsl:when>
                        </xsl:choose>
                </xsl:for-each>
        </xsl:template>

        <xsl:template match="tei:front/tei:div">
                <div class="section" id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:head">
                <div class="head03">
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:div/tei:head">
                <div class="head04">
                        <xsl:value-of select="."/>
                        <!--<xsl:apply-templates/>-->
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>
        
        <!-- This is never used, needs to be used!!!!! -->
        <xsl:template match="tei:att[ancestor-or-self::tei:front]">
                <div class="head04">
                        <xsl:text>@</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div">
                <div id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:div">
                <div id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>


        <xsl:template match="tei:list[@type='ordered']">
                <!-- Numbered list -->
                <div class="listOrdered">
                        <div class="head04">
                                <xsl:apply-templates select="tei:head"/>
                        </div>
                        <xsl:for-each select="tei:item">
                                <div class="listOrder">
                                        <xsl:value-of select="@n"/>
                                        <xsl:text>.</xsl:text>
                                </div>
                                <div class="listContent">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <xsl:template match="tei:list[@type='bulleted']">
                <!-- Numbered list -->
                <div class="listOrdered">
                        <xsl:if test="tei:head">
                                <div class="head04">
                                        <xsl:apply-templates select="tei:head"/>
                                </div>
                        </xsl:if>
                        <xsl:for-each select="tei:item">
                                <div class="listOrder">
                                        <xsl:value-of select="$bulletpoint"/>
                                </div>
                                <div class="listContent">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <xsl:template match="tei:list[@type='simple']">
                <!-- List with only text -->
                <xsl:if test="tei:head">
                        <div>
                                <xsl:value-of select="tei:head"/>
                        </div>
                </xsl:if>
                <xsl:choose>
                        <xsl:when test="tei:label">
                                <xsl:for-each select="tei:label">
                                        <div class="leftcol">
                                                <xsl:apply-templates/>
                                        </div>
                                        <div class="content">
                                                <xsl:for-each
                                                  select="following-sibling::tei:item[1]">
                                                  <xsl:apply-templates/>
                                                </xsl:for-each>
                                        </div>
                                </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="blockIndent">
                                        <xsl:for-each select="tei:item">
                                                <xsl:apply-templates/>
                                                <br/>
                                                <br/>
                                        </xsl:for-each>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <xsl:template match="tei:div[@type='elements']">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <xsl:value-of select="$elements"/>
                        </div>
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='attributes'][parent::tei:body]">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <xsl:value-of select="$attributes"/>
                        </div>
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='elementDocumentation']">
                <div class="element">
                        <!--<xsl:apply-templates/>-->
                        <xsl:apply-templates select="tei:head/tei:gi"/>
                        <xsl:apply-templates select="tei:div[@type='fullname']"/>
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
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='attributeDocumentation']">
                <div class="attribute">
                        <!--<xsl:apply-templates/>-->
                        <xsl:apply-templates select="tei:head/tei:att"/>
                        <xsl:apply-templates select="tei:div[@type='summary']"/>
                        <xsl:apply-templates select="tei:div[@type='description']"/>
                        <xsl:apply-templates select="tei:div[@type='datatype']"/>
                </div>
                <div class="spacer">&#xA0;</div>
        </xsl:template>

        <xsl:template
                match="tei:list[parent::tei:div[@type='elementDocumentation'] or parent::tei:div[@type='attributeDocumentation']]">
                <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:head/tei:gi">
                <xsl:choose>
                        <xsl:when test="ancestor-or-self::tei:front">
                                <div class="leftcol" id="{generate-id()}">
                                        <span class="label">
                                                <xsl:text>&lt;</xsl:text>
                                                <xsl:apply-templates/>
                                                <xsl:text>&gt;</xsl:text>
                                        </span>
                                </div>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="leftcol" id="{translate(., ':','')}">
                                        <span class="label">
                                                <xsl:text>&lt;</xsl:text>
                                                <xsl:apply-templates/>
                                                <xsl:text>&gt;</xsl:text>
                                        </span>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
                <div class="content">
                        <span class="label"> &#xA0; <xsl:value-of
                                        select="ancestor-or-self::tei:div[@type='elementDocumentation']/tei:div[@type='fullName']/tei:p"
                                />
                        </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='fullName']"/>


        <xsl:template match="tei:gi">
                <xsl:text>&lt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&gt;</xsl:text>
        </xsl:template>

        <!-- If this tempelete isnt here the link back to toc will be duplicated -->
        <xsl:template match="tei:gi[ancestor-or-self::tei:front]">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&gt;</xsl:text>
        </xsl:template>

        <!-- If this tempelete isnt here the link back to toc will be duplicated -->
        <xsl:template match="tei:att[ancestor-or-self::tei:front]">
                <xsl:text>@</xsl:text>
                <xsl:value-of select="."/>
        </xsl:template>
        

        <xsl:template match="tei:head/tei:att">
                <div class="leftcol" id="{translate(., ':','')}">

                        <span class="label">
                                <xsl:text>@</xsl:text>
                                <xsl:apply-templates/>
                        </span>
                </div>
                <div class="content">
                        <span class="label"> &#xA0; <xsl:value-of
                                        select="ancestor-or-self::tei:div[@type='attributeDocumentation']/tei:div[@type='fullName']/tei:p"
                                />
                        </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <!--        <xsl:template match="tei:div[@type='fullName']">
                <xsl:apply-templates/>
                <div class="content">
                        <span class="label"> &#xA0; <xsl:apply-templates/>
                        </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>-->

        <xsl:template match="tei:div[@type='summary']">
                <div class="span">
                        <xsl:value-of select="$summary"/>
                        <xsl:text>: </xsl:text>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <!-- When description is its own header -->
        <!--<xsl:template match="tei:div[@type='description']">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$description"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->
        
        <!-- When we have description and usage in one header -->
        <xsl:template match="tei:div[@type='description']">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$description"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$and"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$usage"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='description'][parent::tei:div[@type='attributeDocumentation']]">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$description"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <!-- When we have usage as its own head -->
        <!--<xsl:template match="tei:div[@type='usage']">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$usage"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->
        
        <!-- When we have description and usage in one header -->
        <xsl:template match="tei:div[@type='usage']">
                <div class="span">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='mayContain']">
                <div class="leftcol">
                        <xsl:value-of select="$maycontain"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:call-template name="tokenize">
                                <xsl:with-param name="text" select="tei:p"/>
                        </xsl:call-template>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='mayOccurWithin']">
                <div class="leftcol">
                        <xsl:value-of select="$mayoccurwithin"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:call-template name="tokenize">
                                <xsl:with-param name="text" select="tei:p"/>
                        </xsl:call-template>
                </div>
        </xsl:template>

        <xsl:template name="tokenize">
                <xsl:param name="text" select="."/>
                <xsl:param name="separator" select="','"/>
                <xsl:choose>
                        <xsl:when test="not(contains($text, $separator))">
                                <xsl:choose>
                                        <xsl:when test="not(contains($text, '['))">
                                                <a
                                                  href="#{translate(normalize-space($text), ':','')}">
                                                  <xsl:value-of select="normalize-space($text)"/>
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:value-of select="normalize-space($text)"/>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:choose>
                                        <xsl:when test="not(contains($text, '['))">
                                                <a
                                                  href="#{translate(normalize-space(substring-before($text, $separator)), ':','')}">
                                                  <xsl:value-of
                                                  select="normalize-space(substring-before($text, $separator))"
                                                  />
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:value-of
                                                  select="normalize-space(substring-before($text, $separator))"
                                                />
                                        </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text>, </xsl:text>
                                <xsl:call-template name="tokenize">
                                        <xsl:with-param name="text"
                                                select="substring-after($text, $separator)"/>
                                </xsl:call-template>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <xsl:template
                match="tei:div[@type='attributes'][parent::tei:div[@type='elementDocumentation']]/tei:p">
                <xsl:choose>
                        <xsl:when test="tei:list[@type='gloss']">
                                <div class="leftcol">
                                        <xsl:value-of select="$attributes"/>
                                        <xsl:text>: </xsl:text>
                                </div>
                                <xsl:for-each select="tei:list/tei:label[1]">
                                        <div class="centercol">
                                                <a href="#{translate(., ':','')}">
                                                  <xsl:apply-templates/>
                                                </a>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                                <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                        <div class="leftcol">&#xA0;</div>
                                        <div class="centercol">
                                                <a href="#{translate(., ':','')}">
                                                  <xsl:apply-templates/>
                                                </a>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="leftcol">
                                        <xsl:value-of select="$attributes"/>
                                        <xsl:text>: </xsl:text>
                                </div>
                                <div class="content">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <!-- This is replaced with two elements -->
        <!--<xsl:template match="tei:div[@type='occurrence']">
                <div class="leftcol">
                        <xsl:value-of select="$occurrence"/><xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->

        <xsl:template match="tei:div[@type='mandatory']">
                <div class="leftcol">
                        <xsl:value-of select="$mandatory"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$optional"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='repeatable']">
                <div class="leftcol">
                        <xsl:value-of select="$repeatable"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$nonrepeatable"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='reference']">
                <div class="leftcol">
                        <xsl:value-of select="$references"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='datatype']">
                <div class="leftcol">
                        <xsl:value-of select="$datatype"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:p">
                <div class="p">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:att">
                <xsl:text>@</xsl:text>
                <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:att" mode="toc">
                <xsl:text>@</xsl:text>
                <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:back/tei:div">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <xsl:value-of select="$appendix"/>
                                <xsl:text> </xsl:text>
                                <xsl:text>&#xA0;&#xA0;</xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>

        </xsl:template>

        <xsl:template match="tei:back/tei:div/tei:head">
                <div class="head03">
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>



        <xsl:template match="hi">
                <span style="{@rend}">
                        <xsl:apply-templates/>
                </span>
        </xsl:template>

        <xsl:template match="tei:note">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/ex:egXML">
                <div>
                        <xsl:for-each select="*">

                                <div class="exampleIntro">
                                        <xsl:call-template name="eg"/>
                                        <br/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='examples']">
                <div class="leftcol">
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
                </div>
                <xsl:for-each select="eg:egXML">
                        <div class="leftcol">
                                <xsl:text>&#x20;</xsl:text>
                        </div>
                        <div class="example">
                                <xsl:apply-templates/>
                                <!--<xsl:call-template name="eg"/>-->
                                <br/>
                        </div>
                        <!--<br />
                                                        <xsl:apply-templates/> -->
                </xsl:for-each>
                <br/>
        </xsl:template>

        <xsl:template name="eg">
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
        </xsl:template>

        <!-- In this template all occuring other namespaceprefixis needs to be added -->
        <xsl:template match="eac-cpf:*|example:* | ead:* | mods:* | text:*">
                <div class="innerExample">
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
                                        <xsl:when
                                                test="namespace-uri()='http://www.w3c.org/1999/xlink'">
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
                        <xsl:text>&lt;/</xsl:text>
                        <xsl:value-of select="local-name()"/>
                        <xsl:text>&gt;</xsl:text>
                        <br/>
                </div>
        </xsl:template>
</xsl:stylesheet>
