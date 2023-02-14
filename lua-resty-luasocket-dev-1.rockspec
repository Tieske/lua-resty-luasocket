local package_name = "lua-resty-luasocket"
local package_version = "scm"
local rockspec_revision = "1"
local github_account_name = "Kong"
local github_repo_name = "lua-resty-luasocket"


package = package_name
version = package_version.."-"..rockspec_revision

source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = (package_version == "scm") and "master" or nil,
  tag = (package_version ~= "dev") and package_version or nil,
}

description = {
  summary = "Graceful fallback to LuaSocket for ngx_lua",
  license = "MIT",
  homepage = "https://github.com/"..github_account_name.."/"..github_repo_name,
}

build = {
  type = "builtin",
  modules = {
    ["resty.luasocket"] = "lib/resty/luasocket.lua"
  },
  copy_directories = {
    "docs",
  },
}
