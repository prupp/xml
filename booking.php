<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Schlafen im Fass | Buchen</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link href="css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="container">
    <div class="stripe"></div>
    <div id="content">
        <div id="header">
            <ul class="main_navi">
                <li>
                    <a href="packages/packages.xml">Packages</a>
                </li>
                <li>
                    <a href="calendar.php">Fass Buchen</a>
                </li>
                <li>
                    <a href="index.html">Home</a>
                </li>
            </ul>
            <a href="index.html">
                <img alt="" class="logo" src="images/logo.png"/>
            </a>
        </div>
        <div id="page_content">

    <?php
    $name = $package = $date = "";
    $error = 0; // 1: no name entered, 2: allready booked for this day, 3: fully booked 4: successfully booked

    require_once 'xmlhandler.php';
    $xmlHandler = new XMLHandler();

    // get query from url and parse it
    $query = $_SERVER['QUERY_STRING'];
    parse_str($query, $result);

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = $_POST["name"];
        $package = $_POST["package"];
        $date = $_POST["date"];


        // persist booking only if name entered
        if ($name !== '') {

            $dateParts = explode(".", $date);
            $day = $dateParts[0];
            $month = $dateParts[1];
            $year = $dateParts[2];

            // check if not fully booked for given date
            if ($xmlHandler->getReservationCountByDate($day,$month,$year) < 3) {
                // check if this person already booked for given date, allow only one booking per date and person
                if ($xmlHandler->getReservationCountByDateAndName($day,$month,$year,$name) < 1) {
                    // generate unique booking id
                    $bookingId = uniqid();
                    // add booking to xml
                    $xmlHandler->addBooking($name, $day, $month, $year, $package, $bookingId);
                    $error = 4; // booking successful
                } else {
                    $error = 2; // already booked
                }
            } else {
                $error = 3; // fully booked for this day
            }

        } else {
            $error = 1; // no name entered
        }
    }

    // Set date only if present in url, use previously persisted date otherwise
    if (array_key_exists('m', $result)) {
        $date = $result['d'] . '.' . $result['m'] . '.' . $result['y'];
    }
    ?>

            <div id="booking_response">
                <p>
                <h1>
                    Buchung für den <?php echo $date; ?>
                </h1>
                <br/>
                </p>

                <?php
                switch ($error) {
                    case 0:
                        echo "Namen eingeben, Package auswählen und anschliessend Buchung ausführen.";
                        break;
                    case 1:
                        echo '<span style="color:#FF0000">Bitte geben Sie ihren Namen ein.</span>';
                        break;
                    case 2:
                        $output = "Sie haben für den ";
                        $output .= $date;
                        $output .= " bereits ein Fass gebucht.";
                        $output .= "<br/>";
                        $output .= "Aufgrund der hohen Nachfrage können wir pro Person und Tag nur eine Buchung entgegennehmen.";
                        echo $output;
                        break;
                    case 3:
                        $output = "Da war wohl jemand schneller.";
                        $output .= "<br/>";
                        $output .= "Leider sind für den ";
                        $output .= $date;
                        $output .= " bereits alle Fässer ausgebucht.";
                        echo $output;
                        break;
                    case 4:
                        $pdfFile = $xmlHandler->createConfirmationPDF($bookingId);
                        $output = "Vielen Dank für Ihre Buchung!";
                        echo $output;
                        echo sprintf('</br><p><strong><a href="%s" target=\"_BLANK\">Buchungsbestätigung</a></strong></p>', $pdfFile);
                        break;
                    default:
                        echo "unknown error";
                        break;
                }
                ?>
            </div>
            <div id="booking_content">


                <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                    <p>
                        <input type="hidden"
                               name="date"
                               value="<?php echo $date; ?>"/>
                    </p>

                    <p>
                        Name <br/>
                        <input type="text"
                               name="name"
                               size="30"
                               maxlength="50"/>
                    </p>

                    <p>
                        <br/><br/>Package <br/>
                        <select name="package">
                            <?php foreach ($xmlHandler->getPackages() as $item) {
                                $temp = '<option value="';
                                $temp .= $item;
                                $temp .= '">';
                                $temp .= $item;
                                $temp .= '</option>';
                                echo $temp;
                            } ?>
                        </select>
                    </p>

                    <p>
                        <br/><br/><br/><br/>
                        <input type="submit"
                               name="submit"
                               value="Buchung ausführen"/>
                    </p>
                </form>

            </div>
        </div>
        <div id="footer"> © Schlafen im Fass 2015 | Website by Cédric Brütsch, Philipp Rupp &amp; Marco Schaub
        </div>
    </div>
    <div class="stripe"></div>
</div>
</body>
</html>

