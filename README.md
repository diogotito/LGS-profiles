# LGS-profiles

A small Lua framework to bind arbitrary "mouse chords" to keyboard shortcuts with Scripts in LGS (Logitech Gaming Software) Profiles

## How to use

1. Clone this repository

2. Paste the following in the Script of each LGS Profile:

```lua
DBG = false                               -- true to more see detailed output
PROFILE = [[profile_name]]                -- Optional. Allows custom configuration in profiles\profile_name.lua
BASE = [[C:\path\to\repository\profiles]] -- The full location of this repo's "profiles" folder
dofile(BASE .. [[\index.lua]])            -- Start the magic
```

3. Customize the global mouse chrods in profiles/base.lua:

```lua
mouse.maps {
  [AIM + SCROLL_LEFT]  = '^#left',
  [AIM + SCROLL_RIGHT] = '^#right',
  [PROFILE_SWITCH]     = 'printscreen',
}
```

4. (Optional) Customize profile-specific mouse chords in profiles/`profile_name`.lua

```lua
mouse.maps {
  [SCROLL_LEFT]      = '^pageup',
  [SCROLL_RIGHT]     = '^pagedown',
  [AIM + RIGHT]      = '^tab',
  [AIM + MIDDLE]     = '^w',
  [AIM + INDEX_UP]   = 'end',
  [AIM + INDEX_DOWN] = 'home',
}
```
