<?php 
    include(__DIR__ . "/../config.php"); 
    
    function checkStatus($ip, $port) {
		$fp = @fsockopen($ip, $port, $errornum, $errorstr, 1);
		if ($fp) {
			echo '<div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Online</div>
          </div>';
		} else if (!$fp) {
			echo '<div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Offline</div>
          </div>';
		}
 	}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title><?php echo $name ?> | Status</title>

    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="<?php echo $color ?>">
    <meta property="og:title" content="<?php echo $name ?>">
    <meta property="og:description" content="<?php echo $desc ?>">
    <meta property="og:image" content="<?php echo $logo ?>">
    <link rel="icon" type="image/png" href="<?php echo $logo ?>">

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/style.css" rel="stylesheet">
</head>

<body class="bg-<?php echo $theme ?>">

    <?php include(__DIR__ . "/../includes/scrollbar.inc.php") ?>

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

                            if ($piece[0] == "Status") {
                                echo '<li class="nav-item"> <a class="nav-link active" href="' . $piece[1] . '">' . $piece[0] . '</a> </li>';
                            } elseif ($piece[0] !== $domain) {
                                echo '<li class="nav-item"> <a class="nav-link" href="' . $piece[1] . '">' . $piece[0] . '</a> </li>';
                            }
                        }
                    }
                    ?>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container text-<?php echo $txtcolor ?>" id="status">
        <?php foreach ($servers as $name => $information) { ?>
            <h1><?php echo $name ?></h1>
                <?php checkStatus($information['IP'], $information['port']) ?>
        <?php }?>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>