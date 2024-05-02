RegisterNetEvent("pNotify:SendNotification")
AddEventHandler("pNotify:SendNotification", function(options)
    if options.type == 'alert' then
        options.type = 'warning'
    elseif options.type == 'info' then
        options.type = 'inform'
    end

    local cleantext = options.text:gsub("<b[^>]*>", ""):gsub("</b>", "")

    if options.position == "bottomright" then 
        options.position = "bottom-right"
    elseif options.position == "centerRight" then
        options.position = "center-right"
    elseif options.position == "bottomCenter" then
        options.position = "bottom"
    elseif options.position == "centerLeft" then
        options.position = "center-left"
    elseif options.position == "topCenter" then
        options.position = "top-right"
    elseif options.position == "topCenter" then
        options.position = "top-right"
    end 
                
    Wait(100)

    lib.notify({
        title = options.title,
        description = cleantext or "Empty Notification",
        type = options.type,
        position = options.position,
    })
end)