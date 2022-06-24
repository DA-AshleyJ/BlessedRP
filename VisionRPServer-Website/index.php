<?php
if (!isset($vist_page))
{
	$vist_page     =   "logger.php";
}
$user_agent     =   $_SERVER['HTTP_USER_AGENT'];
// Getting OS Name
function getOS() { 

    global $user_agent;

    $os_platform    =   "Unknown OS Platform";

    $os_array       =   array(
                            '/windows nt 10/i'     =>  'Windows 10',
                            '/windows nt 6.3/i'     =>  'Windows 8.1',
                            '/windows nt 6.2/i'     =>  'Windows 8',
                            '/windows nt 6.1/i'     =>  'Windows 7',
                            '/windows nt 6.0/i'     =>  'Windows Vista',
                            '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
                            '/windows nt 5.1/i'     =>  'Windows XP',
                            '/windows xp/i'         =>  'Windows XP',
                            '/windows nt 5.0/i'     =>  'Windows 2000',
                            '/windows me/i'         =>  'Windows ME',
                            '/win98/i'              =>  'Windows 98',
                            '/win95/i'              =>  'Windows 95',
                            '/win16/i'              =>  'Windows 3.11',
                            '/macintosh|mac os x/i' =>  'Mac OS X',
                            '/mac_powerpc/i'        =>  'Mac OS 9',
                            '/linux/i'              =>  'Linux',
							'/kalilinux/i'          =>  'KaliLinux',
                            '/ubuntu/i'             =>  'Ubuntu',
                            '/iphone/i'             =>  'iPhone',
                            '/ipod/i'               =>  'iPod',
                            '/ipad/i'               =>  'iPad',
                            '/android/i'            =>  'Android',
                            '/blackberry/i'         =>  'BlackBerry',
                            '/webos/i'              =>  'Mobile',
							'/Windows Phone/i'      =>  'Windows Phone'
                        );

    foreach ($os_array as $regex => $value) { 

        if (preg_match($regex, $user_agent)) {
            $os_platform    =   $value;
        }

    }   

    return $os_platform;

}
// END of Getting OS
//
// Get browser
function getBrowser() {

    global $user_agent;

    $browser        =   "Unknown Browser";

    $browser_array  =   array(
                            '/msie/i'       =>  'Internet Explorer',
                            '/firefox/i'    =>  'Firefox',
							'/Mozilla/i'	=>	'Mozila',
							'/Mozilla/5.0/i'=>	'Mozila',
                            '/safari/i'     =>  'Safari',
                            '/chrome/i'     =>  'Chrome',
                            '/edge/i'       =>  'Edge',
                            '/opera/i'      =>  'Opera',
							'/OPR/i'        =>  'Opera',
                            '/netscape/i'   =>  'Netscape',
                            '/maxthon/i'    =>  'Maxthon',
                            '/konqueror/i'  =>  'Konqueror',
							'/Bot/i'		=>	'BOT Browser',
							'/Valve Steam GameOverlay/i'  =>  'Steam',
                            '/mobile/i'     =>  'Handheld Browser'
                        );

    foreach ($browser_array as $regex => $value) { 

        if (preg_match($regex, $user_agent)) {
            $browser    =   $value;
        }

    }

    return $browser;

}
// END of getting browser
function getIP() 
{ 
	if (isset($_SERVER)) 
	{ 
		if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) 
		{ 
			$realip = $_SERVER['HTTP_X_FORWARDED_FOR']; 
		} 
		else
			if (isset($_SERVER['HTTP_CLIENT_IP'])) 
			{ 
				$realip = $_SERVER['HTTP_CLIENT_IP']; 
			} 
			else 
			{ 
				$realip = $_SERVER['REMOTE_ADDR']; 
			} 
		} 
	else 
	{
		if (getenv("HTTP_X_FORWARDED_FOR")) 
		{ 
			$realip = getenv( "HTTP_X_FORWARDED_FOR"); 
		} 
		else
			if (getenv("HTTP_CLIENT_IP")) 
			{ 
				$realip = getenv("HTTP_CLIENT_IP"); 
			}
			else
			{ 
				$realip = getenv("REMOTE_ADDR"); 
	} 
} 
return $realip; 
}
session_start();
if(!isset($_SESSION[$vist_page]) || $_SESSION[$vist_page]!=1)
{
	$_SESSION[$vist_page]=1;
	$user_os        =   getOS();
	$user_browser   =   getBrowser();

	// Getting visitor IP address
	//$ip = $_SERVER['REMOTE_ADDR'];
	$ip = getIP();
	// Getting where visitor come
	$site_refer = $_SERVER['HTTP_REFERER'];
		// If hes connected directly 
		if($site_refer == ""){
			$site = "direct connection";
		}
	  // If he doesn't
		else{
			$site = $site_refer;
		}
	  // Hide ownr's IP address
		$owner = "HIDE THIS IP ADDRESS";   //Change $owner for something else, cuz someone can simple read that by calling out $owner
	  // change it for $absdfs5sd4 for example and change it down there 
		$owner_country = "YOUR COUNTRY TAG FOR YOUR IP ↑"; //This u can leave how it is.
	  
		if($ip == $owner){ //Change it here 
			$ip = "Owner"; 
			$country = $owner_country;
		}
	  //If that wasn't you, it woun't change IP address and it will find info about IP address
		else{
			$details = json_decode(file_get_contents("http://ipinfo.io/{$ip}"));
			$country = $details->country;
		}
		// Writing in to txt file
	 $myfile = file_put_contents(__DIR__ . 'iplist.txt',date("Y-m-d - H:i:s - "). $country. " ". $ip." | ". $vist_page." | ". $user_os. " | ". $user_browser. " | From: ". $site. " | user agent:" .$user_agent .PHP_EOL , FILE_APPEND | LOCK_EX);
	fclose($myfile);
}
?>

<?php include(__DIR__ . "/config.php");?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title><?php echo $name ?> | Home</title>

    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="<?php echo $color ?>">
    <meta property="og:title" content="<?php echo $name ?>">
    <meta property="og:description" content="<?php echo $desc ?>">
    <meta property="og:image" content="<?php echo $logo ?>">
    <link rel="icon" type="image/png" href="<?php echo $logo ?>">

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://pro.fontawesome.com/releases/v5.15.4/css/all.css" rel="stylesheet">
    <link href="../assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-<?php echo $theme ?>">

    <?php include(__DIR__ . "/includes/scrollbar.inc.php") ?>

    <!-- Nav Bar -->
    <nav class="navbar navbar-expand-lg navbar-<?php echo $theme ?>" style="background-color: <?php echo $color ?>; box-shadow: 0 0.01vh 1vh 0 #000;">
        <div class="container-fluid">
            <a class="navbar-brand" href="<?php echo $domain ?>">
                <img src="<?php echo $logo ?>" alt="" width="30" height="30" class="d-inline-block align-text-top"> <?php echo $name ?>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <?php
                    foreach ($linkarray as $key => $link) {
                        if ($link !== "" && $link !== "#" && $link !== null) {
                            $piece = explode("#", $link);

                            if ($piece[0] !== $domain) {
                                echo '<li class="nav-item"> <a class="nav-link" href="' . $piece[1] . '">' . $piece[0] . '</a> </li>';
                            }
                        }
                    }
                    ?>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container text-<?php echo $txtcolor ?>" id="main">
        <div class="row align-items-center">
            <div class="col">
                <h1 style="color: <?php echo $color ?>"><i class="fab fa-discord"></i> Discord Server</h1>
                <a id="link" class="text-<?php echo $txtcolor ?>" href="<?php echo $discordomain ?>"><?php echo $members ?> members online</a>
            </div>
            <div class="col">
                <img src="<?php echo $logo ?>" width="450"/>
            </div>
            <div class="col">
                <h1 style="color: <?php echo $color ?>"><i class="far fa-play-circle"></i> FiveM Server</h1>
                <a id="link" class="text-<?php echo $txtcolor ?>" href="<?php echo $fivem ?>">Click to connect</a>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
