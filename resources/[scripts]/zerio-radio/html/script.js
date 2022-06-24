var currentTab = "default-tab"
var on = true
var currentFrequency = 0
var volume = 100
var voiceScript = ""
var allowDrag = false

tippy('.tooltip-top', {
    animation: 'fade'
});
tippy(".tooltip-left", {
    placement: 'left',
    animation: 'fade'
})
tippy(".tooltip-right", {
    placement: 'right',
    animation: 'fade'
})
tippy(".tooltip-bottom", {
    placement: "bottom",
    animation: 'fade'
})

const FUNCTIONS = { 
    close() {
        $(".main-container").animate({
            "margin-top": "100%"
        }, 500)
        setTimeout(function() {
            $(".main-container").css("display", "none")
            $.post("https://zerio-radio/close", JSON.stringify({}))
        }, 500)
    },

    open() {
        $(".main-container").css("margin-top", "100%").css("display", "block").animate({
            "margin-top": "0px"
        }, 500)
    },

    change_tab(tab) {
        $("."+currentTab).animate({
            "margin-top": "200%"
        }, 300)
        setTimeout(function() {
            $("."+currentTab).css("display", "none")
            $("."+tab).css("margin-top", "200%").css("display", "flex").animate({
                "margin-top": "0px"
            }, 500)
            currentTab = tab
        }, 300)
    },

    join_radio(val) {
        if(val !== undefined && val !== "") {
            $.post("https://zerio-radio/joinRadio", JSON.stringify({
                frequency: val
            }), function(data) {
                if (data.result == true) {
                    FUNCTIONS.change_tab("default-tab")
                    Notifications.fire({
                        title: 'Joined radio',
                        text: `You joined ${data.frequencyLabel !== undefined ? ("the " + data.frequencyLabel) : (data.frequency + " MHz")}`,
                        icon: 'success',
            
                        target: ".main-container"
                    })
                    currentFrequency = data.frequency
                }
                else {
                    Notifications.fire({
                        title: 'Locked channel',
                        text: 'You dont have access to join this channel!',
                        icon: 'error',
            
                        target: ".main-container"
                    })
                }
            })
        }
        else {
            $.post("https://zerio-radio/leaveRadio", JSON.stringify({}))
            Notifications.fire({
                title: 'Left radio',
                text: `You left the radio channel`,
                icon: 'success',
    
                target: ".main-container"
            })
            currentFrequency = 0
            FUNCTIONS.change_tab("default-tab")
        }
    },

    play_sound(name) {
        document.getElementById(name)
        document.getElementById(name).load();
        document.getElementById(name).volume = volume / 100;
        document.getElementById(name).play();
    }
}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                FUNCTIONS.open()
                break;
            case "updateData":
                $(".street-label").html(event.data.data.streetLabel)

                voiceScript = event.data.data.voiceScript

                if(event.data.data.radioFrequency == 0) {
                    $(".radio-status").html("You are not in a radio")
                    $(".radio-label").html("")
                }
                if (voiceScript == "saltychat") {
                    $(".icons2").css("display", "none")
                }
                if(event.data.data.radioFrequency == 0 || (event.data.data.radioMembers.length == 0 && voiceScript !== "saltychat")) {
                    $(".radio-members-container").html(`
                        <div class="radio-member">
                            <h1 class="radio-member-header">You are not in any radio channel</h1>
                        </div>
                    `)
                }
                else {
                    $(".radio-status").html("In radio")
                    if (event.data.data.radioLabel == undefined) {
                        $(".radio-label").html("Frequency: "+event.data.data.radioFrequency)
                    }
                    else {
                        $(".radio-label").html(event.data.data.radioLabel)
                    }

                    $(".radio-members-container").empty()
                    for (i = 0; i < event.data.data.radioMembers.length; i++) {
                        $(".radio-members-container").append(`
                            <div class="radio-member">
                                <h1 class="radio-member-header ${voiceScript == "pma-voice" ? 'clickable tooltip-top"' : '"'} ${voiceScript == "pma-voice" ? 'data-muted="false" data-tippy-content="Mute / Unmute"' : ""} id="${event.data.data.radioMembers[i].source}">${event.data.data.radioMembers[i].name}</h1>
                            </div>
                        `)
                    }
                    tippy('.tooltip-top', {
                        animation: 'fade'
                    });
                }
                break;
            case "updateSettings":
                $("body").attr("id", (event.data.data.theme + "mode"))
                if (event.data.data.theme == "dark") {
                    $('.theme-checkbox').prop('checked', true);
                }
                else {
                    $('.theme-checkbox').prop('checked', false);
                }

                if (event.data.data.anonymous == true) {
                    $('.anonymous-checkbox').prop('checked', true);
                }
                else {
                    $('.anonymous-checkbox').prop('checked', false);
                }

                if (event.data.data.position.left !== 0) {
                    $(".main-container").css("left", event.data.data.position.left)
                }
                if (event.data.data.position.top !== 0) {
                    $(".main-container").css("top", event.data.data.position.top)
                }

                $(".main-container").css("transform", "scale(" + Number(event.data.data.size) + ")")

                $('.size' + (event.data.data.size.toString()).replace(".", "")).prop('checked', true);
                break;
        }
    })

    $(document).on('keydown', function() {
        switch(event.keyCode) {
            case 27: // ESCAPE
                FUNCTIONS.close()
                break
            case 8: // BACKSPACE
                if (!$("#freq").is(":focus")) {
                    FUNCTIONS.close()
                }
                break
            case 13:
                if ($("#freq").is(":focus")) {
                    var val = $("#freq").val()
                    FUNCTIONS.join_radio(val)
                }
                break
        }
    })
});

$("body").on("click", ".radio-member-header.clickable", function() {
    $(this).data("muted", ($(this).data("muted") == false ? true : false))
    $.post("https://zerio-radio/mutePlayer", JSON.stringify({
        source: $(this).attr("id"),
        muted: $(this).data("muted"),
        name: $(this).html()
    }), function(result) {
        if (result.status) {
            Notifications.fire({
                title: 'Muted',
                text: result.text,
                icon: 'success',
    
                target: ".main-container"
            })
        }
        else {
            Notifications.fire({
                title: 'Unmuted',
                text: result.text,
                icon: 'success',
    
                target: ".main-container"
            })
        }
    })
})

$("body").on("click", ".join-radio-button", function() {
    FUNCTIONS.change_tab("join-radio-tab")
})

$("body").on("click", ".settings-button", function() {
    FUNCTIONS.change_tab("settings-tab")
})

$("body").on("click", ".radio-home-button", function() {
    FUNCTIONS.play_sound("click")
    
    if (currentTab !== "default-tab") {
        FUNCTIONS.change_tab("default-tab")
    }
    else {
        FUNCTIONS.close()
    }
})

$("body").on("click", ".radio-join-freq-btn", function() {
    var val = $("#freq").val()
    FUNCTIONS.join_radio(val)

    FUNCTIONS.play_sound("click")
})

$("body").on("click", ".radio-members", function() {
    FUNCTIONS.change_tab("radio-members-tab")
})

$("body").on("click", ".radio-power-button", function() {
    if (on == true) {
        $(".top-container").css("display", "none")
        $(".items-container").css("display", "none")
        $(".main-container").css("background", "#101121")
        $.post("https://zerio-radio/leaveRadio", JSON.stringify({}))
        on = false

        FUNCTIONS.play_sound("audio_off")
    }
    else {
        $(".top-container").css("display", "block")
        $(".items-container").css("display", "block")
        $(".main-container").css("background", "")
        $.post("https://zerio-radio/joinRadio", JSON.stringify({
            frequency: currentFrequency
        }), function(data) {})
        on = true

        FUNCTIONS.play_sound("audio_on")
    }
})

$("body").on("click", ".radio-volume-up-button", function() {
    if (volume !== 100) {
        volume += 5
    }
    $(".top-volume").html(volume + "%")
    $.post("https://zerio-radio/updateVolume", JSON.stringify({
        newVolume: volume
    }))

    FUNCTIONS.play_sound("click")
})

$("body").on("click", ".radio-volume-down-button", function() {
    if (volume !== 0) {
        volume += -5
    }
    $(".top-volume").html(volume + "%")
    $.post("https://zerio-radio/updateVolume", JSON.stringify({
        newVolume: volume
    }))

    FUNCTIONS.play_sound("click")
})

$("body").on("click", ".theme-checkbox", function() {
    if ($("body").attr("id") == "lightmode") {
        $("body").attr("id", "darkmode")
        $.post("https://zerio-radio/savesettings", JSON.stringify({
            name: "theme",
            value: "dark"
        }))
    }
    else {
        $("body").attr("id", "lightmode")
        $.post("https://zerio-radio/savesettings", JSON.stringify({
            name: "theme",
            value: "light"
        }))
    }
})

$("body").on("click", ".anonymous-checkbox", function() {
    $.post("https://zerio-radio/triggerAnonymous", JSON.stringify({}), function(result) {
        if (result.result) {
            Notifications.fire({
                title: 'Turned on',
                text: result.text,
                icon: 'success',

                target: ".main-container"
            })
        }
        else {
            Notifications.fire({
                title: 'Turned off',
                text: result.text,
                icon: 'success',

                target: ".main-container"
            })
        }
    })
})

$("body").on("click", ".custom-select ul li", function() {
    const details = document.querySelectorAll("details");

    details.forEach((detail) => {
        detail.removeAttribute("open");
    });

    $(".main-container").css("transform", "scale(" + Number($(this).find("label").attr("id")) + ")")
    $.post("https://zerio-radio/savesettings", JSON.stringify({
        name: "size",
        value: $(this).find("label").attr("id")
    }))
})

var isDraggable = false

$("body").on("click", ".drag-checkbox", function() {
    if (isDraggable == true) {
        isDraggable = false
        $('#main').css("cursor", "none")
    }
    else {
        isDraggable = true
    }
})

var draggable = $('#main'); //element 

draggable.on('mousedown', function(e){
    if (isDraggable) {
        var dr = $(this).addClass("drag").css("cursor","move");
        height = dr.outerHeight();
        width = dr.outerWidth();
        max_left = dr.parent().offset().left + dr.parent().width() - dr.outerWidth();
        max_top = dr.parent().offset().top + dr.parent().height() - dr.outerHeight();
        min_left = dr.parent().offset().left;
        min_top = dr.parent().offset().top;

        ypos = dr.offset().top + height - e.pageY,
        xpos = dr.offset().left + width - e.pageX;
        $(document.body).on('mousemove', function(e){
            var itop = e.pageY + ypos - height;
            var ileft = e.pageX + xpos - width;
            
            if(dr.hasClass("drag")){
                if(itop <= min_top ) { itop = min_top; }
                if(ileft <= min_left ) { ileft = min_left; }
                if(itop >= max_top ) { itop = max_top; }
                if(ileft >= max_left ) { ileft = max_left; }
                dr.offset({ top: itop,left: ileft});
            }
        }).on('mouseup', function(e){
                dr.removeClass("drag");
                $.post("https://zerio-radio/savesettings", JSON.stringify({
                    name: "position",
                    value: {
                        left: draggable.css("left"),
                        top: draggable.css("top")
                    }
                }))
        });
    }
});