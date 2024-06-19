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

-- Chooser
-- hs.hotkey.bind({ "alt" }, "p", function()
--   local chooser = hs.chooser.new(function(stuff)
--     print(stuff)
--   end)

--   chooser:searchSubText(true)

--   chooser:choices({
--     { text = "First",  subText = "Quis incididunt elit irure sit nisi tempor proident id.", key = "1" },
--     { text = "Second", subText = "Eu Lorem anim est non.",                                  key = "2" },
--     { text = "Third",  subText = "Labore labore esse Lorem dolor.",                         key = "3" },
--   })

--   chooser:show()
-- end)
