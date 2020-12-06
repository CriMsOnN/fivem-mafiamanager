openMenu = function()
    ESX.UI.Menu.CloseAll()
    local elements = {
        { label = "🛒 Buy Weapons", value="buy_weapons"},
        { label = "🛒 Buy Ingredients", value="buy_ingr"}
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'weapons', {
        title = MafiaData.mafia .. " / Reputation: " ..MafiaData.mafia_reputation,
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
    local elements = {}

    for k,v in pairs(Config.Weapons) do
        if v.reputation > MafiaData.mafia_reputation then
            table.insert(elements, {label = "<span style='color:gray; float: left; font-weight: bold;'>🔒 " ..v.name .."</span>", value = v.hash})
        end

        if v.reputation <= MafiaData.mafia_reputation then
            table.insert(elements, {label = "<span style='float: left; font-weight: bold;'>"..v.name .."</span>" .. "&nbsp;&nbsp;&nbsp;&nbsp;<span style='float: right; font-weight: bold;  color:RGBA(0,255,87,0.4); text-shadow: 0px 0px 5px #000'>💲"..v.price.."</span>", value = v.hash})
        end
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
        openMenu()
    end)

end

AddEventHandler("onResourceStop", function()
    ESX.UI.Menu.CloseAll()
end)