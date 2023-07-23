local CurrentModDef = CurrentModDef

local options = CurrentModDef.options

local function ApplyMod()
    print("Better Zoom Mod: ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterZoomModCameraTacMinZoom)
    -- hr.CameraTacMaxZoomOverview = tonumber(options.BetterZoomModCameraTacOverviewZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterZoomModCameraTacZoomStep)

    print("Set camera options to: ", options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.GameStarted = function()
    print("Better Zoom Mod: received GameStarted")
    ApplySettings()
end