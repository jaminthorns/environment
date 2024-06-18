local function bindSystemKey(mods, sourceKey, systemKey)
  local pressed = function() hs.eventtap.event.newSystemKeyEvent(systemKey, true):post() end
  local released = function() hs.eventtap.event.newSystemKeyEvent(systemKey, false):post() end

  hs.hotkey.bind(mods, sourceKey, pressed, released)
end

-- Media
bindSystemKey({ "cmd", "alt" }, "forwarddelete", "PREVIOUS")
bindSystemKey({ "cmd", "alt" }, "end", "PLAY")
bindSystemKey({ "cmd", "alt" }, "pagedown", "NEXT")

-- Volume
bindSystemKey({ "cmd", "alt" }, "help", "SOUND_DOWN")
bindSystemKey({ "cmd", "alt" }, "home", "MUTE")
bindSystemKey({ "cmd", "alt" }, "pageup", "SOUND_UP")

-- Sleep
hs.hotkey.bind({ "cmd", "alt" }, "f15", hs.caffeinate.systemSleep)

-- Open terminal
hs.hotkey.bind({ "alt" }, "`", function() hs.application.open("WezTerm.app") end)
