local Core = Mek91_HR.Core
local Language = Mek91_HR.Language
local StringPrefix = "_Mek91-HR_"
local CurrentlyRobbedHouses = {}
---------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function() if Mek91_HR.AddItem then Mek91_HR.AddItem() end end)
---------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('playerDropped')
AddEventHandler('playerDropped', function(rsn)
    local PlayerId = source
    local Identifiers = Mek91HR_PlayerInfo(PlayerId)
    local reason = tostring(rsn)

    if string.lower(reason) == "disconnecting" or string.lower(reason) == "exiting" then
        for key, Houses in pairs(CurrentlyRobbedHouses) do
            if Houses.PlayerId == PlayerId then
                Mek91HR_SendPoliceInfo(Houses.House, Mek91_HR.Language["Notifications"]["Police"]["CombatlogThief"].Escaped)
    
                TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, Houses.House, {Reason = "Combatlog", CombatType = "Quit", Identifiers = Identifiers})
                Mek91HR_RobberyDeleter(Houses.House)
                break
            end
        end
    end
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Mek91-HR:Server:SelectFunction", function(Selected)
    local PlayerId = source

    local TargetName = Selected.name
    local HouseName = Selected.house

    for key, Event in pairs(Mek91_HR.Fields) do
        if Event.HouseName == HouseName then
            -- DOORs
            local Door = Event["Door"]

            if "Login" == TargetName then -- Public Login
                local RobCreate = Mek91HR_RobberyCreater(PlayerId, HouseName)
            
                if RobCreate == true then
                    TriggerClientEvent("Mek91-HR:Client:LockPickUsing", PlayerId, HouseName)
                    return
                end

                if RobCreate == "pol" then return end
                
                if RobCreate == "lockpick" then return end
                
                if RobCreate == "polcount" then return end
                
                if RobCreate == "sd" then return end

                
            elseif "LoginPolice" == TargetName then -- Police Login
                local RobControl = Mek91HR_HomeRobberyEnquiry(HouseName)

                if RobControl == 0 then
                    Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].DoorControl, "SV", Core)
                    return
                end -- burada yes or no yapacak birde bir kere mi atıldı teslim ol onlar

                Mek91HR_PoliceHouseControl(PlayerId, HouseName)

                if Mek91HR_AddPoliceFollow(HouseName) then
                    TriggerClientEvent("Mek91-HR:Ui:YesOrNo", RobControl)
                    Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Surrounded"].Announce, "SV", Core)
                end

                TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseName, {Reason = "ControllingTheDoor"})
            -- Logout
            elseif "Logout" == TargetName then
                Mek91HR_SendPoliceInfo(HouseName, Mek91_HR.Language["Notifications"]["Police"]["Door"]["Escape"].Logout)
                TriggerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "He came back out of the door he entered.", "Logout", PlayerId)
            -- BackDoorOut
            elseif "BackDoorOut" == TargetName then
                Mek91HR_SendPoliceInfo(HouseName, Mek91_HR.Language["Notifications"]["Police"]["Door"]["Escape"].BackDoor)
                TriggerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "He escaped through the back door.", "BackDoorOut", PlayerId)
            end

            -- PLACEs
            for key, PlaceName in pairs(Event["Places"]) do
                local Place = PlaceName["Target"]

                if Place["PublicOption"].name == TargetName then
                    TriggerClientEvent("Mek91-HR:Client:ProgressBar", PlayerId, HouseName, TargetName)

                    break
                end
            end

            break
        end
    end
end)

RegisterServerEvent("Mek91-HR:Server:GiveItem", function(HouseName, TargetName)
    local PlayerId = source
    
    local Item = Mek91HR_SelectRandomItem(HouseName, TargetName)

    Mek91_HR.GiveItem(PlayerId, Item.ItemName, Item.Amount, Core)
    
    TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseName, {Reason = "FoundedItem", Place = TargetName, Item = Item.ItemName, Amount = Item.Amount})

    if Item.ItemName == "cash" then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["FoundedItem"].Cash .. " $" .. tostring(Item.Amount), "SV", Core)

        return
    end

    Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["FoundedItem"].ItemName .. ": " .. Item.ItemName .. " " .. Mek91_HR.Language["Notifications"]["Thief"]["FoundedItem"].Amount .. ": " .. tostring(Item.Amount), "SV", Core)
end)

RegisterServerEvent("Mek91-HR:Server:RobberyStarter", function(HouseName)
    local PlayerId = source

    local HouseRobberyCreatingProcess = {
        House = HouseName,
        PlayerId = PlayerId,
        PoliceId = {},
        PoliceFollow = false
    }

    table.insert(CurrentlyRobbedHouses, HouseRobberyCreatingProcess)

    TriggerClientEvent("Mek91-HR:Client:RobberyStarter", PlayerId, HouseName)
    TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseName, {Reason = "CurrentlyBeingRobbed"})
end)

RegisterServerEvent("Mek91-HR:Server:RobberyCompleted", function(HouseName, Reason, Door, PlyrId)
    local PlayerId = 0

    if PlyrId == nil then
        PlayerId = source
    else
        PlayerId = PlyrId
    end

    TriggerClientEvent("Mek91-HR:Client:RobberyCompleted", PlayerId, HouseName, Door)
    Mek91HR_RobberyDeleter(HouseName)
end)

RegisterServerEvent("Mek91-HR:Server:YesOrNo", function(HouseName, Reason)
    local PlayerId = source

    if Reason == "Yes" then
        Mek91HR_SendPoliceInfo(HouseName, Mek91_HR.Language["Notifications"]["Police"]["Surrounded"].Surrendered)
        TriggerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "Surrender", "Logout", PlayerId)
        TriggerClientEvent("Mek91-HR:Client:Surrender", PlayerId)

        TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseName, {Reason = "Captured", CapturedType = "Surrender"})
    elseif Reason == "No" then
        Mek91HR_SendPoliceInfo(HouseName, Mek91_HR.Language["Notifications"]["Police"]["Surrounded"].NoSurrender)

        for key, House in pairs(Mek91_HR.Fields) do
            if House.HouseName == HouseName then
                if House["Door"]["BackDoorOut"].BackDoor then
                    Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["Surrounded"].NoSurrender, "SV", Core)
                    break
                end

                Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["Surrounded"].TheresNoPlaceToEscape, "SV", Core)
                break
            end
        end

        TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseName, {Reason = "Captured", CapturedType = "NoSurrender"})
    end
end)
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_RobberyCreater(PlayerId, HouseNames)
    local Done = true
    local House = ""
    local PlayerJob = Mek91_HR.GetPlayerJob(PlayerId, Core)
    local RobPlayerId = Mek91HR_HomeRobberyEnquiry(HouseNames)

    if PlayerJob == "police" then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].YourPolice, "SV", Core)

        return "pol"
    end

    if RobPlayerId ~= 0 then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["Door"].CurrentRobberyExists, "SV", Core)
        Mek91HR_SendThiefInfo(HouseNames, Mek91_HR.Language["Notifications"]["Thief"]["Door"].ForceTheDoor)
        TriggerEvent("Mek91-HR:Server:SendWebhook", PlayerId, HouseNames, {Reason = "TryingToRobbery", TryType="Door"})

        return "sd"
    end

    if Mek91_HR.GetPlayerLockPick(PlayerId, Core) == 0 then
        local Msg = Mek91_HR.Language["Notifications"]["Thief"]["Door"].NotFoundLockPick

        Mek91_HR.SendNotification(PlayerId, Msg, "SV", Core)
    
        return "lockpick"
    end

    if Mek91_HR.GetPoliceCount(Core) < Mek91_HR.MinimumPolice then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Thief"]["Door"].InsufficientNumberOfPolice, "SV", Core)

        return "polcount"
    end

    for key, HouseName in pairs(CurrentlyRobbedHouses) do
        if HouseName == HouseNames then
            Done = false
            break
        end
    end

    if Done then
        return true
    else
        return false
    end
end

function Mek91HR_HomeRobberyEnquiry(HouseName) -- house player rob founder
    local PlayerId = 0

    for key, Houses in pairs(CurrentlyRobbedHouses) do
        if Houses.House == HouseName then
            PlayerId = Houses.PlayerId

            break
        end
    end

    return PlayerId
end

function Mek91HR_RobberyDeleter(HouseName)
    for key, Houses in pairs(CurrentlyRobbedHouses) do
        if Houses.House == HouseName then
            table.remove(CurrentlyRobbedHouses, key)

            break
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_PoliceHouseControl(PlayerId, HouseName)
    local PlayerJob = Mek91_HR.GetPlayerJob(PlayerId, Core)
    local PlayerDuty = Mek91_HR.IsPlayerOnDuty(PlayerId, Core)
    local RobPlayerId = Mek91HR_HomeRobberyEnquiry(HouseName)
    local PoliceListAdd = Mek91HR_AddPoliceList(PlayerId, HouseName)

    if PlayerJob ~= "police" then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].InsufficientProfession, "SV", Core)
        return
    end

    if not PlayerDuty then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].YouAreOffDuty, "SV", Core)
        return
    end

    if PoliceListAdd == "Added" then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].FollowingYou, "SV", Core)
    elseif PoliceListAdd == "Already Attached" then
        Mek91_HR.SendNotification(PlayerId, Mek91_HR.Language["Notifications"]["Police"]["Door"].AlreadyFollowingYou, "SV", Core)
    end
end

function Mek91HR_AddPoliceList(PlayerId, HouseName)
    local Add = true
    local Response = ""

    for key, PoliceList in pairs(CurrentlyRobbedHouses) do
        if PoliceList.House == HouseName then
            for _, PoliceId in pairs(PoliceList.PoliceId) do
                if PoliceId == PlayerId then
                    Add = false

                    break
                end
            end

            if Add then
                table.insert(CurrentlyRobbedHouses[key].PoliceId, PlayerId)

                Response = "Added"
            else
                Response = "Already Attached"
            end

            break
        end
    end

    return Response
end

function Mek91HR_AddPoliceFollow(HouseName)
    local Response = false
    for key, PoliceFollow in pairs(CurrentlyRobbedHouses) do
        if PoliceFollow.House == HouseName then
            if type(PoliceFollow.PoliceFollow) ~= "table" then
                CurrentlyRobbedHouses[key].PoliceFollow = {}
            end

            if next(PoliceFollow.PoliceFollow) then
                Response = false
            else
                table.insert(CurrentlyRobbedHouses[key].PoliceFollow, true)
                Response = true
            end

            break
        end
    end

    return Response
end

function Mek91HR_SendPoliceInfo(HouseName, Msg)
    for key, PoliceList in pairs(CurrentlyRobbedHouses) do
        if PoliceList.House == HouseName then
            local PoliceListId = PoliceList.PoliceId

            for key, PoliceId in pairs(PoliceListId) do
                Mek91_HR.SendNotification(PoliceId, Msg, "SV", Core)
            end

            break
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_SendThiefInfo(HouseName, Msg)
    local PlayerId = Mek91HR_HomeRobberyEnquiry(HouseName)

    Mek91_HR.SendNotification(PlayerId, Msg, "SV", Core)
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_SelectRandomItem(HouseName, TargetName)
    local Item = {}

    for key, Field in pairs(Mek91_HR.Fields) do

        if Field.HouseName == HouseName then

            for key, Place in pairs(Field["Places"]) do

                if Place["Target"]["PublicOption"].name == TargetName then
                    local Items = Place["Items"]

                    local selectedItem = Items[math.random(1, #Items)]

                    Item = {
                        ItemName = selectedItem.item,
                        Amount = math.random(selectedItem.min, selectedItem.max)
                    }

                    break
                end
            end

            break
        end
    end

    return Item
end