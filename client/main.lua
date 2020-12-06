ESX = nil
local PlayerData = {}
MafiaData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
    TriggerServerEvent("mafiamanager:server:playerJoined")

end)


RegisterNetEvent("mafiamanager:client:updateMafia")
AddEventHandler("mafiamanager:client:updateMafia", function(playerData) 
    if playerData ~= nil then
        MafiaData = playerData
    else
        return
    end
end)

RegisterCommand("menu", function()
    exports["cm_notify"]:SendAlert("success", "Successfully opened menu", 5000);
    openMenu()
end)


--DEBUG TOOL:
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end