let myChart
let config
window.addEventListener("message", function(event) {
	let item = event.data;
	$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
	if (item.price) {
		// If is opening the buy request modal
		$('#modal-p').empty();
		$('#modal-p').append(Lang[item.lang]['confirm_buy_dealer'].format(new Intl.NumberFormat(item.format.location, {style: 'currency',currency: item.format.currency}).format(item.price)));
		
		$('#cancel-button-modal4').text(Lang[item.lang]['cancel_button_modal']);
		$('#modal-confirm').text(Lang[item.lang]['confirm_buy_button_modal']);
		$('#modal-confirm-title').text(Lang[item.lang]['modal_title']);

		$("body").css("display", "");
		$(".main").css("display", "none");
		$(document).ready(function() {
			$("#buyModal").modal({show: true});
		});
	} else if (item.isCustomer) {
		// If is customer
		config = item.dados.config;
		let lang = config.lang
		let dealership_owner = item.dados.dealership_owner;
		let dealership_hired_players = item.dados.dealership_hired_players;
		let owned_vehicles = item.dados.owned_vehicles;
		let dealership_requests = item.dados.dealership_requests;
		let user_id = item.dados.user_id;

		$('#pages-list').empty();
		$('#sidebar-ul').empty();
		$('#sidebar-ul').append(`
		<li onclick="changePage(8)" id="sidebar-owned">
			<i class="fas fa-warehouse"></i>
			<div style="height:0;">
				<span class="tooltip">${Lang[lang]['nav_menu_o_vehs']}</span>
			</div>
		</li>
		<li onclick="changePage(2)" id="vhlist">
			<i class="fas fa-car"></i>
			<div style="height:0;">
				<span class="tooltip">${Lang[lang]['nav_menu_vehs']}</span>
			</div>
		</li>
		<li onclick="changePage(6)" id="customerRequests">
			<i class="fas fa-edit"></i>
			<div style="height:0;">
				<span class="tooltip">${Lang[lang]['nav_menu_requests']}</span>
			</div>
		</li>
		<li onclick="changePage(7)" id="dealershipInfos">
			<i class="fas fa-user-tie"></i>
			<div style="height:0;">
				<span class="tooltip">${Lang[lang]['nav_menu_infos']}</span>
			</div>
		</li>
		`);
		$('#pages-list').empty();
		for (const page in config.dealership_types.pagination) {
			var page_name = config.dealership_types.pagination[page].replace(' ', '-');
			$('#pages-list').append(`<li class="menu__group"><a onclick="changeVehiclePage('${page_name}')" class="menu__link r-link text-underlined active">${config.dealership_types.pagination[page]}</a></li>`);
		}

		let arr_stock = {}
		let arr_stock_prices = {}
		if (dealership_owner.stock != false) {
			arr_stock = JSON.parse(dealership_owner.stock)
			arr_stock_prices = JSON.parse(dealership_owner.stock_prices);
		}
		
		$('#vehicles-list').empty();
		for (const key in config.dealership_types.vehicles) {
			let vehicle = config.dealership_types.vehicles[key]
			if (dealership_owner.stock == false) {
				// If does not have owner
				if (config.default_stock == false) {
					if (dealership_owner.dealership_stock[key]) {
						arr_stock[key] = dealership_owner.dealership_stock[key];
					} else {
						arr_stock[key] = 0;
					}
				} else {
					arr_stock[key] = config.default_stock;
				}
				arr_stock_prices[key] = vehicle.price_to_customer
			}else {
				if(arr_stock[key] == undefined) {
					// If does not have stock
					arr_stock[key] = 0;
				}
				if(arr_stock_prices[key] == undefined) {
					// If does not have price defined
					arr_stock_prices[key] = vehicle.price_to_customer;
				}
			}
			let buttons_html = `
				<button onclick="buyVehicle('${key}')" class="add-stock-car" style="border-right-width: 0px;">${Lang[lang]['buy_vehicle']}</button>
				<button onclick="previewVehicle('${key}')" class="add-stock-car">${Lang[lang]['preview']}</button>`;
			if (arr_stock[key] == 0) {
				buttons_html = `
					<button onclick="requestVehicle('${key}')" class="request-car-button">${Lang[lang]['request_vehicle']}</button>
					<input id="request-car-input-${key}" class="sell-car-input" type="number" placeholder="${Lang[lang]['price']}" min="1" max="9999999">`;
			}
			var page_name = config.dealership_types.pagination[vehicle.page].replace(' ', '-');
			$('#vehicles-list').append(`
				<div class="card ${page_name}" style="display: none;" data-price="${arr_stock_prices[key]}" data-stock="${arr_stock[key]}" data-name="${vehicle.name}">
					<img class="card-img" src="${vehicle.img}" alt="Avatar">
					<div class="vh-container">
						<div class="price">
							<h4><b>${vehicle.name}</b></h4> 
						</div>
						<div class="price">
							<h4>
								<b>${Lang[lang]['price']}</b>
								<span>${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(arr_stock_prices[key])}</span>
							</h4>
						</div>
						<div class="stock">
							<h4><b>${Lang[lang]['stock']}</b><span>${arr_stock[key]}</span></h4> 
						</div>
						<div class="card-buttons">
							${buttons_html}
						</div>
					</div>
				</div>
			`);
		}
		
		$('#o-vehicles-list').empty();
		for (const key of owned_vehicles) {
			let vehicle = config.dealership_types.vehicles[key.vehicle]
			if (vehicle != undefined) {
				let buttons_html = `
				<button onclick="sellVehicle('${key.vehicle}','${key.plate}')" class="sell-car-button">${Lang[lang]['sell_vehicle']}</button>
				<input id="sell-car-input-${key.plate}" class="sell-car-input" type="number" placeholder="${Lang[lang]['price']}" min="1" max="9999999">`;
				if (key.status == 0) {
					buttons_html = `
					<button style="width:80%; background-color: transparent; color: 000;" class="sell-car-button">${Lang[lang]['pending']}</button>
					<button style="width:20%;" onclick="cancelSellVehicle('${key.id}')" class="sell-car-button"><i class="fas fa-close"></i></button>`;
				} else if (key.status == 1) {
					buttons_html = `<button style="width:100%; background-color: transparent; color: 000;" class="sell-car-button">${Lang[lang]['inprogress']}</button>`;
				} else if (key.status == 2) {
					buttons_html = `
					<button style="width:80%; background-color: transparent; color: 000;" class="sell-car-button">${Lang[lang]['completed']}</button>
					<button style="width:20%;" onclick="finishSellVehicle('${key.id}')" class="sell-car-button-completed"><i class="fas fa-check"></i></button>`;
				} else if (key.status == 3) {
					buttons_html = `
					<button style="width:80%; background-color: transparent; color: 000;" class="sell-car-button">${Lang[lang]['cancelled']}</button>
					<button style="width:20%;" onclick="cancelSellVehicle('${key.id}')" class="sell-car-button"><i class="fas fa-close"></i></button>`;
				}
				$('#o-vehicles-list').append(`
					<div class="card owned">
						<img class="card-img" src="${vehicle.img}" alt="Avatar">
						<div class="vh-container">
							<div class="price">
								<h4><b>${vehicle.name}</b></h4> 
							</div>
							<div class="price">
								<h4>
									<b>${Lang[lang]['price']}</b>
									<span>${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(arr_stock_prices[key.vehicle])}</span>
								</h4>
							</div>
							<div class="stock">
								<h4><b>${Lang[lang]['plate']}</b><span>${key.plate}</span></h4> 
							</div>
							<div class="card-buttons">
								${buttons_html}
							</div>
						</div>
					</div>
				`);
			}
		}

		$('#employees-page-ul').empty();
		if (dealership_owner.stock != false) { // If has owner
			$('#employees-page-ul').append(`
				<li>
					<a class="employee-card">
						<img src="${dealership_owner.banner_img}" class="employee-card__image" alt="" />
						<div class="employee-card__overlay">
							<div class="employee-card__header">
								<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
								<img class="employee-card__thumb" src="${dealership_owner.profile_img}" alt="" />
								<div class="employee-card__header-text">
									<h3 class="employee-card__title">${dealership_owner.name}</h3>
									<span class="employee-card__status">${Lang[lang]['owner_desc']}</span>
								</div>
							</div>
						</div>
					</a>
				</li>
			`);

			for (const key in dealership_hired_players) {
				let player = dealership_hired_players[key];
				$('#employees-page-ul').append(`
					<li>
						<a class="employee-card">
							<img src="${player.banner_img}" class="employee-card__image" alt="" />
							<div class="employee-card__overlay">
								<div class="employee-card__header">
									<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
									<img class="employee-card__thumb" src="${player.profile_img}" alt="" />
									<div class="employee-card__header-text">
										<h3 class="employee-card__title">${player.name}</h3>
										<span class="employee-card__status">${Lang[lang]['employee_desc']}</span>
									</div>
								</div>
							</div>
						</a>
					</li>
				`);
			}
		} else {
			$('#employees-page-ul').append(`
				<li>
					<a class="employee-card">
						<img src="https://www.bossecurity.com/wp-content/uploads/2018/10/night-time-drive-bys-1024x683.jpg" class="employee-card__image" alt="" />
						<div class="employee-card__overlay">
							<div class="employee-card__header">
								<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
								<img class="employee-card__thumb" src="https://amar.amr.org.br/packages/trustir/exclusiva/img/user_placeholder.png" alt="" />
								<div class="employee-card__header-text">
									<h3 class="employee-card__title">${Lang[lang]['empty_dealer']}</h3>
									<span class="employee-card__status">${Lang[lang]['no_one_there']}</span>
								</div>
							</div>
						</div>
					</a>
				</li>
			`);
		}

		$('#request-table-body').empty();
		for (const key in dealership_requests) {
			let request = dealership_requests[key];
			if (request.request_type == 1 && config.dealership_types.vehicles[request.vehicle] != undefined) {
				let button_html = ``;
				let text = '';
				let color = 'grey';
				if (request.status == 0) {
					color = 'grey';
					text = Lang[lang]['request_status_1'];
					if (request.user_id == user_id) {
						button_html = `<button onclick="cancelRequest('${request.id}')" class="request-car-button" style="width:100%">${Lang[lang]['cancel_request']}</button>`;
					}
				} else if (request.status == 1) {
					color = 'Orange';
					text = Lang[lang]['request_status_2'];
					button_html = ``;
				} else if (request.status == 2) {
					color = '#12a454';
					text = Lang[lang]['request_status_3'];
					if (request.user_id == user_id) {
						button_html = `<button onclick="finishRequest('${request.id}')" class="request-car-button" style="width:100%">${Lang[lang]['finish_request']}</button>`
					}
				} else if (request.status == 3) {
					color = '#e92929';
					text = Lang[lang]['request_status_4'];
					if (request.user_id == user_id) {
						button_html = `<button onclick="cancelRequest('${request.id}')" class="request-car-button" style="width:100%">${Lang[lang]['cancel_request']}</button>`;
					}
				}
				$('#request-table-body').append(`
					<tr>
						<td class="description">${config.dealership_types.vehicles[request.vehicle].name}</td>
						<td class="description" style="text-align: center;">${request.name}</td>
						<td class="expense" style="text-align: center;">${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(request.price)}</td>
						<td class="" style="text-align: center; color: ${color}">${text}</td>
						<td class="" style="width:0px"></td>
						<td class="date" style="text-align: end;min-width: 160px;">${button_html}</td>
					</tr>
				`);
			}
		}
		
		if(item.update != true){
			// Check if it updating the interface, if not updating, open it
			$('.sidebar ul li').removeClass('active');
			$('#sidebar-owned').addClass('active');
			changePage(8);
			
			$("body").css("display", "");
			$(".main").css("display", "");
			$(".actionmenu").fadeIn();
			
			$('#vhlist-title').text(Lang[lang]['vlist_title']);
			$('#o-vhlist-title').text(Lang[lang]['owned_vlist_title']);
			$('#employees-page-title').text(Lang[lang]['employees_details_title']);
			$('#open-requests-title').text(Lang[lang]['open_requests_title']);
			$('#request-th-1').text(Lang[lang]['request_table_head_1']);
			$('#request-th-2').text(Lang[lang]['request_table_head_2']);
			$('#request-th-3').text(Lang[lang]['request_table_head_3']);
			$('#request-th-4').text(Lang[lang]['request_table_head_4']);
			$('#request-th-5').text(Lang[lang]['request_table_head_5']);
		}
		changeVehiclePage(config.dealership_types.pagination[0]);

	} else if (item.showmenu) {
		// If is owner
		config = item.dados.config;
		let lang = config.lang
		let dealership_owner = item.dados.dealership_owner;
		let dealership_hired_players = item.dados.dealership_hired_players;
		let dealership_balance = item.dados.dealership_balance;
		let players = item.dados.players;
		let dealership_requests = item.dados.dealership_requests;
		let user_id = item.dados.user_id;
		
		$('#sidebar-ul').empty();
		$('#sidebar-ul').append(`
			<li id="sidebar-1" onclick="changePage(1)" id="profile">
				<i class="fas fa-user-circle"></i>
				<div style="height:0;">
					<span class="tooltip" >${Lang[lang]['nav_menu_profile']}</span>
				</div>
			</li>
			<li onclick="changePage(2)" id="vhlist">
				<i class="fas fa-car"></i>
				<div style="height:0;">
					<span class="tooltip">${Lang[lang]['nav_menu_vehs']}</span>
				</div>
			</li>
			<li onclick="changePage(3)" id="order">
				<i class="fas fa-users"></i>
				<div style="height:0;">
					<span class="tooltip" >${Lang[lang]['nav_menu_hire']}</span>
				</div>
			</li>
			<li onclick="changePage(4)" id="bank">
				<i class="fas fa-dollar-sign"></i>
				<div style="height:0;">
					<span class="tooltip">${Lang[lang]['nav_menu_bank']}</span>
				</div>
			</li>
			<li onclick="changePage(6)" id="order">
				<i class="fas fa-box-open"></i>
				<div style="height:0;">
					<span class="tooltip" >${Lang[lang]['nav_menu_order']}</span>
				</div>
			</li>
			<li onclick="changePage(7)" id="dealershipInfos">
				<i class="fas fa-user-tie"></i>
				<div style="height:0;">
					<span class="tooltip">${Lang[lang]['nav_menu_infos']}</span>
				</div>
			</li>
			<li href="#myModal" data-toggle="modal" >
				<i class="fas fa-times"></i>
				<div style="height:0;">
					<span class="tooltip">${Lang[lang]['nav_menu_sell']}</span>
				</div>
			</li>
		`);

		var str_low_stock = '';
		$('#warning-type').css("display", "none");
		if(config.warning == 1){
			str_low_stock = Lang[lang]['low_stock'];
			$('#warning-type').css("display", "");
		}else if(config.warning == 2){
			str_low_stock = Lang[lang]['low_stock2'];
			$('#warning-type').css("display", "");
		}
		$('#warning-type').empty();
		$('#warning-type').append(str_low_stock);

		$('#pages-list').empty();
		for (const page in config.dealership_types.pagination) {
			var page_name = config.dealership_types.pagination[page].replace(' ', '-');
			$('#pages-list').append(`<li class="menu__group"><a onclick="changeVehiclePage('${page_name}')" class="menu__link r-link text-underlined active">${config.dealership_types.pagination[page]}</a></li>`);
		}

		let arr_stock_sold = JSON.parse(dealership_owner.stock_sold);
		$('#statics-cards-div').empty();
		let no_vehicles = true;

		let sortedArray = Object.keys(arr_stock_sold).map((key) => [key, arr_stock_sold[key]]).sort(function(a, b) {return b[1] - a[1];});
		let c = 0;
		for (const key of sortedArray) {
			no_vehicles = false;
			let vehicle = config.dealership_types.vehicles[key[0]]
			if (vehicle != undefined) {
				$('#statics-cards-div').append(`
					<div class="statics-card">
						<img src="${vehicle.img}" alt="Avatar" style="width:100%">
						<div class="statics-container">
							<div class="name-car">
								<h4><b>${Lang[lang]['vehicle']}:</b>${vehicle.name}</h4> 
							</div>
							<div class="total-vehicle-sales">
								<h4><b>${Lang[lang]['total_sell']}</b>${arr_stock_sold[key[0]]}</h4> 
							</div>
						</div>
					</div>
				`);
				if (c >= 2){
					break;
				}
				c++;
			}
		}
		if(no_vehicles){
			$('#statics-cards-div').append(`
				<div class="statics-card">
					<img src="images/carro_coberto.jpg" alt="Avatar" style="width:100%">
					<div class="statics-container">
						<div class="name-car">
							<h4><b>${Lang[lang]['nothing_sold']}</b></h4> 
						</div>
					</div>
				</div>
			`);
		}
		
		let arr_stock = JSON.parse(dealership_owner.stock);
		let arr_stock_prices = JSON.parse(dealership_owner.stock_prices);
		$('#vehicles-list').empty();
		for (const key in config.dealership_types.vehicles) {
			let vehicle = config.dealership_types.vehicles[key]
			if (vehicle != undefined) {
				if(arr_stock[key] == undefined) {
					arr_stock[key] = 0;
				}
				if(arr_stock_prices[key] == undefined) {
					arr_stock_prices[key] = vehicle.price_to_customer;
				}
				let display = 'display: none;'
				if (config.dealership_types.pagination[vehicle.page] == config.dealership_types.pagination[0]) {
					display = ''
				}
				let hclass = '';
				if(arr_stock[key] == 0){
					hclass = 'span-no-stock';
				}

				if (config.dealership_types.pagination[vehicle.page]) {
					var page_name = config.dealership_types.pagination[vehicle.page].replace(' ', '-');
					$('#vehicles-list').append(`
						<div style="height: 418px;" class="card ${page_name}" style="${display}" data-price="${arr_stock_prices[key]}" data-stock="${arr_stock[key]}" data-name="${vehicle.name}">
							<img class="card-img" src="${vehicle.img}" alt="Avatar">
							<div class="vh-container">
								<div class="price">
									<h4><b>${vehicle.name}</b></h4> 
								</div>
								<div class="card-text-container">
									<h4 style="margin:0; width:100%"><b>${Lang[lang]['import_price']}</b></h4>
									${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(vehicle.price_to_owner)}
								</div>
								<div class="card-text-container">
									<h4 style="margin:0; width:100%"><b>${Lang[lang]['customer_price']}</b></h4>
									<div style="display: flex;">
										<span>${getCurrencySymbol(config.format.location, config.format.currency)}</span><input id="set-price-car-input-${key}" class="set-price-car-input" type="number" placeholder="${Lang[lang]['price']}" min="1" max="9999999" value="${arr_stock_prices[key]}">
										<button onclick="setPrice('${key}')" class="set-price-car-button"><i class="fas fa-check"></i></button>
									</div>
								</div>
								<div class="card-text-container">
									<h4 style="margin:0; width:100%"><b>${Lang[lang]['stock']}</b></h4>
									<span class="${hclass}">${arr_stock[key]}</span>
								</div>
								<div class="card-buttons">
									<button onclick="importVehicle('${key}')" class="add-stock-car" style="border-right-width: 0px;">${Lang[lang]['import']}</button>
									<button onclick="exportVehicle('${key}')" class="add-stock-car">${Lang[lang]['export']}</button>
								</div>
							</div>
						</div>
					`);
				}
			}
		}
		$('#bank-card-div').empty();
		$('#bank-card-div').append(`
			<div class="statics-card" style="width: 46%;">
				<div onclick="withdrawMoney()" class="money-earned-container">
					<i class="fas fa-arrow-circle-up" style="font-size: 50px; margin-top: 0.8rem;"></i>
					<h2 style="justify-self: left;"><small>${Lang[lang]['withdraw']}</small></h2>
					<h2>${Lang[lang]['your_money']} <span style="color: green;">${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(dealership_owner.money)}</span></h2>
				</div>
			</div>
			<div class="statics-card" style="width: 46%">
				<div class="money-earned-container" style="color: green; margin-top: 1.15rem;">
					<input id="input-deposit-money" class="input-deposit-money" type="number" min="1" max="9999999">
					<button onclick="depositMoney()" class="button-deposit-money">${Lang[lang]['deposit']}</button>
				</div>
			</div>
		`);

		$('#input-hire-player').empty();
		for (const player of players) {
			$('#input-hire-player').append(`<option value="${player.identifier}">${player.name}</option>`);
		}

		$('#hired-players-list').empty();
		for (const user of dealership_hired_players) {
			$('#hired-players-list').append(`
			<div class="new-orders">
				<h4><b>${user.name}</b></h4>
				<span class="price-order">${Lang[lang]['jobs_done']} ${user.jobs_done}</span>
				<span class="price-order">${Lang[lang]['hired_date']} ${timeConverter(user.timer,config.format.location)}</span>
				<input id="input-give-comission" class="input-give-comission" type="number" min="1" max="9999999" placeholder="${Lang[lang]['input_give_comission']}">
				<button onclick="giveComission('${user.user_id}')" class="give-comission-button">${Lang[lang]['button_give_comission']}</button>
				<button onclick="firePlayer('${user.user_id}')" class="fire-employee">${Lang[lang]['button_fire_employee']}</button>
			</div>`);
		}

		$('#employees-page-ul').empty();
		if(user_id == dealership_owner.user_id) {
			$('#employees-page-ul').append(`
				<li>
					<a class="employee-card">
						<img src="${dealership_owner.banner_img}" class="employee-card__image" alt="" />
						<div class="employee-card__overlay">
							<div class="employee-card__header">
								<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
								<img class="employee-card__thumb" src="${dealership_owner.profile_img}" alt="" />
								<div class="employee-card__header-text">
									<span class="employee-card__status">${Lang[lang]['banner_desc']}</span>
									<input id="employee-card__input_banner" class="employee-card__input" type="text" value="${dealership_owner.banner_img}">
									<span class="employee-card__status">${Lang[lang]['profile_desc']}</span>
									<input id="employee-card__input_profile" class="employee-card__input" type="text" value="${dealership_owner.profile_img}">
									<button onclick="changeProfileOwner('${dealership_owner.user_id}')" class="employee-card__button">${Lang[lang]['change_profile']}</button>
								</div>
							</div>
						</div>
					</a>
				</li>
			`);
		} else {
			$('#employees-page-ul').append(`
				<li>
					<a class="employee-card">
						<img src="${dealership_owner.banner_img}" class="employee-card__image" alt="" />
						<div class="employee-card__overlay">
							<div class="employee-card__header">
								<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
								<img class="employee-card__thumb" src="${dealership_owner.profile_img}" alt="" />
								<div class="employee-card__header-text">
									<h3 class="employee-card__title">${dealership_owner.name}</h3>
									<span class="employee-card__status">${Lang[lang]['owner_desc']}</span>
								</div>
							</div>
						</div>
					</a>
				</li>
			`);
		}

		for (const key in dealership_hired_players) {
			let player = dealership_hired_players[key];
			if(user_id == player.user_id) {
				$('#employees-page-ul').append(`
					<li>
						<a class="employee-card">
							<img src="${player.banner_img}" class="employee-card__image" alt="" />
							<div class="employee-card__overlay">
								<div class="employee-card__header">
									<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
									<img class="employee-card__thumb" src="${player.profile_img}" alt="" />
									<div class="employee-card__header-text">
										<span class="employee-card__status">${Lang[lang]['banner_desc']}</span>
										<input id="employee-card__input_banner" class="employee-card__input" type="text" value="${player.banner_img}">
										<span class="employee-card__status">${Lang[lang]['profile_desc']}</span>
										<input id="employee-card__input_profile" class="employee-card__input" type="text" value="${player.profile_img}">
										<button onclick="changeProfile('${player.user_id}')" class="employee-card__button">${Lang[lang]['change_profile']}</button>
									</div>
								</div>
							</div>
						</a>
					</li>
				`);
			} else {
				$('#employees-page-ul').append(`
					<li>
						<a class="employee-card">
							<img src="${player.banner_img}" class="employee-card__image" alt="" />
							<div class="employee-card__overlay">
								<div class="employee-card__header">
									<svg class="employee-card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
									<img class="employee-card__thumb" src="${player.profile_img}" alt="" />
									<div class="employee-card__header-text">
										<h3 class="employee-card__title">${player.name}</h3>
										<span class="employee-card__status">${Lang[lang]['employee_desc']}</span>
									</div>
								</div>
							</div>
						</a>
					</li>
				`);
			}
		}

		$('#request-table-body').empty();
		for (const key in dealership_requests) {
			let request = dealership_requests[key];
			if (config.dealership_types.vehicles[request.vehicle] != undefined) {
				let button_html = `
					<button onclick="acceptRequest(${request.id})" class="accept-request-car-button">${Lang[lang]['accept_request']}</button>
					<button onclick="declineRequest(${request.id})" class="decline-request-car-button">${Lang[lang]['decline_request']}</button>`;
				if (request.status == 1) {
					button_html = ``;
				}
				let text = '';
				let color = 'grey';
				if (request.request_type == 1) {
					color = '#e92929';
					text = Lang[lang]['request_type_1'];
				} else {
					color = '#12a454';
					text = Lang[lang]['request_type_2'];
				}
				let text_status = '';
				let color_status = 'grey';
				if (request.status == 0) {
					color_status = 'grey';
					text_status = Lang[lang]['request_status_1'];
				} else if (request.status == 1) {
					color_status = 'Orange';
					text_status = Lang[lang]['request_status_2'];
				} else if (request.status == 2) {
					color_status = '#12a454';
					text_status = Lang[lang]['request_status_3'];
				} else if (request.status == 3) {
					color_status = '#e92929';
					text_status = Lang[lang]['request_status_4'];
				}
				$('#request-table-body').append(`
					<tr>
						<td class="description">${config.dealership_types.vehicles[request.vehicle].name}</td>
						<td class="description" style="text-align: center;">${request.name}</td>
						<td class="description" style="text-align: center;">${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(request.price)}</td>
						<td class="income" style="text-align: center; color: ${color}">${text}</td>
						<td class="income" style="text-align: center; color: ${color_status}">${text_status}</td>
						<td class="date" style="text-align: end;">${button_html}</td>
					</tr>
				`);
			}
		}

		$('#balance-table').empty();
		$('#client-body').empty();
		let months_arr = []
		months_arr[0] = new Array(12).fill(0);
		months_arr[1] = new Array(12).fill(0);
		
		let date_now = new Date();
		let month_now = date_now.getMonth();
		let month_diff = 11 - month_now
		let ganhos = 0
		let gastos = 0
		let cont = 0
		for (const balance of dealership_balance) {
			let type = 'income'
			if(balance.type == 1) {
				type = 'expense'
			}
			if(balance.isbuy == 1 && cont <= 5){
				cont++;
				$('#client-body').append(`
				<tr>
					<td>${balance.name}</td> 
					<td>${balance.user_id}</td> 
					<td>${balance.description}</td> 
					<td>${timeConverter(balance.date,config.format.location)}</td>
				</tr>`);	
			}
				
			$('#balance-table').append(`
			<tr>
				<td class="description">${balance.description}</td>
				<td class="description">${balance.name}</td>
				<td class="${type}">${new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(balance.amount)}</td>
				<td class="date">${timeConverter(balance.date,config.format.location)}</td>
			</tr>`);

			if (balance.type == 0){
				ganhos += balance.amount			
			}
			else{
				gastos += balance.amount
			}
			
			let date = new Date(balance.date*1000);
			let month = date.getMonth();
			months_arr[balance.type][(month+month_diff)%12] += balance.amount
		}
		$('#ganhos').text(new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(ganhos));
		$('#gastos').text(new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(gastos));
		$('#diferenca').text(new Intl.NumberFormat(config.format.location, {style: 'currency',currency: config.format.currency}).format(ganhos-gastos));

		months_arr[0] = months_arr[0].reverse()
		months_arr[1] = months_arr[1].reverse()

		let labels = [];
		let monthName = Lang[lang]['months_array'];
		let d = new Date();
		d.setDate(1);
		for (i=0; i<=11; i++) {
			labels.push(monthName[d.getMonth()] + ' ' + d.getFullYear());
			d.setMonth(d.getMonth() - 1);
		}
		const chartData = {
		labels: labels,
		datasets: [
			{
				label: Lang[lang]['expenses'],
				data: months_arr[1],
				borderColor: 'rgba(255, 66, 66, 0.6)',
				backgroundColor: 'rgba(255, 66, 66, 0.2)',
				fill: true,
				cubicInterpolationMode: 'monotone',
				tension: 0.4
			},
			{
				label: Lang[lang]['profit'],
				data: months_arr[0],
				borderColor: 'rgba(15, 173, 33, 0.6)',
				backgroundColor: 'rgba(15, 173, 33, 0.2)',
				fill: true,
				cubicInterpolationMode: 'monotone',
				tension: 0.4
			}
		]};

		const chartConfig = {
			type: 'line',
			data: chartData,
			options: {
				responsive: true,
				plugins: {
					legend: {
						position: 'top',
					}
				}
			},
		};
		if(myChart != undefined) {
			myChart.destroy();
		}
		let ctx = document.getElementById('myChart').getContext('2d');
		myChart = new Chart(ctx, chartConfig);

		if(item.update != true){
			$(".profile-page").css("display", "");
			$('.sidebar ul li').removeClass('active');
			$('#sidebar-1').addClass('active');
			$("body").css("display", "");
			$(".main").css("display", "");
			$(".actionmenu").fadeIn();

			$('#statistics-title').text(Lang[lang]['statistics']);
			$('#statistics-title-2').text(Lang[lang]['statistics_top_3']);
			$('#statistics-title-balance').text(Lang[lang]['statistics_balance']);
			$('#last-clients-title').text(Lang[lang]['statistics_clients']);
			$('#th-1').text(Lang[lang]['clients_table_head_1']);
			$('#th-2').text(Lang[lang]['clients_table_head_2']);
			$('#th-3').text(Lang[lang]['clients_table_head_3']);
			$('#th-4').text(Lang[lang]['clients_table_head_4']);
			$('#vhlist-title').text(Lang[lang]['vlist_title']);
			$('#invalid-value').text(Lang[lang]['invalid_value']);
			$('#invalid-value2').text(Lang[lang]['invalid_value']);
			$('#employees-title').text(Lang[lang]['employees_title']);
			$('#employees-page-title').text(Lang[lang]['employees_details_title']);
			$('#button-hire-player').text(Lang[lang]['button_employee']);
			$('#bank-title').text(Lang[lang]['bank_title']);
			$('#bank-status').text(Lang[lang]['bank_status']);
			$('#bank-history-title').text(Lang[lang]['bank_history']);
			$('#bank-th-1').text(Lang[lang]['bank_table_head_1']);
			$('#bank-th-2').text(Lang[lang]['bank_table_head_2']);
			$('#bank-th-3').text(Lang[lang]['bank_table_head_3']);
			$('#bank-th-4').text(Lang[lang]['bank_table_head_4']);
			$('#restock-modal').text(Lang[lang]['restock_modal']);
			$('#restock-modal2').text(Lang[lang]['restock_modal']);
			$('#confirm-button-modal').text(Lang[lang]['confirm_button_modal']);
			$('#confirm-button-modal2').text(Lang[lang]['confirm_button_modal']);
			$('#cancel-button-modal').text(Lang[lang]['cancel_button_modal']);
			$('#cancel-button-modal2').text(Lang[lang]['cancel_button_modal']);
			$('#cancel-button-modal3').text(Lang[lang]['cancel_button_modal']);
			$('#modal-confirm-sell').text(Lang[lang]['confirm_sell_button_modal']);
			$('#modal-desc').text(Lang[lang]['modal_desc']);
			$('#modal-title-sure').text(Lang[lang]['modal_title']);
			$('#open-requests-title').text(Lang[lang]['o_open_requests_title']);
			$('#request-th-1').text(Lang[lang]['o_request_table_head_1']);
			$('#request-th-2').text(Lang[lang]['o_request_table_head_2']);
			$('#request-th-3').text(Lang[lang]['o_request_table_head_3']);
			$('#request-th-4').text(Lang[lang]['o_request_table_head_4']);
			$('#request-th-5').text(Lang[lang]['o_request_table_head_5']);
			$('#request-th-6').text(Lang[lang]['o_request_table_head_6']);
			changeVehiclePage(config.dealership_types.pagination[0]);
			changePage(1);
		}
	} else if (item.hidemenu) {
		// Close menu
		$("body").css("display", "none");
		$('body').css('background-color', 'transparent')
		$(".actionmenu").fadeOut();
	}

	$('.sidebar ul li').on('click', function() {
		$('li').removeClass('active');
		$(this).addClass('active');
	});
});

			
function timeConverter(UNIX_timestamp,locale){
	let a = new Date(UNIX_timestamp * 1000);
	let time = a.toLocaleString(locale);
	return time;
}

document.onkeyup = function(data) {
	if (data.which == 27) {
		closeUI();
	}
};

// ORDER CARS //
$(".order-car").click(function() {
	$(".modal-order-overlay").addClass("active");
})

$(".confirm-modal-order").click(function() {
	let valOrderCars = Number($(".qnt-order-cars").val())
	if (valOrderCars == " " || valOrderCars == 0 || valOrderCars <= 0) {
		$(".notify-order").fadeIn(200)
		setTimeout(function() {
			$(".notify-order").fadeOut()
		}, 2000);
	}
})

$(".cancel-modal-order").click(function() {
	$(".modal-order-overlay").removeClass("active");
})

$(".confirm-modal-stock").click(function() {
	let valStockCars = Number($(".qnt-stock-cars").val())
	if (valStockCars == " " || valStockCars == 0 || valStockCars <= 0) {
		$(".notify-stock").fadeIn(200)
		setTimeout(function() {
			$(".notify-stock").fadeOut()
		}, 2000);
	} else {
		$(".qnt-stock-cars").val(null);
		$(".modal-stock-overlay").removeClass("active");
		let vehicle = $(".modal-stock-overlay").data('vehicle')
		let isexport = $(".modal-stock-overlay").data('isexport')
		$(".modal-stock-overlay").data('vehicle',null)
		$.post('http://dealership/importVehicle', JSON.stringify({vehicle,isexport,valStockCars}));
	}
})
$(".cancel-modal-stock").click(function() {
	$(".modal-stock-overlay").removeClass("active");
})

// BUY MODAL

$('#buyModal').on('hidden.bs.modal', function () {
	closeUI();
})

function openQuestionModal(page) {
	$('#modal-p-question').empty();
	$('#modal-p-question').append(Lang[config.lang]['questions'][page]);
	$('#cancel-button-modal5').text(Lang[config.lang]['cancel_button_modal_question']);
	$('#modal-title-question').text(Lang[config.lang]['modal_title_question']);

	$(document).ready(function() {
		$("#questionModal").modal({show: true});
	});
}

function changePage(pageN) {
	if(pageN == 1) {
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".profile-page").fadeIn(200)
	}else if(pageN == 2) {
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".vhlist-page").fadeIn(200)
	}else if(pageN == 3) {
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".hire-page").fadeIn(200)
	}else if(pageN == 4) {
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".bank-page").fadeIn(200)
	}else if(pageN == 5) {
		// Removed
		// $(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		// $(".order-page").fadeIn(200)
	}else if(pageN == 6) {
		// Customer request
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".open-requests-page").fadeIn(200)
	}else if(pageN == 7) {
		// Dealer infos
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".employees-list-page").fadeIn(200)
	}else if(pageN == 8) {
		// Owned vehicles
		$(".profile-page,.vhlist-page,.o-vhlist-page,.hire-page,.bank-page,.employees-list-page,.open-requests-page").hide()
		$(".o-vhlist-page").fadeIn(200)
	}
}

function filterVehicles(page) {
	let name = document.getElementById('filter-name').value;
	let stock = document.getElementById('filter-stock').checked;
	let min = document.getElementById('filter-min').value;
	let max = document.getElementById('filter-max').value;
	let list = document.getElementById("vehicles-list").getElementsByClassName("card");
	if (list && list.length > 0) {
		for (const cards of list) {
			let classList = cards.className.split(/\s+/);
			if (classList[1] == page) {
				cards.style.display = "";
				if (name != "" && !cards.dataset.name.toLowerCase().includes(name.toLowerCase())) {
					cards.style.display = "none";
				}
				if (stock && cards.dataset.stock == 0) {
					cards.style.display = "none";
				}
				if (parseInt(cards.dataset.price) < parseInt(min) || parseInt(cards.dataset.price) > parseInt(max)) {
					cards.style.display = "none";
				}
			} else {
				cards.style.display = "none";
			}
		}
	}
}

function buyDealership() {
	$.post('http://dealership/buyDealership', JSON.stringify({}));
}

function sellDealership() {
	$.post('http://dealership/sellDealership', JSON.stringify({}));
}

function importVehicle(vehicle) {
	$(".modal-stock-overlay").addClass("active");
	$(".modal-stock-overlay").data('vehicle',vehicle);
	$(".modal-stock-overlay").data('isexport',0);
}

function exportVehicle(vehicle) {
	$(".modal-stock-overlay").addClass("active");
	$(".modal-stock-overlay").data('vehicle',vehicle);
	$(".modal-stock-overlay").data('isexport',1);
}

function buyVehicle(vehicle) {
	$.post('http://dealership/buyVehicle', JSON.stringify({vehicle}));
}

function depositMoney(){
	let amount = document.getElementById('input-deposit-money').value;
	document.getElementById('input-deposit-money').value = null;
	$.post('http://dealership/depositMoney', JSON.stringify({amount}));
}

function withdrawMoney(){
	$.post('http://dealership/withdrawMoney', JSON.stringify({}));
}

function changeVehiclePage(page) {
	let min = -1;
	let max = 0;

	let list = document.getElementById("vehicles-list").getElementsByClassName("card");
	if (list && list.length > 0) {
		for (const cards of list) {
			if (!cards.className.includes(page)){
				cards.style.display = "none"
			} else {
				cards.style.display = ""
				if (min == -1 || min > parseInt(cards.dataset.price)) {
					min = parseInt(cards.dataset.price);
				}
				if (max < parseInt(cards.dataset.price)) {
					max = parseInt(cards.dataset.price);
				}
			}
		}
	}
	min = Math.floor(min/1000)*1000;
	max = Math.ceil(max/1000)*1000;
	$('#filter-vehicles-container').empty();
	$('#filter-vehicles-container').append(`
		<h2 style="border-bottom: 2px solid #00000033;"><b>${Lang[config.lang]['filter_title']}</b></h2>
		<div>
			<h4 style="margin-bottom: 5px;"><b>${Lang[config.lang]['filter_name']}</b></h4> 
			<input id="filter-name" class="filter-name-input" type="text" placeholder="${Lang[config.lang]['filter_name_placeholder']}">
		</div>
		<label for="filter-stock">
			<div>
				<h4 style="margin-bottom: 5px;"><b>${Lang[config.lang]['filter_stock']}</b></h4> 
				<input id="filter-stock" class="filter-name-input" type="checkbox">
			</div>
		</label>
		<div>
			<h4 style="border-top: 2px solid #00000033; margin-top: 6px; padding-top: 14px;"><b>${Lang[config.lang]['filter_price']}</b></h4> 
			<h4>${Lang[config.lang]['filter_min']}</h4> 
			<div class="range-slider" style='--min:${min}; --max:${max}; --step:1000; --value:${min}; --text-value:"${min}"; --prefix:"${getCurrencySymbol(config.format.location, config.format.currency)} ";'>
				<input id="filter-min" type="range" min="${min}" max="${max}" step="1000" value="${min}" oninput="this.parentNode.style.setProperty('--value',this.value); this.parentNode.style.setProperty('--text-value', JSON.stringify(this.value))">
				<output></output>
				<div class='range-slider__progress'></div>
			</div>
			<h4 style="margin-top: 0;">${Lang[config.lang]['filter_max']}</h4> 
			<div class="range-slider" style='--min:${min}; --max:${max}; --step:1000; --value:${max}; --text-value:"${max}"; --prefix:"${getCurrencySymbol(config.format.location, config.format.currency)} ";'>
				<input id="filter-max" type="range" min="${min}" max="${max}" step="1000" value="${max}" oninput="this.parentNode.style.setProperty('--value',this.value); this.parentNode.style.setProperty('--text-value', JSON.stringify(this.value))">
				<output></output>
				<div class='range-slider__progress'></div>
			</div>
		</div>
	`);
	$('#button-filter-vehicles').empty();
	$('#button-filter-vehicles').append(`<button onclick="filterVehicles('${page}')" class="add-stock-car">${Lang[config.lang]['filter_button']}</button>`);
}


function hirePlayer() {
	let user = document.getElementById('input-hire-player').value;
	document.getElementById('input-hire-player').value = null;
	$.post('http://dealership/hirePlayer', JSON.stringify({user}));
}

function firePlayer(user) {
	$.post('http://dealership/firePlayer', JSON.stringify({user}));
}

function giveComission(user) {
	let amount = document.getElementById('input-give-comission').value;
	document.getElementById('input-give-comission').value = null;
	$.post('http://dealership/giveComission', JSON.stringify({user,amount}));
}

function closeUI(){
	$.post('http://dealership/close', JSON.stringify({}));
}

function sellVehicle(vehicle,plate) {
	let price = document.getElementById('sell-car-input-'+plate).value;
	document.getElementById('sell-car-input-'+plate).value = null;
	$.post('http://dealership/sellVehicle', JSON.stringify({vehicle,plate,price}));
}

function cancelSellVehicle(id) {
	$.post('http://dealership/cancelSellVehicle', JSON.stringify({id}));
}

function finishSellVehicle(id) {
	$.post('http://dealership/finishSellVehicle', JSON.stringify({id}));
}

function previewVehicle(vehicle) {
	$.post('http://dealership/previewVehicle', JSON.stringify({vehicle}));
}

function changeProfile(user_id) {
	let profile_img = document.getElementById('employee-card__input_profile').value;
	let banner_img = document.getElementById('employee-card__input_banner').value;
	$.post('http://dealership/changeProfile', JSON.stringify({user_id,banner_img,profile_img}));
}

function changeProfileOwner(user_id) {
	let profile_img = document.getElementById('employee-card__input_profile').value;
	let banner_img = document.getElementById('employee-card__input_banner').value;
	$.post('http://dealership/changeProfileOwner', JSON.stringify({user_id,banner_img,profile_img}));
}

function requestVehicle(vehicle) {
	let price = document.getElementById('request-car-input-'+vehicle).value;
	document.getElementById('request-car-input-'+vehicle).value = null;
	$.post('http://dealership/requestVehicle', JSON.stringify({vehicle,price}));
}

function cancelRequest(id) {
	$.post('http://dealership/cancelRequest', JSON.stringify({id}));
}

function acceptRequest(id) {
	$.post('http://dealership/acceptRequest', JSON.stringify({id}));
}

function declineRequest(id) {
	$.post('http://dealership/declineRequest', JSON.stringify({id}));
}

function finishRequest(id) {
	$.post('http://dealership/finishRequest', JSON.stringify({id}));
}

function setPrice(vehicle) {
	let price = document.getElementById('set-price-car-input-'+vehicle).value;
	$.post('http://dealership/setPrice', JSON.stringify({vehicle,price}));
}

if (!String.prototype.format) {
    String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
        return typeof args[number] != 'undefined'
            ? args[number]
            : match
        ;
        });
    };
}

function getCurrencySymbol (locale, currency) {
	return (0).toLocaleString(
	  locale,
	  {
		style: 'currency',
		currency: currency,
		minimumFractionDigits: 0,
		maximumFractionDigits: 0
	  }
	).replace(/\d/g, '').trim()
}