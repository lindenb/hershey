<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:svg="http://www.w3.org/2000/svg"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:h="http://www.w3.org/1999/xhtml"
 >

<xsl:output method='xml' indent='no' omit-xml-declaration="no"/>


<xsl:param name="S">10</xsl:param>
<xsl:variable name="size" select="number($S)"/>
<xsl:variable name="scalex" select="number(25)"/>
<xsl:variable name="scaley" select="number(25)"/>

<xsl:template match="/">
<svg:svg>
<xsl:attribute name="width"><xsl:value-of select= "100+$size"/></xsl:attribute>
<xsl:attribute name="height"><xsl:value-of select="count(hershey/letter) * $size"/></xsl:attribute>

<svg:style>.glyph { stroke:black;fill:none; }
.frame { stroke:blue;fill:rgb(250,250,250); }
</svg:style>


<svg:defs>
<xsl:for-each select="hershey/letter">



<svg:g>

<xsl:attribute name="id">
<xsl:apply-templates select="@id"/>
</xsl:attribute>

<svg:rect class="frame">
<xsl:attribute name="width"><xsl:value-of select="$size"/></xsl:attribute>
<xsl:attribute name="height"><xsl:value-of select="$size"/></xsl:attribute>
<svg:title>
<xsl:apply-templates select="@id"/>
</svg:title>
</svg:rect>
<svg:path class="glyph">

<xsl:attribute name="d">
<xsl:apply-templates select="lineto|moveto"/>
</xsl:attribute>
<svg:title>
<xsl:apply-templates select="@id"/>
</svg:title>
</svg:path>
</svg:g>

</xsl:for-each>
</svg:defs>

<xsl:for-each select="hershey/letter">
<svg:use>
<xsl:attribute name="xlink:href"><xsl:value-of select= "concat('#',@id)"/></xsl:attribute>
<xsl:attribute name="x">0</xsl:attribute>
<xsl:attribute name="y"><xsl:value-of select= "$size * (position() - 1)"/></xsl:attribute>
<svg:title>
<xsl:apply-templates select="@id"/>
</svg:title>
</svg:use>

<svg:use>
<xsl:attribute name="xlink:href"><xsl:value-of select= "concat('#',@id)"/></xsl:attribute>
<xsl:attribute name="x"><xsl:value-of select= "$size * 1"/></xsl:attribute>
<xsl:attribute name="y"><xsl:value-of select= "$size * (position() - 1)"/></xsl:attribute>
<svg:title>
<xsl:apply-templates select="@id"/>
</svg:title>
</svg:use>

<svg:use>
<xsl:attribute name="xlink:href"><xsl:value-of select= "concat('#',@id)"/></xsl:attribute>
<xsl:attribute name="x"><xsl:value-of select= "$size * 2"/></xsl:attribute>
<xsl:attribute name="y"><xsl:value-of select= "$size * (position() - 1)"/></xsl:attribute>
<svg:title>
<xsl:apply-templates select="@id"/>
</svg:title>
</svg:use>

</xsl:for-each>

</svg:svg>
</xsl:template>

<xsl:template match="lineto|moveto">
<xsl:choose>
<xsl:when test="name(.)='lineto'">L </xsl:when>
<xsl:otherwise>M </xsl:otherwise>
</xsl:choose>
<xsl:value-of select="( $size div 2.0 ) + ( number(@x)  div $scalex) *  $size "/>
<xsl:text> </xsl:text>
<xsl:value-of select="( $size div 2.0 ) + ( number(@y) div $scaley ) *  $size "/>
<xsl:text> </xsl:text>
</xsl:template>

</xsl:stylesheet>
