<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xlink eac-cpf ex exml #default example" version="2.0"
	xmlns="http://www.w3.org/1999/xhtml" xmlns:eac-cpf="urn:isbn:1-931666-33-4"
	xmlns:ex="http://www.tei-c.org/ns/Examples"
	xmlns:exml="http://workaround for xml namespace restriction/namespace"
	xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:example="example"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0">

	<xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" encoding="UTF-8"
		indent="yes" method="html"/>

	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>EAC-CPF Tag Library Draft</title>
				<meta content="en" http-equiv="content-language"/>
				<meta content="text/html; charset=utf-8" http-equiv="content-type"/>
				<link href="tagLibrary.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<div>
					<div>
						<xsl:apply-templates mode="title" select="//tei:text/tei:front/tei:titlePage"/>
					</div>
					<div>
						<div class="head03" id="toc">Table of Contents</div>
						<xsl:apply-templates mode="toc" select="//tei:text/tei:front"/>
						<xsl:apply-templates mode="toc" select="//tei:text/tei:body"/>
						<xsl:apply-templates mode="toc" select="//tei:text/tei:back"/>
					</div>
					<hr/>
					<div>
						<xsl:apply-templates select="//tei:text/tei:front/tei:div"/>
					</div>
					<hr/>
					<div>
						<xsl:apply-templates select="//tei:text/tei:body"/>
					</div>
					<hr/>
					<div>
						<xsl:apply-templates select="//tei:text/tei:back"/>
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

	<xsl:template match="ref">
		<a href="{@target}" target="new">
			<xsl:apply-templates/>
		</a>
	</xsl:template>

	<xsl:template match="tei:front" mode="toc">
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
						<a href="#{generate-id()}">Elements</a>
					</div>
					<div class="toc2">
						<xsl:for-each select="tei:div/tei:head[@type='tag']">
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
				<xsl:when test="@type='attributes'">
					<div class="toc1">
						<a href="#{generate-id()}">Attributes</a>
					</div>
					<div class="toc2">
						<xsl:for-each select="tei:div/tei:head[@type='attribute']">
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
						<xsl:for-each select="tei:div/tei:head[@type='tag']">
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

	<xsl:template match="tei:front/tei:div/tei:head">
		<div class="head03">
			<xsl:apply-templates/>
			<xsl:text>&#xA0;&#xA0;</xsl:text>
			<a class="tocReturn" href="#toc">[toc]</a>
		</div>
	</xsl:template>

	<xsl:template match="tei:front/tei:div/tei:div/tei:head">
		<div class="head04">
			<xsl:apply-templates/>
			<xsl:text>&#xA0;&#xA0;</xsl:text>
			<a class="tocReturn" href="#toc">[toc]</a>
		</div>
	</xsl:template>

	<xsl:template match="tei:front/tei:div/tei:div">
		<div id="{generate-id()}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="p/list[@type='ordered']">
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

	<xsl:template match="tei:list[@type='simple']">
		<xsl:if test="tei:head">
			<div>
				<xsl:value-of select="tei:head"/>
			</div>
		</xsl:if>
		<xsl:for-each select="tei:item">
			<div class="blockIndent">
				<xsl:apply-templates/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="tei:div[@type='elements']">
		<div class="section" id="{generate-id()}">
			<div class="head03">Elements</div>
			<xsl:apply-templates/>
			<xsl:text>&#xA0;&#xA0;</xsl:text>
			<a class="tocReturn" href="#toc">[toc]</a>
		</div>
	</xsl:template>

	<xsl:template match="tei:div[@type='attributes']">
		<div class="section" id="{generate-id()}">
			<div class="head03">Attributes</div>
			<xsl:apply-templates/>
			<xsl:text>&#xA0;&#xA0;</xsl:text>
			<a class="tocReturn" href="#toc">[toc]</a>
		</div>
	</xsl:template>

	<xsl:template match="tei:div[@type='element']">
		<div class="element">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:div[@type='attribute']">
		<div class="attribute">
			<xsl:apply-templates/>
		</div>
		<div class="spacer">&#xA0;</div>
	</xsl:template>

	<xsl:template match="tei:list[parent::tei:div[@type='element'] or parent::tei:div[@type='attribute']]">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:head[@type='tag']">
		<div class="leftcol" id="{generate-id()}">
			<span class="label">
				<xsl:apply-templates/>
			</span>
		</div>
	</xsl:template>

	<xsl:template match="tei:head[@type='attribute']">
		<div class="leftcol" id="{translate(., ':','')}">

			<span class="label">
				<xsl:apply-templates/>
			</span>
		</div>
	</xsl:template>

	<xsl:template match="tei:head[@type='name']">
		<div class="content">
			<span class="label"> &#xA0; <xsl:apply-templates/>
			</span>
			<xsl:text>&#xA0;&#xA0;</xsl:text>
			<a class="tocReturn" href="#toc">[toc]</a>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='summary']">
		<div class="span">
			<xsl:text>Summary: </xsl:text>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='description']">
		<div class="span">
			<div class="descriptionHead">Description</div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='mayContain']">
		<div class="leftcol">
			<xsl:text>May contain: </xsl:text>
		</div>
		<div class="content">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='mayOccurIn']">
		<div class="leftcol">
			<xsl:text>May occur within: </xsl:text>
		</div>
		<div class="content">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='attributes']">
		<xsl:choose>
			<xsl:when test="tei:list">
				<div class="leftcol">
					<xsl:text>Attributes: </xsl:text>
				</div>
				<xsl:for-each select="tei:list/tei:label[1]">
					<div class="centercol">
						<a href="#{translate(., ':','')}">
							<xsl:apply-templates/>
						</a>
					</div>
					<div class="rightcol">
						<xsl:apply-templates select="following-sibling::tei:item[1]"/>
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
						<xsl:apply-templates select="following-sibling::tei:item[1]"/>
					</div>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<div class="leftcol">
					<xsl:text>Attributes: </xsl:text>
				</div>
				<div class="content">
					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:item[@n='occurrence']">
		<div class="leftcol">
			<xsl:text>Occurrence: </xsl:text>
		</div>
		<div class="content">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='reference']">
		<div class="leftcol">
			<xsl:text>References: </xsl:text>
		</div>
		<div class="content">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="tei:item[@n='datatype']">
		<div class="leftcol">
			<xsl:text>Data Type: </xsl:text>
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

	<xsl:template match="tei:tag">
		<xsl:text>&lt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&gt;</xsl:text>
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
				<xsl:text>Appendix</xsl:text>
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

	<xsl:template match="tei:back/tei:div/tei:list">
		<div class="table">
			<xsl:for-each select="label">
				<div class="leftcolTable">
					<xsl:apply-templates/>
				</div>
				<xsl:for-each select="following-sibling::tei:item[1]">
					<div class="contentTable">
						<xsl:apply-templates/>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="hi">
		<span style="{@rend}">
			<xsl:apply-templates/>
		</span>
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

	<xsl:template match="ex:egXML">
		<div class="leftcol">
			<xsl:choose>
				<xsl:when test="count(*) &gt; 1">
					<xsl:text>Examples:</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Example:</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:for-each select="*">
			<div class="leftcol">
				<xsl:text>&#x20;</xsl:text>
			</div>
			<div class="example">
				<xsl:call-template name="eg"/>
				<br/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="eg">
		<xsl:text>&lt;</xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:for-each select="@*">
			<xsl:text>&#x20;</xsl:text>
			<xsl:choose>
				<xsl:when test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
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

	<xsl:template match="eac-cpf:*|example:*">

		<div class="innerExample">

			<xsl:text>&lt;</xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:for-each select="@*">
				<xsl:text>&#x20;</xsl:text>
				<xsl:choose>
					<xsl:when test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
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
			<xsl:text>&lt;/</xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:text>&gt;</xsl:text>
			<br/>
		</div>

	</xsl:template>


</xsl:stylesheet>
