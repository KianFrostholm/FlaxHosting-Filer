dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "@oxmysql/lib/MySQL.lua",
  "server.lua"
}

client_scripts{ 
  "lib/Proxy.lua",
  "client.lua"
}
