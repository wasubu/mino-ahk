#Requires AutoHotkey v2.0
#Include <IMEv2>

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