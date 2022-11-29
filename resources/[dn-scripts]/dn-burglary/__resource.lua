resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

this_is_a_map 'yes'

shared_script "config.lua"

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "callback/client.lua",
    "client.lua"
}

server_scripts{
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "@vrp/lib/utils.lua",
    "callback/server.lua",
    "server.lua"
}


data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}