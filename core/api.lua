--[[

bmt: api (v1)

Available APIs:
- v1.pban()
- v1.ban()
- v1.unban()
- v1.kick()
- v1.reset()
- v1.shutdown()
- v1.freeze()
- v1.unfreeze()

]]

local v1 = {}

local config = require('../configuration')

-- Debugging API
function v1.version()
	return 'bmt Module Version: '..config.version
end

-- Main API
function v1.pban(Player: Player, reason: string, excludeAltAccounts: boolean, applyToUniverse: boolean, modreason: string)
	game.Players:BanAsync({
		UserIds = {Player.UserId},
		ApplyToUniverse = applyToUniverse,
		Duration = -1,
		DisplayReason = reason,
		PrivateReason = modreason,
		ExcludeAltAccounts = excludeAltAccounts,
	})
end
-- Usage: v1.pban("playerToBan", "banReason", excludeAlts, applyToUniverse, "modreason")

function v1.ban(Player: Player, reason: string, excludeAltAccounts: boolean, applyToUniverse: boolean, banDuration: number, modreason: string)
	local banDurationSeconds = banDuration * 86400 -- In days
	game.Players:BanAsync({
		UserIds = {Player.UserId},
		ApplyToUniverse = applyToUniverse,
		Duration = banDurationSeconds,
		DisplayReason = reason,
		PrivateReason = modreason,
		ExcludeAltAccounts = excludeAltAccounts,
	})
end
-- Usage: v1.ban("playerToBan", "banReason", excludeAlts, applyToUniverse, banDurationindays, "modreason")

function v1.unban(username, applyToUniverse)
	local success, userId = pcall(function()
		return game.Players:GetUserIdFromNameAsync(username)
	end)
	if success then
		game.Players:UnbanAsync({
			UserIds = {userId},
			ApplyToUniverse = applyToUniverse,
		})
	end
end
-- Usage: v1.unban("playerToUnban", applyToUniverse)

function v1.kick(player, reason)
	local target = game.Players:FindFirstChild(player.Name)
	if target then
		target:Kick("bmt: "..reason)
	end
end
-- Usage: v1.kick("player", "reason")

function v1.reset(plr)
	local target = game.Players:FindFirstChild(plr.Name)
	if target then
		local char = plr.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Health = 0
			end
		end
	end
end
-- Usage: v1.reset("player")

function v1.shutdown(reason)
	for _, player in ipairs(game.Players:GetPlayers()) do
		player:kick("bmt: Server shutdown due to: "..reason)
	end
end
-- Usage: v1.shutdown("reason")

function v1.freeze(plr)
	local target = game.Players:FindFirstChild(plr.Name)
	if target then
		local char = plr.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = 0
			end
		end
	end
end
-- Usage: v1.freeze("plr")

function v1.unfreeze(plr)
	local target = game.Players:FindFirstChild(plr.Name)
	if target then
		local char = plr.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = 16
			end
		end
	end
end
-- Usage: v1.unfreeze("plr")

return v1
