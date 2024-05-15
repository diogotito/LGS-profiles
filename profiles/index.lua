-- Profile customization system
local profile_customization_env = {}
for k, v in pairs(mouse.button) do
  profile_customization_env[k] = 2 ^ v
end
setmetatable(profile_customization_env, { __index = getfenv() })

function setup_profile(name)
  local path = ("%s/profiles/%s.lua"):format(BASE, name)
  local chunk = assert(loadfile(path), ("[[%s]] doesn't exist!"):format(path))
  
  setfenv(chunk, profile_customization_env)
  return chunk()
end

setup_profile 'base'

if PROFILE then
  printf("=== Setting up profile: [[%s]] ===\n", PROFILE)
  -- require "profiles/PROFILE" decorated with -- Success|ERROR --
  success, error = pcall(setup_profile, PROFILE)
  if success then
    print(" -- Success -- ")
    if DBG then mouse.dbg() end
  else
    print(" -- ERROR -- ")
    print(error)
  end
  print(string.rep('-', 32 + string.len(PROFILE)))
end