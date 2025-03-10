// To add a new lang file you must declare the file on the last lines of index.html like: <script src="lang/en.js" type="text/javascript"></script>
if (Lang == undefined) {
	var Lang = [];
}
Lang['br'] = {
	confirm_buy_dealer: 'Você realmente quer comprar esta concessionária? Preço: {0} ',
	statistics: 'Estatísticas',
	statistics_top_3: 'Top 3 veículos mais vendidos',
	statistics_balance: 'Balance',
	statistics_clients: 'Últimos clientes',
	clients_table_head_1: 'Nome',
	clients_table_head_2: 'ID',
	clients_table_head_3: 'Descrição',
	clients_table_head_4: 'Data',
	vlist_title: 'Lista de veículos',
	owned_vlist_title: 'Veículos próprios',
	invalid_value: '❌ Insira um valor válido',
	open_requests_title: 'Solicitações abertas',
	o_open_requests_title: 'Solicitações',
	employees_title: 'Empregados',
	employees_details_title: 'Detalhes dos empregados',
	employee_desc: 'Vendedor',
	profile_desc: 'URL: IMG do perfil',
	banner_desc: 'URL: IMG do banner',
	owner_desc: 'Proprietário da concessionária',
	button_employee: 'Contratar funcionário',
	button_fire_employee: 'Demitir funcionário',
	button_give_comission: 'Dar comissão',
	input_give_comission: 'Valor da comissão',
	bank_title: 'Banco',
	bank_status: 'Status do banco',
	bank_history: 'Histórico',
	bank_table_head_1: 'Descrição',
	bank_table_head_2: 'Nome',
	bank_table_head_3: 'Valor',
	bank_table_head_4: 'Data',
	request_table_head_1: 'Veículo',
	request_table_head_2: 'Nome',
	request_table_head_3: 'Valor',
	request_table_head_4: 'Status',
	request_table_head_5: '',
	request_status_1: 'Aguardando',
	request_status_2: 'Em andamento',
	request_status_3: 'Concluído',
	request_status_4: 'Cancelado',
	o_request_table_head_1: 'Veículo',
	o_request_table_head_2: 'Nome',
	o_request_table_head_3: 'Preço',
	o_request_table_head_4: 'Tipo de solicitação',
	o_request_table_head_5: 'Status',
	o_request_table_head_6: '',
	request_type_1: 'Importar veículo',
	request_type_2: 'Comprar veículo usado',
	restock_modal: 'Quantidade de carros:',
	confirm_button_modal: 'Confirmar',
	confirm_buy_button_modal: 'Comprar',
	confirm_sell_button_modal: 'Vender',
	cancel_button_modal: 'Cancelar',
	modal_desc: 'Você realmente quer vender sua concessionária? Tudo será excluído e este processo não pode ser desfeito.',
	modal_title: 'Você tem certeza?',
	expenses: 'Gastos',
	profit: 'Ganhos',
	hired_date: 'Contratado em:',
	jobs_done: 'Trabalhos feitos:',
	deposit: 'Depositar',
	withdraw: 'Sacar',
	your_money: 'Seu dinheiro:',
	import: 'Importar',
	export: 'Exportar',
	stock: 'Estoque',
	plate: 'Placa',
	nothing_sold: 'Você ainda não vendeu nenhum veículo',
	total_sell: 'Vendas totais:',
	nav_menu_profile: 'Perfil',
	nav_menu_vehs: 'Lista de veículos',
	nav_menu_hire: 'Empregados',
	nav_menu_bank: 'Banco',
	nav_menu_order: 'Solitações',
	nav_menu_sell: 'Vender concessionária',
	nav_menu_o_vehs: 'Veículos próprios',
	nav_menu_requests: 'Solicitações',
	nav_menu_infos: 'Informações',
	buy_vehicle: 'Comprar',
	sell_vehicle: 'Vender',
	price: 'Preço',
	import_price: 'Preço de importação',
	customer_price: 'Preço pro cliente',
	pending: 'Pendente...',
	inprogress: 'Em progresso...',
	completed: 'Completado!',
	cancelled: 'Cancelado!',
	preview: 'Ver',
	change_profile: 'Confirmar',
	request_vehicle: 'Solicitar',
	cancel_request: 'Cancelar',
	finish_request: 'Pegar seu veículo',
	accept_request: 'Aceitar',
	decline_request: 'Recusar',
	no_one_there: 'Ninguém trabalha aqui',
	empty_dealer: 'Vazio',
	vehicle: 'Veículo',

	cancel_button_modal_question: 'Entendi!',
	modal_title_question: 'Instruções',
	questions: {
		vhlist_page: "<h3 style='margin-block-end: 0em;'>Listagem de veículos</h3><BR>Esta é a página dos veículos da concessionária.<BR><b>Caso o veículo esteja disponível</b> você pode comprá-lo pelo preço apresentado.<BR><b>Caso o veículo não tenha estoque</b> você pode solicitar uma encomenda exclusiva por um preço que você irá definir, porém coloque um preço atrativo, caso contrário, sua soliciação pode ser recusada.",
		o_vhlist_page: "<h3 style='margin-block-end: 0em;'>Listagem dos seus veículos próprios</h3><BR>Aqui você verá <b>apenas</b> os veículos que você possui e estão disponíveis nesta concessionária. Você também pode vender seus veículos aqui.<BR><b>Caso a concessionária não tiver dono</b> você venderá seu veículo à 70% do valor de compra.<BR><b>Caso haja funcionários nessa concessionária</b> você poderá colocar um valor de venda customizado. <b>Aceitar</b> ou <b>recusar</b> a venda do veículo ficará a critério dos funcionários da concessionária.",
		requests_page: "<h3 style='margin-block-end: 0em;'>Listagem de solicitações</h3><BR>Nesta página você verá as solicitações de importações de veículos que você abriu.<BR><b>Aguardando:</b> A solicitação foi recebida pelo dono da concessionária e está em análise.<BR><b>Em andamento:</b> A sua solicitação foi aceita e a importação do veículo está sendo realizada.<BR><b>Concluído:</b> A importação do seu veículo foi feita com sucesso, você já poderá retira-lo aqui.<BR><b>Cancelado:</b> Sua solicitação foi recusada, clique em cancelar para receber seu dinheiro de volta.",
	},

	filter_title: 'Filtros',
	filter_name: 'Nome:',
	filter_name_placeholder: 'Filtrar pelo nome',
	filter_price: 'Preço:',
	filter_stock: 'Tem estoque:',
	filter_min: 'Mínimo:',
	filter_max: 'Máximo:',
	filter_button: 'Filtrar',
	
	low_stock: '<b>Ficar com POUCO ESTOQUE fará você perder sua concessionária!</b>',
	low_stock2: '<b>Você precisa aumentar a VARIEDADE DE PRODUTOS de sua concessionária ou você vai perdê-la!</b>',
	months_array: new Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"),
};