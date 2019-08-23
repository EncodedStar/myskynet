local skynet = require "skynet"

local key,value = ...

function task()
	local r = skynet.send(".mydb","lua","set",key,value)
	skynet.error("testsend:",r)
	
	local r = skynet.call(".mydb","lua","get",key)
	skynet.error("testget:",r)

	skynet.exit()
end

skynet.start(function()
	skynet.fork(task)
end)
