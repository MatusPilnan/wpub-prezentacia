<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:param name="parametre" select="document('parametre.xml')" />
  <xsl:param name="obsah">
    <xsl:value-of select="$parametre//obsah" />
  </xsl:param>
  <xsl:param name="generovat-titulny-slajd">
    <xsl:value-of select="$parametre//generovat-titulny-slajd" />
  </xsl:param>
  <xsl:param name="cislovanie-slajdov">
    <xsl:value-of select="$parametre//cislovanie-slajdov" />
  </xsl:param>
  <xsl:param name="titulny-slajd">
    <xsl:value-of select="$parametre//titulny-slajd" />
  </xsl:param>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="prvy-slajd" size="33.867cm 19.05cm">
          <fo:region-body margin="2in 1in"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="slajd" size="33.867cm 19.05cm">
          <fo:region-body margin="1.4in"/>
          <fo:region-before extent="1in" padding="0.4in 1.5in 0.4in" display-align="before"/>
          <fo:region-after extent="1in" padding="0.4in 1.5in 0.4in" display-align="after"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <xsl:if test="$generovat-titulny-slajd = true()">
        <xsl:apply-templates select="//info" />
      </xsl:if>
      <xsl:if test="$obsah = true()">
        <xsl:call-template name="obsah" />
      </xsl:if>
      <xsl:apply-templates select="//slajd" />

    </fo:root>
  </xsl:template>

  <xsl:template match="info">
    <fo:page-sequence master-reference="prvy-slajd">
      <fo:flow flow-name="xsl-region-body" text-align="center">
        <xsl:if test="contains($titulny-slajd, 'nazov')">
          <fo:block font="bold 60pt Verdana">
            <xsl:value-of select="nazov"/>
          </fo:block>
        </xsl:if>

        <xsl:if test="contains($titulny-slajd, 'podnadpis')">
          <fo:block font="20pt Verdana" color="grey" space-before="20pt">
            <xsl:value-of select="podnadpis"/>
          </fo:block>
        </xsl:if>

        <xsl:if test="contains($titulny-slajd, 'autor')">
          <fo:block font="25pt Verdana" space-before="20pt">
            <xsl:value-of select="autor"/>
          </fo:block>
        </xsl:if>
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
      <xsl:if test="$cislovanie-slajdov = true()">
        <xsl:call-template name="cislo-strany" />
      </xsl:if>
      <fo:flow flow-name="xsl-region-body" font="24pt Verdana">
        <xsl:apply-templates select="child::*" />
        <xsl:if test="position() = last()">
          <fo:block id="posledny-slajd" />
        </xsl:if>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template name="obsah">
    <fo:page-sequence master-reference="slajd">
      <fo:static-content flow-name="xsl-region-before" font="bold 40pt Verdana">
        <fo:block>
          <xsl:text>Obsah</xsl:text>
        </fo:block>
      </fo:static-content>
      <xsl:if test="$cislovanie-slajdov = true()">
        <xsl:call-template name="cislo-strany" />
      </xsl:if>
      <fo:flow flow-name="xsl-region-body" font="24pt Verdana">
        <fo:list-block provisional-distance-between-starts="{20 + string-length(string(count(polozka-zoznamu))) * 15}pt" provisional-label-separation="10pt">
          <xsl:for-each select="//slajd">
            <xsl:call-template name="cislovany-zoznam">
              <xsl:with-param name="slajd" select="." />
            </xsl:call-template>
          </xsl:for-each>
        </fo:list-block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template name="cislo-strany">
    <fo:static-content flow-name="xsl-region-after" font="italic 14pt Verdana" color="grey">
      <fo:block text-align="end">
        <xsl:text>Slajd </xsl:text>
        <fo:page-number />
        <xsl:text>/</xsl:text>
        <fo:page-number-citation ref-id="posledny-slajd"/>
      </fo:block>
    </fo:static-content>
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

  <xsl:template match="polozka-zoznamu[../@cislovany=true()]" name="cislovany-zoznam">
    <xsl:param name="slajd" select="''" />
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block font-weight="bold">
          <xsl:value-of select="position()"/>
          <xsl:text>.</xsl:text>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
          <xsl:if test="not($slajd='')">
            <xsl:value-of select="$slajd/@nadpis"/>
          </xsl:if>
          <xsl:if test="$slajd=''">
            <xsl:value-of select="."/>
          </xsl:if>
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