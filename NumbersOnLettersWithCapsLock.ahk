#Requires AutoHotkey v2.0
#SingleInstance

SetCapsLockState "AlwaysOff"

SC03A & b::Send "1"
SC03A & n::Send "2"
SC03A & m::Send "3"
SC03A & h::Send "4"
SC03A & j::Send "5"
SC03A & k::Send "6"
SC03A & l::Send "7"
SC03A & u::Send "8"
SC03A & i::Send "9"
SC03A & o::Send "0"
SC03A & f::Send " "
SC03A & sc027::Send "{Backspace}"
#HotIf GetKeyState("Shift", "P")
SC03A & b::Send "{!}"
SC03A & n::Send "@"
SC03A & m::Send "{#}"
SC03A & h::Send "$"
SC03A & j::Send "%"
SC03A & k::Send "{^}"
SC03A & l::Send "{&}"
SC03A & u::Send "*"
SC03A & i::Send "("
SC03A & o::Send ")"
;Shift Up:: Send "{SC03A up}"
#HotIf