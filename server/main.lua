ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("mafiamanager:server:playerJoined")
AddEventHandler("mafiamanager:server:playerJoined", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    getMafiaPlayerData(_source, xPlayer.getIdentifier())
end)


RegisterServerEvent("mafiamanager:server:addReputation")
AddEventHandler("mafiamanager:server:addReputation", function(name, reputation)
    addMafiaReputation(name, reputation)
end)


RegisterServerEvent("mafiamanager:server:buyWeapon")
AddEventHandler("mafiamanager:server:buyWeapon", function(hash, price)
    local _source = source
    local weapon = hash
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = xPlayer.getMoney();
    if tonumber(money) >= tonumber(price) then
        if xPlayer.hasWeapon(weapon) then
            TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "error", text="You already have this weapon"}, 5000)
        else
            xPlayer.addWeapon(weapon, 100)
            xPlayer.removeMoney(tonumber(price))
            TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "success", text="You successfully bought the weapon"}, 5000)
        end
    else
        TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "error", text="You dont have enough cash"}, 5000)
    end
end)

RegisterServerEvent("mafiamanager:server:craftItem")
AddEventHandler("mafiamanager:server:craftItem", function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local craftItem = xPlayer.getInventoryItem(item)
    local money = xPlayer.getMoney();
    if tonumber(money) >= tonumber(price) then
        if xPlayer.canCarryItem(item, craftItem.count) then
            xPlayer.addInventoryItem(item, 1)
            xPlayer.removeMoney(tonumber(price))
            TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "success", text="You have successfully crafted ".. item}, 5000)
        else
            TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "error", text="You cant carry more " .. item}, 5000)
        end
    else
        TriggerClientEvent("cm_notify:client:SendAlert", _source, {type = "error", text="You dont have enough cash"}, 5000)
    end
end)

AddEventHandler("playerDropped", function() 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    updateDroppedPlayer(identifier)
end)