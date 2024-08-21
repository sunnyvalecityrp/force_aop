local AOP = "Sandy"  -- Default AOP

local aopZones = {
    ["City"] = {center = vector3(162.24, -989.38, 30.09), radius = 3000.0}, -- Replace with actual coordinates
    ["Sandy"] = {center = vector3(1850.0, 3700.0, 33.0), radius = 1500.0},
    ["Paleto"] = {center = vector3(147.85, 6601.57, 31.85), radius = 1000.0}
}

local allowedLicense = "license:9d0f55e91d5c38d55c2348678a6ddbc18e071681" -- Replace with the correct license

-- Function to change AOP
function SetAOP(newAOP)
    AOP = newAOP
    TriggerClientEvent('chat:addMessage', -1, { args = { '^1AOP has been changed to ' .. AOP } })
    TriggerClientEvent('aop:update', -1, AOP)  -- Notify all clients of the AOP change
end

-- Check player's license and allow /setaop command
RegisterCommand('setaop', function(source, args, rawCommand)
    local playerLicense = nil

    -- Get player's license from identifiers
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(id, "license:") then
            playerLicense = id
            break
        end
    end

    -- Check if the player has the correct license
    if playerLicense == allowedLicense then
        local newAOP = args[1]
        if aopZones[newAOP] then
            SetAOP(newAOP)
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^1Invalid AOP zone.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1You do not have permission to use this command.' } })
    end
end, false)

-- Provide AOP information to newly connected clients
AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    local playerId = source
    TriggerClientEvent('aop:update', playerId, AOP)
end)
