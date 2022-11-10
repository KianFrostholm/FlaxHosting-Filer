CreateThread(function()
	while true do
		Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 10000)
		end
	end
end)


CreateThread( function()
	while true do
	  Wait(0)
	  RestorePlayerStamina(PlayerId(), 1.0)
	end
end)

CreateThread(function()
	while true do
		Wait(0)
        SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0) -- Native der disabler/enabler om hatte og andet prop clothing kan falde af
	end
end)