local function perform_shortcut(...)
  debug("* Performing shortcut: <%s>\n", table.concat({...}, "-"))
	mods = {...}
	key = table.remove(mods)
	PressKey(unpack(mods))
	PressAndReleaseKey(key)
	ReleaseKey(unpack(mods))
end

local function shortcut(...)
	local keys = {...}
	return function() return perform_shortcut(unpack(keys)) end
end

local function ahk(ahk_code)
  local KEYS = {
    ['^'] = 'lctrl',
    ['#'] = 'lgui',
    ['!'] = 'lalt',
    ['+'] = 'lshift',
  }
  local tokens = {}
  local start = 1, from, to
  repeat
    -- If Lua regexps supported disjunction this could be made in 2 or 3 lines
    from, to = ahk_code:find('^[^+!#^]+', start)
    if from then
      tokens[#tokens + 1] = ahk_code:sub(from, to)
    else
      from, to = ahk_code:find('^[+!#^]', start)
      if not from then error("Can't parse " .. ahk_code); end
      tokens[#tokens + 1] = KEYS[ahk_code:sub(from, to)]
    end
    start = to + 1
  until start > ahk_code:len()
  return unpack(tokens)
end

return {
  perform_shortcut = perform_shortcut,
  shortcut = shortcut,
  ahk = ahk
}
