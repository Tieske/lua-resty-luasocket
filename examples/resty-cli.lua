-- The `resty` command line tool doesn't have the CA certs set up.
-- Since the CLI runs in the `timer` phase, it will not be able to
-- connect to HTTPS servers.
-- By forcing the `timer` phase to use luasocket, we can make it
-- work out of the box.
--
-- NOTE: outside of the CLI or init phases, this is a bad idea!

local http = require 'resty.luasocket.http'
local httpc = http.new()


local res, err = httpc:request_uri('https://www.google.com/', {
  ssl_verify = true,
  ssl_server_name = 'www.google.com',
})
print("try 1: ",tostring(res), " ", tostring(err))


-- force the use of the luasocket+luasec implementation and try again
require('resty.luasocket').force_luasocket("timer", true)


local httpc = http.new()
local res, err = httpc:request_uri('https://www.google.com/', {
  ssl_verify = true,
  ssl_server_name = 'www.google.com',
})
print("try 2: ",res.status, " ", tostring(err))
