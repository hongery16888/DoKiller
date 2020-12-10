
MULLIGAN_TIME_LIMIT = 60 --调度时间

ROUND_STATE_MULLIGAN = 1
ROUND_STATE_PLAYING = 2
ROUND_STATE_FIGHTING = 3


RoundManager = class({})

function RoundManager:constructor()
	
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(RoundManager, "OnGameRulesStateChanged"), self) --注册事件监听器，监听事件改变

end

function RoundManager:OnGameRulesStateChanged()
	--当阶段以身试法的时候

	print("------------->StateChange CurrentState = ", GameRules:State_Get())

	--如果当前的游戏阶段是pre game 的话
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then

		print("------------->Pre Ga State")

		--定义一个倒数计时器
		Timer(function(  )
			self:OnTimer()
			return 1
		end)

		LoopOverPlayers(function ( player )

			print("------------->DrawCards")

			--抽INITIAL_CARDS_COUNT 张牌
			player:DrawCards(INITIAL_CARDS_COUNT)

			--进入调度阶段
			self:StartMulligan()
		end)

	end
end

function RoundManager:OnTimer(  )

	print("------------->Timer Lick...CurrentState : ", self.nCurrentState, "    CountDownTimer : ", self.nCountDownTimer)

	-- 调度阶段
	if self.nCountDownTimer then
		self.nCountDownTimer = self.nCountDownTimer - 1
	end

	if self.nCurrentState == ROUND_STATE_MULLIGAN and self.nCountDownTimer <= 0 then
		self:StartPlaying() --强行停止调度阶段

		print("------------->StartPlaying")
	end

	--显示计时器
	if self.nCountDownTimer then
		CustomGameEventManager:Send_ServerToAllClients("timer", {value = self.nCountDownTimer})  --在UI上显示计时器
	end

	--在所有方中循环
	LoopOverPlayers(function( player )
		if not table.contains(GameRules.vAllPlayers, player) then
			table.insert(GameRules.vAllPlayers, player)
		end
	end)
end

function RoundManager:StartMulligan(  )

	print("------------->Player Start Mulligan")

	self.nCountDownTimer = MULLIGAN_TIME_LIMIT --设置调度时间限制
	LoopOverPlayers(function( player )

		--执行调度操作
		player:DoMulligan()
	end)

	self.nCurrentState = ROUND_STATE_MULLIGAN
end

function RoundManager:StartPlaying(  )
	print("------------->Ga State Now Entering Playing State")
	--从多方中随机作为先手
	self.vActivatePlayer = table.random(GameRules.vAllPlayers)
	self.nCurrentState = ROUND_STATE_PLAYING
end

GameRules.RoundManager = RoundManager()