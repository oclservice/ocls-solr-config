<?xml version="1.0" encoding="UTF-8"?>
<!-- OCLS Custom MODS slurp. -->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0"
  exclude-result-prefixes="mods">

  <!-- Title -->
  <xsl:template match="mods:mods/mods:titleInfo" mode="ocls_mods_slurp">
    <xsl:variable name="content">
      <xsl:if test="mods:nonSort">
        <xsl:value-of select="normalize-space(mods:nonSort/text())"/>
        <xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:value-of select="normalize-space(mods:title/text())"/>
      <xsl:if test="mods:subTitle">
        <xsl:text> : </xsl:text>
        <xsl:value-of select="normalize-space(mods:subTitle/text())"/>
      </xsl:if>
      <xsl:if test="mods:partName">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="mods:partName"/>
      </xsl:if>
      <xsl:if test="mods:partNumber">
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(mods:partNumber/text())"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="field">
      <xsl:choose>
        <xsl:when test="@otherType">
          <xsl:value-of select="concat('title_', @otherType)" />
        </xsl:when>
        <xsl:when test="@type">
          <xsl:value-of select="concat('title_', @type)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'title'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="ocls_write_field">
      <xsl:with-param name="field" select="$field" />
      <xsl:with-param name="content" select="$content" />
    </xsl:call-template>
  </xsl:template>

  <!-- Name -->
  <xsl:template match="mods:mods/mods:name[@type = 'personal' or @type = 'corporate' or @type = 'conference']" mode="ocls_mods_slurp">
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '" />
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz__'" />
    <xsl:variable name="name_type" select="@type" />
    <xsl:variable name="role_term" select="translate(mods:role/mods:roleTerm/text(), $uppercase, $lowercase)" />
    <xsl:variable name="name">
      <xsl:for-each select="mods:namePart[not(@type)]">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
      <xsl:value-of select="mods:namePart[@type = 'family']" />
      <xsl:if test="mods:namePart[@type = 'given']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="mods:namePart[@type = 'given']" />
      </xsl:if>
      <xsl:if test="mods:namePart[@type = 'date']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="mods:namePart[@type = 'date']" />
        <xsl:text/>
      </xsl:if>
    </xsl:variable>

    <xsl:call-template name="ocls_write_field">
      <xsl:with-param name="field" select="concat('name_', $name_type, '_', $role_term)" />
      <xsl:with-param name="content" select="normalize-space($name)" />
    </xsl:call-template>
  </xsl:template>

  <!-- Creator & Contributors -->
  <xsl:template match="mods:mods/mods:name[@type = 'personal'][mods:role/mods:roleTerm[. = 'Creator' or . = 'Contributor']]" mode="ocls_mods_creator_contributor_slurp">
    <xsl:variable name="name_type" select="@type" />
    <xsl:variable name="name">
      <xsl:for-each select="mods:namePart[not(@type)]">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
      <xsl:value-of select="mods:namePart[@type = 'family']" />
      <xsl:if test="mods:namePart[@type = 'given']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="mods:namePart[@type = 'given']" />
      </xsl:if>
      <xsl:if test="mods:namePart[@type = 'date']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="mods:namePart[@type = 'date']" />
        <xsl:text/>
      </xsl:if>
    </xsl:variable>

    <xsl:call-template name="ocls_write_field">
      <xsl:with-param name="field" select="'creators_contributors'" />
      <xsl:with-param name="content" select="normalize-space($name)" />
    </xsl:call-template>
  </xsl:template>

  <!-- XXX: Existing OCLS custom MODS slurp -->
  <xsl:template match="mods:mods/mods:name[mods:role/mods:roleTerm/text() = 'creator']/mods:namePart" mode="ocls_mods_slurp">
    <xsl:call-template name="ocls_write_custom_field">
      <xsl:with-param name="field" select="'ocls_mods_creator_ms'" />
      <xsl:with-param name="content" select="text()" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="mods:mods/mods:titleInfo/mods:title |
    mods:mods/mods:name/mods:namePart |
    mods:mods/mods:subject/mods:topic |
    mods:mods/mods:subject/mods:geographic |
    mods:mods/mods:subject/mods:name/mods:namePart |
    mods:mods/mods:originInfo/mods:place/mods:placeTerm |
    mods:mods/mods:originInfo/mods:publisher |
    mods:mods/mods:genre |
    mods:mods/mods:location/mods:physicalLocation" mode="ocls_mods_slurp">
    <xsl:call-template name="ocls_write_custom_field">
      <xsl:with-param name="field" select="'ocls_mods_ts'" />
      <xsl:with-param name="content" select="text()" />
    </xsl:call-template>
  </xsl:template>

  <!-- Standard Field Writer. -->
  <xsl:template name="ocls_write_field">
    <xsl:param name="field" />
    <xsl:param name="content" />
    <xsl:if test="not(normalize-space($content) = '')">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat('ocls_mods_', $field, '_ms')" />
        </xsl:attribute>
        <xsl:value-of select="$content" />
      </field>
    </xsl:if>
  </xsl:template>

  <!-- Custom Field Writer. -->
  <xsl:template name="ocls_write_custom_field">
    <xsl:param name="field" />
    <xsl:param name="content" />
    <xsl:if test="not(normalize-space($content) = '')">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="$field" />
        </xsl:attribute>
        <xsl:value-of select="$content" />
      </field>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
