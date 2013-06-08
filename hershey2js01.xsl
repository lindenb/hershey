<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:svg="http://www.w3.org/2000/svg"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:h="http://www.w3.org/1999/xhtml"
 >

<xsl:output method='text' />



<xsl:template match="/">

var Hershey={
	
	
	
	print: function(ctx,c)
		{
		switch(c)
			{
			<xsl:for-each select="hershey/letter">
			case <xsl:value-of select="@id"/>: 
			<xsl:apply-templates select="lineto|moveto"/>
			break;
			</xsl:for-each>
			default: break;
			}
		}
	
	};

</xsl:template>

<xsl:template match="lineto|moveto">
<xsl:value-of select="concat('ctx.',name(.),'(',@x,',',@y,');')"/><xsl:text>
		</xsl:text>
</xsl:template>

</xsl:stylesheet>
