package.cpath = "luaclib/?.so"
local socket = require "client.socket"
local crypt = require "client.crypt"

local fd = socket.connect("127.0.0.1", 8002)
assert(fd)

local function writeline(fd, text)
	socket.send(fd, text .. "\n")
end

local function unpack_line(text)
local from = text:find("\n", 1, true)
	if from then
		return text:sub(1, from-1), text:sub(from+1)
	end
	return nil, text
end

local last = ""
local function unpack_f(f)
	local function try_recv(fd, last)
		local result
		result, last = f(last)
		if result then
			return result, last
		end
		local r = socket.recv(fd)
		if not r then
			return nil, last
		end
		if r == "" then
			error "Server closed"
		end
		return f(last .. r)
	end
	return function()
		while true do
			local result
			result, last = try_recv(fd, last)
			if result then
				return result
			end
			socket.usleep(100)
		end
	end
end

local readline = unpack_f(unpack_line)

--读取challenge
local challenge = readline()
print ("chanllenge:", crypt.hexencode(challenge))
challenge = crypt.base64decode(challenge)
print ("chanllenge:", crypt.hexencode(challenge))

--发送cKey
local clientKey = crypt.randomkey()
local cKey = crypt.dhexchange(clientKey)
cKey = crypt.base64encode(cKey)
writeline(fd, cKey)

--接受sKey
local sKey = readline()
sKey = crypt.base64decode(sKey)
print("sKey:", crypt.hexencode(sKey))

--得到秘钥secret
local secret = crypt.dhsecret(sKey, clientKey)
print("secret:", crypt.hexencode(secret))

--验证secret是否正确
local CHmac = crypt.hmac64(challenge, secret)
CHmac = crypt.base64encode(CHmac)
writeline(fd, CHmac)

--发送etoken
local token = {
	user = "hello",
	server = "sample",
	passwd = "password",
}

local user = crypt.base64encode(token.user)
local server = crypt.base64encode(token.server)
local passwd = crypt.base64encode(token.passwd)

local tokenStr = user .. "@" .. server .. ":" .. passwd
local etoken = crypt.desencode(secret, tokenStr)
etoken = crypt.base64encode(etoken)
writeline(fd, etoken)

--接受最后一行
local response = readline()

print("response:", response:sub(1, 3))
local code  = response:sub(1, 3)
assert(code == "200")

local subid = response:sub(5)
subid = crypt.base64decode(subid)
print("subid:",subid)
socket.close(fd)







