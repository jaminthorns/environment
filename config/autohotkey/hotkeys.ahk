#UseHook

ProcessSetPriority("Realtime")

TerminalClass := "ahk_class org.wezfurlong.wezterm"

MapAllModifiers()

; Media
!#End::Send("{Media_Play_Pause}")
!#Delete::Send("{Media_Prev}")
!#PgDn::Send("{Media_Next}")

; Volume
!#PgUp::Send("{Volume_Up}")
!#Home::Send("{Volume_Mute}")
!#Insert::Send("{Volume_Down}")

; Sleep
!#Pause::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

; Emoji keyboard
!^Space::Send("#.")

; Window snapping
!#Left::Send("#{Left}")
!#Right::Send("#{Right}")
!#Enter::Send("#{Up 2}")

; Disable modifier key press behavior
~Alt::Send("{Blind}{vkFF}")
~LWin::Send("{Blind}{vkFF}")
~RWin::Send("{Blind}{vkFF}")

#HotIf !WinActive(TerminalClass)
; Cursor control (Alt -> Command)
!Up::Send("^{Home}")
!Down::Send("^{End}")
!Left::Send("{Home}")
!Right::Send("{End}")
!+Up::Send("^+{Home}")
!+Down::Send("^+{End}")
!+Left::Send("+{Home}")
!+Right::Send("+{End}")

; Cursor control (Win -> Option)
#Up::Send("!{Up}")
#Down::Send("!{Down}")
#Left::Send("^{Left}")
#Right::Send("^{Right}")
#+Up::Send("!+{Up}")
#+Down::Send("!+{Down}")
#+Left::Send("^+{Left}")
#+Right::Send("^+{Right}")

; Backspace/Delete
#Backspace::Send("^{Backspace}")
!Backspace::Send("+{Home}{Delete}")
#Delete::Send("^{Delete}")
!Delete::Send("+{End}{Delete}")
#HotIf

#HotIf WinActive(TerminalClass)
; Cursor control (Alt -> Command)
!Up::Send("^{Up}")
!Down::Send("^{Down}")
!Left::Send("^{Left}")
!Right::Send("^{Right}")

; Cursor control (Win -> Option)
#Left::Send("!{Left}")
#Right::Send("!{Right}")

; Backspace/Delete
#Backspace::Send("!{Backspace}")
!Backspace::Send("^{Backspace}")
#Delete::Send("!{Delete}")
!Delete::Send("^{Delete}")
#HotIf

; Cursor control (Alt + Win -> Command + Option)
!#Up::Send("^!{Up}")
!#Down::Send("^!{Down}")

MapAllModifiers() {
  Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"
         , "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
         , "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
         , "-", "=", "[", "]", "\", ";", "'", ",", ".", "/"
         , "Enter", "RButton", "LButton", "MButton"]

  for _, Key in Keys {
    MapModifiers(Key, "!", "^")
    MapModifiers(Key, "!+", "^+")
    MapModifiers(Key, "#", "!")
    MapModifiers(Key, "#+", "!+")

    if (Key != "Enter") {
      MapModifiers(Key, "!#", "^!")
    }

    MapModifiers(Key, "!#+", "^!+")
    MapModifiers(Key, "^#", "^!")
    MapModifiers(Key, "^#+", "^!+")
  }
}

MapModifiers(Key, From, To) {
  Hotkey(From Key, ((K, *) => Send(To "{" K "}")).Bind(Key))
}
