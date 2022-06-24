fx_version 'adamant'
game 'gta5'
version '1.0'


server_scripts {
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/function.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/img/*.png',
	'html/css/styles.css',
	'html/js/questions.js',
	'html/js/scripts.js',
	'html/js/jobmdt.js',
	'html/js/jquery-3.4.1.min.js',
	'html/js/debounce.min.js'
}
