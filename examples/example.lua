-- All of the available functions follow the same prototype as the cosocket API,
-- allowing this example to run in any ngx_lua context or outside ngx_lua
-- altogether:

local socket = require 'resty.luasocket'
local sock = socket.tcp()

sock:settimeout(1000)     ---> 1000ms translated to 1s if LuaSocket
sock:getreusedtimes(...)  ---> 0 if LuaSocket
sock:setkeepalive(...)    ---> calls close() if LuaSocket
sock:sslhandshake(...)    ---> LuaSec dependency if LuaSocket


-- As such, one can write a module relying on TCP sockets such as:
local socket = require 'resty.socket'

local _M = {}

function _M.new()
  local sock = socket.tcp() -- similar to ngx.socket.tcp()

  return setmetatable({
    sock = sock
  }, {__index = _M})
end

function _M:connect(host, port)
  local ok, err = self.sock:connect(host, port)
  if not ok then
    return nil, err
  end

  local times, err = self.sock:getreusedtimes() -- cosocket API
  if not times then
    return nil, err
  elseif times == 0 then
    -- handle connection
    ngx.log(ngx.DEBUG, "start using the connection")
  end
end

return _M
