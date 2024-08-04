fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'EF Development'
description 'Edits and UI designed by BlasterSuraj'
version '2.1.0'
discord 'https://discord.gg/WbDp5GQ45t'

ui_page 'html/index.html'

dependencies {
    'screenshot-basic',
    'ox_lib'
}

shared_scripts {
    'config.lua',
    --'@qb-apartments/config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'lib/Proxy.lua',
    'lib/Tunnel.lua',
    'client/main.lua',
    'client/animation.lua',
    'app/c_ping.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'@vrp/lib/utils.lua',
    'server/main.lua',
    'app/s_ping.lua'
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/*.webp',
    'html/css/*.css',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
}