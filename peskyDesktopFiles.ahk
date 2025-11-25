#Requires AutoHotkey v2.0

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
