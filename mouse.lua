local mouse = {
  button = {
    RIGHT = 2,
    MIDDLE = 3,
    BACK = 4,
    FORWARD = 5,
    AIM = 6,
    INDEX_DOWN = 7,
    PROFILE_SWITCH = 9,
    INDEX_UP = 8,
    SCROLL_RIGHT = 10,
    SCROLL_LEFT = 11,
  },
}

for k, v in pairs(mouse.button) do
  _G[k] = 2 ^ v
end

local _state = 0
function mouse.on_pressed(button)  _state = _state + 2 ^ button; end
function mouse.on_released(button) _state = _state - 2 ^ button; end

local _bindings = {}

-- DSL 1
function mouse.map(mbtns) return function(ahk_hotkey)
  _bindings[_.mask(mbtns)] = _.shortcut(_.ahk(ahk_hotkey))
end; end

-- DSL 2
function mouse.maps(maps_tbl)
  for lhs, rhs in pairs(maps_tbl) do
    _bindings[lhs] = _.shortcut(_.ahk(ahk_hotkey))
  end
end

function mouse.trigger_bindings()
  debug("%8x\n", _state)
  if type(_bindings[_state]) == "function" then
    _bindings[_state]()
  end
end

function mouse.dbg()
  pprint(mouse, _state, _bindings)
end

return mouse