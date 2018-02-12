<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:a="xalan://fr.inra.maiage.bibliome.alvisnlp.bibliomefactory.modules.xml.XMLReader2"
                xmlns:inline="http://bibliome.jouy.inra.fr/alvisnlp/bibliome-module-factory/inline"
                extension-element-prefixes="a inline"
                >

  <xsl:template match="/">
    <xsl:apply-templates select="PubmedArticleSet/PubmedArticle"/>
  </xsl:template>


  <xsl:template match="PubmedArticle">
    <a:document xpath-id="MedlineCitation/PMID">
      <a:feature name="issn" xpath-value="MedlineCitation/Article/Journal/ISSN"/>
      <a:feature name="doi" xpath-value="PubmedData/ArticleIdList/ArticleId[@IdType='doi']"/>
      <a:feature name="journal" xpath-value="MedlineCitation/Article/Journal/Title"/>
      <a:feature name="abbrev" xpath-value="MedlineCitation/Article/Journal/ISOAbbreviation"/>
      <a:feature name="year" xpath-value="MedlineCitation/Article/Journal/JournalIssue/PubDate/Year"/>
      <a:section name="title" xpath-contents="MedlineCitation/Article/ArticleTitle"/>
      <xsl:for-each select="MedlineCitation/Article/Abstract/AbstractText">
	<a:section name="abstract" xpath-contents=".">
	  <a:feature key="label" xpath-value="@Label"/>
	</a:section>
      </xsl:for-each>
      <xsl:for-each select="MedlineCitation/Article/AuthorList/Author">
	<xsl:variable name="fore-name" select="ForeName"/>
	<xsl:variable name="last-name" select="LastName"/>
	<xsl:choose>
	  <xsl:when test="$fore-name = ''">
	    <a:section name="author" xpath-contents="$last-name">
	      <a:annotation start="0" end="string-length($last-name)" layers="name">
		<a:feature key="name-type" value="last-name"/>
	      </a:annotation>
	    </a:section>
	  </xsl:when>
	  <xsl:otherwise>
	    <a:section name="author" xpath-contents="concat($fore-name, ' ', $last-name)">
	      <a:annotation start="0" end="string-length($fore-name)" layers="name">
		<a:feature key="name-type" value="first-name"/>
	      </a:annotation>
	      <a:annotation start="string-length($fore-name) + 1" end="string-length($fore-name) + string-length($last-name) + 1" layers="name">
		<a:feature key="name-type" value="last-name"/>
	      </a:annotation>
	    </a:section>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
      <xsl:for-each select="MedlineCitation/ChemicalList/Chemical/NameOfSubstance|MeshHeadingList/MeshHeading/DescriptorName">
	<a:feature name="mesh-name" xpath-value="."/>
	<a:feature name="mesh-id" xpath-value="@UI"/>
      </xsl:for-each>
    </a:document>
  </xsl:template>

</xsl:stylesheet>
