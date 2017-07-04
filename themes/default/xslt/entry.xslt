<?xml version="1.0"?>
<!--
  Do not use named character entities such as &nbsp; use the numeric form instead e.g &#160;
  The XSLT processor will report syntax errors if you use named character entities.
  -->
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:param name="entrytype" select='"word"' />
  <xsl:preserve-space elements="*"/>
  <xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
  <xsl:template match="/">
  <html>
    <xsl:comment>XSLT script version 1.3: <xsl:value-of select="$entrytype" /></xsl:comment>

    <xsl:apply-templates select="//word" />
    <xsl:if test="$entrytype = 'node'">
      <xsl:call-template name="entry" />
    </xsl:if>
    <!-- use this parameter value when testing standalone node xml
         which start with <entryFree>
         -->
    <xsl:if test="$entrytype = 'free'">
      <xsl:apply-templates select="//entryFree" />
    </xsl:if>
  </html>
  </xsl:template>


  <xsl:template match="word" name="entry">
    <body>
      <xsl:attribute name="class">
    <xsl:choose>
      <xsl:when test="boolean(./@supp = 1)">
        <xsl:text>supplement</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>main</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
      </xsl:attribute>
    <xsl:variable name="entrystyle">
    <xsl:choose>
      <xsl:when test="boolean(./@supp = 1)">
        <xsl:text>insupplement</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>main</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@type = 'root'">
    <p>
      <xsl:attribute name="class">arabicroot <xsl:value-of select="$entrystyle" /></xsl:attribute>
      <xsl:value-of  select="@ar"/>
      <xsl:if test="@quasi = '1'">
        <span class="quasi">&#160;&#160;(Quasi root)</span>
      </xsl:if>
      <xsl:if test="@quasi = '2'">
        <span class="quasi">&#160;&#160;(also quasi root)</span>
      </xsl:if>
      </p>
      </xsl:when>

      <xsl:otherwise>
        <p>
<!--      <xsl:attribute name="class"><xsl:value-of select="$entrystyle" /></xsl:attribute> -->
      <xsl:if test="not(@itype = '') and not(@itype='alphabetical letter')">
        <span class="itype"><xsl:value-of select="@itype" /></span><xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="not(@itype = 'alphabetical letter')">
        <span class="arabichead"><xsl:value-of select="@ar"/></span>&#x200e;
      </xsl:if>

    <xsl:apply-templates select="entryFree" />
        </p>
      </xsl:otherwise>
    </xsl:choose>
    </body>
  </xsl:template>
<!---
  These use characters from Arabic Presentation Forms-B to show short vowels u/i/a
  Replace &#xhhhhn; by the e.g u will work.
-->

  <xsl:template match="form">
    <xsl:if test="@n='infl'">
      <xsl:choose>
      <xsl:when test="orth/@orig = 'Bu'">
      <span class="arabicinflection">&#xfe79;&#160;</span>
      </xsl:when>
      <xsl:when test="orth/@orig = 'Bi'">
      <span class="arabicinflection">&#xfe7b;&#160;</span>
      </xsl:when>
      <xsl:when test="orth/@orig = 'Ba'">
      <span class="arabicinflection">&#xfe77;&#160;</span>
      </xsl:when>
      <xsl:when test="orth/@orig = 'BN'">
      <span class="arabicinflection">&#xfe72;&#160;</span>
      </xsl:when>
      <xsl:when test="orth/@orig = 'BF'">
      <span class="arabicinflection">&#xfe71;&#160;</span>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!---
      From http://stackoverflow.com/questions/14118670/check-type-of-node-in-xsl-template
      This is used in debugging.
  -->
  <xsl:template match="entryFree" priority="99">
    <span class="entry">
    <xsl:for-each select="@*|node()">
      <p><xsl:attribute name="style">
        <xsl:value-of select="position()" />
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="count(.|/)=1">
          <xsl:text>Root</xsl:text>
        </xsl:when>
        <xsl:when test="self::*">
          <xsl:text>Element </xsl:text>
          <xsl:value-of select="name()"/>
        </xsl:when>
        <xsl:when test="self::text()">
          <xsl:text>Text</xsl:text>
        </xsl:when>
        <xsl:when test="self::comment()">
          <xsl:text>Comment</xsl:text>
        </xsl:when>
        <xsl:when test="self::processing-instruction()">
          <xsl:text>PI</xsl:text>
        </xsl:when>
        <xsl:when test="count(.|../@*)=count(../@*)">
          <xsl:text>Attribute </xsl:text> <xsl:value-of select="name()" />
        </xsl:when>
      </xsl:choose>
      </p>
    </xsl:for-each>
    </span>
  </xsl:template>
  <!--
  For the sense separators.
  Lane uses a long underscore for a "to denote a break in the relations of significations"
  and a double long underscore to denote "an extraordinary, or a complete, dissociation."

  Type 'a/A' is a complete break, type 'b/B' otherwise

  -->
  <xsl:template match="sense">
    <xsl:if test="(@type='B') or (@type='b')">
      <span class="bseparator">___</span>  <!-- <xsl:text>&#x2016;</xsl:text> </span> -->
    </xsl:if>
    <xsl:if test="(@type='A') or (@type='a')">
      <span class="aseparator"><xsl:text>&#x2017;&#x2017;&#x2017;</xsl:text> </span>
    </xsl:if>
  </xsl:template>

  <!--
  For page breaks
  -->
   <xsl:template match="pb">
    <xsl:element name="br"/>
    <span class="pagebreak">Page <xsl:value-of select="@n" />    </span>
    <xsl:element name="br"/>
    <xsl:element name="br"/>
  </xsl:template>

  <!--
      For single or multiline quotes.
      In the original they appear on separate lines between *'s but occasionally
      he has

      * <arabic text > * <arabic text> *

      on a single line
  -->
  <xsl:template match="quote_span">
<br/>
    <span class="arabicquoteblock">
      <xsl:for-each select="L">
            <xsl:for-each select="foreign|orth">
              <xsl:if test="@type = 'arrow'">
                ↓
              </xsl:if>
            <span class="arabicquote">
              <xsl:value-of select="."/>
            </span>&#x200e;
            <xsl:if test="position() != last()">
               <span>&#160;&#160;&#160;*&#160;&#160;&#160;</span>
              </xsl:if>

            </xsl:for-each>
        <br/>
      </xsl:for-each>

    </span>
<br/>
  </xsl:template>

  <xsl:template match="quote">
    <!-- A kludge                                                                -->
    <!-- this is because of the way Qt rich text edit handles paragraphs         -->
    <!-- Without an explicit begin tag at the end of this block of html          -->
    <!-- the following text will have its line-height attribute dropped          -->
    <!-- and looks awful.                                                        -->
    <!-- The calling code will replace the comment with a begin or end tag       -->
    <xsl:comment>insert{
         &lt;/p&gt;
    }</xsl:comment>
    <div class="arabicquoteblock">
    <table align="center" width="100%">
      <xsl:for-each select="L">
        <tr>
          <td align="right" width="10%">*</td>
          <td align="center" width="80%">
            <xsl:for-each select="foreign|orth">
              <span class="arabicquote">
                <xsl:for-each select="@*|node()">
                  <xsl:choose>
                    <xsl:when test="name() = 'ref'">
                      <xsl:call-template name="refnode" select="." />
                      <xsl:text> </xsl:text>
                    </xsl:when>
                    <xsl:when test="name() = 'anchor'">
                      <span class="hiddenbreak">x</span>
                    </xsl:when>
                    <xsl:when test="self::text()">
                      <xsl:value-of select="." />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="text()" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </span>
            </xsl:for-each>
             </td>
          <td width="10%">*</td>
        </tr>
      </xsl:for-each>
    </table>
    </div>
    <!-- see above for the reason for this                             -->
    <xsl:comment>insert{
         &lt;p&gt;
    }</xsl:comment>
  </xsl:template>

  <xsl:template name="refnode">
    <a>
      <xsl:choose>
        <xsl:when test="@select">
          <xsl:attribute name="href">
            <xsl:text>127.0.0.0?golink=</xsl:text>
            <xsl:value-of select="@cref"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>linkword</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="href">
            <xsl:text>127.0.0.0?nolink=</xsl:text>
            <xsl:value-of select="@cref"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>nolinkword</xsl:text>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
<!---      <xsl:text> ↓ </xsl:text> -->
      <xsl:value-of select="@target" />

    </a>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template name="nolink-arrow">
    <a>
      <xsl:attribute name="href">
        <xsl:text>127.0.0.0?nolink=</xsl:text>
        <xsl:value-of select="@nogo"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@subtype='multiwordlink'">
          <xsl:message>found multiword link</xsl:message>
          <xsl:attribute name="class">multiwordlink</xsl:attribute>
          <xsl:for-each select="@*|node()">
            <xsl:choose>
              <xsl:when test="self::ref">
                <xsl:if test="@render='linkword'">
                  <span class="nolinkword"><xsl:value-of select="." /></span>
                </xsl:if>
                <xsl:if test="@render='linkwordwitharrow'">
                  <span class="nolinkword"><xsl:value-of select="." /></span> &#x202d;↓&#x202c;
                </xsl:if>
              </xsl:when>
              <xsl:when test="self::text()">
                <xsl:value-of select="."/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">nolink</xsl:attribute>
          <xsl:value-of select="text()" />
        </xsl:otherwise>
      </xsl:choose>

    </a>
  </xsl:template>

  <xsl:template match="entryFree" name="processentry" priority="100">

<!---
  <span>
    <xsl:choose>
      <xsl:when test="boolean(../@supp = 1)">
        <xsl:attribute name="class">entry supplement</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="class">entry</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
-->
    <xsl:if test="$entrytype = 'node'">
       <span class="arabic"><xsl:value-of select="@key" /></span>
   </xsl:if>
      <a>
        <xsl:attribute name="name">
          <xsl:value-of select="@id" />
        </xsl:attribute>
      </a>

    <xsl:for-each select="@*|node()">
      <!---
      <p><xsl:attribute name="pos">
        <xsl:value-of select="position()" />
      </xsl:attribute>
      -->
      <xsl:choose>
        <xsl:when test="count(.|/)=1">
          <xsl:text>Root</xsl:text>
        </xsl:when>
        <xsl:when test="self::*">
          <!---

          -->
          <xsl:choose>
            <xsl:when test="name() = 'hi'">
              <span class="hi"><xsl:value-of select="text()" /></span>
            </xsl:when>
            <xsl:when test="name() = 'form'">
              <xsl:apply-templates select="." />
            </xsl:when>
            <xsl:when test="name() = 'pb'">
              <xsl:apply-templates select="." />
            </xsl:when>
            <xsl:when test="name() = 'quote'">

              <xsl:apply-templates select="." />
            </xsl:when>
            <xsl:when test="name() = 'sense'">
              <xsl:apply-templates select="." />
            </xsl:when>
            <xsl:when test="name() = 'tropical'">
              <xsl:text>‡</xsl:text>
            </xsl:when>
            <xsl:when test="name() = 'assumedtropical'">
              <xsl:text>†</xsl:text>
            </xsl:when>
            <xsl:when test="name() = 'anchor'">
              <span class="hiddenbreak">xxxxx</span>
            </xsl:when>
            <xsl:when test="name() = 'note'">
              <a>
                <xsl:attribute name="href">
                  <xsl:text>127.0.0.0/?text=</xsl:text>
                  <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:attribute name="class">
                  <xsl:text>systemnote</xsl:text>
                </xsl:attribute>
                <xsl:text>[Note]</xsl:text>
              </a>
            </xsl:when>
            <xsl:when test="name() = 'ptr'">
              <span class="arabic">
              <a>
                <xsl:attribute name="class">linkword</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>127.0.0.0?root=</xsl:text>
                  <xsl:value-of select="@pointing"/>
                </xsl:attribute>
                <xsl:value-of select="text()" />
              </a>
              </span>
            </xsl:when>
            <!-- this captures other language entries -->
            <xsl:when test="name() = 'orth'">
              <xsl:element name="span">
                <xsl:if test="@lang">
                  <xsl:attribute name="class">
                    <xsl:text>lang-</xsl:text><xsl:value-of select="@lang"/>
                  </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="." />
              </xsl:element>
            </xsl:when>
            <xsl:when test="name() = 'foreign'">
              <span class="arabic">
                <xsl:for-each select="@*|node()">
                  <xsl:choose>
                    <xsl:when test="name() = 'ref'">
                      <xsl:text> </xsl:text>
                      <xsl:call-template name="refnode" select="." />
                      <xsl:text> </xsl:text>
                    </xsl:when>
                    <xsl:when test="name() = 'anchor'">
                      <span class="hiddenbreak">xxxxx</span>
                    </xsl:when>
                    <xsl:when test="self::text()">
                      <xsl:value-of select="." />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="text()" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </span>
            </xsl:when>
            <xsl:otherwise>
<!--              <xsl:value-of select="name()"/> -->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="self::text()">
          <!---
          <xsl:text>Text</xsl:text>
          -->
          <xsl:value-of select="." />
        </xsl:when>
        <xsl:when test="self::comment()">
         <!---
          <xsl:text>Comment</xsl:text>
         -->
        </xsl:when>
        <xsl:when test="self::processing-instruction()">
          <!---
          <xsl:text>PI</xsl:text>
          -->
        </xsl:when>
        <xsl:when test="count(.|../@*)=count(../@*)">
          <!---
          <xsl:text>Attribute </xsl:text> <xsl:value-of select="name()" />
          -->
        </xsl:when>
      </xsl:choose>
      <!---
      </p>
      -->

    </xsl:for-each>


    <div class="entryend"></div>
  </xsl:template>
</xsl:stylesheet>
