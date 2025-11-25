#Requires AutoHotkey v2.0
#Include <Acc>

global highlightBtn := ""
global drawBtn := ""

activateHighlight() {
    global highlightBtn
    hwnd := WinActive("A")  ; get active window

    ; Only find and cache the button once
    if !IsObject(highlightBtn) {
        root := Acc.ElementFromHandle(hwnd, 0, true)
        highlightBtn := root.FindElement({RoleText:"push button", Name:"Highlight"})
        if !highlightBtn
            return
    }
    highlightBtn.DoDefaultAction()  ; click/select
}

activateDraw() {
    global drawBtn
    hwnd := WinActive("A")  ; get active window

    ; Only find and cache the button once
    if !IsObject(drawBtn) {
        root := Acc.ElementFromHandle(hwnd, 0, true)
        drawBtn := root.FindElement({RoleText:"push button", Name:"Draw"})
        if !drawBtn
            return
    }
    drawBtn.DoDefaultAction()  ; click/select
}

#HotIf WinActive("ahk_class Chrome_WidgetWin_1") && InStr(WinGetTitle("A"), ".pdf")
~1::activateHighlight()  ; pass-through key
~2::activateDraw()       ; pass-through key for Draw/Pen
#HotIf  ; end hotkey