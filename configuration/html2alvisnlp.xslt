<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:a="xalan://fr.inra.maiage.bibliome.alvisnlp.bibliomefactory.modules.xml.XMLReader2"
		xmlns:inline="http://bibliome.jouy.inra.fr/alvisnlp/bibliome-module-factory/inline"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		extension-element-prefixes="a inline"
  >

  <xsl:param name="source-path"/>
  <xsl:param name="source-basename"/>
  <xsl:param name="accepted-tags"> h1 h2 h3 h4 br table tr td ol ul li em </xsl:param>

  <xsl:template match="html">
    <a:document xpath-id="substring-before($source-basename, '.html')">
	<xsl:choose>
		<xsl:when test=".//h1[@id = 'article-title-1']">
		      <a:feature name="title" xpath-value=".//h1[@id = 'article-title-1']"/>
		      <a:section name="title" xpath-contents=".//h1[@id = 'article-title-1']"/>
		</xsl:when>
		<xsl:when test=".//*[@class = 'svTitle']">
		      <a:feature name="title" xpath-value=".//*[@class = 'svTitle']"/>
		      <a:section name="title" xpath-contents=".//*[@class = 'svTitle']"/>
		</xsl:when>
		<xsl:when test=".//a[@name = 'title']">
		      <a:feature name="title" xpath-value=".//a[@name = 'title']"/>
		      <a:section name="title" xpath-contents=".//a[@name = 'title']"/>
		</xsl:when>
		<xsl:when test=".//div[@class = 'title']">
		      <a:feature name="title" xpath-value=".//div[@class = 'title']"/>
		      <a:section name="title" xpath-contents=".//div[@class = 'title']"/>
		</xsl:when>
		<xsl:when test=".//h1">
		      <a:feature name="title" xpath-value=".//h1"/>
		      <a:section name="title" xpath-contents=".//h1"/>
		</xsl:when>
		<xsl:when test=".//h2">
		      <a:feature name="title" xpath-value=".//h2"/>
		      <a:section name="title" xpath-contents=".//h2"/>
		</xsl:when>
		<xsl:otherwise>
			<a:feature name="title" xpath-value="substring-before($source-basename, '.html')"/>
			<a:section name="title" xpath-contents="substring-before($source-basename, '.html')"/>
			<xsl:message>No title for <xsl:value-of select="$source-path"/></xsl:message>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test=".//div [@class='section abstract']">
			<a:section name="abstract" xpath-contents=".//div [@class='section abstract']"/>
		</xsl:when>
		<xsl:when test=".//xhtml:div[@id = 'abstract']/xhtml:div[@class = 'para']">
			<a:section name="abstract" xpath-contents=".//xhtml:div[@id = 'abstract']/xhtml:div[@class = 'para']"/>
		</xsl:when>
		<xsl:when test=".//*[@id = 'ABSTRACT']">
			<a:section name="abstract" xpath-contents=".//*[@id = 'ABSTRACT']"/>
		</xsl:when>
		<xsl:when test=".//*[@class = 'abstract svAbstract']/p[@id = '']">
			<a:section name="abstract" xpath-contents=".//*[@class = 'abstract svAbstract']/p[@id = '']"/>
		</xsl:when>
		<xsl:when test=".//*[@class = 'Abstract']">
			<a:section name="abstract" xpath-contents=".//*[@class = 'Abstract']"/>
		</xsl:when>
		<xsl:when test=".//a[@name = 'abs']">
			<a:section name="abstract" xpath-contents=".//a[@name = 'abs']"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:message>No abstract for <xsl:value-of select="$source-path"/></xsl:message>
		</xsl:otherwise>
	</xsl:choose>

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
