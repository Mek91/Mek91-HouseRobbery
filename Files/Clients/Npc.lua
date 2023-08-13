local LastCreateNpc = {}
local SelectedNpc = {}
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_NpcCreater(HouseName)
    AddRelationshipGroup("MEK91-HR_" .. HouseName)
    
    for key, Field in pairs(Mek91_HR.Fields) do
        if Field.HouseName == HouseName then
            Mek91HR_TableCreater(HouseName)

            for key, Npc in pairs(Field["Npc"]["Location"]) do
                local NpcModel = GetHashKey(Mek91_LastCreateNpcCheck(HouseName))
                RequestModel(NpcModel)
        
                while not HasModelLoaded(NpcModel) do
                    Wait(1)
                end  

                local NpcCreateAndSave = CreatePed(4, NpcModel, Npc.x, Npc.y, Npc.z, Npc.w, false, true)

                GiveWeaponToPed(NpcCreateAndSave, GetHashKey(Mek91_HR.Npc["Weapons"][math.random(1, #Mek91_HR.Npc["Weapons"])]), 1000, false, true)
                SetPedAccuracy(NpcCreateAndSave, 100)
                TaskStartScenarioInPlace(NpcCreateAndSave, "WORLD_HUMAN_BUM_SLUMPED", 0, true)
                SetPedRelationshipGroupHash(NpcCreateAndSave, GetHashKey("MEK91-HR_" .. HouseName))

                for key, SelectHouse in pairs(SelectedNpc) do
                    if SelectHouse.House == HouseName then
                        table.insert(SelectedNpc[key]["Npc"], NpcCreateAndSave)

                        break
                    end
                end
            end

            for key, SelectHouse in pairs(SelectedNpc) do
                if SelectHouse.House == HouseName then
                    TriggerServerEvent("Mek91-HR:Server:NpcSave", HouseName, SelectedNpc[key]["Npc"])

                    break
                end
            end

            break
        end
    end
end

function Mek91_LastCreateNpcCheck(HouseName)
    local Npc = ""
    local NpcSearchFound = false
    
    for key, NpcA in pairs(LastCreateNpc) do
        if NpcA.House == HouseName then
            while not NpcSearchFound do
                Citizen.Wait(0)
                local randomNpc = Mek91_HR.Npc["NpcList"][math.random(1, #Mek91_HR.Npc["NpcList"])]
        
                local found = false
                for i = 1, #LastCreateNpc do
                    if LastCreateNpc[i] == randomNpc then
                        found = true
                        break
                    end
                end
        
                if not found then
                    Npc = randomNpc
                    NpcSearchFound = true
                    table.insert(LastCreateNpc[key].Npc, Npc)
                end
            end

            break
        end
    end

    return Npc
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_NpcDeleter(HouseName)
    local SelectHouseKey

    for key, SelectHouse in pairs(SelectedNpc) do
        if SelectHouse.House == HouseName then
            for key, Npc in pairs(SelectHouse["Npc"]) do
                DeletePed(Npc)
            end

            table.remove(SelectedNpc, key)
            break
        end
    end
    ---------------------------------------------------------------------------------------------------------------------------
    for key, LastCreate in pairs(LastCreateNpc) do
        if LastCreate.House == HouseName then
            table.remove(LastCreateNpc, key)

            break
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_NpcAtack(HouseName, TargetId)
    local TargetPed = GetPlayerPed(GetPlayerFromServerId(TargetId))

    for key, SelectHouse in pairs(SelectedNpc) do
        if SelectHouse.House == HouseName then
            local NpcList = SelectHouse["Npc"]

            for key, Npc in pairs(NpcList) do
                ClearPedTasks(Npc)
                TaskCombatPed(Npc, TargetPed, 0, 16)
            end

            break
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------
function Mek91HR_TableCreater(HouseName)
    local FoundTableSelectedNpc = true
    local FoundTableLastCreateNpc = true
    ---------------------------------------------------------------------------------------------------------------------------
    for key, SelectHouse in pairs(SelectedNpc) do
        if SelectHouse.House == HouseName then
            FoundTableSelectedNpc = false

            break
        end
    end

    if FoundTableSelectedNpc then
        local HouseTable = {
            House = HouseName,
            Npc = {}
        }

        table.insert(SelectedNpc, HouseTable)
    end
    ---------------------------------------------------------------------------------------------------------------------------
    for key, SelectHouse in pairs(LastCreateNpc) do
        if SelectHouse.House == HouseName then
            FoundTableLastCreateNpc = false

            break
        end
    end

    if FoundTableLastCreateNpc then
        local HouseTable = {
            House = HouseName,
            Npc = {}
        }

        table.insert(LastCreateNpc, HouseTable)
    end
end
---------------------------------------------------------------------------------------------------------------------------