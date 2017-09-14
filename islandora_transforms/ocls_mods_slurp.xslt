<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
     exclude-result-prefixes="mods">

  <xsl:template match="mods:mods" mode="ocls_mods_slurp">
    <xsl:apply-templates mode="ocls_mods_slurp"/>
    <xsl:apply-templates mode="ocls_mods_suggester"/>
  </xsl:template>

  <xsl:template match="mods:mods/mods:name[mods:role/mods:roleTerm/text() = 'creator']/mods:namePart" mode="ocls_mods_slurp">
    <xsl:variable name="text_value" select="normalize-space(.)"/>
    <xsl:if test="$text_value">
      <field name="ocls_mods_creator_ms">
        <xsl:value-of select="$text_value"/>
      </field>
    </xsl:if>
  </xsl:template>

  <xsl:template match="mods:mods/mods:titleInfo/mods:title |
    mods:mods/mods:name/mods:namePart | mods:mods/mods:subject/mods:topic |
    mods:mods/mods:subject/mods:name/mods:namePart |
    mods:mods/mods:originInfo/mods:place/mods:placeTerm |
    mods:mods/mods:originInfo/mods:publisher | mods:mods/mods:genre |
    mods:mods/mods:location/mods:physicalLocation" mode="ocls_mods_suggester">
    <xsl:variable name="text_value" select="normalize-space(.)"/>
    <xsl:if test="$text_value">
      <field name="ocls_mods_ts">
        <xsl:value-of select="$text_value"/>
      </field>
    </xsl:if>
  </xsl:template>

  <!-- Do not output text not otherwise output. -->
  <xsl:template match="text()" mode="ocls_mods_slurp"/>
  <xsl:template match="text()" mode="ocls_mods_suggester"/>
</xsl:stylesheet>
