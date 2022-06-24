var selectedWindow = ""
var table = [];
var reportsList = [];
var reportOpened = "";
var ReportCategoriesTranslation = [];

window.addEventListener('message', function(event) {
	item = event.data;
	switch (item.action) {
		case 'clientNoReport':
			selectedWindow = "clientNoReport";
			$('#category-chooser').html(`
				<input type="radio" class="btn-check player_report" name="category" value="player_report" id="player_report" checked>
				<label class="btn btn-primary category_pr" for="player_report"><i class="fas fa-user-alt"></i> ${ReportCategoriesTranslation.player}</label>
				<input type="radio" class="btn-check question" name="category" value="question" id="question">
				<label class="btn btn-primary" for="question"><i class="fas fa-question"></i> ${ReportCategoriesTranslation.question}</label>
				<input type="radio" class="btn-check bug" name="category" value="bug" id="bug">
				<label class="btn btn-primary category_bug" for="bug"><i class="fas fa-bug"></i> ${ReportCategoriesTranslation.bug}</label>
			`);
			$('.report_menu').fadeIn();
			break
		case 'clientWithReport':
			selectedWindow = "clientWithReport";
			var reportInfo = item.data;

			$('#myReport_view-report_id').html(reportInfo.id);
			$('#myReport_subtitle').html(reportInfo.name+' | ID: '+reportInfo.source);
			if(reportInfo.category == ReportCategoriesTranslation.player){
				$('#myReport_category').html(`<i class="fas fa-user-alt"></i> ${reportInfo.category}`);
			} else if(reportInfo.category == ReportCategoriesTranslation.question){
				$('#myReport_category').html(`<i class="fas fa-question"></i> ${reportInfo.category}`);
			} else if(reportInfo.category == ReportCategoriesTranslation.bug){
				$('#myReport_category').html(`<i class="fas fa-bug"></i> ${reportInfo.category}`);
			}
			$('#myReport_title').html(reportInfo.title);
			$('#myReport_desc').html(reportInfo.desc);
			$('#myReport_chat').html('');

			var i = 0, len = reportInfo.msgs.length;
			var row = ``;
			while (i < len) {
				row += reportInfo.msgs[i]
				i++
			}
			$("#myReport_chat").html(row);

			if(reportInfo.isAdminAssisting){
				$('#myreport_buttons').html(``);
				$(".report_player_view_card-body").css("padding", "0.2rem 1rem 0rem 1rem");
			} else {
				$('#myreport_buttons').html(`
					<div class="col" style="padding-left: 0.375rem;">
						<button type="button" class="btn btn-red adminactions-button" data-bs-toggle="modal" data-bs-target="#cancel_myReport" style="width: 32.5%;"><i class="fas fa-times"></i> CANCEL</button>
					</div>
				`);
				$(".report_player_view_card-body").css("padding", "0.2rem 1rem 1rem 1rem");
			}
			
			$('.report_player_view').fadeIn();

			var msgDiv = document.getElementById("myReport_chat");
			msgDiv.scrollTop = msgDiv.scrollHeight;
			break
		case 'updateAnswers':
			if(selectedWindow == "clientWithReport") {
				$.post('https://okokReports/action', JSON.stringify({
					action: "setFocusToUI"
				}));
				$('#myReport_chat').html('');
				var i = 0, len = item.msgs.length;
				var row = ``;
				while (i < len) {
					row += item.msgs[i]
					i++
				}
				$("#myReport_chat").html(row);
				var msgDiv = document.getElementById("myReport_chat");
				msgDiv.scrollTop = msgDiv.scrollHeight;
			} else if(selectedWindow == "viewReport") {
				$.post('https://okokReports/action', JSON.stringify({
					action: "setFocusToUI"
				}));
				$('#reports_view_answers').html('');
				var i = 0, len = item.msgs.length;
				var row = ``;
				while (i < len) {
					row += item.msgs[i]
					i++
				}
				$("#reports_view_answers").html(row);
				var msgDiv = document.getElementById("reports_view_answers");
				msgDiv.scrollTop = msgDiv.scrollHeight;
			} 			
			break
		case 'openAdminMenu':
			selectedWindow = "openAdminMenu";

			reportsList = item.reports;

			$("#reportsTableData").html('');
			var row = ``;
			var total = 0;
			$.each(reportsList, function( index, value ) { 
				total += 1;
				if(value.isBeingHelped) {
					row += `
						<tr>
							<td class="text-center align-middle">${value.id}</td>
							<td class="text-center align-middle">${value.name}</td>
							<th class="text-center align-middle">${value.category}</th>
							<td class="text-center align-middle being-attended">${value.admin_name}</td>
							<td class="text-center align-middle"><button type="button" id="view_report_btn" data-report_index="${index}" class="btn btn-blue btn-view"><i class="fas fa-eye"></i> VIEW</button></td>
						</tr>
					`;
				} else {
					row += `
						<tr>
							<td class="text-center align-middle">${value.id}</td>
							<td class="text-center align-middle">${value.name}</td>
							<th class="text-center align-middle">${value.category}</th>
							<td class="text-center align-middle">${value.admin_name}</td>
							<td class="text-center align-middle"><button type="button" id="view_report_btn" data-report_index="${index}" class="btn btn-blue btn-view"><i class="fas fa-eye"></i> VIEW</button></td>
						</tr>
					`;
				}				
			});
			$("#reportsTableData").html(row);

			var table_id = document.getElementById('reportsTable');
			var dataTable = undefined;
			table.push(dataTable = new simpleDatatables.DataTable(table_id, {
				perPageSelect: false,
				perPage: 5,
				searchable: false,
			}));
			let columns = dataTable.columns();
			columns.sort(0, "asc");

			if (total < 6){
				$(".dataTable-bottom").css("margin-top", "-0.95rem");
			} else {
				$(".dataTable-bottom").css("margin-top", "0.563rem");
			}

			$('.reports_menu').fadeIn();
			break
		case 'viewReport':
			
			var report_id = item.index;
			reportsList = item.reports;
			var report = reportsList[report_id];
			if(report == undefined){
				$.post('https://okokReports/action', JSON.stringify({
					action: "reportNotExist"
				}));
				closeMenu();
			} else {
				reportOpened = report_id;

				selectedWindow = "viewReport";

				$('#reports_view-report_id').html(report.id);
				$('#reports_view_subtitle').html(report.name+' | ID: '+report.source);
				if(report.category == ReportCategoriesTranslation.player){
					$('#reports_view_category').html(`<i class="fas fa-user-alt"></i> ${report.category}`);
				} else if(report.category == ReportCategoriesTranslation.question){
					$('#reports_view_category').html(`<i class="fas fa-question"></i> ${report.category}`);
				} else if(report.category == ReportCategoriesTranslation.bug){
					$('#reports_view_category').html(`<i class="fas fa-bug"></i> ${report.category}`);
				}
				$('#reports_view_title').html(report.title);
				$('#reports_view_description').html(report.desc);

				$('#reports_view_answers').html('');
				var i = 0, len = report.msgs.length;
				var row = ``;
				while (i < len) {
					row += report.msgs[i]
					i++
				}
				$("#reports_view_answers").html(row);

				$('.reports_menu').fadeOut();
				$('.reports_view').fadeIn();

				var msgDiv = document.getElementById("reports_view_answers");
				msgDiv.scrollTop = msgDiv.scrollHeight;

				setTimeout(function(){
					for(var i=0; i<table.length; i++) {
						table[i].destroy();
						table.splice(i, 1);
					}
				}, 500);
			}
			break
	}
});

$(document).on('click', "#submit_report", function() {
	var category = $("input[name='category']:checked").val();
	var title = $("#title_sub_rep").val();
	var description = $("#description_sub_rep").val();

	if(category == 'player_report'){
		category = ReportCategoriesTranslation.player;
	} else if(category == 'question'){
		category = ReportCategoriesTranslation.question;
	} else if(category == 'bug'){
		category = ReportCategoriesTranslation.bug;
	}

	$.post('https://okokReports/action', JSON.stringify({
		action: "submitReport",
		category: category,
		title: title,
		description: description
	}));
	closeMenu();
});

$(document).on('click', "#answer_report_button", function() {
	var answer = $("#answer_text").val();

	$.post('https://okokReports/action', JSON.stringify({
		action: "submitAnswer",
		msg: answer,
		selectedWindow: selectedWindow,
		reportSelected: reportOpened
	}));
	$("#answer_text").val('');
	document.getElementById('answer_report_button').disabled = true;
});

$(document).on('click', "#my_answer_report_button", function() {
	var answer = $("#my_answer_text").val();

	$.post('https://okokReports/action', JSON.stringify({
		action: "submitAnswer",
		msg: answer,
		selectedWindow: selectedWindow,
		reportSelected: reportOpened
	}));
	$("#my_answer_text").val('');
	document.getElementById('my_answer_report_button').disabled = true;
});

$(document).on('click', "#cancel_myReport_btn_modal", function() {
	if(selectedWindow == "clientWithReport"){
		$.post('https://okokReports/action', JSON.stringify({
			action: "cancelReport"
		}));
		closeMenu();
	} else {
		$.post('https://okokReports/action', JSON.stringify({
			action: "conclude",
			reportOpened: reportOpened
		}));
		closeMenu();
	}
});

$(document).on('click', "#view_report_btn", function() {
	var report_id = $(this).data("report_index");
	$.post('https://okokReports/action', JSON.stringify({
		action: "view_report",
		report_id: report_id
	}));
});

$(document).on('click', "#goto_report", function() {
	$.post('https://okokReports/action', JSON.stringify({
		action: "goto",
		reportOpened: reportOpened
	}));
	closeMenu();
});

$(document).on('click', "#bring_report", function() {
	$.post('https://okokReports/action', JSON.stringify({
		action: "bring",
		reportOpened: reportOpened
	}));
	closeMenu();
});

$(document).on('click', "#back_reportlist", function() {
	$('.reports_view').fadeOut();
	$.post('https://okokReports/action', JSON.stringify({
		action: "reportList"
	}));
	$("#answer_text").val('');
});

function checkIfEmpty() {
	if(selectedWindow == "clientNoReport") {
		if(document.getElementById("title_sub_rep").value == "" || document.getElementById("description_sub_rep").value == ""){
			document.getElementById('submit_report').disabled = true;
		} else {
			document.getElementById('submit_report').disabled = false;
		}
	} else {
		if(document.getElementById("answer_text").value == ""){
			document.getElementById('answer_report_button').disabled = true;
		} else {
			document.getElementById('answer_report_button').disabled = false;
		}

		if(document.getElementById("my_answer_text").value == ""){
			document.getElementById('my_answer_report_button').disabled = true;
		} else {
			document.getElementById('my_answer_report_button').disabled = false;
		}
	}
}

function closeMenu(){
	if(selectedWindow != ""){
		$('.report_menu').fadeOut();
		$('.report_player_view').fadeOut();
		$('.reports_menu').fadeOut();
		$('.reports_view').fadeOut();

		$.post('https://okokReports/action', JSON.stringify({
			action: "closeReports",
		}));

		setTimeout(function(){
			if(selectedWindow == "clientNoReport"){
				$('#title_sub_rep').val('');
				$('#description_sub_rep').val('');
			}

			for(var i=0; i<table.length; i++) {
				table[i].destroy();
				table.splice(i, 1);
			}
			$("#answer_text").val('');
			$("#my_answer_text").val('');
			$('.modal').modal('hide');
			
			selectedWindow = ""
		}, 500);
	}
}

$(document).on('click', "#closeReportMenu", function() {
	closeMenu();
});

$(document).on('click', "#closeReportsMenu", function() {
	closeMenu();
});

$(document).on('click', "#closeReportsViewMenu", function() {
	closeMenu();
});

$(document).on('click', "#closeReportPlayerViewMenu", function() {
	closeMenu();
});

$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			closeMenu();
		} else if (data.which == 13) {
			if(selectedWindow == "clientWithReport"){
				if(!$("#my_answer_report_button").is(":disabled")){
					$("#my_answer_report_button").click();
				}
			} else if(selectedWindow == "viewReport"){
				if(!$("#answer_report_button").is(":disabled")){
					$("#answer_report_button").click();
				}
			}
		}
	};
});

fetch(`https://okokReports/request_config`).then(response => {
	if (response.ok) {
		response.json().then(data => {
			Config = data
			ReportCategoriesTranslation = Config.ReportCategoriesTranslation;
		})
	} else {
		console.log('okokNotify: NUI error (could not fetch config)')
	}
})