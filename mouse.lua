local mouse = {
  button = {
    RIGHT = 2,
    MIDDLE = 3,
    BACK = 4,
    FORWARD = 5,
    AIM = 6,
    INDEX_DOWN = 7,
    INDEX_UP = 8,
    PROFILE_SWITCH = 9,
    INDEX_UP = 8,
    SCROLL_RIGHT = 10,
    SCROLL_LEFT = 11,
  },
}



local _state = 0
function mouse.on_pressed(button)  _state = _state + 2 ^ button; end
function mouse.on_released(button) _state = _state - 2 ^ button; end

local _bindings = {}

-- DSL 2
function mouse.maps(maps_tbl)
  for lhs, rhs in pairs(maps_tbl) do
    if type(rhs) == 'string' then rhs = _.shortcut(_.ahk(rhs))  end
    if type(rhs) == 'table'  then rhs = _.shortcut(unpack(rhs)) end
    _bindings[lhs] = rhs
  end
end

function mouse.trigger_bindings()
  debug("%8x\n", _state)
  if type(_bindings[_state]) == "function" then
    _bindings[_state]()
  end
end

function mouse.dbg()
  load_module 'pprint' .defaults.show_all = true
  pprint(mouse, _state, _bindings)
end

return mouse
