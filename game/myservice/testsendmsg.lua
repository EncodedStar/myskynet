skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
	skynet.register(".testsendmsg")
	local testluamsg = skynet.localname(".testluamsg")
	--����lua���͵���Ϣ��testluamsg�����ͳɹ����������أ�r��ֵΪ0
	local r = skynet.send(testluamsg, "lua", 1, "nengzhong", true) --������C�ڴ棨msg��sz���Ѿ����뷢�ͣ����Բ����Լ����ͷ��ڴ��ˡ�
	skynet.error("skynet.send return value:", r)
	--ͨ��skynet.pack���������
	r = skynet.rawsend(testluamsg, "lua", skynet.pack(2, "nengzhong", false)) --������C�ڴ棨msg��sz���Ѿ����ڷ��ͣ����Բ����Լ����ͷ��ڴ��ˡ�
	skynet.error("skynet.rawsend return value:", r)
end)
