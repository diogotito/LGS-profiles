# LGS-profiles

A small Lua framework to bind arbitrary "mouse chords" to keyboard shortcuts with Scripts in LGS (Logitech Gaming Software) Profiles

## How to use

1. Clone this repository

2. Paste the following in the Script of each LGS Profile, and change accordingly:

   ```lua
   -- Optional settings:
   DBG = false -- true to more see detailed output
   PROFILE = [[profile_name]] -- Allows custom configuration in profiles\profile_name.lua

   -- Required:
   BASE = [[C:\path\to\repository\profiles]] -- The full location of this repo's "profiles" folder
   dofile(BASE .. [[\index.lua]])
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

## API

### `mouse.maps { [MOUSE + CHORDS] = "AHK_keys" }`

Define mouse chords by summing (`+`) the names from the `mouse.button` table in mouse.lua
(they are directly available as bit flags in the profile-specific customization scripts' environment):

| Name             | Description                     |
| ---------------- | ------------------------------- |
| `RIGHT`          | Right mouse button              |
| `MIDDLE`         | Mouse wheel button              |
| `BACK`           | Back                            |
| `FORWARD`        | Forward                         |
| `AIM`            | G6                              |
| `INDEX_DOWN`     | G7                              |
| `INDEX_UP`       | G8                              |
| `PROFILE_SWITCH` | G9                              |
| `INDEX_UP`       | G8                              |
| `SCROLL_RIGHT`   | Mouse wheel tilted to the right |
| `SCROLL_LEFT`    | Mouse wheel tilted to the left  |

Sums (`+`) of these names go to the keys in the table passed to `mouse.maps`, wrapped in square brackets (`[]`), like this:

```lua
  [AIM + RIGHT] -- when the G6 button and right mouse button are both pressed
```

The values are keyboard shortcut strings, which use a notation similar to
[AutoHotKey](https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols):

|     Symbol     | Key              |
| :------------: | :--------------- |
| <code>^</code> | <kbd>Ctrl</kbd>  |
| <code>#</code> | <kbd>Win</kbd>   |
| <code>!</code> | <kbd>Alt</kbd>   |
| <code>+</code> | <kbd>Shift</kbd> |

For the remaining names usable in keyboard shortcuts,
refer to Appendix A in your G-seriesLuaAPI.pdf,
accessible through Help > Script API from the Script editor window in LGS.

Some of the key names that you can use in keyboard shorcuts:  
`a` to `z`,
`1` to `9` and `0`,
`f1` to `f24`,
`appkey`,
`backslash`,
`backspace`,
`lbracket` and `rbracket`,
`capslock`,
`comma`,
`delete`,
`down`,
`end`,
`enter`,
`equal`,
`escape`,
`home`,
`insert`,
`left`,
`minus`,
`numlock`,
`pagedown`,
`pageup`,
`pause`,
`period`,
`printscreen`,
`quote`,
`right`,
`scrolllock`,
`semicolon`,
`slash`,
`spacebar`,
`tab`,
`tilde`,
`up`

Example shortcut:

```lua
  "^tab" -- Hold [Ctrl] key and press [Tab]
```

These shortcut keys are passed to `utils.ahk(string)`,
which tokenizes it into a table of keycodes (actually strings),
which is passed to `utils.shortcut(...)`
which returns a closure that calls `utils.perform_shortcut(...)`,
which finally calls
`PressKey(...)`,`PressAndReleaseKey(_)`and`ReleaseKey(...)`
from LGS's Lua API.

With this, there are two alternatives to writing the keyboard shortcut as a
AHK `Send`-style string:

- Write it as a table of key codes

  ```lua
  {"lctrl", "tab"}
  ```

- Write a custom Lua function that gets called when the mouse chord is activated

  ```lua
  function ()
    _.perform_shortcut("lctrl", "tab")
  end
  ```

  Utility functions should be available for working with closures for a more "points free" style (WIP)

  ```lua
  shortcut("lctrl", "tab")
    --> a closure that calls _.perform_shortcut("lctrl", "tab")
  ```
