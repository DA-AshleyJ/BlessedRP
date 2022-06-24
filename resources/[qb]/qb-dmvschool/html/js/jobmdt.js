var timeout;

var firstname;
var lastname;
var identifier;
var application = null;
var applicationcid = null;
var applicationtype = null;
var laoded = false;
var applications = [];
var applistatus = "";
var users;
var notifThread = null;
var notifThread2 = null;
var LicenseType = {
    ["drive"]: "Car Driving License",
    ["drive_bike"]: "Bike Driving License",
    ["drive_truck"]: "Truck Driving License"

}


Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;

    return [year, month, day].join('-');
}

function hideEvery() {
    $("#applications").hide();
}


function closeMenu() {
    $.post('https://qb-dmvschool/closem', JSON.stringify({}));


    $("#main_container").hide();


}

$(document).keyup(function(e) {
    if (e.keyCode === 27) {
        closeMenu();
    }
});

function playClickSound() {
    var audio = document.getElementById("clickaudio");
    audio.volume = 0.05;
    audio.play();
}


function search(t, field) {

    var text = t.value.toLowerCase();
    $("." + field).html('');

    if (field == 'applications') {

        var limit = 0;

        for (const [key, value] of Object.entries(applications)) {

            var val = JSON.stringify(value).toLowerCase();

            if (val.match(text) != null && limit < 50) {


         
                var imgurl = "img/"+value.type+".png"

                var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openApplication(\'' + key + '\')" id="' + key + '"><!-- group -->' +
                    '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                    '       <div class="grpelem" id="u708" style="background: url('+imgurl+'); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                    '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
                    '        <p>' + users[value.citizenid].name + '</p>' +
                    '       </div>' +
                    '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
                    '        <p>' + LicenseType[value.type] + '</p>' +
                    '       </div>' +
                    '      </div>';

                $("." + field).append(base)
                limit = limit + 1;
            }
        }
    }
}



function saveApplication() {
    $('#dashboard').remove();
    if ($('#u2029').prop("checked")) {
        date = 'never';
    } else {
        date = $('#u2026').val();
    }
    if (date == "") {
        date = 'never';
    }
    playClickSound();
    sendNotification('Status Changed!')

    $.post('https://qb-dmvschool/updatestatus', JSON.stringify({
        id: application,
        status: applistatus,
        cid: applicationcid,
        type: applicationtype,
    }));
    laoded = false;
    $("#applications").remove();


}

function openApplication(id) {
    
    playClickSound();
    var current = applications[id];
    application = id;
    applicationcid = current.citizenid
    applicationtype = current.type
    openApplications();

    var charinfo = JSON.parse(users[current.citizenid].charinfo)
    var dob = charinfo.birthdate;
    dob = dob.replaceAll('/', '-');
    var date = new Date(current.created * 1000);

    $("#u1287-4").text(users[current.citizenid].name);
    $("#u1290-4").text(`Type: `+LicenseType[current.type]);
    $('#u1291-4').text(`Time: ` + timeSince(date) + ` Ago`);
    $('#u1291-5').text(`Mistakes: ` + current.mistakes);
    $("#dob").val(dob);
    $("#u1883").val(id);
    $("#phone").val(charinfo.phone);
    $("#height").val(Math.floor(Math.random() * 165));
    $('#u1877').val(users[current.citizenid].name.toUpperCase());
    $('#u1883').val(LicenseType[current.type]);
    $('#u1522-4').text('Application #' + application);
    // $("#u1284").attr("src","img/drive.png");
    $("#u1883").prop("readonly", true);
    document.getElementById("u1284").style.backgroundImage ="url('img/"+current.type+".png')";



    if (current.expire == 'never') {
        $('#u2026').val("");
        $('#u2029').prop("checked", true);
    } else {
        $('#u2026').val(formatDate(current.expire));
        $('#u2029').prop("checked", false);
    }

    $('#pu1999').css(' border-style', 'solid');
    $('#pu1999').css('border-width', '0px');
    $('#pu1999').css('border-color', '#FFFFFF');


    $('#pu1990').css(' border-style', 'solid');
    $('#pu1990').css('border-width', '0px');
    $('#pu1990').css('border-color', '#FFFFFF');

    $('#pu1966').css(' border-style', 'solid');
    $('#pu1966').css('border-width', '0px');
    $('#pu1966').css('border-color', '#FFFFFF');

    $('#u2011').css(' border-style', 'solid');
    $('#u2011').css('border-width', '0px');
    $('#u2011').css('border-color', '#FFFFFF');


    $('#u2017').css(' border-style', 'solid');
    $('#u2017').css('border-width', '0px');
    $('#u2017').css('border-color', '#FFFFFF');
}

function selectapplistatus(t, status) {


    $('#u2011').css(' border-style', 'solid');
    $('#u2011').css('border-width', '0px');
    $('#u2011').css('border-color', '#FFFFFF');


    $('#u2017').css(' border-style', 'solid');
    $('#u2017').css('border-width', '0px');
    $('#u2017').css('border-color', '#FFFFFF');

    $(t).css(' border-style', 'solid');
    $(t).css('border-width', '3px');
    $(t).css('border-color', '#FFFFFF');

    if (status == 'ongoing') {
        applistatus = true;
    } else {
        applistatus = false;
    }



}

function openApplications() {

    playClickSound();
    hideEvery();
    if ($("#applications").length) {

        $("#applications").show();

        return;
    }
    var base = '<div class="clearfix colelem slide-right" id="applications"><!-- group -->' +
        '    <div class="clearfix grpelem" id="pu1492-4"><!-- column -->' +
        '     <div class="clearfix colelem" id="u1492-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '      <p>Applications</p>' +
        '     </div>' +
        '     <input class="clearfix spacing colelem" onInput="search(this, \'applications\')" id="u1493"><!-- group -->' +
        '      <div class="grpelem" id="u1494" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
        '     </input>' +
        '     <div class="clearfix colelem applications" id="u1495"><!-- column -->';

        
    //Applications

    var limit = 0

    for (const [key, value] of Object.entries(applications)) {
        console.log(value.citizenid)
        if (limit < 20) {
            var imgurl = "img/"+value.type+".png"
            base = base + '      <div class="clearfix colelem box scale-up-center incident" onclick="openApplication(\'' + key + '\')" id="' + key + '"><!-- group -->' +
                '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                '       <div class="grpelem" id="u708" style="background: url('+imgurl+'); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
                '        <p>' + users[value.citizenid].name.toUpperCase() + '</p>' +
                '       </div>' +
                '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
                '        <p>' + LicenseType[value.type] + '</p>' +
                '       </div>' +

                '      </div>';

            limit = limit + 1;
        }


    }


    base = base + '     </div>' +
        '    </div>' +
        '    <div class="clearfix grpelem" id="ppu1284"><!-- column -->' +
        '     <div class="clearfix colelem" id="pu1284"><!-- group -->' +
        '      <div class="grpelem" style="background: url(img/placeholder.png); background-size: cover;" id="u1284" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '      <div class="clearfix grpelem" id="pu1287-4"><!-- column -->' +
        '       <div class="clearfix colelem" id="u1287-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>-</p>' +
        '       </div>' +
        '       <div class="clearfix colelem" id="u1290-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>-</p>' +
        '       </div>' +
        '       <div class="clearfix colelem" id="u1291-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>-</p>' +
        '       </div>' +
        '       <div class="clearfix colelem" id="u1291-5" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>-</p>' +
        '       </div>' +
        '      </div>' +
        '     </div>' +

        '     <div class="clearfix colelem" id="u836-5" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '      <p>BirthDay</p>' +
        '     </div>' +
        '     <input class="colelem" type="date" readonly="readonly" id="dob" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +

        '     <div class="clearfix colelem" id="u836-7" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '      <p>Phone</p>' +
        '     </div>' +
        '     <input class="colelem" id="phone" readonly="readonly" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
        '    </div>' +
        '    <div class="clearfix grpelem" id="pu1960-4"><!-- column -->' +
     
        '     <div class="clearfix colelem" id="u2008-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '      <p>Status</p>' +
        '     </div>' +
        '     <div class="clearfix colelem" id="ppu2017"><!-- group -->' +
        '      <div class="clearfix grpelem" id="pu2017"><!-- group -->' +
        '       <div class="grpelem" id="u2017" onclick="selectapplistatus(this, \'resolved\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u2018-4" onclick="selectapplistatus(\'#u2017\', \'resolved\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>Reject</p>' +
        '       </div>' +
        '      </div>' +
        '      <div class="grpelem" id="u2011" onclick="selectapplistatus(this, \'ongoing\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '      <div class="clearfix grpelem" id="u2012-4" onclick="selectapplistatus(\'#u2011\', \'ongoing\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>Accept</p>' +
        '      </div>' +
        '     </div>' +
        '      <div class="grpelem" id="u2016" onclick="saveApplication()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '      <div class="clearfix grpelem" id="u2016-4" onclick="saveApplication()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>Process Application</p>' +
        '      </div>' +
        '     </div>' +
        '     <div class="clearfix colelem" id="pu2029"><!-- group -->' +
        '     </div>' +
        '    </div>' +
        '   </div>';



    $('#u552').append(base);

}


function sendNotification(text) {

    if ($('#notification').length) {
        clearTimeout(notifThread);
        clearTimeout(notifThread2);
        $('#notification').remove();
    }


    var base = '<div id="notification" class=" slide-left ">' +
        '<div id="notification-image" style=" background: url(img/notification.png); background-size: cover;"></div>' +
        '<div id="notification-label">Notification</div>' +
        '<div id="notification-text">' + text + '</div>' +
        '<div>';

    $('#u462').append(base);

    var audio = document.getElementById("notificationSound");
    audio.volume = 0.01;
    audio.play();

    notifThread = setTimeout(function() {

        $('#notification').fadeOut();
        notifThread2 = setTimeout(function() {
            $('#notification').remove();
        }, 2000);

    }, 5000);


}

function openMDW() {
    var url = users[identifier].mdw_image;
    if (url == null || url == '') {
        url = "img/placeholder.png"
    }
    var base = '<div class="clearfix borderbox slide-top" id="page"><!-- group -->' +
        '   <div class="grpelem" id="u462" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
        '   <div class="grpelem" id="u468" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- simple frame --></div>' +
        '   <div class="shadow grpelem" id="u472" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
        '   <div class="clearfix grpelem" id="u475-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
        '    <p>DMV OFFICER</p>' +
        '   </div>' +
        '   <div class="clearfix grpelem" id="u478-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
        '    <p>' + users[identifier].name.toUpperCase() + '</p>' +
        '   </div>' +
        '   <div class="grpelem" id="u1615"><!-- rasterized frame --></div>' +
        
        '   <div class="grpelem" id="u552" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +


        '   <div class="clearfix grpelem" id="u1629-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
        '    <p>Department of Motor Vehicles</p>' +
        '   </div>' +
        '  </div>';


    $('#main_container').html(base);
    //SCREEN SIZE CALC
    var scale = screen.width / 1920;
    if (scale > 1) {
        scale = 1;
    }
    $("#main_container").css("scale", scale.toString());
}


window.addEventListener('message', function(event) {
    var edata = event.data;
    if (edata.type == "update") {
        applications = edata.applications;
        if (!laoded) {
            console.log("SSS")
            openApplications();
            laoded = true;
        }
    }

    if (edata.type == "open") {
        users = edata.users;
        identifier = edata.identifier;
        if (users[identifier] == null) {
            console.log('[CORE MDW] Users not fully loaded!');
            return;
        }

        if ($("#main_container").is(":hidden")) {
            $("#main_container").show();
        } else {
            openMDW();
        }
    }
});

function timeSince(date) {

    var seconds = Math.floor((new Date() - date) / 1000);

    var interval = seconds / 31536000;

    if (interval > 1) {
        return Math.floor(interval) + " yrs";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
        return Math.floor(interval) + " months";
    }
    interval = seconds / 86400;
    if (interval > 1) {
        return Math.floor(interval) + " days";
    }
    interval = seconds / 3600;
    if (interval > 1) {
        return Math.floor(interval) + " hours";
    }
    interval = seconds / 60;
    if (interval > 1) {
        return Math.floor(interval) + " min";
    }
    return Math.floor(seconds) + " sec";
}
