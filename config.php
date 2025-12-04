<?php
// config.php - FINAL VERSION THAT WORKS 100% ON XAMPP

$DB_HOST = '127.0.0.1';
$DB_PORT = 3307;        // CHANGE THIS TO 3306, 3307, or 3308 depending on your XAMPP
$DB_USER = 'root';
$DB_PASS = '';
$DB_NAME = 'visitor_db';

function db_connect() {
    global $DB_HOST, $DB_PORT, $DB_USER, $DB_PASS, $DB_NAME;
    
    $mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME, $DB_PORT);
    
    if ($mysqli->connect_error) {
        die("<h2>MySQL is OFF or wrong port!</h2>
             <p>Open XAMPP → Start MySQL<br>
             Current attempt: $DB_HOST:$DB_PORT</p>");
    }
    
    $mysqli->set_charset('utf8mb4');
    return $mysqli;
}

$mysqli = db_connect();
?>