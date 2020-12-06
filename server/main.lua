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
