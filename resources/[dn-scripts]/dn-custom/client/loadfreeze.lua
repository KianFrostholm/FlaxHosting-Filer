AddEventHandler("playerSpawned", function()
    SetEntityInvincible(PlayerPedId(),true)
    SetEntityVisible(PlayerPedId(),false)
    FreezeEntityPosition(PlayerPedId(), true)
    Cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1519.3956298828,-1846.9437255859,581.66998291016,-17.98504447937,0.00,0.00, 100.00, false, 0)
    SetCamActive(Cam, true)
    RenderScriptCams(1, 0, 750, 1, 1)
    print("Karakter", "Henter data...")
    Wait(1000)
    lib.progressBar({
        duration = 35000,
        label = 'Indlæser karakter',
        useWhileDead = false,
        canCancel = false,
        disable = {
        }
    })
    SetCam(false)
    Wait(2000)
    SetEntityInvincible(PlayerPedId(),false)
    SetEntityVisible(PlayerPedId(),true)
    FreezeEntityPosition(PlayerPedId(), false)
    SetCam(false)
    print("Karakter", "Karkter Indlæst!")
end)



function SetCam(onoff, CamX, CamY, CamZ, CamH)
    if onoff == true then
        if CurrentCam ~= 0 then 
            DestroyCam(CurrentCam)
        end
        CurrentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(CurrentCam, CamX, CamY, CamZ, CamH)
        SetCamRot(CurrentCam, -10.98504447937, 0.0, CamH)
        SetCamActive(CurrentCam, true)
        RenderScriptCams(1, 1, 750, 1, 1)
    else
        SetCamActive(CurrentCam, false)
        DestroyCam(CurrentCam)
        DetachCam(CurrentCam)
        RenderScriptCams(false, true, 2000, true, true)
    end
end
