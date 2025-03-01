--[[

bmt v0.1

Check out the repository for more information: https://github.com/bit-frame/bmt/
The tutorial can be located here: https://devforum.roblox.com/post/

This resouce is under a modified version of the MIT License. Find the full license information here: https://github.com/bit-frame/bmt/blob/main/LICENSE

**You are allowed to:**

- Use, copy, modify, merge, and distribute the software.
- Sublicense it and share it with others under the same terms.

**What you cannot do:**

- You cannot sell the software or its modified versions.
- Always include credit to the original creator (81Frames).
- You cannot claim the software as your own.

]]

local configuration = {}

configuration.version = "v0.1" -- Your bmt module version

configuration.channel = "bmt" -- The MessagingService channel for http requests, default is 'bmt'
configuration.apikey = "bmt-139572938057689023" -- An extra layer of security for incoming requests. Customise this apikey to whatever you want.

configuration.webhook = "" -- For sending discord webhook logs. This will require a proxy server by using cloudflare. Find out more here: https://devforum.roblox.com/t/webhooks-how-to-use-cloudflare-workers-for-sending-discord-messages/3296869
configuration.debuglogs = true -- Send debug logs to the developer console. Enabled by default.

return configuration
