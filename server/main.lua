ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("mafiamanager:server:playerJoined")
AddEventHandler("mafiamanager:server:playerJoined", function()
    print("works")
end)

RegisterCommand("createmafia", function(source, args, raw) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local mafia = createMafia(args[1], xPlayer.getIdentifier())

    if not mafia then 
        TriggerClientEvent("chatMessage", source, "[Mafia]", {220, 0, 0}, "Name already exists")
    else
        TriggerClientEvent("chatMessage", source, "[Mafia]", {220, 0, 0}, "Mafia successfully created")
    end
end)

RegisterCommand("getMafia", function(source, args, raw)
    local test = tostring(args[1])
    print(getMafiaBoss(test))
end)