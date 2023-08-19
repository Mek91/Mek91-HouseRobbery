local Core = Mek91_HR.Core
local StringPrefix = "_Mek91-HR_"
local RobberyProcess = false
local YesOrNoHouseName = ""
---------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent(Mek91_HR.OnPlayerLoaded, function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for key, Field in pairs(Mek91_HR.Fields) do
        local SpawnInsideTheHouse = Field["SpawnInsideTheHouse"]

        if GetDistanceBetweenCoords(playerCoords, SpawnInsideTheHouse.Zone, true) <= SpawnInsideTheHouse.Radius and playerCoords.z >= SpawnInsideTheHouse["Height"].Min and playerCoords.z <= SpawnInsideTheHouse["Height"].Max then
            local AfterCoord = Field["Door"]["Logout"].AfterCoord
            
            SetEntityCoords(playerPed, AfterCoord.x, AfterCoord.y, AfterCoord.z, false, false, false, true)
            SetEntityHeading(playerPed, AfterCoord.w)

            Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Combatlog"].ThrownOut, "CL", Core)

            TriggerServerEvent("Mek91-HR:Server:SendWebhook", nil, Field.HouseName, {Reason = "Combatlog", CombatType = "Spawn"})
            break
        end
    end
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+Mek91HR", function(source, args)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local HouseName = tostring(args[1])
    local HouseNotFound = true

    if args[1] == nil or HouseName == "" then
        print("^1Invalid House Name!")
        return
    end

    for key, Field in pairs(Mek91_HR.Fields) do
        if Field.HouseName == HouseName then
            local SpawnInsideTheHouse = Field["SpawnInsideTheHouse"]
            local isInRange = playerCoords.z >= SpawnInsideTheHouse["Height"].Min and playerCoords.z <= SpawnInsideTheHouse["Height"].Max
    
            local Dist = GetDistanceBetweenCoords(playerCoords, SpawnInsideTheHouse.Zone, true)
            local Radius = SpawnInsideTheHouse.Radius
    
            if not isInRange then
                print("^7Height: ^1" .. tostring(playerCoords.z) .. "^7 MinimumH: ^3".. tostring(SpawnInsideTheHouse["Height"].Min) .. "^7 MaximumH: ^3".. tostring(SpawnInsideTheHouse["Height"].Max))
            else
                print("^7Height: ^2" .. tostring(playerCoords.z) .. "^7 MinimumH: ^3".. tostring(SpawnInsideTheHouse["Height"].Min) .. "^7 MaximumH: ^3".. tostring(SpawnInsideTheHouse["Height"].Max))
            end
    
            if Dist <= Radius and isInRange then
                print("^7Dist: ^2" .. tostring(Dist) .. "^7 Radius: ^3".. tostring(Radius))
                
            else
                print("^7Dist: ^1" .. tostring(Dist) .. "^7 Radius: ^3".. tostring(Radius))
            end
            
            HouseNotFound = false
            break
        end 
    end

    if HouseNotFound then
        print("^1House Not Found!")
    end
end)
---------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    for key, Field in pairs(Mek91_HR.Fields) do
        local Door = Field["Door"]
---------------------------------------------------------------------------------------------------------------------------
        local DoorLogin = Door["Login"]["Target"]
        if DoorLogin then
            local Location = DoorLogin["Location"]

            local Options = {
                {
                    label = DoorLogin["PublicOption"].label,
                    icon = DoorLogin["PublicOption"].icon,
                    event = "Mek91-HR:Server:SelectFunction",
                    type = "server",
                    name = "Login",
                    house = Field.HouseName,
                },
                {
                    label = DoorLogin["PoliceOption"].label,
                    icon = DoorLogin["PoliceOption"].icon,
                    event = "Mek91-HR:Server:SelectFunction",
                    type = "server",
                    job = DoorLogin["PoliceOption"].job,
                    name = "LoginPolice",
                    house = Field.HouseName
                }
            }

            Mek91_HR.SetTarget("Login" .. StringPrefix .. Field.HouseName, Location.TargetLocation, Location.TargetMinZ, Location.TargetMaxZ, Options, Location.LeftWidth, Location.RightWidth)
        end
---------------------------------------------------------------------------------------------------------------------------
        local DoorLogout = Door["Logout"]["Target"]
        if DoorLogout then
            local Location = DoorLogout["Location"]

            local Options = { -- bu kısımda {} içine alarak denicez büyük ihtimalle bunu eklemedik amq bundan dolayı...
                {
                    label = DoorLogout["PublicOption"].label,
                    icon = DoorLogout["PublicOption"].icon,
                    event = "Mek91-HR:Server:SelectFunction",
                    type = "server",
                    name = "Logout",
                    house = Field.HouseName,
                }
            }

            Mek91_HR.SetTarget("Logout" .. StringPrefix .. Field.HouseName, Location.TargetLocation, Location.TargetMinZ, Location.TargetMaxZ, Options, Location.LeftWidth, Location.RightWidth)
        end
---------------------------------------------------------------------------------------------------------------------------
        local DoorBackDoorOut = Door["BackDoorOut"]
        if DoorBackDoorOut then
            if DoorBackDoorOut.BackDoor then
                local Target = DoorBackDoorOut["Target"]
                local Location = Target["Location"]

                local Options = {
                    {
                        label = Target["PublicOption"].label,
                        icon = Target["PublicOption"].icon,
                        event = "Mek91-HR:Server:SelectFunction",
                        type = "server",
                        name = "BackDoorOut",
                        house = Field.HouseName,
                    }
                }

                Mek91_HR.SetTarget("BackDoorOut" .. StringPrefix .. Field.HouseName, Location.TargetLocation, Location.TargetMinZ, Location.TargetMaxZ, Options, Location.LeftWidth, Location.RightWidth)
            end
        end
---------------------------------------------------------------------------------------------------------------------------
        Blip = Field["Blip"]
        if Blip.Blip then
            Mek91HR_AddBlip(Blip.BlipLocation, Blip.BlipId, Blip.BlipColorId, Blip.BlipName, Blip.BlipDisplay, Blip.BlipScale)
        end
---------------------------------------------------------------------------------------------------------------------------
    end
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Mek91-HR:Client:LockPickUsing", function(HouseName)
    local playerPed = PlayerPedId()

    RequestAnimDict("creatures@rottweiler@tricks@")
    while not HasAnimDictLoaded("creatures@rottweiler@tricks@") do
        Citizen.Wait(5)
    end

    TaskPlayAnim(playerPed, 'creatures@rottweiler@tricks@', 'petting_franklin', 8.0, 8.0, -1, 17, 0, false, false, false)
    FreezeEntityPosition(playerPed, true)
    
    Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Door"].TryingTheDoor, "CL", Core)
    
    Mek91_HR.LockPickUsing(HouseName, function(success)
        if success then
            ClearPedTasks(playerPed)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("Mek91-HR:Server:RobberyStarter", HouseName)
        else
            ClearPedTasks(playerPed)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("Mek91-HR:Server:SendWebhook", nil, HouseName, {Reason = "TryingToRobbery", TryType="LockPick"})
        end
    end)
end)

RegisterNetEvent("Mek91-HR:Client:ProgressBar", function(HouseName, TargetName)
    TriggerEvent("Mek91-HR:Client:DeletePlace", HouseName, TargetName)

    local playerPed = PlayerPedId()

    RequestAnimDict("creatures@rottweiler@tricks@")
    while not HasAnimDictLoaded("creatures@rottweiler@tricks@") do
        Citizen.Wait(5)
    end

    TaskPlayAnim(playerPed, 'creatures@rottweiler@tricks@', 'petting_franklin', 8.0, 8.0, -1, 17, 0, false, false, false)
    FreezeEntityPosition(playerPed, true)

    Mek91_HR.ProgressBarUsing(Core, math.random(1000, 5000), function(success)
        if success then
            ClearPedTasks(playerPed)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("Mek91-HR:Server:GiveItem", HouseName, TargetName)
        else
            ClearPedTasks(playerPed)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Mek91-HR:Client:RobberyStarter", function(HouseName)
    Mek91_HR.SendPoliceNotify(Mek91_HR.Language["Notifications"]["Police"]["Robbering"].ActiveHouseRoberring)

    local playerPed = PlayerPedId()
    YesOrNoHouseName = HouseName
    Mek91HR_DeletePlaces(HouseName)
    Mek91HR_NpcDeleter(HouseName)
    RobberyProcess = true

    DoScreenFadeOut(1000)

    Mek91HR_RobberyCreater(HouseName)
    TriggerEvent("Mek91-HR:Client:Door", HouseName, "Login")
    Citizen.Wait(1000)

    DoScreenFadeIn(1000)
---------------------------------------------------------------------------------------------------------------------------
    Citizen.CreateThread(function()
        local Duration = 0
        
        for key, Field in pairs(Mek91_HR.Fields) do
            if Field.HouseName == HouseName then
                Duration = Field.RobberyDuration * 60000
                break
            end
        end

        while RobberyProcess do
            Citizen.Wait(1000)

            Duration = Duration - 1000

            if Duration == 0 then
                TriggerServerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "Duration", "Logout", nil)

                break
            end

            if Duration == 180000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Minute .. " 3", "CL", Core)
            elseif Duration == 120000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Minute .. " 2", "CL", Core)
            elseif Duration == 60000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Minute .. " 1", "CL", Core)
            elseif Duration == 30000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 30", "CL", Core) 
            elseif Duration == 10000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 10", "CL", Core)
            elseif Duration == 5000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 5", "CL", Core)
            elseif Duration == 4000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 4", "CL", Core)
            elseif Duration == 3000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 3", "CL", Core)
            elseif Duration == 2000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 2", "CL", Core)
            elseif Duration == 1000 then
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Duration"].NotifyDuration .. ": " .. Mek91_HR.Language["Notifications"]["Thief"]["Duration"].Second .. " 1", "CL", Core)
            end
        end
    end)
---------------------------------------------------------------------------------------------------------------------------
    Citizen.CreateThread(function()
        local Sleep = 300

        while RobberyProcess do
            Citizen.Wait(Sleep)

            if IsPedShooting(playerPed) then -- the moment of the fight could be webhooked, but I was too lazy.
                Mek91HR_NpcAtack(HouseName, GetPlayerServerId(PlayerId()))
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Npc"].YouWokeThem, "CL", Core)

                Mek91HR_PlayerSpeedHide()
                break
            end

            local Speed = GetEntitySpeed(playerPed) * 3.6
            local SoundLevel = Mek91_HR.Language["Ui"]["SoundLevel"]

            if Speed >= 6.1 then -- the moment of the fight could be webhooked, but I was too lazy.
                Mek91HR_NpcAtack(HouseName, GetPlayerServerId(PlayerId()))
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Npc"].YouWokeThem, "CL", Core)
                
                Mek91HR_PlayerSpeedHide()
                break
            elseif Speed >= 5.6 then
                Mek91HR_PlayerSpeed(SoundLevel.SoHigh, 253, 48, 48)
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Npc"].KeepQuiet, "CL", Core)

                Sleep = 1000
            elseif Speed >= 4.0 then
                Mek91HR_PlayerSpeed(SoundLevel.High, 255, 165, 0)

                Sleep = 300
            elseif Speed >= 3.0 then
                Mek91HR_PlayerSpeed(SoundLevel.Normal, 0, 200, 0)

                Sleep = 300
            elseif Speed >= 0.5 then
                Mek91HR_PlayerSpeed(SoundLevel.Good, 102, 178, 255)

                Sleep = 300
            elseif Speed == 0 then
                Mek91HR_PlayerSpeedHide()

                Sleep = 300
            end
        end
    end)

    Citizen.CreateThread(function()
        while RobberyProcess do
            Citizen.Wait(1000)
            local PlayerStatus = Mek91_HR.GetPlayerStatus(Core)

            if PlayerStatus.Hunger <= 1 or PlayerStatus.Thirst <= 1 then
                TriggerServerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "Starved", "Logout", nil)
                TriggerServerEvent("Mek91-HR:Server:SendWebhook", nil, HouseName, {Reason = "Dead", DeadType = "Starved"})
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Dead"].StarvingToDeath, "CL", Core)
                break
            end

            if PlayerStatus.Dead or PlayerStatus.Fainting then
                TriggerServerEvent("Mek91-HR:Server:RobberyCompleted", HouseName, "NpcByDead", "Logout", nil)
                TriggerServerEvent("Mek91-HR:Server:SendWebhook", nil, HouseName, {Reason = "Dead", DeadType = "Npc"})
                Mek91_HR.SendNotification(nil, Mek91_HR.Language["Notifications"]["Thief"]["Npc"].KillerNpc, "CL", Core)
                break
            end
        end
    end)
end)
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_RobberyCreater(HouseName)
    Citizen.CreateThread(function()
        for key, Field in pairs(Mek91_HR.Fields) do
            if Field.HouseName == HouseName then
                for key, Place in pairs(Field["Places"]) do
                    local PlaceTarget = Place["Target"]
                    local Location = PlaceTarget["Location"]

                    local Options = {
                        {
                            label = PlaceTarget["PublicOption"].label,
                            icon = PlaceTarget["PublicOption"].icon,
                            event = "Mek91-HR:Server:SelectFunction",
                            type = "server",
                            name = PlaceTarget["PublicOption"].name,
                            house = Field.HouseName,
                        }
                    }
        
                    Mek91_HR.SetTarget(PlaceTarget["PublicOption"].name .. StringPrefix .. Field.HouseName, Location.TargetLocation, Location.TargetMinZ, Location.TargetMaxZ, Options, Location.LeftWidth, Location.RightWidth)
                end

                break
            end
        end
    end)

    Mek91HR_NpcCreater(HouseName)
end

function Mek91HR_DeletePlaces(HouseName) -- PlacesDel
    for key, Field in pairs(Mek91_HR.Fields) do
        if Field.HouseName == HouseName then
            for key, Place in pairs(Field["Places"]) do
                PlaceName = Place["Target"]["PublicOption"].name .. StringPrefix .. Field.HouseName

                Mek91_HR.RemoveTarget(PlaceName)
            end

            break
        end
    end
end

RegisterNetEvent("Mek91-HR:Client:DeletePlace", function(HouseName, TargetName)
    Mek91_HR.RemoveTarget(TargetName .. StringPrefix .. HouseName)
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Mek91-HR:Client:RobberyCompleted", function(HouseName, Door)
    RobberyProcess = false
    Mek91HR_DeletePlaces(HouseName)
    Mek91HR_NpcDeleter(HouseName)
    YesOrNoHouseName = ""

    Mek91HR_AllHideUi()
    Mek91HR_PlayerSpeedHide()

    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(500)
        TriggerEvent("Mek91-HR:Client:Door", HouseName, Door)
        DoScreenFadeIn(1000)
    end)

    Citizen.Wait(1000)
    Mek91HR_AllHideUi()
end)

RegisterNetEvent("Mek91-HR:Client:Surrender", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local forwardVector = GetEntityForwardVector(playerPed)
    local targetCoords = playerCoords + forwardVector * 10.0

    -- TaskGoToCoordAnyMeans(playerPed, targetCoords, 1.0, 0, 0, 786603, 0)

    -- Citizen.Wait(5000)

    RequestAnimDict("random@arrests")
    while not HasAnimDictLoaded("random@arrests") do
        Citizen.Wait(5)
    end

    local run = true
    local time = 30000

    Citizen.CreateThread(function()
        while run do
            Wait(1000)
            TaskPlayAnim(playerPed, "random@arrests", "kneeling_arrest_idle", 8.0, -8.0, 10000, 0, 0, false, false, false)
        end
    end)

    Citizen.CreateThread(function()
        while run do
            Wait(1000)
            time = time - 1000

            if time == 0 then
                run = false
            end
        end
    end)
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Mek91-HR:Client:Door", function(HouseName, DoorType)
    Citizen.CreateThread(function()
        for key, Field in pairs(Mek91_HR.Fields) do
            if Field.HouseName == HouseName then
                local Door = Field["Door"][DoorType]
                local AfterCoord = Door.AfterCoord
                local playerPed = PlayerPedId()

                SetEntityCoords(playerPed, AfterCoord.x, AfterCoord.y, AfterCoord.z, false, false, false, true)
                SetEntityHeading(playerPed, AfterCoord.w)

                TriggerServerEvent("Mek91-HR:Server:SendWebhook", nil, HouseName, {Reason = "Door", DoorType = DoorType})
                break
            end
        end
    end)
end)
---------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mek91-HR:Ui:SelectYesOrNo", function(Mek91HR, cb)
    TriggerServerEvent("Mek91-HR:Server:YesOrNo", YesOrNoHouseName, Mek91HR.Result)
    
    SetNuiFocus(false, false)

    if Mek91HR.Result == "No" then 
        Mek91HR_AllHideUi()
    end

    cb('ok')
end)
-------------------------------------------------
function Mek91HR_PlayerSpeed(SoundLevel, R, G, B)
    SendNUIMessage({
        action = 'Mek91HR_Open',
        data = {
            Open = "PlayerSpeed",
            PlayerSpeedText = Mek91_HR.Language["Ui"]["PlayerSpeed"].Text,
            SoundLevel = SoundLevel,
            R = R, 
            G = G, 
            B = B 
        }
    })
end

function Mek91HR_PlayerSpeedHide()
    SendNUIMessage({
        action = 'Mek91HR_PlayerSpeedHide',
        data = {}
    })
end

RegisterNetEvent("Mek91-HR:Ui:YesOrNo", function()
    Mek91HR_PlayerSpeedHide()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'Mek91HR_Open',
        data = {
            Open = "YesOrNo",
            Surrounded = Mek91_HR.Language["Ui"]["YesOrNo"].Surrounded,
            Yes = Mek91_HR.Language["Ui"]["YesOrNo"].Yes,
            Or = Mek91_HR.Language["Ui"]["YesOrNo"].Or,
            No = Mek91_HR.Language["Ui"]["YesOrNo"].No
        }
    })
end)

function Mek91HR_AllHideUi()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'Mek91HR_AllHide',
        data = {}
    })
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_AddBlip(BlipLocation, BlipId, BlipColorId, BlipName, BlipDisplay, BlipScale)
    local blip = AddBlipForCoord(BlipLocation.x, BlipLocation.y, 0.0)
    SetBlipSprite(blip, BlipId)
    SetBlipColour(blip, BlipColorId)
    SetBlipDisplay(blip, BlipDisplay)
    SetBlipScale(blip, BlipScale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(BlipName))
    EndTextCommandSetBlipName(blip)
end
