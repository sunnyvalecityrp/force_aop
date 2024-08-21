local AOP = "Sandy Shores"  -- Default AOP
local aopZones = {}

-- Update AOP and zones from the server
RegisterNetEvent('aop:update')
AddEventHandler('aop:update', function(newAOP)
    AOP = newAOP
    TriggerEvent('chat:addMessage', { args = { '^2AOP is now ' .. AOP } })
end)

-- Function to check if a player is in a zone
function IsPlayerInZone(playerCoords, zoneCenter, zoneRadius)
    return #(playerCoords - zoneCenter) <= zoneRadius
end

-- Teleport the player to the correct AOP zone
function TeleportPlayerToAOP()
    local aopZone = aopZones[AOP]
    if aopZone then
        SetEntityCoords(PlayerPedId(), aopZone.center.x, aopZone.center.y, aopZone.center.z, false, false, false, true)
    end
end

-- Monitor player positions
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every second

        local aopZone = aopZones[AOP]
        if aopZone then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            -- If player is not in the current AOP zone, teleport them back
            if not IsPlayerInZone(playerCoords, aopZone.center, aopZone.radius) then
                TeleportPlayerToAOP()
                TriggerEvent('chat:addMessage', { args = { '^1You are outside the AOP and have been teleported back.' } })
            end
        end
    end
end)

-- Initial setup: define the zones (should match server configuration)
Citizen.CreateThread(function()
    aopZones["City"] = {center = vector3(162.24, -989.38, 30.09), radius = 3000.0} -- Replace with actual coordinates
    aopZones["Sandy"] = {center = vector3(1850.0, 3700.0, 33.0), radius = 1500.0}
    aopZones["Paleto"] = {center = vector3(147.85, 6601.57, 31.85), radius = 1000.0}
end)
