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
				<style>

td{vertical-align:top;padding:10px;padding-left:0px;width:auto;}
tr{vertical-align: top; }
				</style>
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
						<table style="width: auto;
    margin-left: auto;
    margin-right: auto;">
		Diese einzigartige Übernachtung können Sie in 4 verschiedenen Varianten geniessen. <br/>In Ihrem gebuchten Fass finden Sie zusätzlich einen passenden Wein.
		</table><br/>
		<br/>
		<br/>
		<br/>
							<table style="width: auto;
    margin-left: auto;
    margin-right: auto;">

								<xsl:apply-templates />

							</table>
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
		<tr height="50" align="center" style="padding-left:20px;padding-right:20px;border-top: 2px dashed">
			<td style="border-bottom: 2px dashed;background-image:url(../images/holzbrett.jpg);" >
				<span style="font-size:200%; font-weight:bold;color:white;text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">
					<xsl:value-of select="@name"/>
				</span>
			</td>
			<td rowspan="3" style="border-left: 2px dashed;padding-left:10px;" >
				<img src="{picture/@href}" width="300" height="200" style="vertical-align:middle;"/>
			</td>
		</tr>
		<tr height="130">
			<td>
				<xsl:value-of select="description"/>
			</td>
		</tr>
		<tr>
			<td >
				<div style="line-height:130%;">
				Preis für eine Übernachtung im "<xsl:value-of select="@name"/>": <br/> 
					<xsl:value-of select="price"/> SFR. (Pauschal)
				</div>
			</td>
		</tr>
		<tr colspan="2" height="50" style="border-top: 2px dashed; "/>

	</xsl:template>

</xsl:stylesheet>