local CurrentModDef = CurrentModDef
local options = CurrentModDef.options

-- helper functions
local function UnlockCameraTacToMaxZoom()
    cameraTac.SetForceMaxZoom(false)
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    print("Better Zoom Mod -> Set max zoom to", hr.CameraTacMaxZoom)
end

local function LockCameraTacToMaxZoomAI()
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
    cameraTac.SetForceMaxZoom(true)
    print("Better Zoom Mod -> Set max zoom to",
            hr.CameraTacMaxZoom)
end

-- handle turns
OnMsg.TurnStart = function(team)
    print("Better Zoom Mod -> TurnStart handler")

    local team = g_Teams[team]
    print("Better Zoom Mod -> Turn STARTED -> team.player_team",
          team.player_team)

    if team.player_team == true then
        print(
            "Better Zoom Mod -> Player's turn started, will unlock camera to max zoom")
        UnlockCameraTacToMaxZoom()
    end
end

OnMsg.TurnEnded = function(team)
    print("Better Zoom Mod -> TurnEnded handler")

    local team = g_Teams[team]
    print("Better Zoom Mod -> Turn ENDED: team.player_team", team.player_team)

    if team.player_team == true then
        print(
            "Better Zoom Mod -> Player's turn ended, will lock the camera to AI-turn max zoom")
        LockCameraTacToMaxZoomAI()
    end
end

-- handle interrupts
OnMsg.InterruptAttackStart= function()
    print("Better Zoom Mod -> InterruptAttackStart, will lock the camera to AI-turn max zoom")
    LockCameraTacToMaxZoomAI()
end

OnMsg.InterruptAttackEnd= function()
    print("Better Zoom Mod -> InterruptAttackEnd, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

-- handle conflict end etc.
OnMsg.ConflictEnd = function()
    print("Better Zoom Mod -> ConflictEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.CombatEnd = function()
    print("Better Zoom Mod -> CombatEnded, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

OnMsg.ExplorationStart = function()
    print("Better Zoom Mod -> ExplorationStart, will unlock camera to max zoom")
    UnlockCameraTacToMaxZoom()
end

--setup
local function ApplyMod()
    -- print("Better Zoom Mod -> ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterZoomModCameraTacMinZoom)
    -- hr.CameraTacMaxZoomOverview = tonumber(options.BetterZoomModCameraTacOverviewZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterZoomModCameraTacZoomStep)

    print("Better Zoom Mod -> Set camera options to: ", options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.GameStarted = function()
    print("Better Zoom Mod -> Received GameStarted")
    ApplySettings()
end
