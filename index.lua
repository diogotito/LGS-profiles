--[=[ Paste in LGS:
------------------------------------------------------
DBG = true
PROFILE = [[name]]
BASE = [[D:\tralha\lua\default_profile]]
dofile(BASE .. "\\index.lua")
---------------------------------------------------]=]

-- reivent parts of Lua's basic library and I/O library
_G.printf = OutputLogMessage
_G.print = function(s) _G.printf("%s\n", tostring(s)); end
_G.io  = { write = function(s) _G.printf("%s", s); end }
_G.debug = function(...) if _G.DBG then _G.printf(...) end; end

-- poor man's module system
function require(name)
  return dofile(("%s/%s.lua"):format(BASE, name))
end

function load_module(name)
  if not _G[name] then _G[name] = require(name) end
  return _G[name]
end

_ = load_module 'utils'
load_module 'mouse'
load_module 'OnEvent'

require 'profiles/index'
