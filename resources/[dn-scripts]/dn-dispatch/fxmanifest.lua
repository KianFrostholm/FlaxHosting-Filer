fx_version 'adamant'
games { 'gta5' }

client_scripts {
    "lib/Tunnel.lua",
	"lib/Proxy.lua",
    'client.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua'
}

ui_page {
    'html/alerts.html',
}

files {
	'html/alerts.html',
	'html/main.js', 
	'html/style.css',
}