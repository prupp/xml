<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Expires: Sat, 26 Jul 1997 05:00:00 GMT");
header('Content-type: application/xhtml+xml');

require_once 'xmlhandler.php';

// get query from url and parse it
$query = $_SERVER['QUERY_STRING'];
parse_str($query, $result);

// get current day, month and year
$year = date("Y", time());
$month = ltrim(date("m", time()), '0');
$day = ltrim(date("d", time()), '0');

// check if date was present in url, proceed with current date otherwise
if (array_key_exists('m', $result)) {
    $recYear = $result['y'];
    $recMonth = $result['m'];

    // check if received date is in the future, don't allow bookings for past dates
    if ($recYear > $year or $recYear >= $year and $recMonth > $month and $recMonth <= 12) {
        $year = $recYear;
        $month = $recMonth;
        $day = "0";
    }
}

// display the calender as xhtml page
$xmlHandler = new XMLHandler();
echo $xmlHandler->displayCalendar($day, $month, $year);

?>
