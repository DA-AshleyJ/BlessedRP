$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "SendUI"){
            let htmlYazi = ""
            let htmlYazi2 = ""
            $('.HouseBuyMenu').fadeIn(500);
            $('#Adress').html(event.data.Street);
            $('#HouseFiyat').html('$'+event.data.HousePrice);
            $('#RentFiyat').html('$'+event.data.RentPrice);
            $('#HouseNo').html(event.data.HouseId);
            $('#PoolCount').html(event.data.HouseTable.Features.SwimmingPool);
            $('#CarCount').html(event.data.HouseTable.Garages.MaxSlotCar);
            $('#GarageCount').html(event.data.HouseTable.Features.Garage);
            $('#FloorNumber').html(event.data.HouseTable.Features.Floor);
            $('#RoomNumber').html(event.data.HouseTable.Features.NumberRoom)
            let BrotherText = `<button id="BuyHouseButtonProvide" data-houseid="${event.data.HouseId} "class="BuyHouseButtonMorukSuccess" type="button">Buy House</button>`
            let BrotherTextX = `<button id="BuyHouseButtonRent" data-houseid="${event.data.HouseId} "class="BuyHouseButtonMorukWarning" type="button">Rent House</button>`
            $('.Kemalist').html(BrotherText);
            $('.Kemalist2').html(BrotherTextX);
            if (event.data.HouseTable.Purchasable === true) {
                htmlYazi = htmlYazi + `
                <button id="BuyHouse" class="ButtonBuy" type="button">Buy House</button>
                `  
            } else {
                htmlYazi = htmlYazi + `
                <button class="ButtonBuyNot" type="button">NOT SALE</button>
                `  
            }
            $(".BuyHouseButton").html(htmlYazi);
            if (event.data.HouseTable.Rentable === true) {
                htmlYazi2 = htmlYazi2 + `
                <button id="RentHouse" class="ButtonRent" type="button">Rent House</button>
                `  
            } else {
                htmlYazi2 = htmlYazi2 + `
                <button class="ButtonRentNot" type="button">NOT RENTED</button>
                `  
            }
            $(".RentHouseButton").html(htmlYazi2)
        } else if (event.data.type === "Kapat"){
            $('.ModalMoruk').hide();
        } else if (event.data.type == "OpenHouseGarageMenu") {
            $('.HouseGarageMenu').fadeIn(500);
            $('#EvId').text(event.data.HomeId)
            let htmlYazi = ""
            for (let data = 0; data < event.data.HousesVehicles.length; data++) {
                const element = event.data.HousesVehicles[data];
                var AracModelBuyukHarf = element.vehicle.toUpperCase();
                    htmlYazi = htmlYazi + `
                    <div class="VehicleOption">
                        <h1 class="VehicleModel">${AracModelBuyukHarf} - ${element.plate}</h1>
                        <button id="Disari" data-houseid="${event.data.HomeId}" data-aracplate="${element.plate}" class="OutputGarageVehicle" type="button">Select</button>
                    </div>
                `  
            }
            $(".Vehicles").html(htmlYazi)
        } else if (event.data.type === "OpenHouseMang") {
            let CTMLYazi = ""
            let KibraText = ""
            $('.HouseManagementMenu').slideDown(500);
            $('#MahalleNameMoruk').html(event.data.LocationName);
            $('#AnahtarCopyFee').html(event.data.YedekFiyat);
            $('#Orospu').html(event.data.HouseId);
            $('#XD').html(event.data.EvSatisFiyat);
            if (event.data.CopyKeyTrueFalse === true){
                CTMLYazi = CTMLYazi + `
                <button id="CopyKey" class="HouseIslemButton RedButon" type="button"><b>Copy Key</b><br><small>for $${event.data.YedekFiyat}</small></button><br>`
            } else {
                CTMLYazi = CTMLYazi + `<button class="HouseIslemButton GriButon" type="button"><b>Copy Key</b></button>`
            }

            if (event.data.TransferEdilebilirlik == 1) {
                KibraText = KibraText + `
                <button id="EvSahipliginiBirOcaVer" class="HouseIslemButton SariButon" type="button"><b>Transfer Ownership</b><br><small>(The Closest person)</small></button><br>
                <button id="EviSat" class="HouseIslemButton MaviButon" type="button"><b>Sell House</b><br><small>for $${event.data.EvSatisFiyat}</small></button><br>
                `
            }
            $(".Kemalist").html(CTMLYazi);
            $(".Kemalist2").html(KibraText)
        } else if (event.data.type === "Necipmettin"){
            $('.HouseBuyMenu').hide();
            $('.ModalMoruk').hide();
        }
    });
});


document.onkeyup = function(data){
    if (data.which == 27){
        $('.HouseGarageMenu').fadeOut(500);
        $('.HouseManagementMenu').fadeOut(500);
        $.post('http://kibra-housesv2/CloseGarageMenu', JSON.stringify({}));
    }
}

$(document).on('click','#Disari',function(e){
    e.preventDefault();
    AracPlate = $(this).attr("data-aracplate");
    HouseIdd = $(this).attr("data-houseid");
    $('.HouseGarageMenu').fadeOut(500);
    $.post('http://kibra-housesv2/CloseGarageMenu', JSON.stringify({}));
    $.post('http://kibra-housesv2/OutputVehicle', JSON.stringify({
        AracPlaka: AracPlate,
        HouseId: HouseIdd
    })); 
})

$(document).on('click','#EviSat',function(e){
    e.preventDefault();
    $('.HouseManagementMenu').fadeOut(500);
    $.post('http://kibra-housesv2/CloseGarageMenu', JSON.stringify({}));
    $.post('http://kibra-housesv2/SellHouse', JSON.stringify({
        HomeNo: $("#Orospu").text(),
    })); 
})

$(document).on('click','#CopyKey',function(e){
    e.preventDefault();
    $('.HouseManagementMenu').fadeOut(500);
    $.post('http://kibra-housesv2/CloseGarageMenu', JSON.stringify({}));
    $.post('http://kibra-housesv2/CopyHouseKey', JSON.stringify({
        HomeNo: $("#Orospu").text(),
    })); 
})

$(document).on('click','#EvSahipliginiBirOcaVer',function(e){
    e.preventDefault();
    $('.HouseManagementMenu').fadeOut(500);
    $.post('http://kibra-housesv2/CloseGarageMenu', JSON.stringify({}));
    $.post('http://kibra-housesv2/TransferHouseOwnership', JSON.stringify({
        HomeNo: $("#Orospu").text(),
    })); 
})

$(document).on('click','#BuyHouse',function(e){
    e.preventDefault();
    let CTML = ` 
    <div class="ModalMoruk">
        <button id="KapatMenu2" class="CloseButton2" type="button"><i class="fa-solid fa-x"></i></button>
        <h1 class="EminmisinText">Are you sure you want to buy this house?</h1>
        <button class="BuyHouseButtonMoruk" type="button">Cancel</button>
        <button class="BuyHouseButtonMorukSuccess" type="button">Buy House</button>
    </div>
`
$(CTML).fadeIn(500);
})


$(document).on('click','#KapatMenu',function(e){
    e.preventDefault();
    $('.HouseBuyMenu').fadeOut(500);
    $.post('http://kibra-housesv2/BuyMenuClose', JSON.stringify({}));
})

$(document).on('click','#KapatMenu2',function(e){
    e.preventDefault();
    $('.ModalMoruk').hide();
})

$(document).on('click','#KapatMenu3',function(e){
    e.preventDefault();
    $('.ModalMoruk2').hide();
})

$(document).on('click','#KapatRecepsiyon2',function(e){
    e.preventDefault();
    $('.MotelOdalar').fadeOut(500);
    $.post('http://kibra-housesv2/CloseReception2', JSON.stringify({}));
})

$(document).on('click','#KapatResepsiyon2',function(e){
    e.preventDefault();
    $('.MotelOdalarList').fadeOut(500);
    $.post('http://kibra-housesv2/CloseReception', JSON.stringify({}));
})

$(document).on('click','#KapatResepsiyon2',function(e){
    e.preventDefault();
    $('.MotelOdalarList').fadeOut(500);
    $.post('http://kibra-housesv2/CloseReception', JSON.stringify({}));
})

$(document).on('click','#MotelOdalar',function(e){
    e.preventDefault();
    $('.MotelMain').hide();
    $('.MotelOdalar').fadeIn(500);
})

$(document).on('click','#MotelOdalarList',function(e){
    e.preventDefault();
    $('.MotelMain').hide();
    $('.MotelOdalarList').fadeIn(500);
})

$(document).on('click','#BuyHouse',function(e){
    e.preventDefault();
    $('.ModalMoruk').fadeIn();
})

$(document).on('click','#RentHouse',function(e){
    e.preventDefault();
    $('.ModalMoruk2').fadeIn();
})

$(document).on('click','#BuyHouseButtonProvide',function(e){
    e.preventDefault();
    $('.ModalMoruk').fadeOut();
    HouseId = $(this).attr("data-houseid")
    $.post('http://kibra-housesv2/BuyHouse', JSON.stringify({
        HouseIdX: HouseId,
    })); 
})

$(document).on('click','#BuyHouseButtonRent',function(e){
    e.preventDefault();
    $('.ModalMoruk2').fadeOut();
    HouseId = $(this).attr("data-houseid")
    $.post('http://kibra-housesv2/RentHouse', JSON.stringify({
        HouseIdX: HouseId,
    })); 
})
