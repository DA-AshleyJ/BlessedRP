<?php	
    // Website Name
    $name = "RevolutionRP";

    // Description
    $desc = "Realistic FiveM Roleplay Community";

    // Discord Server ID
    $serverid = "927172883506143272";

    // FiveM Connect Link
    $fivem = "https://cfx.re/join/ej85yp";

    // Discord Invite
    $discord = "https://discord.gg/hGVS4hFnXA";
    
    // Theme (light or dark)
    $theme = "dark";

    // Domain (with trailing slash)
    $domain = "http://139.162.255.236/thecityofrevolutionrp.com/public_html/";

    // Discord Domain
    $discordomain = "https://discord.gg/dyusG7Gcqq";

    // Color (hex)
    $color = "#cc0000";

    // Logo (must be an image ".png, .jpg, .gif, etc")
    $logo = $domain."assets/img/logo.png";

    // About Page
    
    $about = "The Number 1 growing FiveM RP UK based City out there.. why? </br> </br> Here's a breakdown: </br> </br> &#8226; Ton's of active, experienced, professional and friendly Government members that make this city run beautifully. </br> &#8226; Brilliant selection of custom vehicles, outfits, map additions! </br> &#8226; Tons of customisable cars! </br> &#8226; Bunch of whitelisted and non-whitelist jobs! From garbage works to Junkyard bosses, to Lawyers to Custom Tuners! </br> &#8226;Professional and active Met Police Force </br> &#8226;3 ACTIVE GANGS that craft and sell weapons to the ones living by Revolution City's roots </br> &#8226; On the job REAL ESTATE! Custom housing ANYWHERE YOU CHOOSE! ... For a price </br> &#8226; Custom Weed, Coke and Meth criminal jobs. From gathering to money washing. We have it all to run your criminal kingdom. </br> &#8226; In-depth dispatch systems and commands for mechanics, EMS and Police! </br> &#8226; Weekly competitions and very frequent giveaways!! </br> &#8226; Custom Black Market NPCs </br> &#8226; Frequent job interviews as we expand! </br> &#8226; 5 new custom heists to sink your teeth into </br> &#8226; Custom Crafting for certain jobs </br> &#8226; Custom Chat commands </br> &#8226; UK Based Economy Speed Cameras (50mph residential / city roads & 70mph Motorways!) </br> &#8226; TONS and TONS more.. our developers are always working hard to add new things for you all to enjoy. </br> </br> So.. I hope that caught your eye.. as our airport staff are waiting for your plane to land with a red carpet rolled out. So why not join the latest Revolution in FiveM and fly into Rev City to set your boots on some of the greatest content around. All players will start with 20k to give you a comfortable start, but the grind is a must in order to claim your wanted titles. </br> We hope to see your flight come through soon. </br> - The Revolution Staff Team";

    // Status Page
    $servers = [
		"QBCore Server" => [
			"IP" => "142.132.213.133",
			"port" => "25567"
		]
	];

    // Gallery
    $gallery = [
		"",
		"",
        ""
	];

    // Navbar Links

    $link1label = "About";
    $link1href = $domain."about";

    $link2label = "Apply";
    $link2href = $domain."apply";

    $link3label = "Status";
    $link3href = $domain."status";

    $link4label = "Gallery";
    $link4href = $domain."gallery";

    $link5label = "Store";
    $link5href = "https://revolutionrpuk.tebex.io/";

    // Navbar Array
    $linkarray = array("link1" => "$link1label#$link1href", "link2" => "$link2label#$link2href", "link3" => "$link3label#$link3href", /*"link4" => "$link4label#$link4href",*/ "link5" => "$link5label#$link5href");

    // Text Color
    if ($theme == "light"){
        $txtcolor = "dark";
    } else if ($theme == "dark") {
        $txtcolor = "light";
    }

    // Discord Member Count
    $link = file_get_contents('https://discordapp.com/api/guilds/'.$serverid.'/widget.json');
    $JSON = json_decode($link, true);
    $members = $JSON['presence_count'];
?>
