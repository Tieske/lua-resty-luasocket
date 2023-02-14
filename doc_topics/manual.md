# Manual

cosocket/LuaSocket automatic compatibility module for lua-resty modules wanting
to be compatible with plain Lua or OpenResty's `init` context.

The use case for this library is: you are developing a lua-resty module relying
on cosockets, but you want it to also be usable in OpenResty's `init` context
or even in plain Lua. This module aims at always providing your library with
sockets that will be compatible in the current context, saving you time and
effort, and extending LuaSocket's API to match that of cosockets, allowing you
to always write your code as if you were in a cosocket-compatible OpenResty
context.


## Features

* Allows your lua-resty modules to automatically use cosockets/LuaSocket
* Provides `sslhandshake` proxy when using LuaSocket, with a dependency on
  LuaSec
* Does not get blocked to using LuaSocket in further contexts if loaded in the
  ngx_lua `init` (easy mistake to make)
* Memoizes underlying socket methods for performance
* Outputs a warning log for your users when spawning a socket using LuaSocket
  while in OpenResty


## Motivation

The aim of this module is to provide an automatic fallback to LuaSocket when
`ngx_lua`'s cosockets are not available. That is:

- When not used in `ngx_lua`
- In `ngx_lua` contexts where cosockets are not supported (`init`, `init_worker`, etc...)

When falling back to LuaSocket, it provides you with shims for cosocket-only
functions such as `getreusedtimes`, `setkeepalive` etc...

It comes handy when one is developing a module/library that aims at being
either compatible with both ngx_lua **and** plain Lua, **or** in ngx_lua
contexts such as `init`.


## Libraries using it

Here are some concrete examples uses of this module. You can see how we only
write code as if we were constantly in an cosocket-compatible OpenResty
context, which greatly simplifies our work and provides out of the box plain
Lua compatibility.

* [lua-cassandra](https://github.com/thibaultcha/lua-cassandra): see how the
  [cassandra](https://github.com/thibaultcha/lua-cassandra/blob/master/lib/cassandra/init.lua)
  module is compatible in both OpenResty and plain Lua with no efforts or
  special code paths distinguishing cosockets and LuaSocket.
* [lua-resty-aws](https://github.com/Kong/lua-resty-aws)
* [lua-resty-azure](https://github.com/Kong/lua-resty-azure)
* [lua-resty-gcp](https://github.com/Kong/lua-resty-gcp)


## Important notes

The use of LuaSocket inside `ngx_lua` is **very strongly** discouraged due to its
blocking nature. However, it is fine to use it in the `init` context where
blocking is not considered harmful.

In the future, only the `init` phase will allow falling back to LuaSocket.

It currently only support TCP sockets.


## Requirements

**As long as sockets are created in contexts with support for cosockets, this
module will never require LuaSocket nor LuaSec.**

- LuaSocket (only if sockets are created where cosockets don't exist)
- LuaSec (only if the fallbacked socket attempts to perform an SSL handshake)


## Installation

This module can either be copied in a lua-resty library, allowing one to
modify the list of contexts allowing fallback.

It can also be installed via LuaRocks:

```shell
$ luarocks install lua-resty-luasocket
```


