-- 每个服务独立, 都需要引入skynet
local skynet = require "skynet"
---- 新版本
--local socket = require "skynet.socket"
---- 读取客户端数据, 并输出
--local function echo(id)
---- 每当 accept 函数获得一个新的 socket id 后，并不会立即收到这个 socket 上的数据。这是因为，我们有时会希望把这个 socket 的操作权转让给别的服务去处理。
---- 任何一个服务只有在调用 socket.start(id) 之后，才可以收到这个 socket 上的数据。
--	socket.start(id)
--
--	while true do
--	-- 读取客户端发过来的数据
--		local str = socket.read(id)
--		if str then
--			-- 直接打印接收到的数据
--			print(str)
--		else
--			socket.close(id)
--			return
--		end
--	end
--end

skynet.start(function()
		print("==========Socket1 Start=========")
end)
