# Force AOP Script for FiveM

## Overview

This script enforces an Area of Play (AOP) on your FiveM server by restricting players from entering zones that are outside the current AOP. 
If a player enters a restricted area, they are automatically teleported back to the correct zone. The AOP can be changed using the command 
by a player with the appropriate license.

## Features

- Restricts players to the designated AOP zone.
- Automatically teleports players back to the allowed area if they stray outside the AOP.
- Allows only specific players (based on their license) to change the AOP via the `/setaop` command.
- Easy configuration of zones with custom coordinates and radii.

## Installation

1. **Download and Extract:**
   - Download the script files and extract them into your `resources` folder in your FiveM server directory.

2. **Add to Server Config:**
   - Add the following line to your `server.cfg` to ensure the script is loaded when your server starts:
     ```
     start aop_restrict
     ```

3. **Configure Zones:**
   - Open `client.lua` and `server.lua` to adjust the coordinates and radii of your AOP zones as needed.

4. **Set Allowed License:**
   - Replace the placeholder license in `server.lua` with the actual license of the player who should have permission to use the `/setaop` command.

## Commands

- `/setaop [ZoneName]`: Changes the current AOP to the specified zone. Only available to players with the specified license.

## Example Configuration

In the `client.lua`, you can define your zones as follows:

```lua
aopZones["Los Santos"] = {center = vector3(0.0, 0.0, 0.0), radius = 3000.0}
aopZones["Sandy Shores"] = {center = vector3(1850.0, 3700.0, 33.0), radius = 1500.0}
aopZones["Paleto Bay"] = {center = vector3(-400.0, 6000.0, 31.0), radius = 1000.0}
