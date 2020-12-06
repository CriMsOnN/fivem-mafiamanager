Citizen.CreateThread(function() 
    while true do
        local sleep = true
        local coords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Ped.x, Config.Ped.y, Config.Ped.z, true) <= 2.0 then
            sleep = false
            Functions.DrawText3D(Config.Ped.x, Config.Ped.y, Config.Ped.z + 1.0, "Press [~r~E~s~] to start a mission")
        end
        if sleep then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)