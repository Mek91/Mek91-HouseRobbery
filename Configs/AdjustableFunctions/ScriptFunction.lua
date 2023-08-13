---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.AddItem = function()
    exports['qb-core']:AddItem(Mek91_HR.LockPickName, {
        name = Mek91_HR.LockPickName,
        label = Mek91_HR.Language["AddItem"].Label,
        weight = 0.2,
        type = 'item',
        image = Mek91_HR.LockPickName .. '.png',
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = Mek91_HR.Language["AddItem"].Descrptn
    })
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.SetTarget = function(Place, TargetLocation, TargetMinZ, TargetMaxZ, options, LeftWidth, RightWidth)
    exports['qb-target']:AddBoxZone(Place, TargetLocation, LeftWidth, RightWidth, {
        name = Place,
        debugPoly = false,
        minZ = TargetMinZ,
        maxZ = TargetMaxZ
    }, {
        options = options,
        distance = 2,
    })
end

Mek91_HR.RemoveTarget = function(Place)
    exports['qb-target']:RemoveZone(Place)
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.LockPickUsing = function(Core, CB)
    local SelectSkillBar = "qb-skillbar" -- | "tgiann-skillbar" or "qb-skillbar" |
    
    local Sucess = 1
    local Remaining = 3

    if SelectSkillBar == "tgiann-skillbar" then
        local TgSkillbar = exports["tgiann-skillbar"]:taskBar(math.random(25000,40000),math.random(2,4))

        if TgSkillbar then
            CB(true)
        else
            CB(false)
        end
    elseif SelectSkillBar == "qb-skillbar" then
        local QbSkillbar = exports['qb-skillbar']:GetSkillbarObject()

        QbSkillbar.Start({
            duration = math.random(4500, 7000),
            pos = math.random(10, 30),
            width = math.random(10, 20),
        }, function()
            if Sucess >= Remaining then
                Sucess = 0
                CB(true)
            else
                QbSkillbar.Repeat({
                    duration = math.random(2000, 4000),
                    pos = math.random(10, 40),
                    width = math.random(10, 13),
                })
                Sucess = Sucess + 1
            end
        end, function()
            CB(false)
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.ProgressBarUsing = function(Core, Duration, CB)
    Core.Functions.Progressbar("Mek91HR_ProgressBar", Mek91_HR.Language["Notifications"]["Thief"]["Searchs"].Nightstand, Duration, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {}, {}, {}, function()
        CB(true)
    end)
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.GetPoliceCount = function(Core)
    local PoliceCount = 0

    for key, PlayerId in ipairs(GetPlayers()) do
        local Player = Core.Functions.GetPlayer(tonumber(PlayerId))
        
        if Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
            PoliceCount = PoliceCount + 1
        end
    end

    return PoliceCount
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.SendPoliceNotify = function(Msg)
    TriggerServerEvent('police:server:policeAlert', Msg)
end
---------------------------------------------------------------------------------------------------------------------------
