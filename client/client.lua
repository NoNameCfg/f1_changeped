if Config.framework == "old-esx" then
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(1000)
        end
    end)
    else if Config.framework == "new-esx" then
      ESX = exports["es_extended"]:getSharedObject()
    else if Config.framework == "old-qb" then
        QBCore = nil
      Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(1000)
        end
    end)
    else if Config.framework == "new-qb" then
       QBCore = exports["qb-core"]:GetCoreObject()
      end
     end
    end
  end

RegisterNetEvent('change_ped')
AddEventHandler('change_ped', function(pedModel)
    local model = GetHashKey(pedModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1000)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end)


RegisterNetEvent('normal_skin')
AddEventHandler('normal_skin', function(normalSkin)
if Config.framework == "old-esx" or Config.framework == "new-esx" then

  local playerPed = PlayerPedId()
  local maxhealth = GetEntityMaxHealth(playerPed)
  local health = GetEntityHealth(playerPed)
  local model, sex, fullSkin = nil
 local wep = GetSelectedPedWeapon(playerPed)

  TriggerEvent('skinchanger:getSkin', function(skin) sex = skin.sex fullSkin = skin end)
  
  if sex == 1 then 
    model = GetHashKey("mp_f_freemode_01") 
  else 
    model = GetHashKey("mp_m_freemode_01") 
  end 
  
  RequestModel(model)

  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  TriggerEvent('skinchanger:loadSkin', fullSkin)
   SetPedMaxHealth(PlayerId(), maxhealth)
   Citizen.Wait(1000) 
  SetEntityHealth(PlayerPedId(), health)
else if Config.framework == "old-qb" or Config.framework == "new-qb" then
local playerPed = PlayerId()
local maxhealth = GetEntityMaxHealth(playerPed)
local health = GetEntityHealth(playerPed)
local model, sex, fullSkin = nil
local wep = GetSelectedPedWeapon(playerPed)

TriggerEvent('qb-skinchanger:client:getSkin', function(skin) sex = skin['sex'] fullSkin = skin end)

if sex == 1 then 
    model = GetHashKey("mp_f_freemode_01") 
else 
    model = GetHashKey("mp_m_freemode_01") 
end 

RequestModel(model)

SetPlayerModel(PlayerId(), model)
SetModelAsNoLongerNeeded(model)
TriggerEvent('qb-skinchanger:loadSkin', fullSkin)
SetPedMaxHealth(playerPed, maxhealth)
Citizen.Wait(1000)
SetEntityHealth(playerPed, health)
end
end
end)
