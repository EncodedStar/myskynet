-- ÿ���������, ����Ҫ����skynet
local skynet = require "skynet"
---- �°汾
--local socket = require "skynet.socket"
---- ��ȡ�ͻ�������, �����
--local function echo(id)
---- ÿ�� accept �������һ���µ� socket id �󣬲����������յ���� socket �ϵ����ݡ�������Ϊ��������ʱ��ϣ������� socket �Ĳ���Ȩת�ø���ķ���ȥ����
---- �κ�һ������ֻ���ڵ��� socket.start(id) ֮�󣬲ſ����յ���� socket �ϵ����ݡ�
--	socket.start(id)
--
--	while true do
--	-- ��ȡ�ͻ��˷�����������
--		local str = socket.read(id)
--		if str then
--			-- ֱ�Ӵ�ӡ���յ�������
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
