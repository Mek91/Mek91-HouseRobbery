function Mek91HR_PlayerInfo(PlayerId)
    local Identifiers = {}

    for i = 0, GetNumPlayerIdentifiers(PlayerId) - 1 do
        local id = GetPlayerIdentifier(PlayerId, i)

        if string.find(id, "steam") then
            Identifiers['steam'] = id
        elseif string.find(id, "discord") then
            Identifiers['discord'] = id
        elseif string.find(id, "license") then
            Identifiers['license'] = id
        elseif string.find(id, "xbl") then
            Identifiers['xbl'] = id
        elseif string.find(id, "live") then
            Identifiers['live'] = id
        end
    end

    local playerName = GetPlayerName(PlayerId)
    if playerName ~= nil then
        Identifiers['name'] = playerName
    end

    local ip = GetPlayerEndpoint(PlayerId)
    if ip ~= nil then
        Identifiers['ip'] = ip
    end

    return Identifiers
end