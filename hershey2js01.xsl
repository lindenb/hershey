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
	glyphs:
		{
		<xsl:for-each select="hershey/letter">
		<xsl:if test="position()&gt;1">,</xsl:if>
		<xsl:value-of select="concat('&quot;',@id,'&quot;:[')"/>
		<xsl:for-each select="lineto|moveto">
			<xsl:if test="position()&gt;1">,</xsl:if>
			<xsl:text>{t:</xsl:text>
			<xsl:choose>
				<xsl:when test="name(.) ='lineto'">&apos;L&apos;</xsl:when>
				<xsl:otherwise>&apos;M&apos;</xsl:otherwise>
				</xsl:choose>
			<xsl:text>,x:</xsl:text>
			<xsl:value-of select="@x"/>
			<xsl:text>,y:</xsl:text>
			<xsl:value-of select="@y"/>
			<xsl:text>}</xsl:text>
			</xsl:for-each>
			<xsl:text>]</xsl:text>
		</xsl:for-each>
		},
	
	print: function(ctx,s,x,y,w,h)
		{
		var i=0;
		if(s.length==0 || h==0 || w==0) return;
		var rows=s.split(/\n/);

		if(rows.length!=1)
			{
			
			var dh= h/rows.length ;
			/* max length */
			var maxL=0;
			for(i=0;i &lt; rows.length;++i)
				{
				maxL=(maxL  &lt; rows[i].length ?rows[i].length:maxL);
				}
			for(i=0;i &lt; rows.length;++i)
				{
				var s2=rows[i];
				while(s2.length  &lt;  maxL) s2+=".";
				this.print(ctx,s2,x,y+(i*dh),w,dh);
				}
			return;
			}

		var dx=w/s.length;
		for(i=0;i &lt; s.length;++i)
			{
			var c=s.toUpperCase().charCodeAt(i);
			if(c&gt;=65 || c &lt; =90)
				{
				var g=Hershey.glyphs[""+(c-64)];
				if(!g) continue;
				var j;
				for(j=0;j &lt; g.length;++j)
					{
					var px=( (g[j].x) / this.scalex)*dx + (x+dx*i) +dx/2.0;
					var py=( (g[j].y) / this.scaley)*h + y +h/2.0 ;
					
					//console.log("p="+px+"/"+py);
					if(g[j].t=='L')
						{
						ctx.lineTo(px,py);
						}
					else
						{
						ctx.moveTo(px,py);
						}
					}
				}
			
			
			}
		},
	scalex:15.0,
	scaley:15.0
	};

</xsl:template>

<xsl:template match="lineto|moveto">
<xsl:value-of select="concat('ctx.',name(.),'(',@x,',',@y,');')"/><xsl:text>
		</xsl:text>
</xsl:template>

</xsl:stylesheet>
