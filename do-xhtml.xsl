<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="parametre" select="document('parametre.xml')" />
  <xsl:param name="obsah"><xsl:value-of select="$parametre//obsah" /></xsl:param>
  <xsl:param name="generovat-titulny-slajd"><xsl:value-of select="$parametre//generovat-titulny-slajd" /></xsl:param>
  <xsl:param name="cislovanie-slajdov"><xsl:value-of select="$parametre//cislovanie-slajdov" /></xsl:param>
  <xsl:param name="tmava-tema"><xsl:value-of select="$parametre//tmava-tema" /></xsl:param>
  <xsl:param name="titulny-slajd"><xsl:value-of select="$parametre//titulny-slajd" /></xsl:param>

  <xsl:template match="/">
    <xsl:if test="$generovat-titulny-slajd = true()">
      <xsl:apply-templates select="//info" />
    </xsl:if>
    <xsl:apply-templates select="//slajd" />
    <xsl:if test="$obsah = true()">
      <xsl:call-template name="obsah" />
    </xsl:if>
  </xsl:template>

  <xsl:template match="info">
    <xsl:result-document href="slajdy/0.xhtml">
      <xsl:text disable-output-escaping="yes">
        &lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"&gt;
      </xsl:text>
      <h:html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://www.w3.org/1999/xhtml" lang="sk">
        <h:head>
          <h:meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
          <xsl:if test="$tmava-tema = true()">
            <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/solar/bootstrap.min.css"/>
          </xsl:if>
          <h:title>
            <xsl:value-of select="nazov"/>
          </h:title>
        </h:head>
        <h:body>
          <h:div class="container-fluid d-flex align-items-center h-100">
            <h:div class="container-fluid text-center">
              <xsl:if test="contains($titulny-slajd, 'nazov')">
                <h:h1 class="display-4">
                  <xsl:value-of select="nazov"/>
                </h:h1>
              </xsl:if>
              <xsl:if test="contains($titulny-slajd, 'podnadpis')">
                <h:p class="lead">
                  <xsl:value-of select="podnadpis"/>
                </h:p>
              </xsl:if>
              <xsl:if test="contains($titulny-slajd, 'oddelovac')">
                <h:hr class="my-4" />
              </xsl:if>
              <xsl:if test="contains($titulny-slajd, 'autor')">
                <h:p>
                  <xsl:value-of select="autor" />
                </h:p>
              </xsl:if>
              <h:a class="btn btn-primary btn-lg" href="1.xhtml">Začať</h:a>
            <xsl:if test="$obsah=true()">
              <h:div class="container d-flex justify-content-around my-4">
                <h:a class="btn btn-outline-secondary" href="obsah.xhtml">Obsah</h:a>
              </h:div>
            </xsl:if>
            </h:div>
          </h:div>
        </h:body>
      </h:html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="slajd">
    <xsl:result-document href="slajdy/{position()}.xhtml">
      <xsl:text disable-output-escaping="yes">
        &lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"&gt;
      </xsl:text>
      <h:html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://www.w3.org/1999/xhtml" lang="sk">
        <h:head>
          <h:meta charset="utf-8" />
          <h:meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
          <xsl:if test="$tmava-tema = true()">
            <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/solar/bootstrap.min.css"/>
          </xsl:if>
          <h:title>
            <xsl:value-of select="@nadpis"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="../info/nazov"/>
          </h:title>
        </h:head>
        <h:body>
          <h:div class="container-fluid d-flex flex-column justify-content-between h-100 py-4">
            <h:div class="container-fluid text-center">
              <h:h1>
                <xsl:value-of select="@nadpis" />
              </h:h1>
              <h:hr/>
            </h:div>
            <h:div class="container d-flex flex-column">
              <xsl:apply-templates select="child::*" />
            </h:div>
            <h:div class="container d-flex justify-content-around">
              <xsl:if test="$generovat-titulny-slajd = true()">
                <h:a class="btn btn-outline-secondary" href="{position() - 1}.xhtml">Predchádzajúci slajd</h:a>
              </xsl:if>
              <xsl:if test="$generovat-titulny-slajd = false() and position() > 1">
                <h:a class="btn btn-outline-secondary" href="{position() - 1}.xhtml">Predchádzajúci slajd</h:a>
              </xsl:if>
              <xsl:if test="$obsah=true()">
                <a href="obsah.xhtml" class="text-secondary font-italic">
                  <xsl:if test="$cislovanie-slajdov = true()">
                    <xsl:text>Slajd </xsl:text>
                    <xsl:value-of select="position()" />
                    <xsl:text> z </xsl:text>
                    <xsl:value-of select="last()" />
                  </xsl:if>
                  <xsl:if test="$cislovanie-slajdov=false()">
                    Obsah
                  </xsl:if>
                </a>
              </xsl:if>
              <xsl:if test="$obsah=false() and $cislovanie-slajdov=true()">
                <h:p class="font-italic text-secondary">
                  <xsl:text>Slajd </xsl:text>
                  <xsl:value-of select="position()" />
                  <xsl:text> z </xsl:text>
                  <xsl:value-of select="last()" />
                </h:p>
              </xsl:if>
              <xsl:if test="position() &lt; last()">
                <h:a class="btn btn-outline-primary" href="{position() + 1}.xhtml">Nasledujúci slajd</h:a>
              </xsl:if>
            </h:div>
          </h:div>
        </h:body>
      </h:html>

    </xsl:result-document>
  </xsl:template>

  <xsl:template name="obsah">
    <xsl:result-document href="slajdy/obsah.xhtml">
      <xsl:text disable-output-escaping="yes">
        &lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"&gt;
      </xsl:text>
      <h:html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://www.w3.org/1999/xhtml" lang="sk">
        <h:head>
          <h:meta charset="utf-8" />
          <h:meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
          <xsl:if test="$tmava-tema = true()">
            <h:link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/solar/bootstrap.min.css"/>
          </xsl:if>
          <h:title>
            <xsl:text>Obsah</xsl:text>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="//info/nazov"/>
          </h:title>
        </h:head>
        <h:body>
          <h:div class="container-fluid d-flex flex-column justify-content-between h-100 py-4">
            <h:div class="container-fluid text-center">
              <h:h1>
                <xsl:text>Obsah</xsl:text>
              </h:h1>
              <h:hr/>
            </h:div>
            <h:div class="container d-flex flex-column">
              <ol>
                <xsl:for-each select="//slajd">
                  <li>
                    <a href="{position()}.xhtml">
                      <xsl:value-of select="@nadpis" />
                    </a>
                  </li>
                </xsl:for-each>
              </ol>
            </h:div>
            <h:div class="container d-flex justify-content-around">
              <h:a class="btn btn-outline-secondary" href="0.xhtml">Titulný slajd</h:a>
            </h:div>
          </h:div>
        </h:body>
      </h:html>

    </xsl:result-document>
  </xsl:template>

  <xsl:template match="text">
    <h:p>
      <xsl:value-of select="."/>
    </h:p>
  </xsl:template>

  <xsl:template match="obrazok">
    <h:img class="align-self-center" src="{@zdroj}" alt="{.}" />
    <h:p class="align-self-center text-center">
      <xsl:value-of select="."/>
    </h:p>
  </xsl:template>

  <xsl:template match="polozka-zoznamu">
    <h:li>
      <xsl:value-of select="."/>
    </h:li>
  </xsl:template>

  <xsl:template match="zoznam[@cislovany=true()]">
    <h:ol>
      <xsl:apply-templates select="polozka-zoznamu" />
    </h:ol>
  </xsl:template>

  <xsl:template match="zoznam[@cislovany=false()]">
    <h:ul>
      <xsl:apply-templates select="polozka-zoznamu" />
    </h:ul>
  </xsl:template>

</xsl:stylesheet>
