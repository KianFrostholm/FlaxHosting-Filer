resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "vrp"
dependency "mysql-async"

client_scripts {
    	"lib/Proxy.lua",
    	"lib/Tunnel.lua",
    "lsconfig.lua",
    "menu.lua",
    "client.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
    "@vrp/lib/utils.lua",
    "server.lua"
}
