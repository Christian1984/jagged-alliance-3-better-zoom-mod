local CurrentModDef = CurrentModDef

local options = CurrentModDef.options

local function ApplyMod()
    -- print("Better Zoom Mod -> ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterZoomModCameraTacMinZoom)
    -- hr.CameraTacMaxZoomOverview = tonumber(options.BetterZoomModCameraTacOverviewZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterZoomModCameraTacZoomStep)

    hr.AaaTest = "TEST"

    print("Better Zoom Mod -> Set camera options to: ", options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.TurnStart = function(team)
    -- print("Better Zoom Mod -> TurnStart handler")

    local team = g_Teams[team]
    -- print("Turn STARTED -> team.player_team", team.player_team)

    cameraTac.SetForceMaxZoom(false)

    if team.player_team == true then
        -- print("palyer's turn started")
        hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
        print("Better Zoom Mod -> START OF PLAYER'S TURN: set max zoom to",
              hr.CameraTacMaxZoom)
    end
end

OnMsg.TurnEnded = function(team)
    -- print("Better Zoom Mod -> TurnEnded handler")

    local team = g_Teams[team]
    -- print("Turn ENDED -> team.player_team", team.player_team)

    if team.player_team == true then
        -- print("palyer's turn ended")
        hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
        cameraTac.SetForceMaxZoom(true)
        print("Better Zoom Mod -> END OF PLAYER'S TURN: set max zoom to",
              hr.CameraTacMaxZoom)
    end
end

OnMsg.GameStarted = function()
    print("Better Zoom Mod -> Received GameStarted")
    ApplySettings()
end
