openMenu = function()
    local elements = {
        { label = "Buy Weapons", value="buy_weapons"},
        { label = "Buy Ingredients", value="buy_ingr"}
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'weapons', {
        title = 'Menu',
        align = "bottom-right",
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