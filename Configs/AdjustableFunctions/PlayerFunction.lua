---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.GetPlayerJob = function(PlayerId, Core)
    local Player = Core.Functions.GetPlayer(PlayerId)

    return Player.PlayerData.job.name
end

Mek91_HR.IsPlayerOnDuty = function(PlayerId, Core)
    local Player = Core.Functions.GetPlayer(PlayerId)

    return Player.PlayerData.job.onduty
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.GetPlayerStatus = function(Core)
    local Player = Core.Functions.GetPlayerData()

    local PlayerStatus = {
        Hunger = Player.metadata["hunger"],
        Thirst = Player.metadata["thirst"],
        Dead = Player.metadata["isdead"],
        Fainting = Player.metadata["inlaststand"]
    }
    
    return PlayerStatus
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.GetPlayerLockPick = function(PlayerId, Core)
    local LockPickCount = 0
        
    for _, item in pairs(Core.Functions.GetPlayer(PlayerId).PlayerData.items) do
        if item.name == Mek91_HR.LockPickName then
            LockPickCount = item.amount
            break
        end
    end

    return LockPickCount
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.DeletePlayerLockPick = function(PlayerId, Core)
    local Player = Core.Functions.GetPlayer(PlayerId)
    
    Player.Functions.RemoveItem(Mek91_HR.LockPickName, 1)
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.GiveItem = function(PlayerId, Item, Amount, Core)
    local Player = Core.Functions.GetPlayer(PlayerId)

    if Item == "cash" then
        Player.Functions.AddMoney('cash', Amount) -- where to give the money to the person
        return
    end

    Player.Functions.AddItem(Item, Amount)
end
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.SendNotification = function(PlayerId, Msg, SendLocation, Core)
    if SendLocation == "SV" then
        TriggerClientEvent('QBCore:Notify', PlayerId, Msg) -- To send incoming messages from the server to the client side.
        return
    end

    Core.Functions.Notify(Msg) -- To send the messages received by the client to the client side.
end
---------------------------------------------------------------------------------------------------------------------------