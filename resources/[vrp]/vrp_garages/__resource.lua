description "vRP ply_garages"

dependency "vrp"

shared_script 'config.lua'

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "GUI.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  '@oxmysql/lib/MySQL.lua',
  "server.lua"
}
