Config = Config or {}

Config.WhitelistedCreators = {
    "1",
}

Config.RaceSetupAllowed = true

function Notify(msg, type)
    lib.notify({
        title = msg,
        type = type,
        position = 'center-right',
    })
end