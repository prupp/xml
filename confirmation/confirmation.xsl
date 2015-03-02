<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- stylesheet parameter -->
    <xsl:param name="bookingId" />

    <xsl:template match="bookings">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="booking_confirmation" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="0.5cm" margin-left="1cm" margin-right="1cm">
                    <fo:region-body margin-top="3.5cm" margin-bottom="1cm"/>
                    <fo:region-before extent="5cm" display-align="before"/>
                    <fo:region-after extent="2cm" display-align="after"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="booking_confirmation">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="left" >
                        <fo:external-graphic content-height="scale-to-fit" height="80px"  content-width="222px" scaling="non-uniform" src="http://schlafenimfass.is-best.net/images/logo.png" />
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:table font-size="9pt" keep-together="always" width="100%" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="5cm"/>
                        <fo:table-column column-number="2" column-width="9cm"/>
                        <fo:table-column column-number="3" column-width="5cm"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell text-align="left">
                                    <fo:block>Schlafen im Fass</fo:block>
                                    <fo:block>Schöne Aussicht 1</fo:block>
                                    <fo:block>3456 Meggen</fo:block>
                                </fo:table-cell>
                                <fo:table-cell text-align="center" white-space-collapse="false" display-align="after">
                                    <fo:block>Seite <fo:page-number/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell text-align="right" white-space-collapse="false" display-align="after">
                                    <fo:block>www.schlafenimfass.is-best.net</fo:block>
                                    <fo:block>Tel: +41 (41) 666 666</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt" padding-top="5pt" padding-bottom="5pt">Buchungsbestätigung</fo:block>
                    <xsl:apply-templates select="reservation[@number=$bookingId]"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="reservation">
        <fo:table space-after="10pt" table-layout="fixed" width="19cm" font-size="12pt" keep-together="always">
            <fo:table-column column-number="1" column-width="5cm"/>
            <fo:table-column column-number="2" column-width="14cm"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            Sehr geehrte(r) <xsl:value-of select="name"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <!-- Stupid code but the only solution I found to make a new line -->
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block white-space-collapse="false"
                                  white-space-treatment="preserve"
                                  font-size="0pt" line-height="15px">.</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block>
                            Wir danken Ihnen für die Buchung in unserem Schlaffass.
                            Wunschgemäss haben wir für Sie das folgende Packages reserviert:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <!-- Stupid code but the only solution I found to make a new line -->
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block white-space-collapse="false"
                                  white-space-treatment="preserve"
                                  font-size="0pt" line-height="15px">.</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-weight="bold">
                    <fo:table-cell>
                        <fo:block>
                            Ihre Buchungsnummer:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="@number"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-weight="bold">
                    <fo:table-cell>
                        <fo:block>
                            Package:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="package"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-weight="bold">
                    <fo:table-cell>
                        <fo:block>
                            Preis:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="price"/> Fr.
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-weight="bold">
                    <fo:table-cell>
                        <fo:block>
                            Ankunftstag:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="concat(day, '.', month, '.', year)"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <!-- Stupid code but the only solution I found to make a new line -->
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block white-space-collapse="false"
                                  white-space-treatment="preserve"
                                  font-size="0pt" line-height="15px">.</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block>
                            Bei Fragen oder Unklarheiten stehen wir Ihnen gerne zur Verfügung. Ihr Schlafen im Fass Team.
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>
