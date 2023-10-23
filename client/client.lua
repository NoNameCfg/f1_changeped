RegisterNetEvent('change_ped')
AddEventHandler('change_ped', function(pedModel)
    local model = GetHashKey(pedModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end)