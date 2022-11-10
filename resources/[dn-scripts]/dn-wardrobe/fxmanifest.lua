fx_version 'bodacious'
game 'gta5'

dependency 'vrp'

client_scripts {
    'Client.lua'
}

server_scripts {
  '@vrp/lib/utils.lua',
  'Config/Config.lua',
  'Version',
  'Server.lua'
}