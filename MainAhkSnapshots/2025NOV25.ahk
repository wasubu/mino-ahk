#Requires AutoHotkey v2.0
Persistent
#include Acc.ahk
#SingleInstance

SetTimer moveDesktop, 1000 * 60 * 120 ;every 40 min

; 👇 target window (change this to your app)
target := "Super Productivity Overlay"

SetTimer MonitorWindow, 500


MonitorWindow() {
    global target
    ;WinSetAlwaysOnTop(1, target)
    if WinActive(target) {
        WinSetAlwaysOnTop(1, target)
        ; wait until focus is lost
        ;WinWaitNotActive(target)
        ;WinMinimize(target)
    }
}


moveDesktop()
{
	Loop Files "C:\Users\delma\Desktop\*.*", "D"
	{
		DirMove A_LoopFilePath, "C:\user content\pesky desktop files", 1
	}
	Loop Files "C:\Users\delma\Desktop\*.*", "F"
	{
		FileMove A_LoopFilePath, "C:\user content\pesky desktop files", 1
	}
}
moveDesktop()
RControl::{
	SoundBeep 850 ;1000 the value before
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



step := 6
interval := 13
mouseMode := false

; Movement flags
movingLeft := false
movingDown := false
movingUp := false
movingRight := false

; Dragging flags
draggingLeft := false
draggingDown := false
draggingUp := false
draggingRight := false

; Helper functions to press/release mouse button for drag
startDrag() {
    MouseClick("Left", , , 1, , "D")  ; Press down (hold)
}
stopDrag() {
    MouseClick("Left", , , 1, , "U") ; Release
}

; Movement functions — move and optionally drag if dragging flag is set
moveLeft(*) {
    global mouseMode, draggingLeft, step
    if (!mouseMode) {
        SetTimer moveLeft, 0
        draggingLeft := false
        return
    }
    if (draggingLeft)
        startDrag()
    MouseMove(-step, 0, 0, "R")
}

moveDown(*) {
    global mouseMode, draggingDown, step
    if (!mouseMode) {
        SetTimer moveDown, 0
        draggingDown := false
        return
    }
    if (draggingDown)
        startDrag()
    MouseMove(0, step, 0, "R")
}

moveUp(*) {
    global mouseMode, draggingUp, step
    if (!mouseMode) {
        SetTimer moveUp, 0
        draggingUp := false
        return
    }
    if (draggingUp)
        startDrag()
    MouseMove(0, -step, 0, "R")
}

moveRight(*) {
    global mouseMode, draggingRight, step
    if (!mouseMode) {
        SetTimer moveRight, 0
        draggingRight := false
        return
    }
    if (draggingRight)
        startDrag()
    MouseMove(step, 0, 0, "R")
}

; Toggle mouse mode with Ctrl+Space
;^Space:: {
;    global mouseMode
;    mouseMode := !mouseMode
;    ToolTip(mouseMode ? "🖱 Mouse Mode ON" : "🖱 Mouse Mode OFF")
;    SetTimer(() => ToolTip(), -1000)
;}
#InputLevel 1
Esc:: {
    global mouseMode
    if (mouseMode) {
        mouseMode := false
        ToolTip("🖱 Mouse Mode OFF")
        SetTimer(() => ToolTip(), -1000)
    } else {
        SendInput("{Blind}{Esc}") ; avoids recursion and keeps modifiers clean
    }
}
#InputLevel 0

#HotIf mouseMode

; Normal mouse movement with hjkl keys
h:: {
    global movingLeft
    if (!movingLeft) {
        movingLeft := true
        SetTimer moveLeft, interval
    }
}
h Up:: {
    global movingLeft
    movingLeft := false
    SetTimer moveLeft, 0
}

j:: {
    global movingDown
    if (!movingDown) {
        movingDown := true
        SetTimer moveDown, interval
    }
}
j Up:: {
    global movingDown
    movingDown := false
    SetTimer moveDown, 0
}

k:: {
    global movingUp
    if (!movingUp) {
        movingUp := true
        SetTimer moveUp, interval
    }
}
k Up:: {
    global movingUp
    movingUp := false
    SetTimer moveUp, 0
}

l:: {
    global movingRight
    if (!movingRight) {
        movingRight := true
        SetTimer moveRight, interval
    }
}
l Up:: {
    global movingRight
    movingRight := false
    SetTimer moveRight, 0
}

; Shift + hjkl for mouse dragging + moving
+h:: {
    global draggingLeft
    if (!draggingLeft) {
        draggingLeft := true
        SetTimer moveLeft, interval
    }
}
+h Up:: {
    global draggingLeft
    draggingLeft := false
    SetTimer moveLeft, 0
    stopDrag()
}

+j:: {
    global draggingDown
    if (!draggingDown) {
        draggingDown := true
        SetTimer moveDown, interval
    }
}
+j Up:: {
    global draggingDown
    draggingDown := false
    SetTimer moveDown, 0
    stopDrag()
}

+k:: {
    global draggingUp
    if (!draggingUp) {
        draggingUp := true
        SetTimer moveUp, interval
    }
}
+k Up:: {
    global draggingUp
    draggingUp := false
    SetTimer moveUp, 0
    stopDrag()
}

+l:: {
    global draggingRight
    if (!draggingRight) {
        draggingRight := true
        SetTimer moveRight, interval
    }
}
+l Up:: {
    global draggingRight
    draggingRight := false
    SetTimer moveRight, 0
    stopDrag()
}

; Press `f` to click the left mouse button
i::MouseClick("Left")

#HotIf

#include .\IMEv2.ahk

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