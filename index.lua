--[=[ Paste in LGS:
------------------------------------------------------
BASE = [[D:\tralha\lua\default_profile]]
dofile(BASE .. "\\index.lua")
---------------------------------------------------]=]

-- reivent parts of Lua's basic library and I/O library
_G.printf = OutputLogMessage
_G.print = function(s) _G.printf("%s\n", s); end
_G.io  = { write = function(s) _G.printf("%s", s); end }
_G.debug = function(...) if _G.DBG then _G.printf(...) end; end

-- poor man's module system
function require(name)
  return dofile(("%s/%s.lua"):format(BASE, name))
end

function load_module(name)
  if not _G[name] then
    _G[name] = require(name)
    return _G[name]
  end
end

load_module 'pprint' .defaults.show_all = true
_ = load_module 'utils'
load_module 'mouse'
load_module 'setup'
load_module 'OnEvent'