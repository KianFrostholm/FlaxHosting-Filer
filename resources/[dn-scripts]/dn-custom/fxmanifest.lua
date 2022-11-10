fx_version 'adamant'
game 'gta5'

author 'Kian Frostholm'

dependency "vrp"

client_scripts {
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "lib/enum.lua",
	"client/radar.lua",
  "client/window.lua",
  "client/stungun.lua",
  "client/dive.lua",
  "client/DriveByLimit.lua",
	"client/nowanted.lua",
  "client/handsup.lua",
  "client/nowanted.lua",
  "client/pointfinger.lua",
  "client/scope.lua",
  "client/vinduerul.lua",
  "client/noweapondrops.lua",
  "client/ragdoll.lua",
  "client/crouch.lua",
  "client/autopilot.lua",
  "client/opgiv.lua",
  "client/cleanup.lua",
  "client/carstats.lua",
  "client/carplacer.lua",
  "client/ped.lua",
  "client/pushcar.lua",
  "client/seat.lua",
  "client/tow.lua",
  "client/lift.lua",
  "client/voicecircle.lua",
  "client/chairs.lua",
  "client/legragdoll.lua",
  "client/takeoff.lua",
  "client/thumbsup.lua",
  "client/carlock.lua",
  "client/carry.lua",
  "client/carhud.lua",
  "client/SemArmasReward.lua",
  "client/loadfreeze.lua",
  "client/carwash.lua",
  "client/simplehudremover.lua",
  
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server/dive.lua",
  "server/discord_support.lua",
  "server/revive.lua",
	"server/uptime.lua",
	"server/lift.lua",
  "server/carry.lua",
  "server/takehostage.lua",
  "server/carwash.lua",
}

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

files {
  'meta/interiorproxies.meta'
}