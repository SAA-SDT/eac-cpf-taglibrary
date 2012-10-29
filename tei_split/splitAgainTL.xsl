<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:eg="http://www.tei-c.org/ns/Examples"
  version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:eac-cpf="urn:isbn:1-931666-33-4" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xd xsi tei">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> October 21th, 2012</xd:p>
      <xd:p><xd:b>Author</xd:b> Florence Clavaud</xd:p>
      <xd:p>Stylesheet to split the multilingual TEI Tag Library instance to separated English and French files.</xd:p>
      <xd:p>The resulting XML instance will include several files. It is valid against the prepared schema. Besides, each included file is valid against another simpler schema.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:variable name="path">
    <xsl:value-of select="concat('../descriptions-multilingual/','?select=*.xml;recurse=yes;on-error=warning')"/>
  </xsl:variable>
  <xsl:variable name="files" select="collection($path)"/>
  <xsl:variable name="output-path"/>
  <xsl:template match="*  | @*">
    <xsl:copy>
      <!-- very often, we will copy everything, getting rid of TEI default  attributes -->
      <xsl:apply-templates select="@*[not(name()='instant') and not(name()='org') and not(name()='sample') and not(name()='part') and not(name()='scheme')]"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="processing-instruction()"/>
  <xsl:template match="/">
    <!-- generating the 2 main files, which contain the introductions and include the other files -->
    <xsl:variable name="outputUrlEng">
      <xsl:value-of select="concat($output-path, 'TL-eng.xml')"/>
    </xsl:variable>
    <xsl:variable name="outputUrlFre">
      <xsl:value-of select="concat($output-path, 'TL-fre.xml')"/>
    </xsl:variable>
    <xsl:result-document href="{$outputUrlEng}">
      <xsl:processing-instruction name="xml-model">
              <xsl:text>href="../schema/EACCPF-TL-teiliteSchema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
        
            </xsl:processing-instruction>
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:eac-cpf="urn:isbn:1-931666-33-4" xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:eg="http://www.tei-c.org/ns/Examples" xmlns:xi="http://www.w3.org/2001/XInclude">
        <teiHeader>
          <fileDesc>
            <titleStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/node()[@xml:lang='eng'  or not(@xml:lang)]"/>
            </titleStmt>
            <editionStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/node()[@xml:lang='eng'  or not(@xml:lang)]"/>
            </editionStmt>
            <publicationStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/node()[@xml:lang='eng'  or not(@xml:lang)]"/>
            </publicationStmt>
            <sourceDesc>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/node()[@xml:lang='eng'  or not(@xml:lang)]"/>
            </sourceDesc>
          </fileDesc>
        </teiHeader>
        <text>
          <front>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:front/tei:titlePage[@xml:lang='eng'  or not(@xml:lang)]"/>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:front/tei:div[@type='EnglishIntroduction'  or not(@xml:lang)]"/>
          </front>
          <body>
            <div type="elements">
              <xsl:for-each select="$files/tei:div[starts-with(@type, 'element')]">
                <xsl:variable name="id">
                  <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:variable name="outputUrl">
                  <xsl:value-of select="concat($output-path, 'eng/elem-',  $id, '.xml')"/>
                </xsl:variable>
                <xi:include>
                  <xsl:attribute name="href">
                    <xsl:value-of select="$outputUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="parse">xml</xsl:attribute>
                </xi:include>
              </xsl:for-each>
          
            </div>
            <div type="attributes">
              <xsl:for-each select="$files/tei:div[starts-with(@type, 'attribute')]">
                <xsl:variable name="id">
                  <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:variable name="outputUrl">
                  <xsl:value-of select="concat($output-path, 'eng/attr-',  $id, '.xml')"/>
                </xsl:variable>
                <xi:include>
                  <xsl:attribute name="href">
                    <xsl:value-of select="$outputUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="parse">xml</xsl:attribute>
                </xi:include>
              </xsl:for-each>
            </div>
          </body>
          <back>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:back/tei:div[@xml:lang='eng']"/>
          </back>
        </text>
      </TEI>
    </xsl:result-document>
    <xsl:result-document href="{$outputUrlFre}">
      <xsl:processing-instruction name="xml-model">
              <xsl:text>href="schemas/EACCPF-TL-teiliteSchema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
        
            </xsl:processing-instruction>
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:eac-cpf="urn:isbn:1-931666-33-4" xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:eg="http://www.tei-c.org/ns/Examples" xmlns:xi="http://www.w3.org/2001/XInclude">
        <teiHeader>
          <fileDesc>
            <titleStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/node()[@xml:lang='fre' or not(@xml:lang)]"/>
            </titleStmt>
            <editionStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/node()[@xml:lang='fre' or not(@xml:lang)]"/>
            </editionStmt>
            <publicationStmt>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/node()[@xml:lang='fre'  or not(@xml:lang)]"/>
            </publicationStmt>
            <sourceDesc>
              <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/node()[@xml:lang='fre'  or not(@xml:lang)]"/>
            </sourceDesc>
          </fileDesc>
        </teiHeader>
        <text>
          <front>
       
            <xsl:apply-templates select="tei:TEI/tei:text/tei:front/tei:div[@type='FrenchIntroduction']"/>
          </front>
          <body>
            <div type="elements">
              <xsl:for-each select="$files/tei:div[starts-with(@type, 'element')]">
                <xsl:variable name="id">
                  <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:variable name="outputUrl">
                  <xsl:value-of select="concat($output-path, 'fre/elem-',  $id, '.xml')"/>
                </xsl:variable>
                <xi:include>
                  <xsl:attribute name="href">
                    <xsl:value-of select="$outputUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="parse">xml</xsl:attribute>
                </xi:include>
              </xsl:for-each>
          
            </div>
            <div type="attributes">
              <xsl:for-each select="$files/tei:div[starts-with(@type, 'attribute')]">
                <xsl:variable name="id">
                  <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:variable name="outputUrl">
                  <xsl:value-of select="concat($output-path, 'fre/attr-',  $id, '.xml')"/>
                </xsl:variable>
                <xi:include>
                  <xsl:attribute name="href">
                    <xsl:value-of select="$outputUrl"/>
                  </xsl:attribute>
                  <xsl:attribute name="parse">xml</xsl:attribute>
                </xi:include>
              </xsl:for-each>
            </div>
          </body>
          <back>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:back/tei:div[@xml:lang='fre']"/>
          </back>
        </text>
      </TEI>
    </xsl:result-document>
    <!-- generating the smaller included files, 2 for each element or attribute -->
    <xsl:for-each select="$files">
      <xsl:variable name="id">
        <xsl:value-of select="tei:div/@xml:id"/>
      </xsl:variable>
      <xsl:variable name="outputUrlEng">
        <xsl:choose>
          <xsl:when test="starts-with(tei:div/@type, 'element')">
            <xsl:value-of select="concat($output-path, 'eng/elem-',  $id, '.xml')"/>
          </xsl:when>
          <xsl:when test="starts-with(tei:div/@type, 'attribute')">
            <xsl:value-of select="concat($output-path, 'eng/attr-',  $id, '.xml')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="outputUrlFre">
        <xsl:choose>
          <xsl:when test="starts-with(tei:div/@type, 'element')">
            <xsl:value-of select="concat($output-path, 'fre/elem-',  $id, '.xml')"/>
          </xsl:when>
          <xsl:when test="starts-with(tei:div/@type, 'attribute')">
            <xsl:value-of select="concat($output-path, 'fre/attr-',  $id, '.xml')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:result-document href="{$outputUrlEng}" exclude-result-prefixes="xd tei xsi">
        <xsl:processing-instruction name="xml-model">
              <xsl:text>href="../schemas/tagLibrary_elementDesc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
        <xsl:apply-templates select="*[@xml:lang='eng' or not(@xml:lang)]" mode="eng"/>
      </xsl:result-document>
      <xsl:result-document href="{$outputUrlFre}" exclude-result-prefixes="xd tei xsi">
        <xsl:processing-instruction name="xml-model">
              <xsl:text>href="../schemas/tagLibrary_elementDesc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
        <xsl:apply-templates select="*[@xml:lang='fre' or not(@xml:lang)]" mode="fre"/>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="*" mode="eng">
    <xsl:if test="(@xml:lang='eng' or not(@xml:lang)) and (child::text()[normalize-space(.)!=''] or descendant::*[@xml:lang='eng' or not(@xml:lang)])">
      <xsl:copy>
        <xsl:apply-templates select="@*[not(name()='instant') and not(name()='org') and not(name()='sample') and not(name()='part') and not(name()='scheme')]"/>
        <xsl:apply-templates mode="eng"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  <xsl:template match="*" mode="fre">
    <xsl:if test="(@xml:lang='fre' or not(@xml:lang)) and (child::text()[normalize-space(.)!=''] or descendant::*[@xml:lang='fre' or not(@xml:lang)])">
      <xsl:copy>
        <xsl:apply-templates select="@*[not(name()='instant') and not(name()='org') and not(name()='sample') and not(name()='part') and not(name()='scheme')]"/>
        <xsl:apply-templates mode="fre"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
