Citizen.CreateThread(function() 
    local model = Config.Ped.Model
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Citizen.Wait(200)
    end

    local ped = CreatePed('PED_TYPE_MISSION', GetHashKey(model), Config.Ped.x, Config.Ped.y, Config.Ped.z - 1.0, Config.Ped.h, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityCanBeDamaged(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@base")
    while not HasAnimDictLoaded("amb@world_human_hang_out_street@female_arms_crossed@base") do
        Citizen.Wait(200)
    end
    TaskPlayAnim(ped, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 8.0, 8.0, -1, 16, 1.0, 1, 1, 1)
end)