-- ÿ���������, ����Ҫ����skynet
local skynet = require "skynet"
require "skynet.manager"    -- ���� skynet.register
local db = {}

local command = {}

function command.get(key)
	print("comman.get:"..key)   
	return db[key]
end

function command.set(key, value)
	print("comman.set:key="..key..",value:"..value) 
	db[key] = value
	local last = db[key]
	return last
end

skynet.start(function()
	print("==========Service2 Start=========")
	skynet.dispatch("lua", function(session, address, cmd, ...)
	print("==========Service2 dispatch============"..cmd)
	print(address)
	print(seession)
	local f = command[cmd]      
		if f then
			-- ��Ӧһ����Ϣ����ʹ�� skynet.ret(message, size) ��
			-- ���Ὣ message size ��Ӧ����Ϣ���ϵ�ǰ��Ϣ�� session ���Լ� skynet.PTYPE_RESPONSE �����𣬷��͸���ǰ��Ϣ����Դ source 
			skynet.ret(skynet.pack(f(...))) --��Ӧ��Ϣ
		else
			error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)
	--����Ϊ�Լ�ע��һ�������������������� 32 ���ַ����ڣ�
	skynet.register "SERVICE2"
end)

