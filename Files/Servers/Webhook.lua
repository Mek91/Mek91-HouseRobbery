RegisterServerEvent("Mek91-HR:Server:SendWebhook", function(PlyrId, HouseName, Response)
    local PlayerId = 0

    if PlyrId == nil then
        PlayerId = source
    else
        PlayerId = PlyrId
    end

    local Identifiers = Mek91HR_PlayerInfo(PlayerId)

    local WebHook = {
        Color = 0,
        Title = "",
        DiscordWebhook = "",
        DiscordWebhookName = "",
        DiscordWebhookAvatarUrl = "",
        Info = {}
    }
---------------------------------------------------------------------------------------------------------------------------
    if Response.Reason == "Door" then
        local DoorWebHookCfg = Mek91_HR.DiscordWebhooks["Door"]

        WebHook.DiscordWebhook = DoorWebHookCfg.Webhook
        WebHook.DiscordWebhookName = DoorWebHookCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = DoorWebHookCfg.AvatarUrl

        if Response.DoorType == "Login" then
            WebHook.Color = DoorWebHookCfg.LoginColor
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Door"].HouseLogin, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Door"].Login, ["inline"] = false})
        elseif Response.DoorType == "Logout" then
            WebHook.Color = DoorWebHookCfg.ExitColor
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Door"].HouseOut, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Door"].Out, ["inline"] = false})
        elseif Response.DoorType == "BackDoorOut" then
            WebHook.Color = DoorWebHookCfg.ExitColor
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Door"].HouseOut, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Door"].BackDoor, ["inline"] = false})
        end
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "Combatlog" then
        local CombatlogCfg = Mek91_HR.DiscordWebhooks["Combatlog"]

        WebHook.DiscordWebhook = CombatlogCfg.Webhook
        WebHook.DiscordWebhookName = CombatlogCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = CombatlogCfg.AvatarUrl
        WebHook.Color = CombatlogCfg.Color

        if Response.CombatType == "Quit" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Combatlog"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Combatlog"].Quit, ["inline"] = false})
            Identifiers = Response.Identifiers
        elseif Response.CombatType == "Spawn" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Combatlog"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Combatlog"].Spawn, ["inline"] = false})
        end
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "ControllingTheDoor" then
        local ControllingTheDoorCfg = Mek91_HR.DiscordWebhooks["ControllingTheDoor"]

        WebHook.DiscordWebhook = ControllingTheDoorCfg.Webhook
        WebHook.DiscordWebhookName = ControllingTheDoorCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = ControllingTheDoorCfg.AvatarUrl
        WebHook.Color = ControllingTheDoorCfg.Color

        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["ControllingTheDoor"].House, ["value"] = HouseName, ["inline"] = false})
        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["ControllingTheDoor"].ControlDoor, ["inline"] = false})
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "TryingToRobbery" then
        local TryingToRobberyCfg = Mek91_HR.DiscordWebhooks["TryingToRobbery"]

        WebHook.DiscordWebhook = TryingToRobberyCfg.Webhook
        WebHook.DiscordWebhookName = TryingToRobberyCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = TryingToRobberyCfg.AvatarUrl
        WebHook.Color = TryingToRobberyCfg.Color

        if Response.TryType == "Door" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["TryingToRobbery"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["TryingToRobbery"].TryDoor, ["inline"] = false})
        elseif Response.TryType == "LockPick" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["TryingToRobbery"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["TryingToRobbery"].TryDoorLockPick, ["inline"] = false})
        end
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "CurrentlyBeingRobbed" then
        local CurrentlyBeingRobbedCfg = Mek91_HR.DiscordWebhooks["CurrentlyBeingRobbed"]

        WebHook.DiscordWebhook = CurrentlyBeingRobbedCfg.Webhook
        WebHook.DiscordWebhookName = CurrentlyBeingRobbedCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = CurrentlyBeingRobbedCfg.AvatarUrl
        WebHook.Color = CurrentlyBeingRobbedCfg.Color

        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["CurrentlyBeingRobbed"].House, ["value"] = HouseName, ["inline"] = false})
        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["CurrentlyBeingRobbed"].Robbed, ["inline"] = false})
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "Captured" then
        local Captured = Mek91_HR.DiscordWebhooks["Captured"]

        WebHook.DiscordWebhook = Captured.Webhook
        WebHook.DiscordWebhookName = Captured.WebhookName
        WebHook.DiscordWebhookAvatarUrl = Captured.AvatarUrl

        if Response.CapturedType == "Surrender" then
            WebHook.Color = Captured.YesColor
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Captured"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Captured"].Surrender, ["inline"] = false})
        elseif Response.CapturedType == "NoSurrender" then
            WebHook.Color = Captured.NoColor
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Captured"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Captured"].NoSurrender, ["inline"] = false})
        end
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "FoundedItem" then
        local FoundedItemCfg = Mek91_HR.DiscordWebhooks["FoundedItem"]

        WebHook.DiscordWebhook = FoundedItemCfg.Webhook
        WebHook.DiscordWebhookName = FoundedItemCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = FoundedItemCfg.AvatarUrl
        WebHook.Color = FoundedItemCfg.Color

        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["FoundedItem"].House, ["value"] = HouseName, ["inline"] = false})
        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["FoundedItem"].Place, ["value"] = Response.Place, ["inline"] = false})
        table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["FoundedItem"].ItemName, ["value"] = Response.Item .. " " .. Response.Amount .. "X", ["inline"] = false})
---------------------------------------------------------------------------------------------------------------------------
    elseif Response.Reason == "Dead" then
        local DeadCfg = Mek91_HR.DiscordWebhooks["Dead"]

        WebHook.DiscordWebhook = DeadCfg.Webhook
        WebHook.DiscordWebhookName = DeadCfg.WebhookName
        WebHook.DiscordWebhookAvatarUrl = DeadCfg.AvatarUrl
        WebHook.Color = DeadCfg.Color

        if Response.DeadType == "Npc" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Dead"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Dead"].KilledByNpc, ["inline"] = false})
        elseif Response.DeadType == "Starved" then
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["Dead"].House, ["value"] = HouseName, ["inline"] = false})
            table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Main"].Response, ["value"] = Mek91_HR.Language["Webhook"]["Dead"].StarvedToDeath, ["inline"] = false})
        end
---------------------------------------------------------------------------------------------------------------------------
    end
---------------------------------------------------------------------------------------------------------------------------
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Title, ["value"] = "", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].PlayerId, ["value"] = PlayerId, ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Name, ["value"] = Identifiers.name or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Steam, ["value"] = Identifiers.steam or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Discord, ["value"] = Identifiers.discord and ("<@!"..Identifiers.discord:gsub("discord:", "")..">\n" .. Identifiers.discord:gsub("discord:", "")) or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].License, ["value"] = Identifiers.license or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Xbox, ["value"] = Identifiers.xbl or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Live, ["value"] = Identifiers.live or "N/A", ["inline"] = false})
    table.insert(WebHook.Info, {["name"] = Mek91_HR.Language["Webhook"]["PlayerInfo"].Ip, ["value"] = Identifiers.ip or "N/A", ["inline"] = false})
---------------------------------------------------------------------------------------------------------------------------
    PerformHttpRequest(WebHook.DiscordWebhook,function(err, text, headers)end,'POST',json.encode({username=WebHook.DiscordWebhookName,avatar_url=WebHook.DiscordWebhookAvatarUrl,embeds={{["color"]=WebHook.Color,["title"]=WebHook.Title,["url"]="https://youtube.com/@mek91",['author']={['name']='Mek91 House Robbery',['icon_url']='https://cdn.discordapp.com/attachments/1084868011871183008/1084868083233075240/mekMiniLogo.png'},["fields"]=WebHook.Info,["footer"]={["text"]="dev. 'Mek91#9959 | youtube.com/@mek91"},['timestamp']=os.date('!%Y-%m-%dT%H:%M:%SZ')}}}),{['Content-Type']='application/json'})
end)