#Requires AutoHotkey v2.0
Persistent
#include Acc.ahk
#include .\IMEv2.ahk
#SingleInstance

F1::KeyHistory

sc079::MsgBox "henko"
sc07B::MsgBox "muhenko"
sc070::MsgBox "kana"
;SC03A & b::{
;    if GetKeyState("Shift", "P") {
;        Send "{!}"
;    }
;}


;CapsLock::Return
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


; Move desktop files every 2 hours
SetTimer moveDesktop, 1000 * 60 * 120  ; every 2 hours

DestFolder := "C:\user content\pesky desktop files"
moveDesktop() {
    global DestFolder

    ; Move user desktop files
    LoopFiles("C:\Users\delma\Desktop\*.*", DestFolder)

    ; Move public desktop files
    LoopFiles("C:\Users\Public\Desktop\*.*", DestFolder)
}

LoopFiles(src, DestFolder) {
    ; Move directories
    Loop Files src, "D"
        DirMove A_LoopFilePath, DestFolder, 1

    ; Move files (including .lnk shortcuts)
    Loop Files src, "F"
        FileMove A_LoopFilePath, DestFolder, 1
}

moveDesktop()


; IME toggle with RControl
RControl::{
	SoundBeep 850
	Send "!``"
	ToolTip
	SetTimer processJP, -1
}

processJP() {
	SetTimer showLang, 0
	SetTimer showLang, 6
	Sleep 2000
	SetTimer showLang, 0
	ToolTip
}

showLang(){
	if  IME_GET() = 1
		ToolTip "日本語 🇯🇵"
	else if IME_GET() = 0
		ToolTip "English 🇺🇸"
}

; PDF Highlighter & Draw/Pen buttons
global highlightBtn := ""
global drawBtn := ""
global eraseBtn := ""

getBtn(cachedBtn, name) {
    hwnd := WinActive("A")

    ; Validate cached button
    if IsObject(cachedBtn) {
        try {
            test := cachedBtn.accName ; will error if dead
            return cachedBtn
        } catch {
            cachedBtn := ""   ; reset
        }
    }

    ; Re-scan UI
    root := Acc.ElementFromHandle(hwnd, 0, true)
    btn := root.FindElement({RoleText:"push button", Name:name})
    return btn
}

activateHighlight() {
    global highlightBtn
    highlightBtn := getBtn(highlightBtn, "Highlight")
    if highlightBtn
        highlightBtn.DoDefaultAction()
}

activateDraw() {
    global drawBtn
    drawBtn := getBtn(drawBtn, "Draw")
    if drawBtn
        drawBtn.DoDefaultAction()
}

activateErase() {
    global eraseBtn
    eraseBtn := getBtn(eraseBtn, "Erase")
    if eraseBtn
        eraseBtn.DoDefaultAction()
}

#HotIf WinActive("ahk_class Chrome_WidgetWin_1") && InStr(WinGetTitle("A"), ".pdf")
~1::activateHighlight()
~2::activateDraw()
~3::activateErase()
#HotIf