#Requires AutoHotkey v2.0
#Include <Acc>

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