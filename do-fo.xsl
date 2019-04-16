<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
  <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <fo:layout-master-set>
      <fo:simple-page-master master-name="my-page">
        <fo:region-body margin="1in"/>
      </fo:simple-page-master>
    </fo:layout-master-set>

    <fo:page-sequence master-reference="my-page">
      <fo:flow flow-name="xsl-region-body">
        <fo:block>Hello, world!</fo:block>
      </fo:flow>
    </fo:page-sequence>
  </fo:root>
  </xsl:template>
</xsl:stylesheet>