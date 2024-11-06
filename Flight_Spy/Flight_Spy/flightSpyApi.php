<?php
$options = [
    "http" => [
        "header" => "User-Agent: PHP\r\n"
    ]
];

$context = stream_context_create($options);
$html = file_get_contents('https://www.radarbox.com/data/flights/' . $_GET["flightCode"], false, $context);

$dom = new DOMDocument();
@$dom->loadHTML($html);
$xpath = new DOMXPath($dom);

// Variables
$originCity = "Unknown";
$destinationCity = "Unknown";
$schedDeparture = "Unknown";
$schedArrival = "Unknown";
$departureDate = "Unknown";
$arrivalDate = "Unknown";
$progress = "0";
$flightNum = "Unknown";
$airlineLogoLink = "Unknown";
$airline = "Unknown";
$aircraftModel = "Unknown";
$registration = "Unknown";
$imgLink = "Unknown";

// Origin and destination city
$destinations = $xpath->query('//div[@id="city"]');
if ($destinations->length >= 2) {
    $originCity = $destinations->item(0)->nodeValue;
    $destinationCity = $destinations->item(1)->nodeValue;
}

// Scheduled departure and arrival
$schedules = $xpath->query('//div[@id="scheduled"]');
if ($schedules->length >= 2) {
    $schedDeparture = $schedules->item(0)->nodeValue . ", local";
    $schedArrival = $schedules->item(1)->nodeValue . ", local";
}

// Departure and arrival dates
$dates = $xpath->query('//div[@id="date"]');
if ($dates->length >= 2) {
    $departureDate = $dates->item(0)->nodeValue;
    $arrivalDate = $dates->item(1)->nodeValue;
}

// Progress
$progressBox = $xpath->query('//*[@id="progress"]');
if ($progressBox->length > 0) {
    $progress = preg_replace('/[^0-9]/', '', ($progressBox->item(0)->getAttribute('title')));
}

// Flight number
$flightNumBox = $xpath->query('//div[@id="main"]/span');
if ($flightNumBox->length > 0) {
    $flightNum = $flightNumBox->item(0)->nodeValue;
}

// Airline logo link
$airlineLogoBox = $xpath->query('//div[@id="main"]/img');
if ($airlineLogoBox->length > 0) {
    $link = $airlineLogoBox->item(0)->getAttribute('src');
    $airlineLogoLink = substr($link, 0, 33) . "/sq/" . substr($link, 34);

}

// Airline name
$airlineBox = $xpath->query('//div[@id="value"]/a');
if ($airlineBox->length > 0) {
    $airline = $airlineBox->item(0)->nodeValue;
}

// Aircraft model
$aircraftModelBox = $xpath->query('//div[@id="title" and text()="Aircraft Model"]/following-sibling::div[@id="value"]/a');
if ($aircraftModelBox->length > 0) {
    $aircraftModel = $aircraftModelBox->item(0)->nodeValue;
}

// Registration
$registrationBox = $xpath->query('//div[@id="title" and text()="Registration"]/following-sibling::div[@id="value"]/a');
if ($registrationBox->length > 0) {
    $registration = str_replace(' ', '', ($registrationBox->item(0)->nodeValue));
}

// Image link
$imgLinkBox = $xpath->query('//div[@id="image-container"]/img');
if ($imgLinkBox->length > 0) {
    $imgLink = $imgLinkBox->item(0)->getAttribute('src');
}

// JSON response
$jsonAnswer = [
    "originCity" => $originCity,
    "destinationCity" => $destinationCity,
    "schedDeparture" => $schedDeparture,
    "schedArrival" => $schedArrival,
    "departureDate" => $departureDate,
    "arrivalDate" => $arrivalDate,
    "progress" => $progress,
    "flightNum" => $flightNum,
    "airlineLogoLink" => $airlineLogoLink,
    "airline" => $airline,
    "aircraftModel" => $aircraftModel,
    "registration" => $registration,
    "imgLink" => $imgLink,
];

header('Content-Type: application/json');
echo json_encode($jsonAnswer);
?>
