<?php
/**
 * Created by PhpStorm.
 * User: philipprupp
 * Date: 24.02.15
 * Time: 12:57
 */

require_once 'foservice/fop_service_client.php';

class XMLHandler {

    const CALENDAR_XSL = "calendar/calendar.xsl";
    const CALENDAR_XML = "calendar/calendar.xml";
    const BOOKINGS_XML = "booking/bookings.xml";
    const PACKAGES_XML = "packages/packages.xml";
    const CONFIRMATION_FO = "confirmation/confirmation.fo";
    const CONFIRMATION_XSL = "confirmation/confirmation.xsl";

    /**
     * Transforms one month from an xml file into a xhtml page with a given xsl stylesheet.
     * @param $day current day
     * @param $month month to display
     * @param $year year to display
     * @return string xhtml page
     */
    public function displayCalendar($day, $month, $year) {
        $xslDoc = new DOMDocument();
        $xslDoc->load(self::CALENDAR_XSL);

        $xmlDoc = new DOMDocument();
        $xmlDoc->load(self::CALENDAR_XML);

        $xsltProcessor = new XSLTProcessor();
        $xsltProcessor->registerPHPFunctions();
        $xsltProcessor->importStyleSheet($xslDoc);
        $xsltProcessor->setParameter('', 'yearToDisplay', $year);
        $xsltProcessor->setParameter('', 'monthToDisplay', $month);
        $xsltProcessor->setParameter('', 'currentDay', $day);

        return $xsltProcessor->transformToXML($xmlDoc);
    }

    /**
     * Counts the reservations for a given day.
     * @param $day
     * @param $month
     * @param $year
     * @return int number of reservations for given date
     */
    public function getReservationCountByDate($day, $month, $year) {
        $xml = simplexml_load_file(self::BOOKINGS_XML);
        return count($xml->xpath("/bookings/reservation[day='{$day}' and month='{$month}' and year='{$year}']"));
    }

    /**
     * Counts the reservation for a given day and a given person name.
     * @param $day
     * @param $month
     * @param $year
     * @param $name
     * @return int number of reservations for given date and person name
     */
    public function getReservationCountByDateAndName($day, $month, $year, $name) {
        $xml = simplexml_load_file(self::BOOKINGS_XML);
        return count($xml->xpath("/bookings/reservation[day='{$day}' and month='{$month}' and year='{$year}' and name ='{$name}']"));
    }

    /**
     * Adds a booking into the xml file
     * @param $name
     * @param $day
     * @param $month
     * @param $year
     * @param $package
     * @param $bookingId
     */
    public function addBooking($name, $day, $month, $year, $package, $bookingId, $price)
    {
        $xml = simplexml_load_file(self::BOOKINGS_XML);
        $node = $xml->addChild('reservation');
        $node->addAttribute('number', $bookingId);
        $node->addChild('name', $name);
        $node->addChild('package', $package);
        $node->addChild('day', $day);
        $node->addChild('month', $month);
        $node->addChild('year', $year);
        $node->addChild('price', $price);
        file_put_contents(self::BOOKINGS_XML, $xml->asXML());
    }

    /**
     * Reads package names out of an xml file.
     * @return SimpleXMLElement[] all package names
     */
    public function getPackages() {
        $packageXml = simplexml_load_file(self::PACKAGES_XML);
        return $packageXml->xpath("/packages/package/@name");
    }

    /**
     * Gets package price from a given package
     * @param $packageName to get price from
     * @return SimpleXMLElement[] package price
     */
    public function getPriceByPackageName($packageName) {
        $packageXml = simplexml_load_file(self::PACKAGES_XML);
        $price = $packageXml->xpath("/packages/package[@name='{$packageName}']/price");
        return $price[0];
    }

    /**
     * Creates a confirmation for a booking.
     * @param $bookingId ID for which the confirmation has to be created
     * @return string booking confirmation as PDF
     */
    public function createConfirmationPDF($bookingId) {

        $xslDoc = new DOMDocument();
        $xslDoc->load(self::CONFIRMATION_XSL);

        $xmlDoc = new DOMDocument();
        $xmlDoc->load(self::BOOKINGS_XML);

        $xsltProcessor = new XSLTProcessor();
        $xsltProcessor->registerPHPFunctions();
        $xsltProcessor->importStyleSheet($xslDoc);
        $xsltProcessor->setParameter('', 'bookingId', $bookingId);

        $fo = $xsltProcessor->transformToXML($xmlDoc);

        $myfile = fopen(self::CONFIRMATION_FO, "w") or die("Unable to open file!");
        fwrite($myfile, $fo);
        fclose($myfile);

        // create an instance of the FOP client and perform service request.
        $serviceClient = new FOPServiceClient();
        return $serviceClient->processFile(self::CONFIRMATION_FO, "confirmation/confirmation" . $bookingId . ".pdf");
    }
}
?>