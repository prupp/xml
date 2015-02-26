<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- stylesheet parameter -->
    <xsl:param name="bookingId" />

    <xsl:template match="bookings">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="booking_confirmation" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="booking_confirmation">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="right" font-size="8pt">
                        Seite
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt" background-color="blue" color="white" text-align="center" padding-top="5pt" padding-bottom="5pt">Buchungsbestätigung</fo:block><!-- For each movie ...  -->
                    <xsl:apply-templates select="reservation[@number=$bookingId]"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="reservation">
        <fo:table space-after.optimum="20pt" width="13cm" font-size="11pt">
            <fo:table-column column-number="1"/>
            <fo:table-column column-number="2"/>
            <fo:table-column column-number="3"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block font-size="16pt" color="grey" font-weight="900" text-align="left">
                            <xsl:value-of select="@number"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="5">
                        <fo:block>
                            <fo:external-graphic src="images/logo.png" border-width="0cm" width="2.5cm"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-top="8pt" number-columns-spanned="2" padding-bottom="10pt">
                        <fo:block>
                            Package: <xsl:value-of select="package"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            Price: <xsl:value-of select="price"/> Fr.
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Date: <xsl:value-of select="concat(day, '.', month, '.', year)"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2" padding-top="8pt" padding-bottom="4pt">
                        <fo:block>
                            <fo:external-graphic src="images/arrow.gif" border-width="0cm" width="6cm" height="2pt"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            Name: <xsl:value-of select="name"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Price: <xsl:value-of select="price"/> Fr.
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>
