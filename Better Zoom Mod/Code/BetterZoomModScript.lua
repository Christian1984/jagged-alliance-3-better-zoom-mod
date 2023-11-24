local CurrentModDef = CurrentModDef
local options = CurrentModDef.options

local logToConsole = true
local logToSnype = false

-- helper functions
local function log(msg)
    if logToConsole then
        print("BZM -> ", msg)
    end
    if logToSnype then
        CombatLog("debug", "BZM -> " .. msg)
    end
end

local function UnlockCameraTacToMaxZoom()
    cameraTac.SetForceMaxZoom(false)
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    local aiZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
    cameraTac.SetZoom(aiZoom * 10);
    log("Set max zoom to " .. tostring(hr.CameraTacMaxZoom))
end

local function LockCameraTacToMaxZoomAI()
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
    cameraTac.SetZoom(hr.CameraTacMaxZoom * 10);
    cameraTac.SetForceMaxZoom(true)
    log("Set max zoom to " .. tostring(hr.CameraTacMaxZoom))
end

-- handle turns
OnMsg.TurnStart = function(team)
    log("TurnStart handler")

    local team = g_Teams[team]
    log("Turn STARTED -> team.player_team "..
            tostring(team.player_team))

    if team.player_team == true then
        log(
            "Player's turn started, will unlock camera to max zoom")
        UnlockCameraTacToMaxZoom()
    else
        LockCameraTacToMaxZoomAI()
    end
end

OnMsg.TurnEnded = function(team)
    log("TurnEnded handler")

    local team = g_Teams[team]
    log("Turn ENDED: team.player_team " ..
            tostring(team.player_team))

    if team.player_team == true then
        log(
            "Player's turn ended, will lock the camera to AI-turn max zoom")
        LockCameraTacToMaxZoomAI()
    else
        UnlockCameraTacToMaxZoom()
    end
end

-- handle interrupts
OnMsg.InterruptAttackStart = function()
    log("Received InterruptAttackStart")

    local currentTeam = g_Combat and g_Teams[g_Combat.team_playing]
    if currentTeam.player_team == true then
        log(
            "InterruptAttackStart, will lock the camera to AI-turn max zoom")
        LockCameraTacToMaxZoomAI()
    else
        UnlockCameraTacToMaxZoom()
    end
end

OnMsg.InterruptAttackEnd = function()
    log("Received InterruptAttackEnd")

    local currentTeam = g_Combat and g_Teams[g_Combat.team_playing]
    if currentTeam.player_team == true then
        log("InterruptAttackEnd, will unlock camera to max zoom")
        UnlockCameraTacToMaxZoom()
    else
        LockCameraTacToMaxZoomAI()
    end
end

-- handle conflict end etc.
OnMsg.ConflictStart = function()
    log("ConflictEnded, will unlock camera to max zoom")
    LockCameraTacToMaxZoomAI()
end

OnMsg.CombatStart = function()
    log("CombatEnded, will unlock camera to max zoom")
    LockCameraTacToMaxZoomAI()
end

OnMsg.ConflictEnd = function()
    log("ConflictEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.CombatEnd = function()
    log("CombatEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.ExplorationStart = function()
    log("ExplorationStart, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

-- setup
local function ApplyMod()
    -- log("ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterZoomModCameraTacMinZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterZoomModCameraTacZoomStep)

    log("Set camera options to:")
    log(options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.GameStarted = function()
    log("Received GameStarted")
    ApplySettings()
end
