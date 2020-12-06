openMenu = function()
    ESX.UI.Menu.CloseAll()
    local elements = {
        {label = "🛒 Buy Weapons", value = "buy_weapons"},
        {label = "👩🏿‍🏭 Craft Items", value = "craft_items"}
    }

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "weapons",
        {
            title = MafiaData.mafia ..
                " / Reputation: <span style='color:red;'>" .. MafiaData.mafia_reputation .. "</span>",
            align = "bottom",
            elements = elements
        },
        function(data, menu)
            if data.current.value == "buy_weapons" then
                open_weapons()
            elseif data.current.value == "craft_items" then
                open_craft()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

open_weapons = function()
    ESX.UI.Menu.CloseAll()
    local elements = {}

    for k, v in pairs(Config.Weapons) do
        if v.reputation > MafiaData.mafia_reputation then
            table.insert(
                elements,
                {
                    label = "<span style='color:gray; float: left; font-weight: bold;'>🔒 " .. v.name .. "</span>",
                    value = v.hash,
                    reputation = v.reputation,
                    price = v.price
                }
            )
        end

        if v.reputation <= MafiaData.mafia_reputation then
            table.insert(
                elements,
                {
                    label = "<span style='float: left; font-weight: bold;'>" ..
                        v.name ..
                            "</span>" ..
                                "&nbsp;&nbsp;&nbsp;&nbsp;<span style='float: right; font-weight: bold;  color:RGBA(0,255,87,0.4); text-shadow: 0px 0px 5px #000'>💲" ..
                                    v.price .. "</span>",
                    value = v.hash,
                    reputation = v.reputation,
                    price = v.price
                }
            )
        end
    end
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "weapon_shop",
        {
            title = MafiaData.mafia .. " Weapon Shop",
            align = "bottom",
            elements = elements
        },
        function(data, menu)
            for k, v in pairs(elements) do
                if data.current.value == v.value then
                    if (v.reputation > MafiaData.mafia_reputation) then
                        exports["cm_notify"]:SendAlert("error", "Your mafia doesnt have enought reputation")
                    elseif (v.reputation <= MafiaData.mafia_reputation) then
                        TriggerServerEvent("mafiamanager:server:buyWeapon", data.current.value, data.current.price)
                    end
                end
            end
        end,
        function(data, menu)
            openMenu()
        end
    )
end

open_craft = function()
    ESX.UI.Menu.CloseAll()
    local elements = {}
    for k, v in pairs(Config.Craft) do
        if v.reputation > MafiaData.mafia_reputation then
            table.insert(
                elements,
                {
                    label = "<span style='color:gray; float: left; font-weight: bold;'>🔒 " .. v.item .. "</span>",
                    value = v.hash,
                    reputation = v.reputation,
                    price = v.price
                }
            )
        end

        if v.reputation <= MafiaData.mafia_reputation then
            table.insert(
                elements,
                {
                    label = "<span style='float: left; font-weight: bold;'>" ..
                        v.item ..
                            "</span>" ..
                                "&nbsp;&nbsp;&nbsp;&nbsp;<span style='float: right; font-weight: bold;  color:RGBA(0,255,87,0.4); text-shadow: 0px 0px 5px #000'>💲" ..
                                    v.price .. "</span>",
                    value = v.hash,
                    reputation = v.reputation,
                    price = v.price
                }
            )
        end
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "craft_menu",
        {
            title = MafiaData.mafia .. " Craft Menu",
            align = "bottom",
            elements = elements
        },
        function(data, menu)
            for k, v in pairs(elements) do
                if data.current.value == v.value then
                    if (v.reputation > MafiaData.mafia_reputation) then
                        exports["cm_notify"]:SendAlert("error", "Your mafia doesnt have enought reputation")
                    elseif (v.reputation <= MafiaData.mafia_reputation) then
                        TriggerServerEvent("mafiamanager:server:craftItem", data.current.value, data.current.price)
                    end
                end
            end
        end,
        function(data, menu)
            openMenu()
        end
    )
end

AddEventHandler(
    "onResourceStop",
    function()
        ESX.UI.Menu.CloseAll()
    end
)
