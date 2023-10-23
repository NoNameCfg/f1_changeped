if Config.framework == "old-esx" then
  ESX = nil
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  else if Config.framework == "new-esx" then
    ESX = exports["es_extended"]:getSharedObject()
  else if Config.framework == "old-qb" then
    local QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
  else if Config.framework == "new-qb" then
    local QBCore = exports["qb-core"]:GetCoreObject()
    end
   end
  end
end

RegisterCommand('changeped', function(source, args, rawCommand)

  if Config.framework == "old-esx" or Config.framework == "new-esx" then
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' then
    local targetPlayer = tonumber(args[1])
    local newPedModel = args[2]

    if targetPlayer and newPedModel then
      local targetXPlayer = ESX.GetPlayerFromId(targetPlayer)

      if targetXPlayer then
        TriggerClientEvent('change_ped', targetPlayer, newPedModel)

        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'STAFF ' .. GetPlayerName(source) .. ' has changed the ped of ' .. GetPlayerName(targetPlayer) .. ' to ' .. newPedModel, 2000, 'success', true)
          PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the ped of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to ' .. newPedModel}), { ['Content-Type'] = 'application/json' })
        else if Config.notify == "default" then
          TriggerClientEvent('chatMessage', -1, 'PED CHANGE', {255, 0, 0}, 'STAFF ' .. GetPlayerName(source) .. ' has changed the ped of ' .. GetPlayerName(targetPlayer) .. ' to ' .. newPedModel)
          PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the ped of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to ' .. newPedModel}), { ['Content-Type'] = 'application/json' })
        end
      end
      else
        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Invalid Player.', 2000, 'error', true)
        else if Config.notify == "default" then
          TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Invalid Player.')
        end
      end
      end
    else
      if Config.notify == "okok" then
        TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Incorrect use. /changeped [player ID] [ped model]', 2000, 'warning', true)
      else if Config.notify == "default" then
        TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Incorrect use. /changeped [player ID] [ped model]')
      end
    end
  end
  else
    if Config.notify == "okok" then
      TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'You do not have permission to use this command.', 2000, 'error', true)
      else if Config.notify == "default" then
      TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'You do not have permission to use this command.')
    end
  end
end
  else if Config.framework == "old-qb" or Config.framework == "new-qb" then
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if xPlayer.Functions.GetPermission() == 'god' or xPlayer.Functions.GetPermission() == 'admin' or xPlayer.Functions.GetPermission() == 'mod' then
      local targetPlayer = tonumber(args[1])
      local newPedModel = args[2]
  
      if targetPlayer and newPedModel then
        local targetXPlayer = QBCore.Functions.GetPlayer(targetPlayer)
  
        if targetXPlayer then
          TriggerClientEvent('change_ped', targetPlayer, newPedModel)
  
          if Config.notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Player ' .. GetPlayerName(source) .. ' has changed the ped of ' .. GetPlayerName(targetPlayer) .. ' to ' .. newPedModel, 2000, 'success', true)
            PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the ped of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to ' .. newPedModel}), { ['Content-Type'] = 'application/json' })
          else if Config.notify == "default" then
            TriggerClientEvent('chatMessage', -1, 'PED CHANGE', {255, 0, 0}, 'Player ' .. GetPlayerName(source) .. ' has changed the ped of ' .. GetPlayerName(targetPlayer) .. ' to ' .. newPedModel)
            PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n **STAFF**: __' .. GetPlayerName(source) .. '__ has changed the ped of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to ' .. newPedModel}), { ['Content-Type'] = 'application/json' })
          end
        end
        else
          if Config.notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Invalid Player.', 2000, 'error', true)
          else if Config.notify == "default" then
            TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Invalid Player.')
          end
        end
      end
      else
        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Incorrect use. /changeped [player ID] [ped model]', 2000, 'warning', true)
        else if Config.notify == "default" then
          TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Incorrect use. /changeped [player ID] [ped model]')
        end
      end
    end
    else
      if Config.notify == "okok" then
        TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'You do not have permission to use this command.', 2000, 'error', true)
      else if Config.notify == "default" then
        TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'You do not have permission to use this command.')
      end
    end
  end
  end
  end
end, true, {help = "Swap another player's ped"})


RegisterCommand('resetped', function(source, args, rawCommand)
  if Config.framework == "old-esx" or Config.framework == "new-esx" then
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' then
      local targetPlayer = tonumber(args[1]) 
      if targetPlayer then
      local targetXPlayer = ESX.GetPlayerFromId(targetPlayer)
      if targetXPlayer then
        TriggerClientEvent('normal_skin', targetPlayer)
        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'STAFF ' .. GetPlayerName(source) .. ' has changed the skin of ' .. GetPlayerName(targetPlayer) .. ' to the default skin', 2000, 'success', true)
          PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the skin of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to the default skin'}), { ['Content-Type'] = 'application/json' })
        elseif Config.notify == "default" then
          TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'STAFF ' .. GetPlayerName(source) .. ' has changed the skin of ' .. GetPlayerName(targetPlayer) .. ' to the default skin' )
          PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the skin of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to the default skin'}), { ['Content-Type'] = 'application/json' })
        end
      else
        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Invalid Player.', 2000, 'error', true)
        elseif Config.notify == "default" then
          TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Invalid Player.')
        end
      end
    else
      if Config.notify == "okok" then
        TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Invalid player ID. Usage: /resetped [PlayerID]', 2000, 'error', true)
      elseif Config.notify == "default" then
        TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Invalid player ID. Usage: /resetped [PlayerID]')
      end
    end
  else
    if Config.framework == "old-qb" or Config.framework == "new-qb" then
      local xPlayer = QBCore.Functions.GetPlayer(source)

      if xPlayer.Functions.GetPermission() == 'god' or xPlayer.Functions.GetPermission() == 'admin' or xPlayer.Functions.GetPermission() == 'mod' then
        local targetPlayer = tonumber(args[1]) 
        if targetPlayer then
          local targetXPlayer = QBCore.Functions.GetPlayer(targetPlayer)
  
          if targetXPlayer then
          TriggerClientEvent('normal_skin', targetPlayer)
          if Config.notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'STAFF ' .. GetPlayerName(source) .. ' has changed the skin of ' .. GetPlayerName(targetPlayer) .. ' to the default skin', 2000, 'success', true)
            PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the skin of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to the default skin'}), { ['Content-Type'] = 'application/json' })
          elseif Config.notify == "default" then
            TriggerClientEvent('chatMessage', -1, 'PED CHANGE', {255, 0, 0}, 'STAFF ' .. GetPlayerName(source) .. ' has changed the skin of ' .. GetPlayerName(targetPlayer) .. ' to the default skin' )
            PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({content = '**__PED CHANGE LOGS__**\n\n**STAFF**: __' .. GetPlayerName(source) .. '__ has changed the skin of \n\n**PLAYER**: __' .. GetPlayerName(targetPlayer) .. '__ to the default skin'}), { ['Content-Type'] = 'application/json' })
          end
        else
          if Config.notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'Invalid Player.', 2000, 'error', true)
          elseif Config.notify == "default" then
            TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'Invalid Player.')
          end
        end
      else
        if Config.notify == "okok" then
          TriggerClientEvent('okokNotify:Alert', source, 'PED CHANGE', 'You do not have permission to use this command.', 2000, 'error', true)
        elseif Config.notify == "default" then
          TriggerClientEvent('chatMessage', source, 'PED CHANGE', {255, 0, 0}, 'You do not have permission to use this command.')
        end
      end
    end
  end
end
end
end, true, {help = 'Return to your normal skin'})
