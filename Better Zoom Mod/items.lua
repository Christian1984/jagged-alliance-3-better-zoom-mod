return {
PlaceObj('ModItemCode', {
	'name', "BetterZoomModScript",
	'CodeFileName', "Code/BetterZoomModScript.lua",
}),
PlaceObj('ModItemGameRuleDef', {
	id = "1",
	msg_reactions = {
		PlaceObj('MsgReaction', {
			Event = "TurnStart",
			Handler = function (self, team)
				local options = AccountStorage.ModOptions.BetterZoomMod
				
				local team = g_Teams[team]
				-- print("Turn STARTED -> team.player_team", team.player_team)
				
				cameraTac.SetForceMaxZoom(false)
				
				if team.player_team == true then
					-- print("palyer's turn started")
					hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
					print("START OF PLAYER'S TURN: set max zoom to", hr.CameraTacMaxZoom)
				end
			end,
			HandlerCode = function (self, team)
				local options = AccountStorage.ModOptions.BetterZoomMod
				
				local team = g_Teams[team]
				-- print("Turn STARTED -> team.player_team", team.player_team)
				
				cameraTac.SetForceMaxZoom(false)
				
				if team.player_team == true then
					-- print("palyer's turn started")
					hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoom)
					print("START OF PLAYER'S TURN: set max zoom to", hr.CameraTacMaxZoom)
				end
			end,
			param_bindings = false,
		}),
		PlaceObj('MsgReaction', {
			Event = "TurnEnded",
			Handler = function (self, teamEnded)
				local options = AccountStorage.ModOptions.BetterZoomMod
				
				local team = g_Teams[teamEnded]
				-- print("Turn ENDED -> team.player_team", team.player_team)
				
				if team.player_team == true then
					-- print("palyer's turn ended")
					hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
					cameraTac.SetForceMaxZoom(true)
					print("END OF PLAYER'S TURN: set max zoom to", hr.CameraTacMaxZoom)
				end
			end,
			HandlerCode = function (self, teamEnded)
				local options = AccountStorage.ModOptions.BetterZoomMod
				
				local team = g_Teams[teamEnded]
				-- print("Turn ENDED -> team.player_team", team.player_team)
				
				if team.player_team == true then
					-- print("palyer's turn ended")
					hr.CameraTacMaxZoom = tonumber(options.BetterZoomModCameraTacMaxZoomAI)
					cameraTac.SetForceMaxZoom(true)
					print("END OF PLAYER'S TURN: set max zoom to", hr.CameraTacMaxZoom)
				end
			end,
			param_bindings = false,
		}),
	},
}),
PlaceObj('ModItemOptionChoice', {
	'name', "BetterZoomModCameraTacMaxZoom",
	'comment', "Vanilla Default = 130, Mod Default = 300",
	'DisplayName', "Maximum Camera Zoom",
	'Help', "Defines how far the camera may zoom out (Vanilla Default = 130)",
	'DefaultValue', "300",
	'ChoiceList', {
		"130",
		"200",
		"300",
		"400",
		"500",
		"600",
		"700",
		"800",
	},
}),
PlaceObj('ModItemOptionChoice', {
	'name', "BetterZoomModCameraTacMinZoom",
	'comment', "Vanilla Default = 65, Mod Default = 70",
	'DisplayName', "Minimum Camera Zoom",
	'Help', "Defines how far the camera may zoom in (Vanilla Default = 65)",
	'DefaultValue', "70",
	'ChoiceList', {
		"100",
		"90",
		"80",
		"70",
		"65",
		"60",
		"50",
		"40",
		"30",
		"20",
		"10",
	},
}),
PlaceObj('ModItemOptionChoice', {
	'name', "BetterZoomModCameraTacMaxZoomAI",
	'comment', "Vanilla Default = 130, Mod Default = 130",
	'DisplayName', "Maximum Camera Zoom During AI Turns",
	'Help', "Defines the camera's zoom level during enemy turns (Vanilla Default = 130)",
	'DefaultValue', "130",
	'ChoiceList', {
		"130",
		"200",
		"300",
		"400",
		"500",
		"600",
		"700",
		"800",
	},
}),
PlaceObj('ModItemOptionChoice', {
	'name', "BetterZoomModCameraTacZoomStep",
	'comment', "Vanilla Default = 25, Mod Default = 50",
	'DisplayName', "Zoom Step Size",
	'Help', "Defines how fast the camera zoom (Vanilla Default = 25)",
	'DefaultValue', "50",
	'ChoiceList', {
		"10",
		"25",
		"50",
		"75",
		"100",
		"125",
	},
}),
}
