local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

local config = require('../configuration')
local api = require('./api')
local channel = config.channel

print("🤖 This game uses version "..config.version.." of bmt 🤖")

local function onrequest(msg)
	if msg.apikey and msg.apikey == config.apikey then
		if msg.cmd == "kick" then
			local target = game.Players:FindFirstChild(msg.plr)
			if target then
				target:Kick("bmt: "..msg.reason)
				print("[bmt] Kicked '"..msg.plr.."': "..msg.reason)
			else
				warn("[bmt] Failed to kick: Target '"..msg.plr.."' not found")
			end
		elseif msg.cmd == "shutdown" then
			api.shutdown(msg.reason)
			print("[bmt] Server shutdown initiated for: "..msg.reason)
		end
	else
		warn("[bmt] Blocked request: Invalid api key")
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	print("[bmt] "..plr.Name.." joined")

	local subscribeSuccess, subscribeConnection = pcall(function()
		return MessagingService:SubscribeAsync(channel, function(message)
			if config.debuglogs then
				print("[bmt-debug] New request: "..message.Data)
			end
			local success, decodedMessage = pcall(function()
				return HttpService:JSONDecode(message.Data)
			end)
			if success and decodedMessage then
				onrequest(decodedMessage)
			else
				warn("[bmt] Failed to decode message data: Invalid message data")
			end
		end)
	end)

	if subscribeSuccess then
		plr.AncestryChanged:Connect(function()
			subscribeConnection:Disconnect()
		end)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	print("[bmt] "..plr.Name.." left")
end)
