local skynet = require "skynet"
local login = require "snax.loginserver"
local crypt = require "skynet.crypt"

local server = {
	host = "127.0.0.1",
	port = 8002,
	multilogin = false,
	name = "login_master",
}

--�ص�������ֻ����client������etoken֮��Żᱻ���ã�token�ǽ���֮���etoken����Ҫ���������֤�û�������
--�Լ���¼�㣬��Ҫ���ص��ǵ�¼���Լ��û���
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
	--���ݸ�server uid �Լ� secret 
	subid = subid + 1
	return subid
end


local CMD = {}
function CMD.register_gate(server, address)
	skynet.error("cmd register_gate")
end
--ʵ��command_handler������Ҫʵ�֣���������lua��Ϣ
function server.command_handler(command, ...)
	local f = assert(CMD[command])
	return f(...)
end
login(server)
