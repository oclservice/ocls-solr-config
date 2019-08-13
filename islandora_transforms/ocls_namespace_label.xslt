<?xml version="1.0" encoding="UTF-8"?>
<!-- for all inline xml glob all the text nodes into one field-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:foxml='info:fedora/fedora-system:def/foxml#'
  exclude-result-prefixes="foxml">

  <xsl:template match="foxml:digitalObject" mode="ocls_namespace_label">
    <xsl:param name="PID"/>

    <!-- Get the namespace portion of the PID. -->
    <xsl:variable name="namespace">
      <xsl:value-of select="substring-before($PID, ':')"/>
    </xsl:variable>

    <!-- Map namespace to label. -->
    <xsl:variable name="namespace_label">
      <xsl:choose>
        <xsl:when test="$namespace='centennial'">Centennial College</xsl:when>
        <xsl:when test="$namespace='conestoga'">Conestoga College</xsl:when>
        <xsl:when test="$namespace='fleming'">Fleming College</xsl:when>
        <xsl:when test="$namespace='georgian'">Georgian College</xsl:when>
        <xsl:when test="$namespace='loyalist'">Loyalist Library</xsl:when>
        <xsl:when test="$namespace='seneca'">Seneca Libraries</xsl:when>
        <xsl:when test="$namespace='niagara'">Niagara College</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- Make a field -->
    <xsl:if test="$namespace_label != ''">
      <field name="ocls_namespace_label_s">
        <xsl:value-of select="$namespace_label"/>
      </field>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
