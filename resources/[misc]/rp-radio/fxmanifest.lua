fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'config.lua',
	'functions/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/*.css',
	'ui/*.js',
	'ui/images/**/*.png'
}