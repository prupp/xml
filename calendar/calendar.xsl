<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN" doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd" indent="yes"/>

    <!-- stylesheet parameter -->
    <xsl:param name="yearToDisplay" />
    <xsl:param name="monthToDisplay" />
    <xsl:param name="currentDay" />

    <!-- global variables -->
    <xsl:variable name="rectSize" select="90" />
    <xsl:variable name="numberOfBarrels" select="3" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Schlafen im Fass | Buchen</title>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <link href="css/reset.css" rel="stylesheet" type="text/css" />
                <link href="css/style.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <div id="container">
                    <div class="stripe"></div>
                    <div id="content">
                        <!-- Header -->
                        <div id="header">
                            <ul class="main_navi">
                                <li>
                                    <a href="packages/packages.xml">Packages</a>
                                </li>
                                <li class="current">
                                    <a href="calendar.php">Fass Buchen</a>
                                </li>
                                <li>
                                    <a href="index.html">Home</a>
                                </li>
                            </ul>
                            <a href="index.html">
                                <img alt="" class="logo" src="images/logo.png" />
                            </a>
                        </div>
                        <div id="page_content">

                            <svg:svg width="800" height="700">

                                <!-- define rectangle for days -->
                                <svg:defs>
                                    <svg:rect id="rect1" stroke="none" stroke-width="1pt">
                                        <xsl:attribute name="width">
                                            <xsl:value-of select="$rectSize"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="height">
                                            <xsl:value-of select="$rectSize"/>
                                        </xsl:attribute>
                                    </svg:rect>
                                </svg:defs>

                                <!-- display month only if it allready exists in calendar.xml -->
                                <xsl:choose>
                                    <xsl:when test="count(//month[@year=$yearToDisplay and @value=$monthToDisplay]) >= 1">
                                        <xsl:apply-templates select="calendar/weekday"/>

                                        <xsl:call-template name="displayNavigation"/>

                                        <xsl:call-template name="displayCalendar">
                                            <xsl:with-param name="year" select="$yearToDisplay"/>
                                            <xsl:with-param name="month" select="$monthToDisplay"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <svg:text x="400" y="100" text-anchor="middle" alignment-baseline="middle">
                                            Die Buchung für diesen Monat ist noch nicht möglich.
                                        </svg:text>
                                        <svg:a xlink:href="calendar.php">
                                            <svg:text x="400" y="150"  text-anchor="middle" alignment-baseline="middle">
                                                ZURÜCK
                                            </svg:text>
                                        </svg:a>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </svg:svg>

                        </div>
                        <div id="footer"> © Schlafen im Fass 2015 | Website by Cédric Brütsch, Philipp Rupp &amp; Marco Schaub
                        </div>
                    </div>
                    <div class="stripe"></div>
                </div>
            </body>
        </html>

    </xsl:template>

    <xsl:template name="displayCalendar">
        <xsl:param name="year" />
        <xsl:param name="month" />
        <xsl:variable name="monthToDisplay" select="//month[@value=$month and //month[@year=$year]]" />

        <xsl:variable name="x-value" select="((8 * $rectSize) div 2)" />
        <xsl:variable name="y-value" select="($rectSize div 2) - 20" />

        <svg:text style="font-size:28px">
            <xsl:attribute name="x">
                <xsl:value-of select="$x-value"/>
            </xsl:attribute>
            <xsl:attribute name="y">
                <xsl:value-of select="$y-value"/>
            </xsl:attribute>
            <xsl:value-of select="concat($monthToDisplay/@name, ' ', $monthToDisplay/@year)"/>
        </svg:text>
        <xsl:apply-templates select="$monthToDisplay"/>
    </xsl:template>

    <xsl:template match="weekday">
        <xsl:variable name="x-value" select="((@value * ($rectSize + 10)) + ($rectSize div 2) - 15)" />
        <xsl:variable name="y-value" select="($rectSize div 2) + 30" />

        <svg:text>
            <xsl:attribute name="x">
                <xsl:value-of select="$x-value"/>
            </xsl:attribute>
            <xsl:attribute name="y">
                <xsl:value-of select="$y-value"/>
            </xsl:attribute>
            <xsl:value-of select="text()"/>
        </svg:text>

    </xsl:template>

    <xsl:template match="day">
        <xsl:variable name="x-value" select="(position() div 2) * ($rectSize + 10)" />
        <xsl:variable name="y-value" select="../@value * ($rectSize + 10)" />
        <xsl:variable name="day" select="text()" />

        <!-- get all bookings for the current day out of bookings.xml file -->
        <xsl:variable name="bookingCount" select="count(document('../booking/bookings.xml')/bookings/reservation[day=$day and month=$monthToDisplay and year=$yearToDisplay])" />

        <!-- fill fully booked days red, past days grey and free days green -->
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="$bookingCount >= $numberOfBarrels">
                    <xsl:text>red</xsl:text>
                </xsl:when>
                <xsl:when test="$day &lt; $currentDay">
                    <xsl:text>grey</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>green</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- ignore empty nodes -->
        <xsl:if test="text() > 0">


            <svg:use xlink:href = "#rect1" fill-opacity="0.1">
                <xsl:attribute name="x">
                    <xsl:value-of select="$x-value"/>
                </xsl:attribute>
                <xsl:attribute name="y">
                    <xsl:value-of select="$y-value"/>
                </xsl:attribute>
                <xsl:attribute name="fill">
                    <xsl:value-of select="$color"/>
                </xsl:attribute>
            </svg:use>


            <svg:text>
                <xsl:attribute name="x">
                    <xsl:value-of select="$x-value + 5"/>
                </xsl:attribute>
                <xsl:attribute name="y">
                    <xsl:value-of select="$y-value + 20"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </svg:text>

            <!-- deactivate booking link on fully booked days -->
            <xsl:choose>
                <xsl:when test="$bookingCount &lt; $numberOfBarrels and $day >= $currentDay">
                    <svg:a xlink:href="booking.php?y={$yearToDisplay}&amp;m={$monthToDisplay}&amp;d={text()}">
                        <svg:image width="60" height="60" xlink:href="images/barrel.svg">
                            <xsl:attribute name="x">
                                <xsl:value-of select="$x-value + (($rectSize div 2) - 30)"/>
                            </xsl:attribute>
                            <xsl:attribute name="y">
                                <xsl:value-of select="$y-value  + (($rectSize div 2) - 30)"/>
                            </xsl:attribute>
                        </svg:image>
                    </svg:a>
                </xsl:when>
                <xsl:otherwise>
                    <svg:image width="60" height="60" xlink:href="images/nobarrel.svg">
                        <xsl:attribute name="x">
                            <xsl:value-of select="$x-value + (($rectSize div 2) - 30)"/>
                        </xsl:attribute>
                        <xsl:attribute name="y">
                            <xsl:value-of select="$y-value  + (($rectSize div 2) - 30)"/>
                        </xsl:attribute>
                    </svg:image>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:if>

    </xsl:template>

    <xsl:template name="displayNavigation">
        <!-- calculate next month for navigation -->
        <xsl:variable name="nextMonth">
            <xsl:choose>
                <xsl:when test="($monthToDisplay + 1) = 13">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$monthToDisplay + 1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- calculate next year for navigation -->
        <xsl:variable name="nextYear">
            <xsl:choose>
                <xsl:when test="$nextMonth = 1">
                    <xsl:value-of select="$yearToDisplay + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$yearToDisplay"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- calculate previous month for navigation -->
        <xsl:variable name="prevMonth">
            <xsl:choose>
                <xsl:when test="($monthToDisplay - 1) = 0">
                    <xsl:text>12</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$monthToDisplay - 1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- calculate previous year for navigation -->
        <xsl:variable name="prevYear">
            <xsl:choose>
                <xsl:when test="$prevMonth = 12">
                    <xsl:value-of select="$yearToDisplay - 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$yearToDisplay"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- add next link to navigate -->
        <svg:a xlink:href="calendar.php?y={$nextYear}&amp;m={$nextMonth}">
            <svg:image width="30" height="30" xlink:href="images/next.svg">
                <xsl:attribute name="x">
                    <xsl:value-of select="(8 * ($rectSize + 10)) - 40"/>
                </xsl:attribute>
                <xsl:attribute name="y">
                    <xsl:value-of select="($rectSize div 2) - 40"/>
                </xsl:attribute>
            </svg:image>
        </svg:a>

        <!-- add prev link to navigate -->
        <svg:a xlink:href="calendar.php?y={$prevYear}&amp;m={$prevMonth}">
            <svg:image width="30" height="30" xlink:href="images/prev.svg">
                <xsl:attribute name="x">
                    <xsl:value-of select="$rectSize + 10"/>
                </xsl:attribute>
                <xsl:attribute name="y">
                    <xsl:value-of select="($rectSize div 2) - 40"/>
                </xsl:attribute>
            </svg:image>
        </svg:a>
    </xsl:template>

</xsl:stylesheet>