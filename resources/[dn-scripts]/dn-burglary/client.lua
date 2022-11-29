local isLockpicking = false
local isPolice = false
local lasthouse = nil
local curHouseCoords = {x = 0, y = 0, z = 0}
local curExitCoords = {x = 0, y = 0, z = 0}
local myrobbableItems = {}
local antal = 0

local HT = nil

Citizen.CreateThread(function()
	while HT == nil do
		TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
		Wait(0)
	end
end)


local Cooldown = 0

RegisterNetEvent('kian-indburd:useItem', function()
   TriggerServerCallback('kian-indburd:BetjenteOnline', function(onlinebetjente)
      local vedhus = false
		if onlinebetjente >= Config.minCops then
         if Cooldown <= 1 then
            for k,v in pairs(Config.robbableHouses) do
               if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z) < 3 then
                  vedhus = true
                  TriggerEvent('kian-indburd:lockpickanim')
                  print("Indbrud", Config.Lang['lockpick_door_notify'])
                  TriggerEvent('s_lockpick:client:openLockpick', lockpick)

                  exports[Config.progress]:startUI(10000, Config.Lang['lockpick_door'])
                  Wait(10000)
                  isLockpicking = false
         
                  local chance = math.random(1,10)
                  if chance >= 1 then
                     lasthouse = k
                     createHouse(k, false)
                     if chance >= 1 then
                        local ped = PlayerPedId()
                        local x,y,z = table.unpack(GetEntityCoords(ped, false))
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        print('add politi notify')
                        Wait(5000)
                        Cooldown = Config.Cooldown
                        TriggerServerEvent('dispatch2', playerCoords.x, playerCoords.y, playerCoords.z, "Indbrud igang ved")
                     end
                  else
                     print("Indbrud", Config.Lang['lockpick_broke'])
                     TriggerServerEvent('kian-indburd:lockpickbroke')
                     return
                  end
               end
            end
            if vedhus == false then
               TriggerServerEvent("kian-indburd:givback")
            end
         else
            print("Indbrud", Config.Lang['cooldown_message'])
            TriggerServerEvent("kian-indburd:givback2")
         end
      else
         print("Indbrud", Config.Lang['police_nearby'])
         TriggerServerEvent("kian-indburd:givback2")
		end
	end)
end)

CreateThread(function()
   while true do
     Wait(0)
      for k,v in pairs(Config.robbableHouses) do
         if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z) < 3 then
            if Cooldown == 0 then
               DrawText3Ds(v.x, v.y, v.z, Config.Lang['rob_house'])
               if IsControlJustPressed(1, 38) then
                  TriggerEvent('kian-indburd:useItem')
               end
            else
               DrawText3Ds(v.x, v.y, v.z, Config.Lang['cooldown']..' '..Cooldown..' Sekunder')
            end
         end
      end
   end
end)

function createHouse(houseid, police)
   local house = Config.robbableHouses[houseid]

   local generator = {x = house.x, y = house.y, z = house.z-50}

   myrobbableItems = robbableItems

   for i=1,#myrobbableItems do
      myrobbableItems[i]['isSearched'] = false
   end

   curHouseCoords = {x = house.x, y = house.y, z = house.z-50}
   curExitCoords = {x = house.x+3.6, y = house.y-15, z = house.z-50}


   SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
   FreezeEntityPosition(PlayerPedId(), true)
   DoScreenFadeOut(100)
   Wait(2000)
   local building = CreateObject(GetHashKey("clrp_house_1"), generator.x, generator.y-0.05, generator.z+1.26253700-89.825, false, false, false)
   FreezeEntityPosition(building, true)
   Wait(500)
   SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+2.9)
   SetEntityHeading(PlayerPedId(), 358.106)

   local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
   local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
   local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
   local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
   local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
   local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
   local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
   local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
   local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
   local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
   local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
   local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
   local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
   local bed = CreateObject(GetHashKey("V_16_mid_bed_bed"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false)
   local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
   local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
   local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)

   --props
   local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
   local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
   local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
   local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
   local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
   local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
   local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
   local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
   local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
   local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
   local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.83123500, generator.z+2.09373700, false, false, false)
   local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
   local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
   local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
   local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
   local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
   local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
   local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
   local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
   local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
   local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
   local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
   local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
   local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
   local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
   local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
   local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
   local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
   local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
   local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
   local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
   local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
   local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.53423500, generator.z+1.19625800, false, false, false)
   local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
   local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
   local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
   local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
   --local laundry = CreateObject(GetHashKey("v_res_mlaundry"), generator.x+5.77729800, generator.y+4.60211400, generator.z+1.19674400, false, false, false)
   local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
   local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
   local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
   local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
   local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
   local tablod = CreateObject(GetHashKey("V_Res_TabloidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
   local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
   local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
   local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
   local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
   local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
   local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
   local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
   local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
   local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
   local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
   local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
   local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
   local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
   local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
   local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
   local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
   local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
   local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
   local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
   local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)

   FreezeEntityPosition(dt,true)
   FreezeEntityPosition(mpmid01,true)
   FreezeEntityPosition(mpmid09,true)
   FreezeEntityPosition(mpmid07,true)
   FreezeEntityPosition(mpmid03,true)
   FreezeEntityPosition(midData,true)
   FreezeEntityPosition(glow,true)
   FreezeEntityPosition(curtins,true)
   FreezeEntityPosition(mpmid13,true)
   FreezeEntityPosition(mpcab,true)
   FreezeEntityPosition(mpdecal,true)
   FreezeEntityPosition(mpdelta,true)
   FreezeEntityPosition(couch,true)
   FreezeEntityPosition(chair,true)
   FreezeEntityPosition(chair2,true)
   FreezeEntityPosition(plant,true)
   FreezeEntityPosition(lamp,true)
   FreezeEntityPosition(fridge,true)
   FreezeEntityPosition(micro,true)
   FreezeEntityPosition(sideBoard,true)
   FreezeEntityPosition(bedSide,true)
   FreezeEntityPosition(plant2,true)
   FreezeEntityPosition(table,true)
   FreezeEntityPosition(tv,true)
   FreezeEntityPosition(plant3,true)
   FreezeEntityPosition(chair3,true)
   FreezeEntityPosition(lampStand,true)
   FreezeEntityPosition(chair4,true)
   FreezeEntityPosition(chair5,true)
   FreezeEntityPosition(chair6,true)
   FreezeEntityPosition(plant4,true)
   FreezeEntityPosition(storage2,true)
   FreezeEntityPosition(basket,true)
   FreezeEntityPosition(wardrobe,true)
   FreezeEntityPosition(wardrobe2,true)
   FreezeEntityPosition(table2,true)
   FreezeEntityPosition(lamp3,true)
   -- FreezeEntityPosition(laundry,true)
   FreezeEntityPosition(beddelta,true)
   FreezeEntityPosition(bed,true)
   FreezeEntityPosition(beddecal,true)
   FreezeEntityPosition(tapeplayer,true)
   FreezeEntityPosition(basket7,true)
   FreezeEntityPosition(basket6,true)
   FreezeEntityPosition(basket8,true)
   FreezeEntityPosition(basket9,true)

   SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
   SetEntityHeading(couch,GetEntityHeading(couch)-90)
   SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
   SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
   SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
   SetEntityHeading(micro,GetEntityHeading(micro)-90)
   SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
   SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
   SetEntityHeading(tv,GetEntityHeading(tv)+90)
   SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
   SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
   SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
   SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
   SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
   SetEntityHeading(storage,GetEntityHeading(storage)+180)
   SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
   SetEntityHeading(table2,GetEntityHeading(table2)+90)
   SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
   SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)
   FreezeEntityPosition(PlayerPedId(),false)
   DoScreenFadeIn(100)
   if not police then
      isRobbing = true
   end
end

function removeSpawnedHouse(k)
   local housePosition = Config.robbableHouses[k]
   local handle, ObjectFound = FindFirstObject()
   local success
   repeat
      local pos = GetEntityCoords(ObjectFound)
      local distance = GetDistanceBetweenCoords(housePosition["x"], housePosition["y"], (housePosition["z"] - 24.0), pos, true)
      if distance < 35.0 and ObjectFound ~= PlayerPedId() then
         if IsEntityAPed(ObjectFound) then
            if not IsPedAPlayer(ObjectFound) then
              DeleteObject(ObjectFound)
            end
         else
            DeleteObject(ObjectFound)
         end
      end
      success, ObjectFound = FindNextObject(handle)
   until not success
   EndFindObject(handle)

   SetEntityCoords(PlayerPedId(), housePosition.x, housePosition.y, housePosition.z)

   isRobbing = false
end

function getRotation(input)
   return 360/(10*input)
end

Citizen.CreateThread(function()
   while true do
      Wait(1)
      local generator = {x = curHouseCoords["x"], y = curHouseCoords["y"], z = curHouseCoords["z"]}
      local generatorExit = {x = curExitCoords["x"], y = curExitCoords["y"], z = curExitCoords["z"]}

      if isPolice or isRobbing then
         for i=1,#myrobbableItems do
            local playerCoords = GetEntityCoords(PlayerPedId(), true)

            if GetDistanceBetweenCoords(playerCoords, generatorExit.x, generatorExit.y, generatorExit.z, true) < 2.5 then
               DrawText3Ds(playerCoords.x, playerCoords.y, playerCoords.z, Config.Lang['leave_house'])
               if IsControlPressed(0, 38) then
                  removeSpawnedHouse(lasthouse)

                  while IsControlPressed(0, 38) do
                     Wait(1)
                  end
               end
            end
            if isRobbing then
               if (GetDistanceBetweenCoords(generator.x + myrobbableItems[i]["x"], generator.y + myrobbableItems[i]["y"], generator.z + myrobbableItems[i]["z"], GetEntityCoords(GetPlayerPed(-1))) < 1.4) and not myrobbableItems[i]['isSearched'] then
                 DrawText3Ds(generator.x + myrobbableItems[i]["x"], generator.y + myrobbableItems[i]["y"], generator.z + myrobbableItems[i]["z"], Config.Lang['search_storage3D'])

                  if IsControlPressed(1, 38) then
                     myrobbableItems[i]['isSearched'] = true
                     TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                     exports[Config.progress]:startUI(10000, Config.Lang['search_storage'])
                     Wait(10000)

                     TriggerServerEvent('kian-indburd:searchItem', antal)
                     ClearPedTasks(PlayerPedId())

                     while IsControlPressed(1, 38) do
                         Wait(1)
                     end
                  end
                  while IsControlPressed(0,38) do
                     Wait(1)
                  end
               end
            end
         end
      end
   end
end)

RegisterNetEvent('kian-indburd:lockpickanim', function()
   isLockpicking = true
   loadAnimDict('veh@break_in@0h@p_m_one@')
   while isLockpicking do
      if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
         TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
         Wait(1500)
         ClearPedTasks(PlayerPedId())
         end
         Wait(1)
      end
   ClearPedTasks(PlayerPedId())
end)

function loadAnimDict(dict)
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do
      Wait(5)
   end
end

RegisterNetEvent('kian-indburd:cbreach')
AddEventHandler('kian-indburd:cbreach', function(police)
   for k,v in pairs(Config.robbableHouses) do
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z) < 3 then
         lasthouse = k
         createHouse(k, police)
         isPolice = true
      end
   end
end)

RegisterCommand('removehouse', function()
   removeSpawnedHouse(lasthouse)
end)

function HelpText(string)
	SetTextComponentFormat("STRING")
    AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


CreateThread(function()
   while true do
      Wait(1000)
      if Cooldown >= 1 then
         Cooldown = Cooldown - 1
      end
   end
end)

function DrawText3Ds(x,y,z, text)
   local onScreen,_x,_y=World3dToScreen2d(x,y,z)
   local px,py,pz=table.unpack(GetGameplayCamCoords())

   SetTextScale(0.42, 0.42)
   SetTextFont(4)
   SetTextProportional(1)
   SetTextColour(255, 255, 255, 255)
   SetTextEntry("STRING")
   SetTextCentre(1)
   AddTextComponentString(text)
   DrawText(_x,_y)
   local factor = (string.len(text)) / 370
   DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 0)
end




robbableItems = {
   [1] = {x = 1.90339700, y = -3.80026800, z = 1.29917900, name = "Fridge", isSearched = false},
   [2] = {x = -3.50363200, y = -6.55289400, z = 1.30625800, name = "Drawers", isSearched = false},
   [3] = {x = -3.50712600, y = -4.13621600, z = 1.29625800, name = "Table", isSearched = false},
   [4] = {x = 8.47819500, y = -2.50979300, z = 1.19712300, name = "Storage", isSearched = false},
   [5] = {x = 9.75982700, y = -1.35874100, z = 1.29625800, name = "Storage", isSearched = false},
   [6] = {x = 8.46626300, y = 4.53223600, z = 1.19425800, name = "Wardrobe", isSearched = false},
   [7] = {x = 5.84416200, y = 2.57377400, z = 1.22089100, name = "Table", isSearched = false},
   [8] = {x = 3.04164100, y = 0.31671810, z = 3.58363900, name = "Jewelry", isSearched = false},
   [9] = {x = 6.86376900, y = 1.20651200, z = 1.36589100, name = "Under Bed", isSearched = false},
   [10] = {x = 2.03442400, y = -5.61585100, z = 3.30395600, name = "Cupboards", isSearched = false},
   [11] = {x = -5.53120400, y = 0.76299670, z = 1.77236000, name = "Cabinet", isSearched = false},
   [12] = {x = -1.24716200, y = 1.07820500, z = 1.69089300, name = "Coffee Table", isSearched = false},
   [13] = {x = 2.91325400, y = -4.2783510, z = 1.82746400, name = "Table", isSearched = false},
}









function lockpick(success)
   ped = PlayerPedId()
   pedc = GetEntityCoords(ped)
   local veh = GetClosestVehicle(pedc.x, pedc.y, pedc.z, 3.0, 0, 71)
   if success then
       Citizen.Wait(1000)
       ExecuteCommand("e uncuff")
       Citizen.Wait(500)
       ClearPedTasks(PlayerPedId())
       FreezeEntityPosition(PlayerPedId(), false)
       ESX.ShowNotification('Successfully picklocked vehicle')
       SetVehicleDoorsLocked(veh, 0)
       SetVehicleDoorsLockedForAllPlayers(veh, false)
   else
       ClearPedTasks(PlayerPedId())
       ESX.ShowNotification('Picklocking failed, vehicle alarms went off')
       FreezeEntityPosition(PlayerPedId(), false)
       SetVehicleAlarm(veh, true)
       SetVehicleAlarmTimeLeft(veh, 4000)
       SetVehicleDoorsLocked(veh, 2)
       --Here you can add your own police notification event if you wish
   end
end
