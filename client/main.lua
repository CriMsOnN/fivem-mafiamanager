ESX = nil
local playerLoaded = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while not playerLoaded do
        Citizen.Wait(0)
        if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent('mafiamanager:server:playerJoined')
            playerLoaded = true
        end
    end
end)

