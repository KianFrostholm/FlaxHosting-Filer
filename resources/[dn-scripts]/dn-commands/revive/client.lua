RegisterNetEvent("revive")
AddEventHandler("revive", function()
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
	SetEntityHealth(GetPlayerPed(-1), 200)
end)