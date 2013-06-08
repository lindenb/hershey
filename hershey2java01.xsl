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

public abstract class Hershey
	{
	private interface Context
		{
		}
	
	public static class Graphic extends Hershey
		{
		private class Ctx implements Hershey.Context
			{
			Graphics g;
			Ctx(Graphics g)
				{
				this.g=g;
				}
			}
		
		public Graphic()
			{
			}
		public void print(Graphics g,int c)
			{
			_print(new Ctx(g),c);
			}
		}
	
	
	public void _print(Context ctx,int c)
		{
		switch(c)
			{
			<xsl:for-each select="hershey/letter">
			case <xsl:value-of select="@id"/>: print<xsl:value-of select="@id"/>(g); break;
			</xsl:for-each>
			default: break;
			}
		}
	<xsl:for-each select="hershey/letter">
	private void print<xsl:value-of select="@id"/>(Context ctx)
		{
		<xsl:apply-templates select="lineto"/>
		}
	
	</xsl:for-each>
	}
</xsl:template>

<xsl:template match="lineto">
<xsl:value-of select="concat('lineto(ctx,',preceding-sibling::*[1]/@x,',',preceding-sibling::*[1]/@y,',',@x,',',@y,');')"/><xsl:text>
		</xsl:text>
</xsl:template>

</xsl:stylesheet>
