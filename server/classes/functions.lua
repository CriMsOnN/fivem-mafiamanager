Mafia = {}

createMafia = function(name, identifier) 
    MySQL.Async.execute("SELECT * FROM mafia WHERE name = @name", {
        ["name"] = name
    }, function(result) 
        if result[1] == nil then return end
        MySQL.Async.execute("INSERT INTO mafia('name', 'reputation', 'boss', 'money', 'createdOn') VALUES(@name, @reputation, @boss, @money, @createdOn)", {
            ["name"] = name,
            ["reputation"] = 0,
            ["boss"] = identifier,
            ["money"] = 0,
            ["createdOn"] = timeT["day"] .. "/" .. "/" .. timeT["month"] .. "/" .. timeT["year"] .. "-".. timeT["hour"] .. ":" .. timeT["min"] 
        }, function(result)
            Mafia[name] = { reputation = 0, boss = identifier, money = 0,  createdOn = timeT["day"] .. "/" .. "/" .. timeT["month"] .. "/" .. timeT["year"] .. "-".. timeT["hour"] .. ":" .. timeT["min"] }
        end)
    end)
end

addMafiaMoney = function(name, money)
    Mafia[name].money = Mafia[name].money + money
end

getMafiaMoney = function(name)
    return Mafia[name].money
end

getMafiaCreated = function(name)
    return Mafia[name].createdOn
end

addMafiaReputation = function(name, reputation)
    Mafia[name].reputation = Mafia[name].reputation + reputation
end

getMafiaReputation = function(name)
    return Mafia[name].reputation
end

getMafiaBoss = function(name)
    return Mafia[name].boss
end

getMafiaByName = function(name)
    return Mafia[name]
end
