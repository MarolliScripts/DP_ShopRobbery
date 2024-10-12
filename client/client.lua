local cfg = Config.ShopRob
local lang = Config.Lang
local Okradanie = false

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k, v in pairs(Config.Sejfy) do
            exports.qtarget:AddBoxZone("sejfy" .. k, v, 0.8, 0.8, {
                name = "sejfy" .. k,
                heading = 0,
                debugPoly = false,
                minZ = v.z - 0.5,
                maxZ = v.z + 0.5,
            }, {
                options = {
                    {
                        event = "DP_shoprobbery:startNapad",
                        icon = "fas fa-sack-dollar",
                        label = "Obrabuj sejf!",
                        canInteract = function()
                            return IsPedArmed(ESX.PlayerData.ped, 4) or IsPedArmed(ESX.PlayerData.ped, 1)
                        end,
                    },
                },
                distance = 2
            })
        end
    end
end)

RegisterNetEvent('DP_shoprobbery:startNapad', function()    
    local sekund = Config.ShopRob.Cooldown
    ESX.TriggerServerCallback('DP_shoprobbery:firstCheck', function(info) 
        if info == 'brakpolicji' then 
            return ESX.ShowNotification(lang.BrakPD) 
        end
        if info == 'cooldown' then 
            return ESX.ShowNotification('Sejf jest pusty. W ciągu '..sekund..' sekund będziesz mógł zrobić napad.') 
        end
        if info == true then 
            if cfg.Minigame == true then
                local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w', 'a', 's', 'd'})
                if success then
                    Okradanie = true
                    if cfg.Anuluj == true then ESX.ShowNotification(lang.ClickX) end
                    if lib.progressBar({
                        duration = cfg.Duration * 1000,
                        label = 'Okradasz sejf!',
                        useWhileDead = false,
                        canCancel = cfg.Anuluj,
                        disable = {
                            car = true,
                            combat = true,
                            move = true,
                        },
                        anim = {
                            dict = 'oddjobs@shop_robbery@rob_till',
                            clip = 'loop'
                        },
                    }) then 
                        ESX.TriggerServerCallback('DP_shoprobbery:getReward', function(reward)
                            Okradanie = false
                            ESX.ShowNotification('Napad skończony! Zarobiłeś '..reward..'$')
                        end)
                    else
                        Okradanie = false 
                        ESX.ShowNotification(label.Cancel)
                    end
                else
                    Okradanie = false 
                    ESX.ShowNotification(lang.Fail)
                end 
            else
                Okradanie = true
                if cfg.Anuluj == true then ESX.ShowNotification(lang.ClickX) end
                if lib.progressBar({
                    duration = cfg.Duration * 1000,
                    label = 'Okradasz sejf!',
                    useWhileDead = false,
                    canCancel = cfg.Anuluj,
                    disable = {
                        car = true,
                        combat = true,
                        move = true,
                    },
                    anim = {
                        dict = 'oddjobs@shop_robbery@rob_till',
                        clip = 'loop'
                    },
                }) then 
                    ESX.TriggerServerCallback('DP_shoprobbery:getReward', function(reward)
                        Okradanie = false
                        ESX.ShowNotification('Napad skończony! Zarobiłeś '..reward..'$')
                    end)
                else
                    Okradanie = false 
                    ESX.ShowNotification(label.Cancel)
                end
                else
                    Okradanie = false 
                    ESX.ShowNotification(lang.Fail)
                end 
            end
        end
    end)
end)
