<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="//info" />
    <xsl:apply-templates select="//slajd" />
  </xsl:template>

  <xsl:template match="info">
    <xsl:result-document href="slajdy/0.html">
      <html>
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
          <title>
            <xsl:value-of select="nazov"/>
          </title>
        </head>
        <body>
          <div class="container-fluid d-flex align-items-center h-100">
            <div class="container-fluid text-center">
              <h1 class="display-4">
                <xsl:value-of select="nazov"/>
              </h1>
              <p class="lead">
                <xsl:value-of select="podnadpis"/>
              </p>
              <hr class="my-4" />
              <p>
                <xsl:value-of select="autor" />
              </p>
              <a class="btn btn-primary btn-lg" href="1.html">Začať</a>
            </div>
          </div>

        </body>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="slajd">
    <xsl:result-document href="slajdy/{position()}.html">
      <html>
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
          <title>
            <xsl:value-of select="@nadpis"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="../info/nazov"/>
          </title>
        </head>
        <body>
          <div class="container-fluid d-flex flex-column justify-content-between h-100 py-4">
            <div class="container-fluid text-center">
              <h1>
                <xsl:value-of select="@nadpis" />
              </h1>
              <hr/>
            </div>
            <div class="container d-flex flex-column">
              <xsl:apply-templates select="child::*" />
            </div>
            <div class="container d-flex justify-content-around">
              <a class="btn btn-outline-secondary" href="{position() - 1}.html">Predchádzajúci slajd</a>
              <p class="font-italic text-secondary">
                <xsl:text>Slajd </xsl:text>
                <xsl:value-of select="position()" />
                <xsl:text> z </xsl:text>
                <xsl:value-of select="last()" />
              </p>
              <xsl:if test="position() &lt; last()">
                <a class="btn btn-outline-primary" href="{position() + 1}.html">Nasledujúci slajd</a>
              </xsl:if>
            </div>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="text">
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template match="obrazok">
    <img class="align-self-center" src="{@zdroj}" alt="{.}" />
    <p class="align-self-center text-center">
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template match="polozka-zoznamu">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>

  <xsl:template match="zoznam[@cislovany=true()]">
    <ol>
      <xsl:apply-templates select="polozka-zoznamu" />
    </ol>
  </xsl:template>

  <xsl:template match="zoznam[@cislovany=false()]">
    <ul>
      <xsl:apply-templates select="polozka-zoznamu" />
    </ul>
  </xsl:template>

</xsl:stylesheet>
