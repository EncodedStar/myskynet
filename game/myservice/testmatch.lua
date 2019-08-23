local token = "root@sample:123456"
local user,server,passwd = token:match("([^@]+)@([^:]+):(.+)")

print("user:",user)
print("server:",server)
print("passwd:",passwd)
