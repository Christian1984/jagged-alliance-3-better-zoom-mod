local CurrentModDef = CurrentModDef
local options = CurrentModDef.options

local logToConsole = true
local logToSnype = false

-- helper functions
local function log(msg)
    if logToConsole then
        print(msg)
    end
    if logToSnype then
        CombatLog("debug", msg)
    end
end

local function UnlockCameraTacToMaxZoom()
    cameraTac.SetForceMaxZoom(false)
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    log("Better Zoom Mod -> Set max zoom to " .. tostring(hr.CameraTacMaxZoom))
end

local function LockCameraTacToMaxZoomAI()
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
    cameraTac.SetForceMaxZoom(true)
    log("Better Zoom Mod -> Set max zoom to " .. tostring(hr.CameraTacMaxZoom))
end

-- handle turns
OnMsg.TurnStart = function(team)
    log("Better Zoom Mod -> TurnStart handler")

    local team = g_Teams[team]
    log("Better Zoom Mod -> Turn STARTED -> team.player_team "..
            tostring(team.player_team))

    if team.player_team == true then
        log(
            "Better Zoom Mod -> Player's turn started, will unlock camera to max zoom")
        UnlockCameraTacToMaxZoom()
    end
end

OnMsg.TurnEnded = function(team)
    log("Better Zoom Mod -> TurnEnded handler")

    local team = g_Teams[team]
    log("Better Zoom Mod -> Turn ENDED: team.player_team " ..
            tostring(team.player_team))

    if team.player_team == true then
        log(
            "Better Zoom Mod -> Player's turn ended, will lock the camera to AI-turn max zoom")
        LockCameraTacToMaxZoomAI()
    end
end

-- handle interrupts
OnMsg.InterruptAttackStart = function()
    log(
        "Better Zoom Mod -> InterruptAttackStart, will lock the camera to AI-turn max zoom")
    LockCameraTacToMaxZoomAI()
end

OnMsg.InterruptAttackEnd = function()
    log("Better Zoom Mod -> InterruptAttackEnd, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

-- handle conflict end etc.
OnMsg.ConflictEnd = function()
    log("Better Zoom Mod -> ConflictEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.CombatEnd = function()
    log("Better Zoom Mod -> CombatEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.ExplorationStart = function()
    log("Better Zoom Mod -> ExplorationStart, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

-- setup
local function ApplyMod()
    -- log("Better Zoom Mod -> ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterZoomModCameraTacMinZoom)
    -- hr.CameraTacMaxZoomOverview = tonumber(options.BetterZoomModCameraTacOverviewZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterZoomModCameraTacZoomStep)

    log("Better Zoom Mod -> Set camera options to:")
    log(options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.GameStarted = function()
    log("Better Zoom Mod -> Received GameStarted")
    ApplySettings()
end
