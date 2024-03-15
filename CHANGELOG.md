# CHANGELOG

#### Releasing new versions

- create a release branch
- update the changelog below
- update `_VERSION` and copyright-years in `./LICENSE.md` and `./lib/resty/luasocket/init.lua` (in doc-comments
  header, and in module constants)
- create a new rockspec and update the version inside the new rockspec:<br/>
  `cp lua-resty-luasocket-dev-1.rockspec ./rockspecs/lua-resty-luasocket-X.Y.Z-1.rockspec`
- test: run `make test` and `make lint`
- clean and render the docs: run `make docs`
- commit the changes as `release vX.Y.Z`
- push the commit, and create a release PR
- after merging tag the release commit with `vX.Y.Z`
- upload to LuaRocks:<br/>
  `luarocks upload ./rockspecs/lua-resty-luasocket-X.Y.Z-1.rockspec --api-key=ABCDEFGH`
- test the newly created rock:<br/>
  `luarocks install lua-resty-luasocket`

### Version x.x.x, unreleased

- fix: implemented workaround for luasocket [issue #427](https://github.com/lunarmodules/luasocket/issues/427)
  which caused blocking while not reading
  [#6](https://github.com/Tieske/lua-resty-luasocket/pull/6)
- chore: updated some documentation to clarify
  [#3](https://github.com/Tieske/lua-resty-luasocket/pull/3)

### Version 1.1.1, released 24-apr-2023

- fix: set sni when a server-name is provided
  [#5](https://github.com/Tieske/lua-resty-luasocket/pull/5)

### Version 1.1.0, released 15-feb-2023

- added: try and find a default CAfile by checking a number of standard file locations
  (for different distros)
- fix: makefile target docs to be phony

### Version 1.0.1, released 14-feb-2023

- fix: copy paste error in `resty.luasocket.http` module would prevent it from loading

### Version 1.0.0, released 14-feb-2023

- added: `resty.luasocket.http` module that will use the compatibility sockets
- fix: added compatibility function `sock:settimeouts`
- added: LuaSec defaults are now configurable, see `resty.luasocket.get_luasec_defaults` and `resty.luasocket.set_luasec_defaults`.
- fix: support `send_status_req` in the sslhandshake signature which was added to `ngx.lua`
- change: update TLS defaults to exclude deprecated ones; `options = {"all", "no_sslv2", "no_sslv3", "no_tlsv1"}`
- fix: `ngx_lua` allows sending a table of strings, if the value was a number, the compatibility
  shim would not properly cast it to a string.
- fix: allow reuse of sockets. Luasocket doesn't allow reusing the same socket after it was closed.
  This doesn't play nice with resty-http which allows this.

### Origin

- forked from https://github.com/thibaultcha/lua-resty-socket
