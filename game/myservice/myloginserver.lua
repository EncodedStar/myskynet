local skynet = require "skynet"
local login = require "snax.loginserver"
local crypt = require "skynet.crypt"

local server = {
	host = "127.0.0.1",
	port = 8002,
	multilogin = false,
	name = "login_master",
}

--回调函数，只有在client发送完etoken之后才会被调用，token是解密之后的etoken，需要这个方法验证用户名密码
--以及登录点，需要返回的是登录点以及用户名
--token = base64 user @ base64 server : base64 passer
function server.auth_handler(token)
	local user, server, passwd = token:match("([^@]+)@([^:]+):(.+)")
	user = crypt.base64decode(user)
	server = crypt.base64decode(server)
	passwd = crypt.base64decode(passwd)
	skynet.error("user:",user,"server:",server,"passwd:",passwd)
	skynet.error(string.format("%s@%s:%s", user, server, passwd))
	assert(passwd == "password","Invalid password")
	return server, user
end

local subid = 0
function server.login_handler(server, uid, secret)
	skynet.error("login_handler secret:", crypt.hexencode(secret))
	--传递给server uid 以及 secret 
	subid = subid + 1
	return subid
end


local CMD = {}
function CMD.register_gate(server, address)
	skynet.error("cmd register_gate")
end
--实现command_handler，必须要实现，用来处理lua消息
function server.command_handler(command, ...)
	local f = assert(CMD[command])
	return f(...)
end
login(server)
