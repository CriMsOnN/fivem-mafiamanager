Mafia = {}

createMafia = function(name, identifier) 
    MySQL.Async.execute("SELECT * FROM mafia WHERE name = @name", {
        ["name"] = name
    }, function(result) 
        if result ~= nil then 
            return false
        end
        local timeT = os.date("*t", os.time())
        MySQL.Async.execute("INSERT INTO mafia(name, reputation, boss, money, createdOn) VALUES(@name, @reputation, @boss, @money, @createdOn)", {
            ["name"] = name,
            ["reputation"] = 0,
            ["boss"] = identifier,
            ["money"] = 0,
            ["level"] = 1,
            ["createdOn"] = timeT["day"] .. "/" .. timeT["month"] .. "/" .. timeT["year"] .. " - ".. timeT["hour"] .. ":" .. timeT["min"] 
        }, function(result)
            MySQL.Async.execute("UPDATE users SET mafia = @mafia, mafia_grade = @grade WHERE identifier = @identifier", {
                ["mafia"] = name,
                ["grade"] = "Boss",
                ["identifier"] = identifier
            })
            Mafia[name] = { reputation = 0, boss = identifier, money = 0, level = 1,  createdon = timeT["day"] .. "/" .. "/" .. timeT["month"] .. "/" .. timeT["year"] .. "-".. timeT["hour"] .. ":" .. timeT["min"] }
        end)
    end)
end

loadMafias = function()
    MySQL.Async.fetchAll("SELECT * FROM mafia", {}, function(result) 
        for k,v in pairs(result) do
            Mafia[v.name] = { boss = v.boss, reputation = v.reputation, level = v.level, money = v.money, createdon = v.createdOn }

        end
    end)
end

loadMafias()

addMafiaMember = function(name, identifier)
    MySQL.Async.execute("UPDATE users SET mafia = @mafia, mafia_grade = @grade WHERE identifier = @identifier", {
        ["mafia"] = name,
        ["mafia_grade"] = "Member",
        ["identifier"] = identifier
    })
end

removeMafiaMember = function(identifier)
    MySQL.Async.execute("UPDATE users SET mafia = @mafia, mafia_grade = @grade WHERE identifier = @identifier", {
        ["mafia"] = nil,
        ["mafia_grade"] = nil,
        ["identifier"] = identifier
    })
end


getMafiaLevel = function(name)
    return Mafia[name].level
end

addMafiaLevel = function(name)
    Mafia[name].level = Mafia[name].level + 1
end

addMafiaMoney = function(name, money)
    Mafia[name].money = Mafia[name].money + money
end

getMafiaMoney = function(name)
    return Mafia[name].money
end

getMafiaCreated = function(name)
    return Mafia[name].createdon
end

addMafiaReputation = function(name, reputation)
    local newReputation = Mafia[name].reputation + reputation
    local mafiaLevel = Mafia[name].level
    if newReputation >= Config.level[mafiaLevel].xp then
        Mafia[name].level = Mafia[name].level + 1
        Mafia[name].reputation = newReputation - Config.level[mafiaLevel].xp
    else
        Mafia[name].reputation = newReputation
    end
end

RegisterCommand("test1", function(source, args, raw) 
    addMafiaReputation(tostring(args[1]), tonumber(args[2]))
end)

getMafiaReputation = function(name)
    return Mafia[name].reputation
end

getMafiaBoss = function(name)
    return Mafia[name].boss
end

getMafiaByName = function(name)
    return Mafia[name]
end


getMafiaPlayerData = function(source, identifier)
    MySQL.Async.fetchAll("SELECT mafia, mafia_grade FROM `users` WHERE identifier = @identifier", {
        ["identifier"] = identifier
    }, function(result) 
        if result[1] ~= nil then
            local MafiaData = {
                mafia = result[1].mafia,
                mafia_grade = result[1].mafia_grade,
                mafia_reputation = Mafia[result[1].mafia].reputation,
                mafia_money = Mafia[result[1].mafia].money,
            }
            TriggerClientEvent("mafiamanager:client:updateMafia", source, MafiaData)
        else
            return false
        end
    end)
end

getMafiaByPlayer = function(identifier)
    local mafia = {}
    MySQL.ready(function() 
        MySQL.Async.fetchAll("SELECT mafia, mafia_grade FROM `users` WHERE identifier = @identifier", {
        ["identifier"] = identifier
        }, function(result) 
            mafia = result[1].mafia
        end)
        return mafia
    end)
end

updateDroppedPlayer = function(identifier)
    MySQL.Async.fetchAll("SELECT mafia FROM `users` WHERE identifier = @identifier", {
        ["identifier"] = identifier
    }, function(result) 
        if result[1] ~= nil then
            local name = tostring(result[1].mafia)
            MySQL.Async.execute("UPDATE mafia SET reputation = @reputation, money = @money, level = @level WHERE name = @mafia", {
                ["reputation"] = Mafia[name].reputation,
                ["money"] = Mafia[name].money,
                ["level"] = Mafia[name].level,
                ["mafia"] = name
            }, function(rows) 
                if rows == 0 then return end
            end)
        else
            return
        end
    end)
end

-- RegisterCommand("getm", function(source, args, raw) 
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local identifier = xPlayer.getIdentifier()
--     updateDroppedPlayer(identifier)
-- end)


updateMafia = function(name) 
    MySQL.Async.execute("UPDATE mafia SET reputation = @reputation, money = @money, level = @level WHERE name = @mafia ", {
        ["reputation"] = Mafia[name].reputation,
        ["money"] = Mafia[name].money,
        ["level"] = Mafia[name].level,
        ["name"] = name
    }, function(result) 
        print(name.." Updated successfully")
    end)
end
--DEBUG TOOL

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