local a = module("vrp", "lib/Tunnel")
local b = module("vrp", "lib/Proxy")

vRP = b.getInterface("vRP")
vRPclient = a.getInterface("vRP", "vRP_atm")


function vRP.hasInventoryItem(c, d)
    local e = vRP.getInventoryItemAmount({c, d})
    if e > 0 then
        return true
    else
        return false
    end
end
vrpitems = {}
vRP.returnItems(
    {function(f)
            for g, h in pairs(f) do
                vrpitems[g] = h
            end
        end}
)

playerbags = {}
playerstrips = {}

vRP.registerMenuBuilder(
    {"main", function(C, D)
            local c = vRP.getUserId({D.player})
            if c ~= nil then
                local E = {}
                E["Funktioner"] = {
                    function(F, G)
                        local H = {name = "Funktioner", css = {top = "75px", header_color = "rgba(225,160,0,0.75)"}}
                        H.onclose = function(F)
                            vRP.openMainMenu({F})
                        end
                        H["> Sæk på/af."] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {1},
                                    function(I)
                                        if I ~= nil then
                                            if playerbags[I] == nil then
                                                if vRP.tryGetInventoryItem({c, "pose", 1, true}) then
                                                    TriggerClientEvent("vrp:putOnBag", I)
                                                    vRPclient.notify(
                                                        F,
                                                        {"Du har puttet en sæk på den nærmeste spilers hoved!"}
                                                    )
                                                    playerbags[I] = {status = "on"}
                                                end
                                            elseif playerbags[I].status == "off" then
                                                if vRP.tryGetInventoryItem({c, "pose", 1, true}) then
                                                    TriggerClientEvent("vrp:putOnBag", I)
                                                    vRPclient.notify(
                                                        F,
                                                        {"Du har puttet en sæk på den nærmeste spilers hoved!"}
                                                    )
                                                    playerbags[I] = {status = "on"}
                                                end
                                            elseif playerbags[I].status == "on" then
                                                TriggerClientEvent("vrp:putOnBag", I)
                                                playerbags[I].status = "off"
                                            end
                                        end
                                    end
                                )
                            end,
                            "Put en sæk på en andens hoved - kræver at du har en sæk"
                        }
                        H["> Strips på/af"] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {1},
                                    function(I)
                                        if I ~= nil then
                                            if playerstrips[I] == nil then
                                                if vRP.tryGetInventoryItem({c, "strips", 1, true}) then
                                                    vRPclient.toggleHandcuff(I, {})
                                                    vRPclient.notify(
                                                        F,
                                                        {"Du har puttet strips på den nærmeste spiler!"}
                                                    )
                                                    playerstrips[I] = {status = "on"}
                                                end
                                            elseif playerstrips[I].status == "off" then
                                                if vRP.tryGetInventoryItem({c, "strips", 1, true}) then
                                                    vRPclient.toggleHandcuff(I, {})
                                                    vRPclient.notify(
                                                        F,
                                                        {"Du har puttet strips på den nærmeste spiler!"}
                                                    )
                                                    playerstrips[I] = {status = "on"}
                                                end
                                            elseif playerstrips[I].status == "on" then
                                                vRPclient.toggleHandcuff(I, {})
                                                vRPclient.notify(F, {"Du har taget strips af den nærmeste spiler!"})
                                                playerstrips[I] = {status = "off"}
                                            end
                                        end
                                    end
                                )
                            end,
                            "Put strips på en anden - kræver at du har nogle strips"
                        }
                        H["Drag"] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {1},
                                    function(I)
                                        local J = vRP.getUserId({I})
                                        if J ~= nil then
                                            vRPclient.isHandcuffed(
                                                I,
                                                {},
                                                function(K)
                                                    if K then
                                                        TriggerClientEvent("dr:drag", I, F)
                                                    else
                                                        TriggerClientEvent(
                                                            "pNotify:SendNotification",
                                                            F,
                                                            {
                                                                text = {"Spilleren er ikke i håndjern eller strips."},
                                                                type = "error",
                                                                queue = "global",
                                                                timeout = 4000,
                                                                layout = "centerRight",
                                                                animation = {
                                                                    open = "gta_effects_fade_in",
                                                                    close = "gta_effects_fade_out"
                                                                }
                                                            }
                                                        )
                                                    end
                                                end
                                            )
                                        else
                                            TriggerClientEvent(
                                                "pNotify:SendNotification",
                                                F,
                                                {
                                                    text = {"Ingen spiller fundet."},
                                                    type = "error",
                                                    queue = "global",
                                                    timeout = 4000,
                                                    layout = "centerRight",
                                                    animation = {
                                                        open = "gta_effects_fade_in",
                                                        close = "gta_effects_fade_out"
                                                    }
                                                }
                                            )
                                        end
                                    end
                                )
                            end,
                            "Drag en spiller i strips eller håndjern"
                        }
                        H["Sæt i bil"] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {1},
                                    function(I)
                                        local J = vRP.getUserId({I})
                                        if J ~= nil then
                                            vRPclient.isHandcuffed(
                                                I,
                                                {},
                                                function(K)
                                                    if K then
                                                        vRPclient.putInNearestVehicleAsPassenger(I, {5})
                                                        TriggerClientEvent("dr:undrag", I)
                                                    else
                                                        TriggerClientEvent(
                                                            "pNotify:SendNotification",
                                                            F,
                                                            {
                                                                text = {"Spilleren er ikke i håndjern eller strips."},
                                                                type = "error",
                                                                queue = "global",
                                                                timeout = 4000,
                                                                layout = "centerRight",
                                                                animation = {
                                                                    open = "gta_effects_fade_in",
                                                                    close = "gta_effects_fade_out"
                                                                }
                                                            }
                                                        )
                                                    end
                                                end
                                            )
                                        else
                                            TriggerClientEvent(
                                                "pNotify:SendNotification",
                                                F,
                                                {
                                                    text = {"Ingen spiller fundet."},
                                                    type = "error",
                                                    queue = "global",
                                                    timeout = 4000,
                                                    layout = "centerRight",
                                                    animation = {
                                                        open = "gta_effects_fade_in",
                                                        close = "gta_effects_fade_out"
                                                    }
                                                }
                                            )
                                        end
                                    end
                                )
                            end,
                            "Sæt en person i strips eller håndjern ind i en bil"
                        }
                        H["Tag ud af bil"] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {5},
                                    function(I)
                                        local J = vRP.getUserId({I})
                                        if J ~= nil then
                                            vRPclient.isHandcuffed(
                                                I,
                                                {},
                                                function(K)
                                                    if K then
                                                        vRPclient.ejectVehicle(I, {})
                                                    else
                                                        TriggerClientEvent(
                                                            "pNotify:SendNotification",
                                                            F,
                                                            {
                                                                text = {"Spilleren er ikke i håndjern eller strips."},
                                                                type = "error",
                                                                queue = "global",
                                                                timeout = 4000,
                                                                layout = "centerRight",
                                                                animation = {
                                                                    open = "gta_effects_fade_in",
                                                                    close = "gta_effects_fade_out"
                                                                }
                                                            }
                                                        )
                                                    end
                                                end
                                            )
                                        else
                                            TriggerClientEvent(
                                                "pNotify:SendNotification",
                                                F,
                                                {
                                                    text = {"Ingen spiller fundet."},
                                                    type = "error",
                                                    queue = "global",
                                                    timeout = 4000,
                                                    layout = "centerRight",
                                                    animation = {
                                                        open = "gta_effects_fade_in",
                                                        close = "gta_effects_fade_out"
                                                    }
                                                }
                                            )
                                        end
                                    end
                                )
                            end,
                            "Tag en person i strips eller håndjern ud af en bil"
                        }
                        H["Visiter"] = {
                            function(F, G)
                                vRPclient.getNearestPlayer(
                                    F,
                                    {1},
                                    function(I)
                                        local J = vRP.getUserId({I})
                                        if J ~= nil then
                                            vRPclient.isHandcuffed(
                                                I,
                                                {},
                                                function(K)
                                                    if K then
                                                        TriggerClientEvent(
                                                            "pNotify:SendNotification",
                                                            I,
                                                            {
                                                                text = {"Du er blevet visiteret."},
                                                                type = "info",
                                                                queue = "global",
                                                                timeout = 5000,
                                                                layout = "centerRight",
                                                                animation = {
                                                                    open = "gta_effects_fade_in",
                                                                    close = "gta_effects_fade_out"
                                                                }
                                                            }
                                                        )
                                                        vRPclient.getWeapons(
                                                            I,
                                                            {},
                                                            function(L)
                                                                local M = vRP.getMoney({J})
                                                                local f = ""
                                                                local D = vRP.getUserDataTable({J})
                                                                if D and D.inventory then
                                                                    for g, h in pairs(D.inventory) do
                                                                        local N = vrpitems[g]
                                                                        if N then
                                                                            f =
                                                                                f ..
                                                                                "<br />" ..
                                                                                    N.name .. " (" .. h.amount .. ")"
                                                                        end
                                                                    end
                                                                end
                                                                local O = ""
                                                                for g, h in pairs(L) do
                                                                    O = O .. "<br />" .. g .. " (" .. h.ammo .. ")"
                                                                end
                                                                vRPclient.setDiv(
                                                                    F,
                                                                    {
                                                                        "police_check",
                                                                        ".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",
                                                                        "<b>Penge: </b>" ..
                                                                            M ..
                                                                                "DKK<br /><br /><b>Inventar</b>:" ..
                                                                                    f ..
                                                                                        "<br /><br /><b>Våben:</b>" .. O
                                                                    }
                                                                )
                                                                vRP.request(
                                                                    {F, "Gem rapport?", 1000, function(F, P)
                                                                            vRPclient.removeDiv(F, {"police_check"})
                                                                        end}
                                                                )
                                                            end
                                                        )
                                                    end
                                                end
                                            )
                                        else
                                            TriggerClientEvent(
                                                "pNotify:SendNotification",
                                                F,
                                                {
                                                    text = {lang.common.no_player_near()},
                                                    type = "error",
                                                    queue = "global",
                                                    timeout = 4000,
                                                    layout = "centerRight",
                                                    animation = {
                                                        open = "gta_effects_fade_in",
                                                        close = "gta_effects_fade_out"
                                                    }
                                                }
                                            )
                                        end
                                    end
                                )
                            end,
                            "Visiter en person i strips eller håndjern"}
                        H["Tag våben"] = {
                            function(F, G)
                                local c = vRP.getUserId({F})
                                if c ~= nil then
                                    vRPclient.getNearestPlayer(F, {1}, function(I)
                                            local J = vRP.getUserId({I})
                                            if J ~= nil and vRP.hasPermission({J, "police.seizable"}) then
                                                vRPclient.isHandcuffed(I, {}, function(K)
                                                        if K then
                                                            vRPclient.getWeapons(I, {}, function(L)
                                                                    for g, h in pairs(L) do
                                                                        vRP.giveInventoryItem({c, "wbody|" .. g, 1, true})
                                                                        if h.ammo > 0 then
                                                                            vRP.giveInventoryItem({c, "wammo|" .. g, h.ammo, true})
                                                                        end
                                                                    end
                                                                    vRPclient.giveWeapons(I, {{}, true})
                                                                    vRPclient.notify(I, {"Du fik frataget dine våben"})
                                                                end)
                                                        else
                                                            vRPclient.notify(F, {"Person ikke i håndjern"})
                                                        end
                                                    end)
                                            else
                                                vRPclient.notify(F, {"Ingen spiller tæt på dig"})
                                            end
                                        end
                                    )
                                end
                            end,
                            "Tag våbne fra en person i strips eller håndjern"
                        }
                        vRP.openMenu({F, H})
                    end
                }
                C(E)
            end
        end
    }
)
