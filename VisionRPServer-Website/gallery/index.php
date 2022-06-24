<?php include(__DIR__ . "/../config.php"); ?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title><?php echo $name ?> | Gallery</title>

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

                            if ($piece[0] == "Gallery") {
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

    <!-- Gallery Images -->

    <div class="container" id="gallery">
        <div class="row row-cols-1 row-cols-md-4 g-4" style="margin-top: 1%">
            <?php
            foreach ($gallery as &$image) {
            ?>
                <div class="col">
                    <div class="card h-100 bg-<?php echo $theme ?>" style="filter:brightness(0.8)">
                        <img src="<?php echo $image ?>" class="card-img">
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>