var timeout;

var firstname;
var lastname;
var job;
var grade;
var citizenid;
  
var vehColors;

var updated = true;

var announcements = [];

var profile = null;
var staffprofile = null;
var report = null;

var activeWarrants = [];

var impounded = false;
var profileVehicles = [];

var charges;
var chargesPerson;
var chargeJail = 0;
var chargeFine = 0;

var laoded = false;

var evidence = [];
var openedEvidence = null;

var incidents = [];
var incident;
var addingField;

var reports = [];
var reportBroadcast = "";
var reportStatus = "";

var departaments = [];
var badges = [];

var warrantending = 48;

var users;

var permissions = [];
var staffperms = [];

var notifThread = null;
var notifThread2 = null;



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
  $("#incidents").hide();
  $("#staff").hide();
  $("#dashboard").hide();
  $("#evidence").hide();
  $("#reports").hide();
  $("#profiles").hide();
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

function closeMenu() {
  $.post('https://core_mdw/close', JSON.stringify({}));


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


function searchSQL(text, field) {

  $.post('https://core_mdw/searchSQL', JSON.stringify({
    text: text,
    field: field
  }));

}


function updateUsers(updatingUsers) {


  if (updated && updatingUsers.length > 0) {
    showLoader(true);
    updated = false;

    $.post('https://core_mdw/updateUsers', JSON.stringify({
      users: updatingUsers
    }));
  }


}

function search(t, field) {

  var text = t.value.toLowerCase();


  $("." + field).html('');

  if (field == 'incidents') {

    var limit = 0;

    for (const [key, value] of Object.entries(incidents)) {

      var val = JSON.stringify(value).toLowerCase();

      if (val.match(text) != null && limit < 50) {




        var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openIncident(\'' + key + '\')" id="' + key + '"><!-- group -->' +
          '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" id="u708" style="background: url(img/incident.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + value.title + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + value.description + '</p>' +
          '       </div>' +
          '      </div>';

        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }

  if (field == 'reports') {

    var limit = 0;

    for (const [key, value] of Object.entries(reports)) {

      var val = JSON.stringify(value).toLowerCase();

      if (val.match(text) != null && limit < 50) {




        var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openReport(\'' + key + '\')" id="' + key + '"><!-- group -->' +
          '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" id="u708" style="background: url(img/report.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + value.title + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + value.description + '</p>' +
          '       </div>' +
          '      </div>';

        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }

  if (field == 'addevidence') {

    var limit = 0;

    for (const [key, value] of Object.entries(evidence)) {

      value.id = '#' + key;
      var val = JSON.stringify(value).toLowerCase();

      if (val.match(text) != null && limit < 50) {




        var desc = "";
        if (value.type == 'ecosystem') {
          desc = "Evidence Locker";
        } else {
          desc = "Photo Evidence";
        }

        var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="chooseToAdd(\'' + key + '\')" id="' + key + '"><!-- group -->' +
          '       <div class="grpelem" id="u707"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" id="u708" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>#' + key + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + desc + '</p>' +
          '       </div>' +
          '      </div>';

        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }

  if (field == 'evidence') {

    var limit = 0;

    for (const [key, value] of Object.entries(evidence)) {

      value.id = '#' + key;
      var val = JSON.stringify(value).toLowerCase();

      if (val.match(text) != null && limit < 50) {




        var desc = "";
        if (value.type == 'ecosystem') {
          desc = "Evidence Locker";
        } else {
          desc = "Photo Evidence";
        }

        var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openEvidence(\'' + key + '\')" id="' + key + '"><!-- group -->' +
          '       <div class="grpelem" id="u707"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" id="u708" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>#' + key + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + desc + '</p>' +
          '       </div>' +
          '      </div>';

        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }

  if (field == 'charges') {


    for (const [key, value] of Object.entries(charges)) {

      var val = JSON.stringify(value).toLowerCase();

      if (val.match(text) != null) {

        var base = '     <div class="clearfix grpelem box scale-up-center charge" onclick="selectCharge(this,\'' + key + '\')" id="' + key + '"><!-- group -->' +
          '      <div class="grpelem" id="u1168" style="background-color: ' + value.color + ';" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '      <div class="clearfix grpelem" id="u1171-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p>' + value.label + '</p>' +
          '      </div>' +
          '      <div class="clearfix grpelem" id="u1174-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p>' + value.jail + ' MONTHS</p>' +
          '      </div>' +
          '      <div class="clearfix grpelem" id="u1177-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p>$' + value.fine + '</p>' +
          '      </div>' +
          '     </div>';

        $("." + field).append(base)

        if (incidents[incident].crims[chargesPerson].charges[key]) {

          $("#" + key).css('border-style', 'solid');
          $("#" + key).css('border-width', '4px');
          $("#" + key).css('border-color', '#FFFFFF');

        }



      }
    }
  }

  if (field == 'users') {

    searchSQL(text, 'users')
  }


  if (field == 'profiles') {

    searchSQL(text, 'profiles');

  }

  if (field == 'warrants') {

    var limit = 0;

    for (const [key, value] of Object.entries(activeWarrants)) {

      var val = JSON.stringify(value).toLowerCase();


      if (val.match(text) != null && limit < 50) {

        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }

        var base = '      <div class="clearfix colelem scale-up-center box" onclick="openProfile(\'' + key + '\')" id="pu707"><!-- group -->' +
          '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" style="background: url(' + url + '); background-size: cover;" id="u708" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + users[key].name + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>WARRANT EXPIRES IN ' + value.hours + ' HOURS</p>' +
          '       </div>' +
          '      </div>';


        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }

  if (field == 'staff') {

    var limit = 0;

    for (const [key, value] of Object.entries(users)) {

      for (const [key2, value2] of Object.entries(value.jobs)) {

        for (const [key3, value3] of Object.entries(departaments)) {

          if (key2 == key3) {

            var val = JSON.stringify(value).toLowerCase();


            if (val.match(text) != null && limit < 50) {

              var url = users[key].mdw_image;
              if (url == null || url == '') {
                url = "img/placeholder.png"
              }

              var base = base = '      <div class="clearfix colelem box scale-up-center user" onclick="openStaffProfile(\'' + key + '\', \'' + key3 + '\')" id="' + key.replace(":", "-") + '""><!-- group -->' +
                '       <div class="grpelem" id="u1258" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                '       <div class="grpelem" id="u1259" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
                '       <div class="clearfix grpelem" id="u1260-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
                '        <p>' + value.firstname + ' ' + value.lastname + '</p>' +
                '       </div>' +
                '      </div>';


              $("." + field).append(base)
              limit = limit + 1;
            }


          }

        }

      }


    }
  }


  if (field == 'badges') {

    var limit = 0;

    for (const [key, value] of Object.entries(badges)) {

      var val = JSON.stringify(value).toLowerCase();


      if (val.match(text) != null && limit < 50) {



        var base = '      <div class="grpelem scale-up-center" id="u2279" onclick="selectBadge(\'' + key + '\')" style="background: rgba(66, 66, 66, 1.0) url(img/badges/' + key + '.png); background-size: cover;"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><div id="badgeInfo" class="scale-up-center">' + value + '</div></div>';


        $("." + field).append(base)
        limit = limit + 1;
      }
    }
  }




}

function fillSQLSearch(results, field) {



  $("." + field).html("");



  if (field == 'profiles') {



    for (const [key, value] of Object.entries(results)) {

      var url = value.mdw_image;
      if (url == null || url == '') {
        url = "img/placeholder.png"
      }



      var base = '      <div class="clearfix colelem box scale-up-center user" onclick="openProfile(\'' + value.citizenid + '\')" id="' + value.citizenid.replace(":", "-") + '""><!-- group -->' +
        '       <div class="grpelem" id="u1258" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u1259" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u1260-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.firstname + ' ' + value.lastname + '</p>' +
        '       </div>' +
        '      </div>';


      $("." + field).append(base)


    }

  }

  if (field == 'users') {


    for (const [key, value] of Object.entries(results)) {



      var url = value.mdw_image;
      if (url == null || url == '') {
        url = "img/placeholder.png"
      }

      var base = '      <div class="clearfix colelem box scale-up-center user" onclick="chooseToAdd(\'' + value.citizenid + '\')" id="' + value.citizenid.replace(":", "-") + '""><!-- group -->' +
        '       <div class="grpelem" id="u1258" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u1259" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u1260-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.firstname + ' ' + value.lastname + '</p>' +
        '       </div>' +
        '      </div>';


      $("." + field).append(base)

    }

  }


}

//STAFF


function clickPermission(perm) {


  if (permissions['administrator']) {
    if (staffperms[perm]) {
      $("." + perm).css('border-style', 'solid');
      $("." + perm).css('border-width', '0px');
      $("." + perm).css('border-color', '#FFFFFF');
      $("." + perm).css('box-sizing', 'border-box');


      staffperms[perm] = false;
    } else {
      $("." + perm).css('border-style', 'solid');
      $("." + perm).css('border-width', '4px');
      $("." + perm).css('border-color', '#FFFFFF');
      $("." + perm).css('box-sizing', 'border-box');
      staffperms[perm] = true;
    }
  }

}

function setPermission(perm, value) {


  if (value) {
    $("." + perm).css('border-style', 'solid');
    $("." + perm).css('border-width', '4px');
    $("." + perm).css('border-color', '#FFFFFF');
    $("." + perm).css('box-sizing', 'border-box');


  } else {


    $("." + perm).css('border-style', 'solid');
    $("." + perm).css('border-width', '0px');
    $("." + perm).css('border-color', '#FFFFFF');
    $("." + perm).css('box-sizing', 'border-box');


  }




}


function saveVehicle(k) {

 if (checkPerms('editincident')) {

var image = $("#u2509").val();


$.post('https://core_mdw/saveVehicle', JSON.stringify({
      impounded: impounded,
      plate: k,
      image: image,
      owner: profile
    }));


profileVehicles[k].impounded = impounded;
profileVehicles[k].mdw_image = image;

 

 if(image != '') {
    $("#u2494").css("background", "url(" + image + ")");
 } else {
    $("#u2494").css("background", "url(img/vehicle.png)");
 }
 $("#u2494").css("background-size", "cover");

 sendNotification('Vehicle saved!');

}

}

function impoundVehicle() {

  if (checkPerms('editincident')) {

    if ($('#u2521').css('border-width') == "0px") {
          $('#u2521').css('border-width', "3px");
          impounded = true;
    } else {
           $('#u2521').css('border-width', "0px");
           impounded = false;
    }

  }

}

function openVehicleInfo(k) {

var v = profileVehicles[k];
var insurance = "-";



impounded = v.impounded;


if (v.insurance != null) {

    insurance = v.insurance;

}

var base = '<div class="clearfix borderbox slide-right" id="vehicleInfo"><!-- group -->'+
'   <div class="grpelem" id="u2413" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>'+
'   <div class="clearfix grpelem" id="u2414-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>VEHICLE INFORMATION</p>'+
'   </div>'+
'   <div class="grpelem box" onclick="closeVehicleInfo()" id="u2488" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><i class="fas fa-times fa-lg"></i></div>'+
'   <div class="grpelem box" id="u2491" onclick="saveVehicle(\''+k+'\')" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --><i class="far fa-save fa-lg"></i></div>'+
'   <div class="grpelem" id="u2494" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>'+
'   <div class="clearfix grpelem" id="u2497-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>'+v.plate+'</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2500-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>LICENSE PLATE</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2503-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>'+users[profile].firstname + ' ' + users[profile].lastname+'</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2504-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>OWNER</p>'+
'   </div>' +
'   <input class="grpelem spacing" id="u2509" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"></input>'+
'   <div class="grpelem" id="u2510" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><i class="fas fa-image"></i></div>'+
'   <div class="clearfix grpelem" id="u2515-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>'+insurance.toUpperCase()+'</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2516-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>INSURANCE PLAN</p>'+
'   </div>'+
'   <div class="grpelem" id="u2521" onclick="impoundVehicle()" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>'+
'   <div class="clearfix grpelem" onclick="impoundVehicle()" id="u2522-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>IMPOUND</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2645-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>'+vehColors[JSON.parse(v.mods)["color1"]]+'</p>'+
'   </div>'+
'   <div class="clearfix grpelem" id="u2646-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->'+
'    <p>COLOR</p>'+
'   </div>'+
'  </div>';




$("#profiles").append(base);  



if(v.mdw_image != '') {
    $("#u2494").css("background", "url(" + v.mdw_image + ")");
 } else {
     $("#u2494").css("background", "url(img/vehicle.png)");
 }
 $("#u2494").css("background-size", "cover");

$("#u2509").val(v.mdw_image);

  if (v.impounded) {
          $('#u2521').css('border-width', "3px");
          impounded = true;
    } else {
           $('#u2521').css('border-width', "0px");
           impounded = false;
    }


}

function openStaffProfile(k, departament) {

  updatingUsers = [k]
  updateUsers(updatingUsers)
  playClickSound();

  loadStaffProfile(k, departament)

}

function loadStaffProfile(k, departament) {

  if (!updated) {
    setTimeout(function() {
      loadStaffProfile(k, departament)
    }, 50)
  } else {



    var current = users[k];
    staffprofile = k;

    staffperms = current.permissions;



    for (const [key, value] of Object.entries(staffperms)) {
      setPermission(key, value);
    }


    $("#u1697-4").text(current.firstname);
    $("#u1698-4").text(current.lastname);

    $("#u1294").val(current.mdw_image);
    $("#u1832").val(departaments[departament].label);
    $("#u1845").val(current.jobs[departament].gradeLabel);
    $("#u1851").val(current.mdw_alias);

    if (current.mdw_image != null && current.mdw_image != '') {

      $("#u1696").css("background", "url(" + current.mdw_image + ")");

    } else {
      $("#u1696").css("background", "url(img/placeholder.png)");
    }

    $("#u1696").css("background-size", "cover");



    $('#u2276').html('');

    for (const [key, value] of Object.entries(badges)) {

      if (current.badges[key]) {

        var badge = '      <div class="grpelem slide-top2" onclick="removeBadge(this, \'' + key + '\')" id="u2279" style="background: rgba(66, 66, 66, 1.0) url(img/badges/' + key + '.png); background-size: cover;"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><div id="badgeInfo" class="scale-up-center">' + value + '</div></div>';

        $('#u2276').append(badge);

      }

    }


    //PERMISSIONS
  }
}

//PROFILES

function revokeLicense(t, license) {

  if (checkPerms('revokelicense')) {

    $.post('https://core_mdw/revokeLicense', JSON.stringify({
      person: profile,
      license: license
    }));
    $(t).parent().remove();
    users[profile].licenses[license] = null;

  }




}

function saveProfile() {

  if (checkPerms('editprofile') && profile != null) {

    sendNotification('Profile saved!');


    playClickSound();

    var desc = $("#u1299").val();
    var picture = $("#u1293").val();

    users[profile].mdw_image = picture;
    users[profile].mdw_description = desc;

    $.post('https://core_mdw/updateProfile', JSON.stringify({
      person: profile,
      description: desc,
      picture: picture
    }));

    if (picture != null && picture != '') {

      $("#u1284").css("background", "url(" + picture + ")");
      $('#' + profile.replace(":", "-")).find('#u1259').css("background", "url(" + picture + ")");

    } else {
      $("#u1284").css("background", "url(img/placeholder.png)");
      $('#' + profile.replace(":", "-")).find('#u1259').css("background", "url(img/placeholder.png)");
    }

    $("#u1284").css("background-size", "cover");
    $('#' + profile.replace(":", "-")).find('#u1259').css("background-size", "cover");




    if (citizenid == profile) {

      $("#u465").css("background", "url(" + picture + ")");
      $("#u465").css("background-size", "cover");
    }
  }


}

function setHouseWaypoint(property) {


  $.post('https://core_mdw/setHouseWaypoint', JSON.stringify({
    waypoint: users[profile].housing[property].entering
  }));
}

function openProfile(k) {

  openProfiles();

  updatingUsers = [k];
  updateUsers(updatingUsers);

  loadProfile(k);

}


function loadProfile(k) {


  if (!updated) {

    setTimeout(function() {
      loadProfile(k);
    }, 50)
  } else {



    var current = users[k];
    profile = k;




    $("#u1287-4").text(current.firstname);
    $("#u1290-4").text(current.lastname);
    $("#dob").val(current.dateofbirth);
    $("#phone").val(current.phone_number);
    $("#height").val(current.nationality);
    $("#u1299").val(current.mdw_description);

    $("#u1293").val(current.mdw_image);

    if (current.mdw_image != null && current.mdw_image != '') {

      $("#u1284").css("background", "url(" + current.mdw_image + ")");

    } else {
      $("#u1284").css("background", "url(img/placeholder.png)");
    }

    $("#u1284").css("background-size", "cover");

    $('#u1303').html('');
    $('#u1407').html('');
    $('#u1416').html('');
    $('#u1434').html('');
    $('#u1425').html('');

    $('#userStatus').html('');
    if (current.jail != null) {
      if (current.jail > 0) {
        $('#userStatus').append('<div id="status"><i class="fas fa-user-lock"></i></div>')
      }
    }

    if (current.online == true) {

      $('#userStatus').append('<div id="status"><i class="fas fa-signal"></i></div>')

    }

    if (activeWarrants[profile]) {
      if (activeWarrants[profile].hours > 0) {
        $('#userStatus').append('<div id="status"><i class="fas fa-file-word"></i><div id="statusTooltip" class="slide-right">' + activeWarrants[profile].hours + ' HOURS LEFT</div></div>')
      }
    }



    for (const [key, value] of Object.entries(current.jobs)) {


      var jobs = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p id="u1418-2">' + value.label + '</p>' +
        '      <div class="grpelem" id="u1823" onclick="openJobInfo(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-eye"></i></div>' +
        '      </div>';

      $('#u1303').append(jobs);

    }

      profileVehicles = {};
    for (const [key, value] of Object.entries(current.vehicles)) {
        profileVehicles[key] = value;

      var vehicles = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p id="u1418-2">' + value.label + '</p>' +
        '      <div class="grpelem" id="u1823" onclick="openVehicleInfo(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-eye"></i></div>' +
        '      </div>';

      $('#u1407').append(vehicles);

    }

    for (const [key, value] of Object.entries(current.housing)) {



      var housing = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p id="u1418-2">' + value.label + '</p>' +
        '      <div class="grpelem" id="u1823" onclick="setHouseWaypoint(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-location-arrow"></i></div>' +
        '      </div>';



      $('#u1416').append(housing);

    }

    for (const [key, value] of Object.entries(current.licenses)) {

      if (value == null) {
        return;
      }

      var licenses = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p id="u1418-2">' + value.toUpperCase() + '</p>' +
        '      <div class="grpelem" id="u1823" onclick="revokeLicense(this, \'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-unlink"></i></div>' +
        '      </div>';

      $('#u1425').append(licenses);

    }

    for (const [key, value] of Object.entries(incidents)) {

      if (value.crims[k] != null) {
        var priors = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p id="u1418-2">#' + key + ' - ' + value.title + '</p>' +
          '      <div class="grpelem" id="u1823" onclick="openIncident(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-eye"></i></div>' +
          '      </div>';

        $('#u1434').append(priors);
      } else if (value.spectators[k] != null) {
        var priors = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p id="u1418-2">#' + key + ' - ' + value.title + '</p>' +
          '      <div class="grpelem" id="u1823" onclick="openIncident(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-eye"></i></div>' +
          '      </div>';

        $('#u1434').append(priors);
      } else if (value.officers[k] != null) {
        var priors = '      <div class="clearfix slide-right grpelem" id="u1418-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '       <p id="u1418-2">#' + key + ' - ' + value.title + '</p>' +
          '      <div class="grpelem" id="u1823" onclick="openIncident(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i style="margin-top: 8px;" class="fas fa-eye"></i></div>' +
          '      </div>';

        $('#u1434').append(priors);
      }



    }


  }
}


//INCIDENTS

function chooseToAdd(k) {

if (addingField != 'evidence') {
 updatingUsers = [k];
  updateUsers(updatingUsers);
}


  loadChosen(k);


}

function loadChosen(k) {

  if (!updated) {
    setTimeout(function() {
      loadChosen(k);
    }, 50)
  } else {



    playClickSound();

    if (addingField == 'evidence') {
      $.post('https://core_mdw/addToIncidentEvidence', JSON.stringify({
        incident: incident,
        field: addingField,
        id: k,
        incidents: incidents
      }));
    } else {
      $.post('https://core_mdw/addToIncident', JSON.stringify({
        incident: incident,
        field: addingField,
        citizenid: k,
        firstname: users[k].firstname,
        lastname: users[k].lastname,
        incidents: incidents
      }));
    }



    if (addingField == "crims") {

      var url = users[k].mdw_image;
      if (url == null || url == '') {
        url = "img/placeholder.png"
      }

      var crims = '       <div class="clearfix colelem slide-right crims" id="crims-' + k.replace(":", "-") + '"><!-- group -->' +
        '        <div class="grpelem" id="u929" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '        <div class="clearfix grpelem" id="u930-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '         <p>' + users[k].firstname + ' ' + users[k].lastname + '</p>' +
        '        </div>' +
        '        <div class="grpelem" id="u931"  onclick="deleteFromIncident(\'crims\', \'' + k + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u932" onclick="openCharges(\'' + k + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-edit" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u1072" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       </div>';

      $('#u869').append(crims)
    }
    if (addingField == "officers") {

      var url = users[k].mdw_image;
      if (url == null || url == '') {
        url = "img/placeholder.png"
      }

      var officers = '       <div class="clearfix slide-right colelem officers" id="officers-' + k.replace(":", "-") + '"><!-- group -->' +
        '        <div class="grpelem" id="u1000" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '        <div class="clearfix grpelem" id="u1001-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '         <p>' + users[k].firstname + ' ' + users[k].lastname + '</p>' +
        '        </div>' +
        '        <div class="grpelem" onclick="deleteFromIncident(\'officers\', \'' + k + '\')" id="u1002" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u1075" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       </div>';

      $('#u997').append(officers)

    }
    if (addingField == "spectators") {

      var url = users[k].mdw_image;
      if (url == null || url == '') {
        url = "img/placeholder.png"
      }

      var spec = '       <div class="clearfix slide-right colelem spectator" id="spectators-' + k.replace(":", "-") + '" id="pu1041"><!-- group -->' +
        '        <div class="grpelem" id="u1041" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '        <div class="clearfix grpelem" id="u1042-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '         <p>' + users[k].firstname + ' ' + users[k].lastname + '</p>' +
        '        </div>' +
        '        <div class="grpelem" onclick="deleteFromIncident(\'spectators\', \'' + k + '\')" id="u1043" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u1082" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       </div>';

      $('#u1033').append(spec)

    }

    if (addingField == "evidence") {


      var evid = '       <div class="clearfix colelem slide-right crims" id="evidence-' + k + '"><!-- group -->' +
        '        <div class="grpelem" id="u929" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '        <div class="clearfix grpelem" id="u930-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '         <p>#' + k + '</p>' +
        '        </div>' +
        '        <div class="grpelem" id="u931"  onclick="deleteFromIncident(\'evidence\', \'' + k + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u933" onclick="openEvidence(\'' + k + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-eye" style="margin-top: 10px;"></i></div>' +
        '        <div class="grpelem" id="u1072" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       </div>';

      $('#u1578').append(evid)

    }


    $("#addingusers").remove();
    $("#addingevidence").remove();

  }

}

function createIncident() {

  if (checkPerms('createincident')) {
    if ($('#u830-4').text() == "NEW INCIDENT") {
      incident = getRandomInt(99999).toString();
      $('#u830-4').text('INCIDENT #' + incident);

      $.post('https://core_mdw/createIncident', JSON.stringify({
        incident: incident
      }));

    }
  }



}

function checkPerms(perms) {


  if (permissions[perms] || permissions['administrator']) {

    return true;

  } else {
    sendNotification('No permission!');
    return false;

  }

}

function deleteFromIncident(field, person) {

  if (checkPerms('editincident')) {



    playClickSound();


    $("#" + field + "-" + person.replace(":", "-")).remove();

    if (field == 'crims') {
      incidents[incident].crims[person] = null;
    }
    if (field == 'officers') {
      incidents[incident].officers[person] = null;
    }
    if (field == 'spectators') {
      incidents[incident].spectators[person] = null;
    }
    if (field == 'evidence') {
      incidents[incident].evidence[person] = null;
    }

    saveIncident();

  }
}

function newIncident() {

  if (checkPerms('createincident')) {
    playClickSound();
    incident = null;
    $('#u830-4').text('NEW INCIDENT');
    $('#u833').val('');
    $('#u1774').val('');
    $('#u1871').val('');
    $('#u848').val('');

    $('#u869').html('');
    $('#u997').html('');
    $('#u1033').html('');
    $('#u1578').html('');
  }



}

function openIncident(k) {

  var current = incidents[k];

  openIncidents();

  updatingUsers = [];


  for (const [key, value] of Object.entries(current.crims)) {

    updatingUsers.push(key);

  }


  for (const [key, value] of Object.entries(current.officers)) {

    updatingUsers.push(key);

  }

  for (const [key, value] of Object.entries(current.spectators)) {

    updatingUsers.push(key);

  }

  updateUsers(updatingUsers);

  loadIncident(k);

}

function loadIncident(k) {

  var current = incidents[k];
  if (!updated) {
    setTimeout(function() {
      loadIncident(k);
    }, 300)
  } else {


    if ($('#incidents').length) {

      incident = k
      $('#u833').val(current.title);
      $('#u830-4').text('INCIDENT #' + k);
      $('#u1774').val(current.location);
      $('#u1871').val(current.time);
      $('#u848').val(current.description);


      $('#u869').html('');
      $('#u997').html('');
      $('#u1033').html('');
      $('#u1578').html('');

      for (const [key, value] of Object.entries(current.crims)) {

        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }

        var crims = '       <div class="clearfix colelem slide-right crims" id="crims-' + key.replace(":", "-") + '"><!-- group -->' +
          '        <div class="grpelem" id="u929"    data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '        <div class="clearfix grpelem"  id="u930-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>' + value.name + '</p>' +
          '        </div>' +
          '        <div class="grpelem" id="u931"  onclick="deleteFromIncident(\'crims\', \'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" id="u932" onclick="openCharges(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-edit" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" id="u1072" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       </div>';

        $('#u869').append(crims)

      }


      for (const [key, value] of Object.entries(current.officers)) {

        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }

        var officers = '       <div class="clearfix slide-right colelem officers" id="officers-' + key.replace(":", "-") + '"><!-- group -->' +
          '        <div class="grpelem" id="u1000" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '        <div class="clearfix grpelem" id="u1001-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>' + value.name + '</p>' +
          '        </div>' +
          '        <div class="grpelem" onclick="deleteFromIncident(\'officers\', \'' + key + '\')" id="u1002" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" style="background: url(' + url + '); background-size: cover;" id="u1075" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       </div>';

        $('#u997').append(officers)

      }

      for (const [key, value] of Object.entries(current.spectators)) {

        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }

        var spec = '       <div class="clearfix slide-right colelem spectator" id="spectators-' + key.replace(":", "-") + '" id="pu1041"><!-- group -->' +
          '        <div class="grpelem" id="u1041" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '        <div class="clearfix grpelem" id="u1042-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>' + value.name + '</p>' +
          '        </div>' +
          '        <div class="grpelem" onclick="deleteFromIncident(\'spectators\', \'' + key + '\')" id="u1043" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" style="background: url(' + url + '); background-size: cover;" id="u1082" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       </div>';

        $('#u1033').append(spec)

      }


      for (const [key, value] of Object.entries(current.evidence)) {



        var evidence = '       <div class="clearfix colelem slide-right crims" id="evidence-' + key + '"><!-- group -->' +
          '        <div class="grpelem" id="u929" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '        <div class="clearfix grpelem" id="u930-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>#' + key + '</p>' +
          '        </div>' +
          '        <div class="grpelem" id="u931"  onclick="deleteFromIncident(\'evidence\', \'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-trash-alt" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" id="u933" onclick="openEvidence(\'' + key + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-eye" style="margin-top: 10px;"></i></div>' +
          '        <div class="grpelem" id="u1072" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       </div>';

        $('#u1578').append(evidence)

      }



    }

  }
}

function removeIncident() {

  if (incident != null && checkPerms('deleteincident')) {
    playClickSound();
    sendNotification('Incident removed!');


    incidents[incident] = null;

    $.post('https://core_mdw/removeIncident', JSON.stringify({
      incident: incident
    }));
    $("#" + incident).remove();



    newIncident();
  }

}

function saveStaffProfile() {

  if (checkPerms('administrator') && staffprofile != null) {

    sendNotification('Profile saved!');


    playClickSound();

    var alias = $("#u1851").val();
    var picture = $("#u1294").val();

    users[staffprofile].mdw_image = picture;
    users[staffprofile].mdw_alias = alias;
    users[staffprofile].permissions = staffperms;



    $.post('https://core_mdw/saveStaffProfile', JSON.stringify({
      person: staffprofile,
      picture: picture,
      alias: alias,
      permissions: users[staffprofile].permissions,
      badges: users[staffprofile].badges
    }));


    if (picture != null && picture != '') {

      $("#u1696").css("background", "url(" + picture + ")");
      $('#' + staffprofile.replace(":", "-")).find('#u1259').css("background", "url(" + picture + ")");

    } else {
      $("#u1696").css("background", "url(img/placeholder.png)");
      $('#' + staffprofile.replace(":", "-")).find('#u1259').css("background", "url(img/placeholder.png)");
    }

    $("#u1696").css("background-size", "cover");
    $('#' + staffprofile.replace(":", "-")).find('#u1259').css("background-size", "cover");




    if (citizenid == staffprofile) {

      $("#u465").css("background", "url(" + picture + ")");
      $("#u465").css("background-size", "cover");
    }

  }




}

function saveIncident() {

  if (incident != null && checkPerms('editincident')) {

    playClickSound();

    sendNotification('Incident saved!');


    var title = $('#u833').val();
    var location = $('#u1774').val();
    var time = $('#u1871').val();
    var desc = $('#u848').val();

    if (title != '') {


      if (!$("#" + incident).length) {



        var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openIncident(\'' + incident + '\')" id="' + incident + '"><!-- group -->' +
          '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" style="background: url(img/incident.png); background-size: cover;" id="u708" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + title + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + desc + '</p>' +
          '       </div>' +
          '      </div>';

        $("#u803").append(base);



      } else {
        $("#" + incident).find("#u709-4").text(title);
        $("#" + incident).find("#u1895-4").text(desc);
      }




      $.post('https://core_mdw/saveIncident', JSON.stringify({
        title: title,
        location: location,
        time: time,
        incident: incident,
        description: desc,
        crims: incidents[incident].crims,
        officers: incidents[incident].officers,
        spectators: incidents[incident].spectators,
        evidence: incidents[incident].evidence
      }));
    }



  }
}


function addEvidence() {

  if (checkPerms('editincident') && checkPerms('createincident')) {



    playClickSound();

    createIncident();

    var title = $('#u833').val();

    if (title == '') {
      $('#u833').val('UNNAMED');
    }


    addingField = 'evidence';

    var base = '<div class="slide-right" id="addingevidence">' +
      '    <div class="grpelem" id="u1106" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '    <div class="clearfix grpelem" id="u1153-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>EVIDENCE</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem addevidence" id="u1187"><!-- group -->' +
      '    </div>' +

      '    <input class="clearfix spacing grpelem" onInput="search(this, \'addevidence\')" id="u1180"><!-- group -->' +
      '     <div class="grpelem" id="u1181" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
      '    </input>' +


      '<div class="grpelem box" id="u1958" onclick="closeAdding(\'addingevidence\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-times fa-lg"></i></div></div>';




    $('#incidents').append(base);

  }

}

function selectBadge(badge) {

  $('#addingbadge').remove();


  if (users[staffprofile].badges[badge]) {
    sendNotification('Badge already added!');
    return;
  }
  var badgee = '      <div class="grpelem slide-top" onclick="removeBadge(this,\'' + badge + '\')" id="u2279" style="background: rgba(66, 66, 66, 1.0) url(img/badges/' + badge + '.png); background-size: cover;"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><div id="badgeInfo" class="scale-up-center">' + badges[badge] + '</div></div>';

  $('#u2276').append(badgee);

  users[staffprofile].badges[badge] = true;

  saveStaffProfile();




}

function removeBadge(t, badge) {

  users[staffprofile].badges[badge] = false;
  saveStaffProfile();

  $(t).fadeOut();
  setTimeout(function() {
    $(t).remove();
  }, 3000);



}

function addBadge() {

  if (checkPerms('administrator')) {



    playClickSound();




    var base = '<div class="slide-right" id="addingbadge">' +
      '    <div class="grpelem" id="u1106" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '    <div class="clearfix grpelem" id="u1153-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>BADGES</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem badges" id="u1188"><!-- group -->';

    for (const [key, value] of Object.entries(badges)) {


      base = base + '      <div class="grpelem scale-up-center" onclick="selectBadge(\'' + key + '\')" id="u2279" style="background: rgba(66, 66, 66, 1.0) url(img/badges/' + key + '.png); background-size: cover;"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><div id="badgeInfo" class="scale-up-center">' + value + '</div></div>';



    }


    base = base + '    </div>' +

      '    <input class="clearfix spacing grpelem" onInput="search(this, \'badges\')" id="u1180"><!-- group -->' +
      '     <div class="grpelem" id="u1181" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
      '    </input>' +



      '<div class="grpelem box" id="u1958" onclick="closeAdding(\'addingbadge\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-times fa-lg"></i></div></div>';




    $('#staff').append(base);


  }
}

function addToIncident(field) {



  if (checkPerms('createincident') && checkPerms('editincident')) {




    playClickSound();

    createIncident();

    var title = $('#u833').val();

    if (title == '') {
      $('#u833').val('UNNAMED');
    }



    var current = incidents[incident];
    addingField = field;



    var base = '<div class="slide-right" id="addingusers">' +
      '    <div class="grpelem" id="u1106" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '    <div class="clearfix grpelem" id="u1153-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>PROFILES</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem users" id="u1187"><!-- group -->';




    base = base + '    </div>' +

      '    <input class="clearfix spacing grpelem" onInput="search(this, \'users\')" id="u1180"><!-- group -->' +
      '     <div class="grpelem" id="u1181" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
      '    </input>' +



      '<div class="grpelem box" id="u1958" onclick="closeAdding(\'addingusers\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-times fa-lg"></i></div></div>';




    $('#incidents').append(base);


  }
}


function closeAdding(menu) {
  playClickSound();
  $('#' + menu).remove();
}

//CHARGES

function selectCharge(t, charge) {

  if (incidents[incident].crims[chargesPerson].charges[charge]) {
    incidents[incident].crims[chargesPerson].charges[charge] = false;
    $(t).css('border-style', 'solid');
    $(t).css('border-width', '0px');
    $(t).css('border-color', '#FFFFFF');


    if (charges[charge]) {
      chargeJail = chargeJail - charges[charge].jail;
      chargeFine = chargeFine - charges[charge].fine;

      $('#u1793-4').text('$' + chargeFine);
      $('#u1802-4').text(chargeJail + ' MONTHS');
    }

  } else {

    incidents[incident].crims[chargesPerson].charges[charge] = true;

    if (charges[charge]) {
      chargeJail = chargeJail + charges[charge].jail;
      chargeFine = chargeFine + charges[charge].fine;

      $('#u1793-4').text('$' + chargeFine);
      $('#u1802-4').text(chargeJail + ' MONTHS');
    }

    $(t).css('border-style', 'solid');
    $(t).css('border-width', '4px');
    $(t).css('border-color', '#FFFFFF');
  }




}

function closeVehicleInfo() {

  playClickSound();
  $('#vehicleInfo').remove();

}

function closeJobInfo() {

  playClickSound();
  $('#jobinfo').remove();

}

function openJobProfile(k) {

  $('#jobinfo').remove();
  openProfile(k)


}

function openJobInfo(job) {


  var base = '<div class="clearfix colelem slide-right" id="jobinfo"><!-- group -->' +
    '    <div class="grpelem" id="u2554" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
    '    <div class="clearfix grpelem" id="u2555-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
    '     <p>' + users[profile].jobs[job].jobLabel.toUpperCase() + '</p>' +
    '    </div>' +
    '<div class="grpelem box" id="u1958" onclick="closeJobInfo()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-times fa-lg"></i></div>' +
    '    <div class="clearfix grpelem" id="u2569-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
    '     <p>EMPLOYEES</p>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="u2572"><!-- column -->';

  var bossName = "";
  var bossLabel = "";
  var bossUrl = "";


  for (const [key, value] of Object.entries(users)) {

    for (const [key2, value2] of Object.entries(value.jobs)) {

      if (key2 == job) {



        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }

        if (value.jobs[job].gradeName == 'boss') {
          bossName = value.name
          bossLabel = value.jobs[job].gradeLabel + ' - $' + value.jobs[job].gradeSalary
          bossUrl = url
        }

        base = base + '     <div class="clearfix colelem box" onclick="openJobProfile(\'' + key + '\')" id="pu2614"><!-- group -->' +
          '      <div class="grpelem" id="u2614"  data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
          '      <div class="grpelem" id="u2615" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
          '      <div class="clearfix grpelem" id="u2616-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
          '       <p>' + value.name + '</p>' +
          '      </div>' +
          '      <div class="clearfix grpelem" id="u2617-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
          '       <p>' + value.jobs[job].gradeLabel + ' - $' + value.jobs[job].gradeSalary + '</p>' +
          '      </div>' +
          '     </div>';

      }

    }



  }



  base = base + '    </div>' +
    '    <div class="clearfix grpelem" id="u2599-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
    '     <p>BOSS</p>' +
    '    </div>';

  if (bossName != "") {

    base = base + '    <div class="grpelem" id="u2626" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
      '    <div class="grpelem" id="u2627" style="background: url(' + bossUrl + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
      '    <div class="clearfix grpelem" id="u2628-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
      '     <p>' + bossName + '</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem" id="u2629-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
      '     <p>' + bossLabel + '</p>' +
      '    </div>';

  }




  base = base + '    <div class="clearfix grpelem" id="u2638-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
    '     <p>FUNDS</p>' +
    '    </div>' +
    '    <div class="rgba-background clearfix grpelem" id="u2641-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- content -->' +
    '     <p id="u2641-2">$' + users[profile].jobs[job].funds + '</p>' +
    '    </div>' +
    '   </div>';




  $('#profiles').append(base);

}

function saveCharges() {

  var date = $('#u1232').val();
  var check = $('#u1226').prop("checked");

  if (check) {
    incidents[incident].crims[chargesPerson].warrant = date;
  } else {
    incidents[incident].crims[chargesPerson].warrant = '';
  }



  $('#charges').remove();

  saveIncident();

  playClickSound();
}


function openCharges(k) {


  if (checkPerms('editincident')) {
    playClickSound();

    var current = incidents[incident].crims[k];
    chargesPerson = k;

    chargeJail = 0
    chargeFine = 0


    var base = '<div class="slide-right" id="charges">' +
      '    <div class="grpelem" id="u1106" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '    <div class="clearfix grpelem" id="u1153-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>CHARGES</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem charges" id="u1186"><!-- group -->';


    for (const [key, value] of Object.entries(charges)) {

      base = base + '     <div class="clearfix grpelem charge" onclick="selectCharge(this,\'' + key + '\')" id="' + key + '"><!-- group -->' +
        '      <div class="grpelem" id="u1168" style="background-color: ' + value.color + ';" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '      <div class="clearfix grpelem" id="u1171-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>' + value.label + '</p>' +
        '      </div>' +
        '      <div class="clearfix grpelem" id="u1174-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>' + value.jail + ' MONTHS</p>' +
        '      </div>' +
        '      <div class="clearfix grpelem" id="u1177-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>$' + value.fine + '</p>' +
        '      </div>' +
        '     </div>';

    }

    base = base + '    </div>' +

      '    <input class="clearfix spacing grpelem" onInput="search(this, \'charges\')" id="u1180"><!-- group -->' +
      '     <div class="grpelem" id="u1181" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
      '    </input>';

    if (checkPerms('issuewarrant')) {
      base = base + '    <input class="grpelem" type="checkbox" id="u1226" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>';
    } else {
      base = base + '    <input class="grpelem" type="checkbox" id="u1226" disabled="disabled" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>';
    }


    base = base + '    <div class="clearfix grpelem" id="u1229-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>ISSUE A WARRANT</p>' +
      '    </div>' +
      '    <input class="grpelem" type="date" id="u1232" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
      '    <div class="clearfix grpelem" id="u1787-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     <p>FINAL</p>' +
      '    </div>' +
      '    <div class="clearfix grpelem" id="u1793-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     $0' +
      '    </div>' +
      '    <div class="clearfix grpelem" id="u1802-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '     0 MONTHS' +
      '    </div>' +
      '    <div class="grpelem box" id="u1958" onclick="saveCharges()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>';
    if (users[chargesPerson].online) {
      base = base + '    <div class="grpelem box" id="u1959" onclick="sentanceForCharges()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-paper-plane"></i></div>';
    }

    base = base + '</div>';




    $('#incidents').append(base);

    if (current.warrant != '') {



      var now = new Date();
      var date = Date.parse(current.warrant);

      $('#u1232').val(formatDate(date));
      if (date > now) {
        $('#u1226').prop("checked", true);

      }

    }




    for (const [key, value] of Object.entries(current.charges)) {

      if (value) {

        if (charges[key]) {
          chargeJail = chargeJail + charges[key].jail;
          chargeFine = chargeFine + charges[key].fine;
        }


        $("#" + key).css('border-style', 'solid');
        $("#" + key).css('border-width', '4px');
        $("#" + key).css('border-color', '#FFFFFF');
      }

    }

    $('#u1793-4').text('$' + chargeFine);
    $('#u1802-4').text(chargeJail + ' MONTHS');


  }
}


function sentanceForCharges() {

  var chargesLabel = "";

  for (const [key, value] of Object.entries(incidents[incident].crims[chargesPerson].charges)) {

    if (value) {
      chargesLabel = chargesLabel + ", " + charges[key].label;
    }


  }

  chargesLabel = chargesLabel.replace(", ", "");

  sendNotification('Criminal sentanced!')
  $.post('https://core_mdw/sentance', JSON.stringify({
    jail: chargeJail,
    fine: chargeFine,
    person: chargesPerson,
    charges: chargesLabel
  }));


}


function openIncidents() {


  playClickSound();
  hideEvery();
  if ($("#incidents").length) {
    $("#incidents").show();

    return;
  }


  var base = '<div class="slide-right" id="incidents">' +
    '<div class="clearfix grpelem" id="pu800-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u800-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>INCIDENTS</p>' +
    '     </div>' +
    '     <input class="clearfix colelem spacing" onInput="search(this, \'incidents\')" id="u801"><!-- group -->' +
    '      <div class="grpelem" id="u802" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem incidents" id="u803"><!-- column -->';

  var limit = 0
  for (const [key, value] of Object.entries(incidents)) {

    if (limit < 50) {



      base = base + '      <div class="clearfix colelem box scale-up-center incident" onclick="openIncident(\'' + key + '\')" id="' + key + '"><!-- group -->' +
        '       <div class="grpelem" id="u707"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u708" style="background: url(img/incident.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.title + '</p>' +
        '       </div>' +
        '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.description + '</p>' +
        '       </div>' +
        '      </div>';

      limit = limit + 1;
    }

  }


  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu830-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u830-4" data-sizePolicy="fixed" data-pintopage="page_fluidx">' +
    'NEW INCIDENT' +
    '</div>' +
    '     <div class="clearfix colelem" id="u836-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>TITLE</p>' +
    '     </div>' +
    '     <input class="colelem" onInput="createIncident()" id="u833" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     <div class="clearfix colelem" id="pu1775-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u1775-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>LOCATION</p>' +
    '      </div>' +
    '      <div class="clearfix grpelem" id="u1872-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>TIME</p>' +
    '      </div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu1774"><!-- group -->' +
    '      <input class="grpelem" id="u1774" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '      <input class="grpelem" type="time" id="u1871" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u849-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>DESCRIPTION</p>' +
    '     </div>' +
    '     <textarea   id="u848" data-sizePolicy="fixed" data-pintopage="page_fluidx"></textarea>' +
    '     <div class="clearfix colelem" id="pu1579-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u1579-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>EVIDENCE</p>' +
    '      </div>' +
    '      <div class="grpelem box" id="u1780" onclick="addEvidence()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-plus"></i></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1578"><!-- group -->' +

    //EVIDENCE




    '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="ppu860-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="pu860-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u860-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>INVOLVEMENT</p>' +
    '      </div>' +
    '      <div class="grpelem box" onclick="saveIncident()" id="u1817" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>' +
    '      <div class="grpelem box" onclick="newIncident()" id="u1818" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-file-alt"></i></div>' +
    '      <div class="grpelem box" onclick="removeIncident()" id="u1819" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-trash-alt"></i></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu872-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u872-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>CRIMINALS</p>' +
    '      </div>' +
    '      <div class="grpelem box" onclick="addToIncident(\'crims\')" id="u893" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-plus"></i></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u869"><!-- column -->' +




    '     </div>' +
    '     <div class="clearfix colelem" id="pu998-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u998-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>OFFICERS</p>' +
    '      </div>' +
    '      <div class="grpelem box" onclick="addToIncident(\'officers\')" id="u999" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-plus"></i></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u997"><!-- column -->' +


    //OFFICERS




    '     </div>' +
    '     <div class="clearfix colelem" id="pu1034-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u1034-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>SPECTATORS</p>' +
    '      </div>' +
    '      <div class="grpelem box" onclick="addToIncident(\'spectators\')" id="u1035" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-plus"></i></div>' +

    '     </div>' +
    '     <div class="clearfix colelem" id="u1033"><!-- column -->' +

    //SPECTATORS




    '     </div>' +
    '    </div></div>';

  $('#u552').append(base);




}

function openProfiles() {


  playClickSound();
  hideEvery();
  if ($("#profiles").length) {

    $("#profiles").show();

    return;
  }

  var base = '<div class="clearfix colelem slide-right" id="profiles"><!-- group -->' +
    '    <div class="clearfix grpelem" id="pu1254-4"><!-- column -->' +
    '      <div class="grpelem box" onclick="saveProfile()" id="u1817" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>' +
    '     <div class="clearfix colelem" id="u1254-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>PROFILES</p>' +
    '     </div>' +
    ' <div id="userStatus"></div>' +
    '     <input class="clearfix spacing colelem" onInput="search(this, \'profiles\')" id="u1255"><!-- group -->' +
    '      <div class="grpelem" id="u1256" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem profiles" id="u1257"><!-- column -->';

  //PROFILES

  var limit = 0

  for (const [key, value] of Object.entries(users)) {

    var url = users[key].mdw_image;
    if (url == null || url == '') {
      url = "img/placeholder.png"
    }

    if (limit < 20) {
      base = base + '      <div class="clearfix colelem box scale-up-center user" onclick="openProfile(\'' + key + '\')" id="' + key.replace(":", "-") + '""><!-- group -->' +
        '       <div class="grpelem" id="u1258" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u1259" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u1260-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.firstname + ' ' + value.lastname + '</p>' +
        '       </div>' +
        '      </div>';
    }

    limit = limit + 1
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
    '       <div class="clearfix colelem" id="pu1293"><!-- group -->' +
    '        <input class="grpelem spacing" id="u1293" data-sizePolicy="fixed" data-pintopage="page_fluidx"></input>' +
    '        <div class="grpelem" id="u1296" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-image"></i></div>' +
    '       </div>' +
    '      </div>' +
    '     </div>' +

    '     <div class="clearfix colelem" id="u836-5" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>BIRTHDAY</p>' +
    '     </div>' +
    '     <input class="colelem" type="text" readonly="readonly" id="dob" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +

    '     <div class="clearfix colelem" id="u836-6" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>ORIGIN</p>' +
    '     </div>' +
    '     <input class="colelem" type="text" readonly="readonly" id="height" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +

    '     <div class="clearfix colelem" id="u836-7" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>PHONE</p>' +
    '     </div>' +
    '     <input class="colelem" id="phone" readonly="readonly" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +

    '     <textarea class="colelem" id="u1299" data-sizePolicy="fixed" data-pintopage="page_fluidx"></textarea>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu1302-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1302-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>INFORMATION</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1304-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EMPLOYMENT</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1303"><!-- group -->' +

    //EMPLOYMENT


    '     </div>' +
    '     <div class="clearfix colelem" id="u1408-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>VEHICLES</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1407"><!-- group -->' +

    //VEHICLES




    '     </div>' +
    '     <div class="clearfix colelem" id="u1417-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>HOUSING</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1416"><!-- group -->' +

    //HOUSING




    '     </div>' +
    '     <div class="clearfix colelem" id="u1426-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>LICENSES</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu1425"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u1425"><!-- column -->' +

    //LICENSES


    '      </div>' +

    '       <div class="clearfix colelem" id="u1435-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '        <p>INCIDENTS</p>' +
    '       </div>' +

    '      <div class="clearfix grpelem" id="u1434"><!-- group -->' +


    //INCIDENTS



    '      </div>' +
    '     </div>' +
    '    </div>' +
    '   </div>';

  $('#u552').append(base);

}

function openEvidence(id) {

  var current = evidence[id];
  openedEvidence = id;

  openEvidences();

  $('#u2714-4').text('EVIDENCE #' + id);

  $('#evidenceMenu').html('');

  if (current.type == 'evidence') {

    if (current.image == "" || current.image == null) {
      url = "img/evidencePicture.png";
    } else {
      url = current.image;
    }

    var base = '      <div class="grpelem slide-right" style="background: url(' + url + '); background-size: cover;" id="u2252" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '      <input class="grpelem spacing slide-right" id="u2253" data-sizePolicy="fixed" data-pintopage="page_fluidx" value="' + current.image + '"></input>' +
      '      <div class="grpelem slide-right" id="u2254" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-image"></i></div>' +
      '      <textarea class="grpelem slide-right" id="u2264" data-sizePolicy="fixed" data-pintopage="page_fluidx">' + current.description + '</textarea>';

    $('#evidenceMenu').append(base);




  }

  if (current.type == 'ecosystem') {

    var base = '     <div class="clearfix colelem slide-right" id="pu2252"><!-- group -->';
    var count = 1;

    for (const [key, value] of Object.entries(current.data)) {

      base = base + '      <div class="clearfix grpelem" id="u2711"><!-- group -->' +
        '       <div class="grpelem" id="u2717" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u2720" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u2723-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>EVIDENCE #' + count + ' (' + value.type + ')</p>' +
        '       </div>' +
        '<div id="evidencePlace">';

      for (const [key2, value2] of Object.entries(value.evidence)) {

        base = base + '       <div class="clearfix grpelem" id="u2738"><!-- column -->' +
          '        <div class="clearfix colelem" id="u2726-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>' + key2.toUpperCase() + '</p>' +
          '        </div>' +
          '        <div class="clearfix colelem" id="u2729-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '         <p>' + value2.toUpperCase() + '</p>' +
          '        </div>' +
          '       </div>';

      }

      base = base + '</div>';

      count = count + 1;

    }


    base = base + '      </div>' +




      $('#evidenceMenu').append(base);


  }

}

function saveEvidence() {



  playClickSound();

  var image = $('#u2253').val();
  var description = $('#u2264').val();

  if ($('#u2714-4').text() == 'NEW EVIDENCE') {

    sendNotification('Evidence created!');

    openedEvidence = getRandomInt(99999).toString();

    $.post('https://core_mdw/createEvidence', JSON.stringify({
      id: openedEvidence,
      image: image,
      description: description
    }));

    $('#u2714-4').text('EVIDENCE #' + openedEvidence);

    if (image == "") {
      image = "img/evidencePicture.png";
    }

    $("#u2252").css("background", "url(" + image + ")");
    $("#u2252").css("background-size", "cover");


    var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openEvidence(\'' + openedEvidence + '\')" id="' + openedEvidence + '"><!-- group -->' +
      '       <div class="grpelem" id="u707"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '       <div class="grpelem" id="u708" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '        <p>#' + openedEvidence + '</p>' +
      '       </div>' +
      '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '        <p>' + "Photo Evidence" + '</p>' +
      '       </div>' +
      '      </div>';

    $('#u2195').append(base);


  } else {

    sendNotification('Evidence saved!');

    if (evidence[openedEvidence].type == 'evidence') {

      if (image == "") {
        image = "img/evidencePicture.png";
      }

      $("#u2252").css("background", "url(" + image + ")");
      $("#u2252").css("background-size", "cover");

      $.post('https://core_mdw/saveEvidence', JSON.stringify({
        id: openedEvidence,
        image: image,
        description: description
      }));


    }

  }




}



function removeReport() {

  if (report != null && checkPerms('deletereport')) {

    sendNotification('Report removed!');


    playClickSound();

    $('#' + report).remove();
    $.post('https://core_mdw/removeReport', JSON.stringify({
      id: report
    }));
    newReport();




  }

}

function removeEvidence() {

  if (openedEvidence != null) {
    if (evidence[openedEvidence].type == 'evidence') {

      sendNotification('Evidence removed!');

      playClickSound();

      $('#' + openedEvidence).remove();
      $.post('https://core_mdw/removeEvidence', JSON.stringify({
        id: openedEvidence
      }));
      $('#evidenceMenu').html('');

    }


  }

}

function newEvidence() {

  playClickSound();
  openedEvidence = null;


  $('#evidenceMenu').html('');
  $('#u2714-4').text('NEW EVIDENCE');



  var base = '      <div class="grpelem slide-right" id="u2252" style="background: url(img/evidencePicture.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <input class="grpelem spacing slide-right" id="u2253" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '      <div class="grpelem slide-right" id="u2254" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-image"></i></div>' +
    '      <textarea class="grpelem slide-right" id="u2264" data-sizePolicy="fixed" data-pintopage="page_fluidx"></textarea>';

  $('#evidenceMenu').append(base);


}

function openEvidences() {


  playClickSound();
  hideEvery();
  if ($("#evidence").length) {

    $("#evidence").show();

    return;
  }


  var base = '<div class="clearfix colelem slide-right" id="evidence"><!-- group -->' +
    '      <div class="grpelem box" onclick="saveEvidence()" id="u1817" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>' +
    '      <div class="grpelem box" onclick="newEvidence()" id="u1818" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-file-alt"></i></div>' +
    '      <div class="grpelem box" onclick="removeEvidence()" id="u1819" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-trash-alt"></i></div>' +
    '    <div class="clearfix grpelem" id="pu2192-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u2192-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EVIDENCE</p>' +
    '     </div>' +
    '     <input class="clearfix spacing colelem" onInput="search(this, \'evidence\')" id="u2193"><!-- group -->' +
    '      <div class="grpelem" id="u2194" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem evidence" id="u2195"><!-- column -->';

  //EVIDENCES
  var limit = 0
  for (const [key, value] of Object.entries(evidence)) {


    if (limit < 50) {

      var desc = "";
      if (value.type == 'ecosystem') {
        desc = "Evidence Locker";
      } else {
        desc = "Photo Evidence";
      }

      base = base + '      <div class="clearfix colelem box scale-up-center incident" onclick="openEvidence(\'' + key + '\')" id="' + key + '"><!-- group -->' +
        '       <div class="grpelem" id="u707"  data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u708" style="background: url(img/evidence.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>#' + key + '</p>' +
        '       </div>' +
        '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + desc + '</p>' +
        '       </div>' +
        '      </div>';

      limit = limit + 1;
    }

  }


  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="ppu2714-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="pu2714-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u2714-4" data-sizePolicy="fixed" data-pintopage="page_fluidx">' +
    'NEW EVIDENCE' +
    '      </div>' +
    '      <div class="clearfix grpelem" id="u2267-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p></p>' +
    '      </div>' +
    '      <div class="grpelem" id="u2270" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     </div>' +
    '     <div id="evidenceMenu"></div>';



  '     </div>';

  base = base + '    </div>' +
    '    <div class="grpelem" id="u2246" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '   </div>';


  $('#u552').append(base);

}

function openStaff() {


  playClickSound();
  hideEvery();
  if ($("#staff").length) {

    $("#staff").show();

    return;
  }


  var base = '<div class="clearfix colelem slide-right" id="staff"><!-- group -->' +
    '    <div class="clearfix grpelem" id="pu1651-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1651-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>STAFF</p>' +
    '     </div>' +
    '      <div class="grpelem box" onclick="saveStaffProfile()" id="u1817" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>' +


    '     <input class="clearfix spacing colelem" onInput="search(this, \'staff\')" id="u1652"><!-- group -->' +
    '      <div class="grpelem" id="u1653" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem staff" id="u1654"><!-- column -->';

  //STAFF

  var limit = 0

  for (const [key, value] of Object.entries(users)) {

    for (const [key2, value2] of Object.entries(value.jobs)) {

      for (const [key3, value3] of Object.entries(departaments)) {

  
        if (key2 == key3) {
          var url = value.mdw_image;
          if (url == null || url == '') {
            url = "img/placeholder.png"
          }

          if (limit < 20) {
            base = base + '      <div class="clearfix colelem box scale-up-center user" onclick="openStaffProfile(\'' + key + '\', \'' + key3 + '\')" id="' + key.replace(":", "-") + '""><!-- group -->' +
              '       <div class="grpelem" id="u1258" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
              '       <div class="grpelem" id="u1259" style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
              '       <div class="clearfix grpelem" id="u1260-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
              '        <p>' + value.firstname + ' ' + value.lastname + '</p>' +
              '       </div>' +
              '      </div>';
          }

          limit = limit + 1
        }

      }

    }

  }

  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="ppu1696"><!-- column -->' +
    '     <div class="clearfix colelem" id="pu1696"><!-- group -->' +
    '      <div class="grpelem" id="u1696" style="background: url(img/placeholder.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <div class="clearfix grpelem" id="pu1697-4"><!-- column -->' +
    '       <div class="clearfix colelem" id="u1697-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '        <p>-</p>' +
    '       </div>' +
    '       <div class="clearfix colelem" id="u1698-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '        <p>-</p>' +
    '       </div>' +
    '       <div class="clearfix colelem" id="pu1293"><!-- group -->' +
    '        <input class="grpelem spacing" id="u1294" data-sizePolicy="fixed" data-pintopage="page_fluidx"></input>' +
    '        <div class="grpelem" id="u1296" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-image"></i></div>' +
    '       </div>' +
    '      </div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1856-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>DEPARTAMENT</p>' +
    '     </div>' +
    '     <input readonly class="colelem" id="u1832" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     <div class="clearfix colelem" id="u1844-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>RANK</p>' +
    '     </div>' +
    '     <input readonly class="colelem" id="u1845" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     <div class="clearfix colelem" id="u1850-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>ALIAS</p>' +
    '     </div>' +
    '     <input class="colelem" id="u1851" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     <div class="clearfix colelem" id="pu2300-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u2300-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>BADGES</p>' +
    '      </div>' +
    '      <div class="grpelem box" id="u2301" onclick="addBadge()" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-plus"></i></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu2276"><!-- group -->' +
    '      <div class="grpelem" id="u2276" data-sizePolicy="fixed" data-pintopage="page_fluidx">' +




    '     </div>' +
    '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu1711-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1711-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>PERMISSIONS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1714-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>ISSUE A WARRANT</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1721-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EDIT INCIDENTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1730-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>DELETE INCIDENTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1736-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>CREATE INCIDENTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1741-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>CREATE REPORTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1743-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EDIT REPORTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1746-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>DELETE REPORTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1748-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EDIT PROFILES</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1860-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>REVOKE LICENSE</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1866-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>ADMINISTRATOR</p>' +
    '     </div>' +
    '    </div>' +


    '    <div class="clearfix grpelem" id="pu1910"><!-- column -->' +

    '     <div class="colelem issuewarrant" onclick="clickPermission(\'issuewarrant\')" id="u1726" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem editincident" onclick="clickPermission(\'editincident\')" id="u1720" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem deleteincident" onclick="clickPermission(\'deleteincident\')" id="u1729" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem createincident" onclick="clickPermission(\'createincident\')" id="u1735" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem createreport" onclick="clickPermission(\'createreport\')" id="u1744" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem editreport" onclick="clickPermission(\'editreport\')" id="u1742" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem deletereport" onclick="clickPermission(\'deletereport\')" id="u1745" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem editprofile" onclick="clickPermission(\'editprofile\')" id="u1747" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem revokelicense" onclick="clickPermission(\'revokelicense\')" id="u1859" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     <div class="colelem administrator" onclick="clickPermission(\'administrator\')" id="u1865" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '    </div>' +
    '   </div>';



  $('#u552').append(base);

}


function saveReport() {



  $('#dashboard').remove();

  var title = $('#u1877').val();
  var report_incident = $('#u1883').val();
  var description = $('#u1889').val();

  var date = "";

  if ($('#u2029').prop("checked")) {
    date = 'never';
  } else {
    date = $('#u2026').val();
  }

  if (date == "") {
    date = 'never';
  }



  if ($('#u1522-4').text() == 'NEW REPORT' && title != "" && report_incident != "" && incidents[report_incident] != null && reportStatus != "") {

    playClickSound();
    sendNotification('Report created!')

    var count = 1;

    for (let i = 1; i < 100; i++) {
      if (reports[report_incident + '-' + i] == null) {
        count = i;
        break;
      }
    }

    report = report_incident + '-' + count;

    $('#u1522-4').text('REPORT #' + report);

    if (reportBroadcast != "") {

      $.post('https://core_mdw/broadcast', JSON.stringify({
        type: reportBroadcast,
        message: description
      }));

    }




    $.post('https://core_mdw/createReport', JSON.stringify({
      title: title,
      id: report,
      description: description,
      incident: report_incident,
      ongoing: reportStatus,
      expire: date
    }));

    var base = '      <div class="clearfix colelem box scale-up-center incident" onclick="openReport(\'' + report + '\')" id="' + report + '"><!-- group -->' +
      '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '       <div class="grpelem" id="u708" style="background: url(img/report.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
      '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '        <p>' + title + '</p>' +
      '       </div>' +
      '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
      '        <p>' + description + '</p>' +
      '       </div>' +
      '      </div>';

    $(".reports").append(base);



  } else if (report != null) {



    if (title != "" && checkPerms('editreport')) {

      playClickSound();
      sendNotification('Report saved!')

      if (reportBroadcast != "") {

        $.post('https://core_mdw/broadcast', JSON.stringify({
          type: reportBroadcast,
          message: description
        }));

      }


      $.post('https://core_mdw/updateReport', JSON.stringify({
        title: title,
        id: report,
        description: description,
        incident: report_incident,
        ongoing: reportStatus,
        expire: date
      }));



      $("#" + report).find("#u709-4").text(title);
      $("#" + report).find("#u1895-4").text(description);

    }


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

  reportBroadcast = "";



}

function newReport() {

  if (checkPerms('createreport')) {
    playClickSound();

    report = null;
    reportStatus = "";
    reportBroadcast = "";

    $("#u1883").prop("readonly", false);

    $('#u1877').val("");
    $('#u1883').val("");
    $('#u1889').val("");
    $('#u1522-4').text('NEW REPORT');

    $('#u2026').val("");
    $('#u2029').prop("checked", false);

    $('#u2011').css(' border-style', 'solid');
    $('#u2011').css('border-width', '0px');
    $('#u2011').css('border-color', '#FFFFFF');

    $('#pu1999').css(' border-style', 'solid');
    $('#pu1999').css('border-width', '0px');
    $('#pu1999').css('border-color', '#FFFFFF');


    $('#pu1990').css(' border-style', 'solid');
    $('#pu1990').css('border-width', '0px');
    $('#pu1990').css('border-color', '#FFFFFF');

    $('#pu1966').css(' border-style', 'solid');
    $('#pu1966').css('border-width', '0px');
    $('#pu1966').css('border-color', '#FFFFFF');


    $('#u2017').css(' border-style', 'solid');
    $('#u2017').css('border-width', '0px');
    $('#u2017').css('border-color', '#FFFFFF');
  }



}

function showBroadcast(type, message) {
  var audio = document.getElementById("broadcast");
  audio.volume = 0.05;
  audio.play();


  var base = '<div class="grpelem broadcast slide-right" id="u2692" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame -->' +
    '   <div class="clearfix grpelem" id="u2695-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '    <p>REPORT BROADCAST</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem" id="u2698-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '    <p>' + message + '</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem" id="u2707-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '    <p id="u2707-2">' + type.toUpperCase() + '</p>' +
    '   </div>' +
    '   </div>';


  $('body').append(base);

  setTimeout(function() {

    $('#u2692').fadeOut();
    setTimeout(function() {
      $('#u2692').remove();
    }, 2000);

  }, 13000);


}

function openReport(id) {

  playClickSound();
  var current = reports[id];
  report = id;

  openReports();

  reportBroadcast = "";


  $('#u1877').val(current.title);
  $('#u1883').val(current.incident);
  $('#u1889').val(current.description);
  $('#u1522-4').text('REPORT #' + report);

  $("#u1883").prop("readonly", true);



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

  if (current.ongoing) {


    $('#u2017').css(' border-style', 'solid');
    $('#u2017').css('border-width', '3px');
    $('#u2017').css('border-color', '#FFFFFF');

    reportStatus = true;

  } else {



    $('#u2011').css(' border-style', 'solid');
    $('#u2011').css('border-width', '3px');
    $('#u2011').css('border-color', '#FFFFFF');

    reportStatus = false;
  }



}

function selectReportStatus(t, status) {


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
    reportStatus = true;
  } else {
    reportStatus = false;
  }



}

function selectReportBroadcast(t, type) {

  $('#pu1999').css(' border-style', 'solid');
  $('#pu1999').css('border-width', '0px');
  $('#pu1999').css('border-color', '#FFFFFF');


  $('#pu1990').css(' border-style', 'solid');
  $('#pu1990').css('border-width', '0px');
  $('#pu1990').css('border-color', '#FFFFFF');

  $('#pu1966').css(' border-style', 'solid');
  $('#pu1966').css('border-width', '0px');
  $('#pu1966').css('border-color', '#FFFFFF');

  $(t).css(' border-style', 'solid');
  $(t).css('border-width', '3px');
  $(t).css('border-color', '#FFFFFF');

  reportBroadcast = type;




}

function openReports() {

  playClickSound();
  hideEvery();
  if ($("#reports").length) {

    $("#reports").show();

    return;
  }

  var base = '<div class="clearfix colelem slide-right" id="reports"><!-- group -->' +
    '    <div class="clearfix grpelem" id="pu1492-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1492-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>REPORTS</p>' +
    '     </div>' +
    '      <div class="grpelem box" onclick="saveReport()" id="u1817" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-save"></i></div>' +
    '      <div class="grpelem box" onclick="newReport()" id="u1818" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-file-alt"></i></div>' +
    '      <div class="grpelem box" onclick="removeReport()" id="u1819" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="far fa-trash-alt"></i></div>' +
    '     <input class="clearfix spacing colelem" onInput="search(this, \'reports\')" id="u1493"><!-- group -->' +
    '      <div class="grpelem" id="u1494" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem reports" id="u1495"><!-- column -->';

  //REPORTS

  var limit = 0

  for (const [key, value] of Object.entries(reports)) {

    if (limit < 20) {
      base = base + '      <div class="clearfix colelem box scale-up-center incident" onclick="openReport(\'' + key + '\')" id="' + key + '"><!-- group -->' +
        '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u708" style="background: url(img/report.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.title + '</p>' +
        '       </div>' +
        '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.description + '</p>' +
        '       </div>' +
        '      </div>';

      limit = limit + 1;
    }


  }


  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu1522-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1522-4" data-sizePolicy="fixed" data-pintopage="page_fluidx">' +
    'NEW REPORT' +
    '</div>' +
    '     <div class="clearfix colelem" id="u1878-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>TITLE</p>' +
    '     </div>' +
    '     <input class="colelem" id="u1877" data-sizePolicy="fixed" data-pintopage="page_fluidx"></input>' +
    '     <div class="clearfix colelem" id="u1884-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>INCIDENT ID</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu2038-4"><!-- group -->' +
    '      <div class="clearfix grpelem" id="u2038-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p id="u2038-2">#</p>' +
    '      </div>' +
    '      <input class="grpelem" id="u1883" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1890-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>DESCIPTION</p>' +
    '     </div>' +
    '     <textarea class="colelem" id="u1889" data-sizePolicy="fixed" data-pintopage="page_fluidx"></textarea>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu1960-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u1960-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>SETTINGS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u1981-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>BROADCAST TO</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" onclick="selectReportBroadcast(this, \'police\')"  id="pu1966"><!-- group -->' +
    '      <div class="grpelem" id="u1990" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <div class="clearfix grpelem" id="u1991-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>POLICE OFFICERS</p>' +
    '      </div>' +
    '      <div class="grpelem" id="u1987" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" onclick="selectReportBroadcast(this, \'emergency\')" id="pu1990"><!-- group -->' +
    '      <div class="grpelem" id="u1990" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <div class="clearfix grpelem" id="u1991-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>EMERGENCY PERSONEL</p>' +
    '      </div>' +
    '      <div class="grpelem" id="u1992" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" onclick="selectReportBroadcast(this, \'everyone\')" id="pu1999"><!-- group -->' +
    '      <div class="grpelem" id="u1999" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <div class="clearfix grpelem" id="u2000-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>EVERYONE</p>' +
    '      </div>' +
    '      <div class="grpelem" id="u2001" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u2008-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>STATUS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="ppu2017"><!-- group -->' +
    '      <div class="clearfix grpelem" id="pu2017"><!-- group -->' +
    '       <div class="grpelem" id="u2017" onclick="selectReportStatus(this, \'ongoing\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '       <div class="clearfix grpelem" id="u2018-4" onclick="selectReportStatus(\'#u2017\', \'ongoing\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '        <p>ONGOING</p>' +
    '       </div>' +
    '      </div>' +
    '      <div class="grpelem" id="u2011" onclick="selectReportStatus(this, \'resolved\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
    '      <div class="clearfix grpelem" id="u2012-4" onclick="selectReportStatus(\'#u2011\', \'resolved\')" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>RESOLVED</p>' +
    '      </div>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u2023-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>EXPIRE</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="pu2029"><!-- group -->' +
    '      <input type="checkbox" class="grpelem" id="u2029" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '      <div class="clearfix grpelem" id="u2032-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '       <p>NEVER EXPIRE</p>' +
    '      </div>' +
    '      <input type="date" class="grpelem" id="u2026" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></input>' +
    '     </div>' +
    '    </div>' +
    '   </div>';



  $('#u552').append(base);

}

function fillWarrants() {

  if (!updated) {

    setTimeout(function() {
      fillWarrants();
    }, 50)
  } else {



    for (const [key, value] of Object.entries(activeWarrants)) {


      if (value.hours < warrantending) {



        var url = users[key].mdw_image;
        if (url == null || url == '') {
          url = "img/placeholder.png"
        }
        activeWarrants[key].name = users[key].name;

        base = '      <div class="clearfix colelem box" onclick="openProfile(\'' + key + '\')" id="pu707"><!-- group -->' +
          '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="grpelem" style="background: url(' + url + '); background-size: cover;" id="u708" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
          '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>' + users[key].name + '</p>' +
          '       </div>' +
          '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
          '        <p>WARRANT EXPIRES IN ' + value.hours + ' HOURS</p>' +
          '       </div>' +
          '      </div>';


        $('.warrants').append(base);



      }

    }

  }
}


function openDashboard() {


  playClickSound();
  hideEvery();
  if ($("#dashboard").length) {

    $("#dashboard").remove();


  }

  activeWarrants = [];

  var now = new Date();

  var base = '   <div class="clearfix colelem slide-right" id="dashboard"><!-- group -->' +
    '<div class="clearfix grpelem " id="pu589-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u589-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>WARRANTS</p>' +
    '     </div>' +
    '     <input class="clearfix spacing colelem" onInput="search(this, \'warrants\')" id="u619"><!-- group -->' +
    '      <div class="grpelem" id="u610" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem warrants" id="u706"><!-- column -->';


  var updatingUsers = [];
 

  for (const [key, value] of Object.entries(incidents)) {

    for (const [key2, value2] of Object.entries(value.crims)) {

        update = true;

      var date = new Date(value2.warrant);

      const diffTime = Math.abs(date - now);
      const diffHours = Math.ceil(diffTime / (1000 * 60 * 60));

      if (diffHours > 0) {
        activeWarrants[key2] = {};
        activeWarrants[key2].hours = diffHours;
        updatingUsers.push(key2);
      }




    }


  }


    updateUsers(updatingUsers);
  


  fillWarrants();




  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu634-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u634-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>REPORTS</p>' +
    '     </div>' +
    '     <input class="clearfix spacing colelem" onInput="search(this, \'reports\')" id="u635"><!-- group -->' +
    '      <div class="grpelem" id="u636" data-sizePolicy="fixed" data-pintopage="page_fluidx"><i class="fas fa-search"></i></div>' +
    '     </input>' +
    '     <div class="clearfix colelem reports" id="u679"><!-- column -->';


  for (const [key, value] of Object.entries(reports)) {


    var date = new Date(value.created * 1000);


    const diffTime = Math.abs(date - now);
    const diffHours = Math.ceil(diffTime / (1000 * 60 * 60));




    if (diffHours < 24 && value.ongoing) {



      base = base + '      <div class="clearfix colelem box  incident" onclick="openReport(\'' + key + '\')" id="' + key + '"><!-- group -->' +
        '       <div class="grpelem" id="u707" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="grpelem" id="u708" style="background: url(img/report.png); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +
        '       <div class="clearfix grpelem" id="u709-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.title + '</p>' +
        '       </div>' +
        '       <div class="clearfix grpelem" id="u1895-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '        <p>' + value.description + '</p>' +
        '       </div>' +
        '      </div>';

    }


  }



  base = base + '     </div>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="pu643-4"><!-- column -->' +
    '     <div class="clearfix colelem" id="u643-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
    '      <p>ANNOUNCEMENTS</p>' +
    '     </div>' +
    '     <div class="clearfix colelem" id="u682"><!-- group -->';



  for (const [key, value] of Object.entries(announcements)) {

    if (value != null) {

      var diff = new Date(value.date * 1000);

      base = base + '      <div class="rgba-background clearfix grpelem" id="u685-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p id="u685-2"><span id="u685">' + value.text + '</span></p>' +
        '      <div class="rgba-background clearfix grpelem" id="u1913-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '       <p>' + timeSince(diff) + '</p>' +
        '      </div>' +
        '      </div>';

    }


  }


  base = base + '     </div>' +
    '    </div></div>';




  $('#u552').append(base);


}

function showLoader(show) {

  if (show) {

    setTimeout(function() {

      if (!updated) {
        var base = '<div id="loader-background" class="">' +
          '<img id="loader" src="img/loader.svg" class="scale-up-center">' +
          '<div>';

        $('#u552').append(base);

      }

    }, 50);



  } else {
    $("#loader-background").remove();
  }


}

function sendNotification(text) {

  if ($('#notification').length) {
    clearTimeout(notifThread);
    clearTimeout(notifThread2);
    $('#notification').remove();
  }


  var base = '<div id="notification" class=" slide-left ">' +
    '<div id="notification-image" style=" background: url(img/notification.png); background-size: cover;"></div>' +
    '<div id="notification-label">NOTIFICATION</div>' +
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


  var url = users[citizenid].mdw_image;
  if (url == null || url == '') {
    url = "img/placeholder.png"
  }

  var base = '<div class="clearfix borderbox slide-top" id="page"><!-- group -->' +
    '   <div class="grpelem" id="u462" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
    '   <div class="grpelem" id="u1615"><!-- rasterized frame --></div>' +
    '   <div class="shadow grpelem" id="u465"style="background: url(' + url + '); background-size: cover;" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- simple frame --></div>' +
    '   <div class="grpelem" id="u468" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- simple frame --></div>' +
    '   <div class="shadow grpelem" id="u472" data-sizePolicy="fixed" data-pintopage="page_fixedCenter"><!-- simple frame --></div>' +
    '   <div class="clearfix grpelem" id="u475-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
    '    <p>OFFICER</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem" id="u478-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
    '    <p>' + users[citizenid].name.toUpperCase() + '</p>' +
    '   </div>' +
    '   <div class="grpelem" id="u505"><!-- simple frame --></div>' +
    '   <div class="clearfix grpelem button" onclick="openDashboard()" id="u512-4"><!-- content -->' +
    '    <p id="u512-2">DASHBOARD</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem button" onclick="openIncidents()" id="u530-4"><!-- content -->' +
    '    <p id="u530-2">INCIDENTS</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem button" onclick="openProfiles()" id="u533-4"><!-- content -->' +
    '    <p id="u533-2">PROFILES</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem button" onclick="openReports()" id="u536-4"><!-- content -->' +
    '    <p id="u536-2">REPORTS</p>' +
    '   </div>' +
    '   <div class="clearfix grpelem button" onclick="openEvidences()" id="u542-4"><!-- content -->' +
    '    <p id="u542-2">EVIDENCE</p>' +
    '   </div>' +
    '   <div class="gradient clearfix grpelem button" onclick="openStaff()" id="u549-4"><!-- content -->' +
    '    <p id="u549-2">STAFF</p>' +
    '   </div>' +

    '   <div class="grpelem" id="u552" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame --></div>' +


    '   <div class="clearfix grpelem" id="u1629-4" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"><!-- content -->' +
    '    <p>LOS SANTOS POLICE DEPARTAMENT</p>' +
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


  if (edata.type == "broadcast") {


    showBroadcast(edata.broadcast_type, edata.message)

  }


  if (edata.type == "updateUsers") {

    for (const [key, value] of Object.entries(edata.users)) {

      users[key] = value;
      showLoader(false);


    }

    updated = true;


  }

  if (edata.type == "searchResults") {



    fillSQLSearch(edata.results, edata.field)




  }


  if (edata.type == "update") {


    incidents = edata.incidents;
    reports = edata.reports;
    announcements = edata.announcements;
    evidence = edata.evidence;

    if (!laoded) {

      openDashboard();
      laoded = true;
    }

  }

  if (edata.type == "open") {



     vehColors = edata.vehColors;
    charges = edata.charges;
    users = edata.users;
    badges = edata.badges;
    citizenid = edata.citizenid;
    departaments = edata.departaments;
    warrantending = edata.warrantending;

    if (users[citizenid] == null) {
      console.log('[CORE MDW] Users not fully loaded!');
      return;
    }

    if ($("#main_container").is(":hidden")) {
      $("#main_container").show();
    } else {
      openMDW();
    }

    permissions = users[citizenid].permissions;


    for (const [key, value] of Object.entries(edata.instantadmins)) {
      if (citizenid == key && value == true) {

        permissions['administrator'] = true;
      }

    }




  }


});