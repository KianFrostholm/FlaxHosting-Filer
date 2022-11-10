Prompt = false

Citizen.CreateThread(function()    
    while true do
        Citizen.Wait(0)
        if Prompt then
            SetTextComponentFormat("STRING")
            AddTextComponentString('Tryk på ~INPUT_PICKUP~ for at tilgå din garderobe.')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent('Wolxy:Garderobe:OpenMenu')
            end
        end
    end
end)

RegisterNetEvent('Wolxy:Garderobe:OpenPrompt')
AddEventHandler('Wolxy:Garderobe:OpenPrompt', function()
    Prompt = true
end)

RegisterNetEvent('Wolxy:Garderobe:RemoveOpenPrompt')
AddEventHandler('Wolxy:Garderobe:RemoveOpenPrompt', function()
    Prompt = false
end)