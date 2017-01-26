<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:a="xalan://org.bibliome.alvisnlp.modules.xml.XMLReader2"
		xmlns:inline="http://bibliome.jouy.inra.fr/alvisnlp/bibliome-module-factory/inline"
		extension-element-prefixes="a inline"
  >

  <xsl:param name="source-path"/>
  <xsl:param name="source-basename"/>
  <xsl:param name="accepted-tags"> h1 h2 h3 h4 br table tr td ol ul li em </xsl:param>

  <xsl:template match="html">
    <a:document xpath-id="substring-before($source-basename, '.html')">
      <a:feature name="title" xpath-value=".//h1[@id = 'article-title-1']"/>
      <a:section name="title" xpath-contents=".//h1[@id = 'article-title-1']"/>
      <a:section name="abstract" xpath-contents=".//div [@class='section abstract']"/>
	<a:section name="alltext" xpath-contents=".">
	  <xsl:for-each select="a:inline()[contains($accepted-tags, concat(' ', name(), ' '))]">
	    <a:annotation start="@inline:start" end="@inline:end" layers="html">
	      <a:feature name="tag" xpath-value="name()"/>
	      <xsl:for-each select="@*[namespace-uri() != 'http://bibliome.jouy.inra.fr/alvisnlp/bibliome-module-factory/inline']">
		<a:feature xpath-name="name()" xpath-value="."/>
	      </xsl:for-each>
	    </a:annotation>
	  </xsl:for-each>
	</a:section>
    </a:document>
  </xsl:template>
</xsl:stylesheet>
