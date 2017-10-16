<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="ocls_get_ip_embargoed_status">
    <xsl:param name="pid"/>

    <!-- Get the PID namespace. -->
    <xsl:variable name="namespace">
      <xsl:value-of select="substring-before($pid, ':')"/>
    </xsl:variable>

    <!-- Map namespace to URL to hit. -->
    <xsl:variable name="url">
      <xsl:choose>
        <xsl:when test="$namespace='centennial'">http://centennial.core.ocls.ca</xsl:when>
        <xsl:when test="$namespace='conestoga'">http://conestoga.core.ocls.ca</xsl:when>
        <xsl:when test="$namespace='fleming'">http://fleming.core.ocls.ca</xsl:when>
        <xsl:when test="$namespace='georgian'">http://georgian.core.ocls.ca</xsl:when>
        <xsl:when test="$namespace='loyalist'">http://loyalist.core.ocls.ca</xsl:when>
        <xsl:when test="$namespace='seneca'">http://seneca.core.ocls.ca</xsl:when>
        <xsl:otherwise>http://core.ocls.ca</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Get the IP embargoed status document. -->
    <xsl:variable name="ip_embargoed_doc">
      <xsl:copy-of select="document(concat($url, '/ip_embargoed/', $pid))"/>
    </xsl:variable>

    <!-- Make a cool field. -->
    <field name="ocls_ip_embargoed_b">
      <xsl:value-of select="$ip_embargoed_doc/embargo_info/embargo_status"/>
    </field>

  </xsl:template>
</xsl:stylesheet>
