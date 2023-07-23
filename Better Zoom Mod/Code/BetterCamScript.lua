local CurrentModDef = CurrentModDef

local options = CurrentModDef.options

local function ApplyMod()
    print("Better Cam Mod: ApplyMod() called")

    options = CurrentModDef.options
    hr.CameraTacMaxZoom = tonumber(options.BetterCamMaxZoom)
    hr.CameraTacMinZoom = tonumber(options.BetterCamMinZoom)
    -- hr.CameraTacMaxZoomOverview = tonumber(options.BetterCamOverviewZoom)
    hr.CameraTacZoomStep = tonumber(options.BetterCamZoomStepSize)

    print("Set camera options to: ", options)
end

OnMsg.ApplyModOptions = ApplyMod
OnMsg.ModsReloaded = ApplyMod

OnMsg.GameStarted = function()
    print("Better Cam Mod: received GameStarted")
    ApplySettings()
end