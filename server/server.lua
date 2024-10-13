local playerCooldowns = {}
local cfg = Config.ShopRob
local webhook = '' -- kanał discord, na który zostaną wysłane informacje o napadach

ESX.RegisterServerCallback('DP_shoprobbery:firstCheck', function(source, cb)
    local players = ESX.GetPlayers()
    local licznikpolice = 0 
    local currentTime = os.time() 
    local cooldown = cfg.Cooldown
    local xPlayer = ESX.GetPlayerFromId(source)

    for i = 1, #players do 
        local player = ESX.GetPlayerFromId(players[i])
        if player and (player.job.name == cfg.Police or player.job.name == cfg.Sheriff) then
            licznikpolice = licznikpolice + 1
        end
    end 

    if licznikpolice < cfg.Potrzebni then 
        return cb('brakpolicji') 
    end 

    if playerCooldowns[xPlayer.identifier] and (currentTime - playerCooldowns[xPlayer.identifier].lastRobbed) < cooldown then
        return cb('cooldown') 
    end 

    cb(licznikpolice >= 1)
    sendLog(webhook, 66666, 'DP_shoprobbery', GetPlayerName(source)..' rozpoczął napad na kasetkę!')
end)

ESX.RegisterServerCallback('DP_shoprobbery:getReward', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end 

    local reward = cfg.Rewards 
    local currentTime = os.time() 
    playerCooldowns[xPlayer.identifier] = {
        lastRobbed = currentTime
    }

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local targetRadius = 6.0
    local withinTarget = false

    for i = 1, #Config.Sejfy do
        local targetCoords = Config.Sejfy[i]
        local distance = #(playerCoords - targetCoords)

        if distance <= targetRadius then
            withinTarget = true
            break
        end
    end

    if not withinTarget then
        DropPlayer(source, 'Złapałem cię cheaterze!')
        sendLog(webhook, 0xFF0000, 'DP_shoprobbery', GetPlayerName(source) .. ' Próbował zniszczyć system i nielegalnie wykraść pieniądze! Zbanuj go!')
        return
    end

    xPlayer.addMoney(reward)
    cb(reward)
    sendLog(webhook, 66666, 'DP_shoprobbery', GetPlayerName(source) .. ' zgarnął z napadu na kasetkę **' .. reward .. '$!**')
end)


function sendLog(webhook, color, name, message)
    local currentDate = os.date("%Y-%m-%d")
    local currentTime = os.date("%H:%M:%S")
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = currentTime.." "..currentDate,
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
