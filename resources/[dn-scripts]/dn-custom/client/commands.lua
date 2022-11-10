CreateThread(function() 
    TriggerEvent('chat:addSuggestion', '/discord', 'Discord link') 
end)



RegisterCommand("discord", function(source, args, rawCommandString)
    TriggerEvent('chatMessage', "^3[FlaxHosting]", { 255, 255, 255 }, "Discord link | https://discord.gg/pbv7zCeUNh")
end, false)