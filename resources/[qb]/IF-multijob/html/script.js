function exit() {
    $(document.body).fadeOut(250, function(){
        $(document.body).css('display', 'none');
    });
    $.post('https://IF-multijob/close');
}

function changeButton(id,info){
    if (id === 'duty-button') {
        $(`#${id}`).html(($(`#${id}`).html() === "Chose") ? "SELECTED" : "Chose") //translatable
        $.post('https://IF-multijob/toggleDuty');
    } else if (id == 'delete-button') {
        $(`#${info}`).parent().parent().remove();

        if ($(`.jobs`).children().length === 0) {
            $('.jobs').html('<h3 style="margin: auto;">You have no jobs</h3>');
        } 
        $.post('https://IF-multijob/deleteJob', JSON.stringify({
            job: info.toString()
        }));
    } else {
        $('#duty-button').html("Chose")//translatable
        $('.job-selectButton').each(function(index) {
            $(this).replaceWith(`<button class="button job-selectButton" id="${$(this).attr('id')}" data-grade="${$(this).data('grade')}">Chose</button>`)//translatable
        })

        $(`#${id}`).replaceWith( `
            <div class="job-selectButton" id="${id}" data-grade="${info}">
                <button class="half-button2" id="delete-button" data-name="${id}" >
                <i class="fa-solid fa-trash"></i>
                </button>
                <button class="half-button">
                <i class="fa-solid fa-check"></i>
                </button>
            </div>
        `)
        $.post('https://IF-multijob/changeJob', JSON.stringify({
            job: id.toString(),
            grade: info.toString()
        }));
    }
}

function populateMenu(jobs){
    $('.jobs').html(JSON.parse(jobs).length === 0 ? '<h3 style="margin: auto;">You have no jobs</h3>':
        JSON.parse(jobs).map(job => {
            return `
            <div class="job">
                <div class="badge-info">
                    <i class="${job.icon} icon"></i>
                    <div class="job-info">
                        <h4 class="text">${job.jobLabel}</h4>
                        <h5 class="text">${job.gradeLabel}</h4>
                    </div>
                </div>
                <div class="money-select">
                    <i class="bi bi-currency-dollar job-icon"></i>
                    <h4>${job.salary}</h4>
                    <button class="button job-selectButton" id="${job.job}" data-grade="${job.grade}">Chose</button>   
                </div>
            </div>
        `
        //translatable
        })
    )
}



/* ------------------------------ end of functions ------------------------------- */

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                populateMenu(event.data.jobInfo)
                $(`#${event.data.job}`).replaceWith( `
                    <div class="job-selectButton" id="${event.data.job}" data-grade="${event.data.currentGrade}">
                        <button class="half-button2" id="delete-button" data-name="${event.data.job}">
                        <i class="fa-solid fa-trash"></i>
                        </button>
                        <button class="half-button">
                        <i class="fa-solid fa-check"></i>
                        </button>
                    </div>
                `);
                $('#duty-button').html(event.data.duty?"Chose":"SELECTED");//translatable
                $(document.body).fadeIn(200, function(){
                    $(document.body).css('display', 'block');
                });
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch(event.key) {
        case 'Escape':
           exit();
        break;
    }
});

$(document).on("click", ".exit", function(e){
    e.preventDefault();
    exit()
})

$(document).on("click", ".button", function(e){
    e.preventDefault();
    changeButton($(this).attr('id'), $(this).data('grade'))
})



$(document).on("click", ".half-button2", function(e){
    e.preventDefault();
    if ($(this).attr('id') === 'delete-button') {
        changeButton($(this).attr('id'), $(this).data('name'))
    }
})




