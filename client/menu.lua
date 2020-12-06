openMenu = function()
    ESX.UI.Menu.CloseAll()
    local elements = {
        { label = "🛒 Buy Weapons", value="buy_weapons"},
        { label = "🛒 Buy Ingredients", value="buy_ingr"}
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'weapons', {
        title = "🕵️"..MafiaData.mafia .. ' / Reputation: ' ..MafiaData.mafia_reputation,
        align = "bottom",
        elements = elements,
    }, function(data, menu) 
        if data.current.value == "buy_weapons" then
            open_weapons()
        elseif data.current.value == "buy_ingr" then
            open_ingr()
        end
    end, function(data, menu) 
        menu.close()
    end)
end

open_weapons = function()
    local elements = {
        { label = "AK47", value = "weapon_ak47"},
        { label = "Carbine Rifle", value = "weapon_carbine_rifle"}
    }

    if MafiaData.mafia_reputation >= 0 then
        table.insert(elements, { label = "SMS", value = "SMG" })
        table.insert(elements, {label = "SLS", value = "SLS" })
    end

    if MafiaData.mafia_reputation >= 0 then
        table.insert(elements, { label = "other", value = "other"})
    end
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "weapon_shop", {
        title = MafiaData.mafia .. " Weapon Shop",
        align = "bottom",
        elements = elements,
    }, function(data, menu) 
        for k,v in pairs(elements) do
            if data.current.value == v.value then
                print("works")
            end
        end
    end, function(data, menu)
        menu.close()
    end)

end

AddEventHandler("onResourceStop", function()
    ESX.UI.Menu.CloseAll()
end)