<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="prvy-slajd" size="33.867cm 19.05cm">
          <fo:region-body margin="2in 1in"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="slajd" size="33.867cm 19.05cm">
          <fo:region-body margin="1.4in"/>
          <fo:region-before extent="1in" padding="0.4in 1.5in 0.4in" display-align="before"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <xsl:apply-templates select="//info" />
      <xsl:apply-templates select="//slajd" />
    </fo:root>
  </xsl:template>

  <xsl:template match="info">
    <fo:page-sequence master-reference="prvy-slajd">
      <fo:flow flow-name="xsl-region-body" text-align="center">
        <fo:block font="bold 60pt Verdana">
          <xsl:value-of select="nazov"/>
        </fo:block>

        <fo:block font="20pt Verdana" color="grey" space-before="20pt">
          <xsl:value-of select="podnadpis"/>
        </fo:block>

        <fo:block font="25pt Verdana" space-before="20pt">
          <xsl:value-of select="autor"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template match="slajd">
    <fo:page-sequence master-reference="slajd">
      <fo:static-content flow-name="xsl-region-before" font="bold 40pt Verdana">
        <fo:block>
          <xsl:value-of select="@nadpis"/>
        </fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body" font="24pt Verdana">
        <xsl:apply-templates select="child::*" />
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template match="text">
    <fo:block>
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <xsl:template match="obrazok">
    <fo:block text-align="center">
      <fo:external-graphic src="url({@zdroj})" content-height="scale-to-fit" content-width="scale-to-fit" height="10cm" width="20cm" scaling="uniform"/>
    </fo:block>

    <fo:block text-align="center" font="16pt Verdana" color="grey">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <xsl:template match="polozka-zoznamu[../@cislovany=false()]">
    <fo:list-item>
      <fo:list-item-label end-indent="20pt">
        <fo:block>&#x2022;</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="20pt">
        <fo:block>
          <xsl:value-of select="."/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="polozka-zoznamu[../@cislovany=true()]">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block font-weight="bold">
          <xsl:value-of select="position()"/>
          <xsl:text>.</xsl:text>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
          <xsl:value-of select="."/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="zoznam">
    <fo:list-block provisional-distance-between-starts="{20 + string-length(string(count(polozka-zoznamu))) * 15}pt" provisional-label-separation="10pt">
      <xsl:apply-templates select="polozka-zoznamu" />
    </fo:list-block>
  </xsl:template>

</xsl:stylesheet>