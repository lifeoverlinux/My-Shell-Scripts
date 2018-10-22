// Taken from Stackoverflow! I couldn't find the same link address that I found php codes on it.

// If you get error after run mailsender.php : https://serverfault.com/questions/635139/how-to-fix-send-mail-authorization-failed-534-5-7-14

<?php
$usage = exec("cat /tmp/diskuse.txt | cut -f1 -d\%");
$hostname = exec(hostname);
$date = exec("date '+%Y/%m/%d at %H:%M:%S'");

    require "Mail.php";
    $to      = "email_address"; // to email address
    $from    = "email_address"; // the email address
    $subject = "WARNING: Disk Capaticy 90%";
    $body    = "Disk running out of space. Currently disk usage ".$usage."% on ".$hostname." as on ".$date.". Do
not forget to check disk space before system crash.";

    $host    = "smtp.gmail.com";
    $port    =  "587";
    $user    = "username";  // write yout mail address
    $pass    = "password";  // write your mail password
    $headers = array("From"=> $from, "To"=>$to, "Subject"=>$subject);
    $smtp    = @Mail::factory("smtp", array("host"=>$host, "port"=>$port, "auth"=> true, "username"=>$user,
"password"=>$pass));
    $mail    = @$smtp->send($to, $headers, $body);

    if (PEAR::isError($mail)){
        echo "error: {$mail->getMessage()}";
    } else {
        echo "Message sent";
    }
?>
