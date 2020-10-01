#UseHook

MapModifierKeys()

; Media
!#End::Send {Media_Play_Pause}
!#Delete::Send {Media_Prev}
!#PgDn::Send {Media_Next}

; Volume
!#PgUp::Send {Volume_Up}
!#Home::Send {Volume_Mute}
!#Insert::Send {Volume_Down}

; Search
!Space::Send #s

; Emoji keyboard
!^Space::Send #.

; Window snapping
!#Left::Send #{Left}
!#Right::Send #{Right}
!#Enter::Send #{Up}

; Disable modifier key press behavior
Alt::Return
LWin & vkFF::Return
LWin::Return
RWin & vkFF::Return
RWin::Return

; Cursor control (Alt -> Command)
!Up::Send ^{Home}
!Down::Send ^{End}
!Left::Send {Home}
!Right::Send {End}
!+Up::Send ^+{Home}
!+Down::Send ^+{End}
!+Left::Send +{Home}
!+Right::Send +{End}

; Cursor control (Win -> Option)
#Up::Send !{Up}
#Down::Send !{Down}
#Left::Send ^{Left}
#Right::Send ^{Right}
#+Up::Send !+{Up}
#+Down::Send !+{Down}
#+Left::Send ^+{Left}
#+Right::Send ^+{Right}

; Cursor control (Alt + Win -> Command + Option)
!#Up::Send ^!{Up}
!#Down::Send ^!{Down}

; Backspace/Delete
#Backspace::Send ^{Backspace}
!Backspace::Send +{Home}{Delete}
#Delete::Send ^{Delete}
!Delete::Send +{End}{Delete}

MapModifierKeys() {
  Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"
         , "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
         , "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
         , "-", "=", "[", "]", "\", ";", "'", ",", ".", "/"
         , "Enter"]

  For _, Key In Keys {
    ControlFunc := Func("Control").Bind(Key)
    Hotkey, !%Key%, %ControlFunc%

    ControlShiftFunc := Func("ControlShift").Bind(Key)
    Hotkey, !+%Key%, %ControlShiftFunc%

    If (Key != "x") {
      AltFunc := Func("Alt").Bind(Key)
      Hotkey, #%Key%, %AltFunc%
    }

    AltShiftFunc := Func("AltShift").Bind(Key)
    Hotkey, #+%Key%, %AltShiftFunc%

    If (Key != "Enter") {
      ControlAltFunc := Func("ControlAlt").Bind(Key)
      Hotkey, !#%Key%, %ControlAltFunc%
    }

    ControlAltShiftFunc := Func("ControlAltShift").Bind(Key)
    Hotkey, !#+%Key%, %ControlAltShiftFunc%
  }
}

Control(Key) {
  Send ^{%Key%}
}

ControlShift(Key) {
  Send ^+{%Key%}
}

Alt(Key) {
  Send !{%Key%}
}

AltShift(Key) {
  Send !+{%Key%}
}

ControlAlt(Key) {
  Send ^!{%Key%}
}

ControlAltShift(Key) {
  Send ^!+{%Key%}
}
