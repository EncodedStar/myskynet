local skynet = require "skynet"
require "skynet.manager"

local db = {}

local command = {}

function command.SET(key, value)
	db[key] = value
end

function command.GET(key)
	return db[key]
end

skynet.start(function()
	skynet.error("mydb")
	skynet.dispatch("lua",function(session, address, cmd, ...)
		cmd = cmd:upper()
		local f = command[cmd]
		if f then
			skynet.retpack(f(...))
		else
			skynet.error("error: unknow cmd")
		end
	end)
	skynet.register(".mydb")
end)
