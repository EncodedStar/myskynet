package.cpath = "../luaclib/?.so"
package.path = "../lualib/?.lua"

if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

-- �°汾
local socket = require "client.socket"

local fd = assert(socket.connect("127.0.0.1", 8888))

-- ����һ����Ϣ��������, ��ϢЭ����Զ���(�ٷ��Ƽ�sprotoЭ��,��Ȼ��Ҳ����ʹ������Ϥ��json)
socket.send(fd, "Hello world")
