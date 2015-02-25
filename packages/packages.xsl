<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Schlafen im Fass | Packages</title>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <link href="../css/reset.css" rel="stylesheet" type="text/css" />
                <link href="../css/style.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <div id="container">
                    <div class="stripe"></div>
                    <div id="content">
                        <!-- Header -->
                        <div id="header">
                            <ul class="main_navi">
                                <li class="current">
                                    <a href="packages.xml">Packages</a>
                                </li>
                                <li>
                                    <a href="../calendar.php">Fass Buchen</a>
                                </li>
                                <li>
                                    <a href="../index.html">Home</a>
                                </li>
                            </ul>
                            <a href="../index.html">
                                <img alt="" class="logo" src="../images/logo.png" />
                            </a>
                        </div>
                        <div id="page_content">

                            <xsl:apply-templates />

                        </div>
                        <div id="footer"> © Schlafen im Fass 2015 | Website by Cédric Brütsch, Philipp Rupp &amp; Marco Schaub
                        </div>
                    </div>
                    <div class="stripe"></div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="package">
        <xsl:value-of select="@name"/>
    </xsl:template>

</xsl:stylesheet>