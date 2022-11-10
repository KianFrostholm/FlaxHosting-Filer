--------------------------------
-- CleanUp --
--------------------------------

--GetClosestObjectOfType(x, y, z, radius, modelHash, false, p6, p7)
local objectslist = {
	307771752,
	-1184516519,
	1230099731,
	406416082,
	242636620,
	627816582,
	-136782495,
	304890764,
	-- ROCKERBORG
	-1340926540,
	-2021659595,
	232216084,
	1452552716,
	322493792,
	-46303329,
	-1738103333,
	1120812170,
	-1919073083,
	-2073573168,
	757019157,
	438342263,
	1096997751,
	-861197080,
	-1829764702,
	897494494,
	-940719073
}

Citizen.CreateThread(function()
	while true do
		local player = GetPlayerPed(-1)
		local pos = GetEntityCoords(player)
		
		local handle, object = FindFirstObject()
		local success
		
		
		if has_value(objectslist, GetEntityModel(object)) then
			RemoveObject(object)
		end
		repeat 
			success, object = FindNextObject(handle)
			
			if has_value(objectslist, GetEntityModel(object)) then
				RemoveObject(object)
			end
		until not success
		
		EndFindObject(handle)
		
		Citizen.Wait(500)
	end
end)

function RemoveObject(object)
	SetEntityAsMissionEntity(object,  false,  true)
	DeleteObject(object)
end

function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	
	return false
end


Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        "LSA_Planes", -- LSIA planes
        "GRAPESEED_PLANES", -- Sandy Shores planes
        "Grapeseed_Planes", -- Sandy Shores planes
        "SANDY_PLANES", -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
        "HYDRA",
        "BUZZARD",
        "VALKYRIE",
        "VALKYRIE2",
        "BUZZARD2",
        "SAVAGE",
        "ANNIHILATOR"
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(1)
    end
end)


--==--==--==--
-- Broken Veh Script by Pegi16/Antwanr942!
-- This script may **NOT** be re-released without permission from myself.
-- However feel free to edit it and use it as you wish.
-- Enjoy :)
--==--==--==--

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10) -- [[Usually 1 however the difference between the two is un-noticable.]]
        for theveh in EnumerateVehicles() do -- [[Gets every single vehicle that exists... I think.]]
            if GetEntityHealth(theveh) == 0 then -- [[If the vehicle is destroyed continue.]]
                SetEntityAsMissionEntity(theveh, false, false) -- [[Sets the entity as mission entity for further use.]]
                DeleteEntity(theveh) -- [[Once set as mission entity it will be deleted.]]
            end
		end
    end
end)

--==--==--==--
-- Entity Enumerator by IllidanS4 [https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2]
--==--==--==--

local entityEnumerator = {
	__gc = function(enum)
	    if enum.destructor and enum.handle then
		    enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
	        disposeFunc(iter)
		    return
	    end
	  
	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator)
	  
	    local next = true
	    repeat
		    coroutine.yield(id)
		    next, id = moveFunc(iter)
	    until not next
	  
	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--==--==--==--
-- End :(
--==--==--==--



Citizen.CreateThread(function()
    while true 
    	do
    		-- These natives has to be called every frame.
    	SetVehicleDensityMultiplierThisFrame(0.5)
		SetPedDensityMultiplierThisFrame(0.5)
		SetRandomVehicleDensityMultiplierThisFrame(0.5)
		SetParkedVehicleDensityMultiplierThisFrame(0.5)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		
		
		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(0)
		SetRandomBoats(0)
    	
		Citizen.Wait(1)
	end

end)