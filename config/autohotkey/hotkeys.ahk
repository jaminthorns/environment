#UseHook

TerminalId := "ahk_class org.wezfurlong.wezterm"
VSCodeId := "ahk_exe Code.exe"

MapWinToCtrl()

; Media
!#End::Send {Media_Play_Pause}
!#Delete::Send {Media_Prev}
!#PgDn::Send {Media_Next}

; Volume
!#PgUp::Send {Volume_Up}
!#Home::Send {Volume_Mute}
!#Insert::Send {Volume_Down}

; Power
!#ScrollLock::DllCall("LockWorkStation")
!#Pause::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

; Open terminal
!`::
  If WinExist(TerminalId) {
    WinActivate
  } Else {
    Run "wezterm-gui.exe", , , OutputVarPID
    WinWait ahk_pid %OutputVarPID%
    WinActivate ahk_pid %OutputVarPID%
  }
Return

; Emoji keyboard
#^Space::Send #.

; Clipboard history
#+v::Send {Shift Up}#v

; Window snapping
^!Left::Send #{Left}
^!Right::Send #{Right}

; Window Switching
!Tab::Send #{Tab}

#Tab::
  Send {Alt Down}{Tab}
  KeyWait LWin
  Send {Alt Up}
Return

#+Tab::
  Send {Alt Down}{Shift Down}{Tab}
  KeyWait LWin
  Send {Alt Up}{Shift Up}
Return

; Disable modifier key press behavior
Alt::Return
LWin & vkFF::Return
LWin::Return
RWin & vkFF::Return
RWin::Return

; General applications + VS Code
#If !WinActive(TerminalId)
  #Left::Send {Home} ; Move cursor to start of line
  #Right::Send {End} ; Move cursor to end of line
  #Up::Send ^{Home} ; Move cursor to start of input
  #Down::Send ^{End} ; Move cursor to end of input

  #+Left::Send +{Home} ; Select to start of line
  #+Right::Send +{End} ; Select to end of line
  #+Up::Send ^+{Home} ; Select to start of input
  #+Down::Send ^+{End} ; Select to end of input

  !Left::Send ^{Left} ; Move cursor left by word
  !Right::Send ^{Right} ; Move cursor right by word
  !+Left::Send ^+{Left} ; Select left by word
  !+Right::Send ^+{Right} ; Select right by word

  !Backspace::Send ^{Backspace} ; Delete word backward
  !Delete::Send ^{Delete} ; Delete word forward
#If

; General applications
#If !WinActive(TerminalId) && !WinActive(VSCodeId)
  #Backspace::Send +{Home}{Delete} ; Delete line backward
  #Delete::Send +{End}{Delete} ; Delete line forward
#If

; VS Code + Terminal
#If WinActive(TerminalId) || WinActive(VSCodeId)
  ; Workaround for copy/paste/search in terminal
  ^c::Send ^!c
  ^v::Send ^!v
  ^f::Send ^!f
#If

; Terminal
#If WinActive(TerminalId)
  ; Just map Win to Ctrl and handle further mapping in config
  #Up::Send ^{Up}
  #Down::Send ^{Down}
  #Left::Send ^{Left}
  #Right::Send ^{Right}
  #Backspace::Send ^{Backspace}
  #Delete::Send ^{Delete}
#If

; VS Code
#If WinActive(VSCodeId)
  ; Move editor shortcut
  ^#Left::Send ^!{Left}
  ^#Right::Send ^!{Right}

  ; Duplicate cursor shortcut
  !#Up::Send ^!{Up}
  !#Down::Send ^!{Down}

  ; Send surrogate keys for line deletion
  ;
  ; In VS Code, cursor movement within editor inputs can be fully remapped from
  ; any keystroke, but other inputs (quick picks, search widgets, file pickers)
  ; cannot be remapped. To implement line deletion in Windows, multiple
  ; keystrokes are required, which works fine for inputs (editor or otherwise)
  ; but doesn't map cleanly to terminal keybindings.
  ;
  ; Because of this, we make the choice to sacrifice line deletion keybindings
  ; in non-editor inputs so we can have line deletion be triggered by a single
  ; keystroke using surrogate keys, which can then be handled in VS Code
  ; keybindings for the editor and terminal.
  #Backspace::Send ^{F13}
  #Delete::Send ^{F14}

  ; Workaround for Win+L release behavior
  ;
  ; AutoHotkey waits until after the modifier is released when sending the L key
  ; for Win key shortcuts to prevent locking the computer. This wait is fine for
  ; general applications, but this shortcuts is pressed repeatedly in VS Code,
  ; so we send a surrogate key.
  #l::Send ^{F15}
#If

; Workaround for Win+Esc shortcut (opens start menu)
^Esc::Send ^{F16}

; Workaround for Alt+Space shortcut (opens window menu)
!Space::Send ^{F17}

MapWinToCtrl() {
  Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"
    , "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
    , "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
    , "-", "=", "[", "]", "\", ";", "'", ",", ".", "/"
    , "Enter", "RButton", "LButton", "MButton"]

  For _, Key In Keys {
    ControlFunc := Func("Control").Bind(Key)
    Hotkey, #%Key%, %ControlFunc%

    ; Win+Shift+V used for clipboard history
    ; Win+Shift+C used for color picker
    If (Key != "v" && Key != "c") {
      ControlShiftFunc := Func("ControlShift").Bind(Key)
      Hotkey, #+%Key%, %ControlShiftFunc%
    }

    ControlAltFunc := Func("ControlAlt").Bind(Key)
    Hotkey, !#%Key%, %ControlAltFunc%

    ControlAltShiftFunc := Func("ControlAltShift").Bind(Key)
    Hotkey, !#+%Key%, %ControlAltShiftFunc%
  }
}

Control(Key) {
  If StrLen(Key) > 1 {
    Send ^{%Key%}
  } Else {
    Send ^%Key%
  }
}

ControlShift(Key) {
  If StrLen(Key) > 1 {
    Send ^+{%Key%}
  } Else {
    Send ^+%Key%
  }
}

ControlAlt(Key) {
  If StrLen(Key) > 1 {
    Send ^!{%Key%}
  } Else {
    Send ^!%Key%
  }
}

ControlAltShift(Key) {
  If StrLen(Key) > 1 {
    Send ^!+{%Key%}
  } Else {
    Send ^!+%Key%
  }
}
