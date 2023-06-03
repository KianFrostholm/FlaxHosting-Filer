resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "oxmysql"

ui_page "gui/index.html"

shared_script{'cfg/webhooks.lua'}

server_scripts{ 
  "@oxmysql/lib/MySQL.lua",
  "lib/utils.lua",
  "base.lua",
  "modules/gui.lua",
  "modules/group.lua",
  "modules/admin.lua",
  "modules/survival.lua",
  "modules/player_state.lua",
  "modules/map.lua",
  "modules/money.lua",
  "modules/inventory.lua",
  "modules/identity.lua",
  "modules/business.lua",
  "modules/item_transformer.lua",
  "modules/emotes.lua",
  "modules/police.lua",
  "modules/home.lua",
  "modules/home_components.lua",
  "modules/mission.lua",
  "modules/aptitude.lua",
  "modules/paycheck.lua",
  "modules/basic_phone.lua",
  "modules/basic_market.lua",
  "modules/basic_garage.lua",
  "modules/basic_items.lua",
  "modules/basic_skinshop.lua",
  "modules/basic_gunshop.lua",
  "modules/cloakroom.lua",
  --"modules/anticheat.lua",
}


client_scripts{
  "lib/utils.lua",
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client/base.lua",
  "client/iplloader.lua",
  "client/gui.lua",
  "client/player_state.lua",
  "client/survival.lua",
  "client/map.lua",
  "client/identity.lua",
  "client/basic_garage.lua",
  "client/police.lua",
  "client/policespikes.lua",
  "client/drag.lua",
  "client/adminvehicle.lua",
  "client/admin.lua",
  --"client/anticheat.lua",
}


files{
  "cfg/client.lua",
  "gui/index.html",
  "gui/design.css",
  "gui/bg.png",
  "gui/main.js",
  "gui/Menu.js",
  "gui/ProgressBar.js",
  "gui/WPrompt.js",
  "gui/RequestManager.js",
  "gui/AnnounceManager.js",
  "gui/Div.js",
  "gui/dynamic_classes.js"
}
