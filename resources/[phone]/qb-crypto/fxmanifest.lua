fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'@vrp/lib/utils.lua',
    'server/main.lua'
}
client_script 'client/main.lua'