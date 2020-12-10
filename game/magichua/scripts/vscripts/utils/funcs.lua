function LoopOverPlayers( callback )
	for i = 0, DOTA_MAX_TEAM_PLAYERS do
		if PlayerResource:IsValidTeamPlayer(i) then
			local player = PlayerResource:GetPlayer(i)
			callback(player)

			print("------------->Player : ", i)
		end
	end
end

function Timer( delay, callback )
	if callback == nil then
		callback = delay
		delay = 0
	end

	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("timer"), function (  )
		return callback()
	end, delay)
end