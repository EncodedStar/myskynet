local skynet = require "skynet"

skynet.start(function()
	skynet.error("start---main")
	if not skynet.getenv "daemon" then
		local console = skynet.newservice("console")
	end
	skynet.exit()
end)
