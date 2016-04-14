#SingleInstance, force

Gui, Add, DropDownList, w220 vBitByte gCtrlEvent, Byte||Bit
Gui, Add, DropDownList, w220 vStandard gCtrlEvent, SI (Base 2) - 1024... Kibi, Mebi, Gibi, ...||IEC (Base 10) - 1000... Kilo, Mega, Giga, ...

Gui, Add, Text, , b
Gui, Add, Edit, w220 vB gCtrlEvent

Gui, Add, Text, , kb
Gui, Add, Edit, w220 vKB gCtrlEvent

Gui, Add, Text, , mb
Gui, Add, Edit, w220 vMB gCtrlEvent

Gui, Add, Text, , gb
Gui, Add, Edit, w220 vGB gCtrlEvent

Gui, Add, Text, , tb
Gui, Add, Edit, w220 vTB gCtrlEvent

Gui, Add, Text, , pb
Gui, Add, Edit, w220 vPB gCtrlEvent

Gui, Show,, Storage Unit Converter

CtrlEvent(CtrlHwnd:=0, GuiEvent:="", EventInfo:="", ErrLvl:="") {
    GuiControlGet, controlName, Name, %CtrlHwnd%
    If IsGuiControlFocused(controlName) {
        GuiControlGet, bitbyte,, BitByte
        byte := (bitbyte = "Byte")
        GuiControlGet, standard,, standard
        std := (InStr(standard, "SI (Base 2)") ? "SI" : "IEC")
        GuiControlGet, value,, %controlName%
        If (controlName = "B") {
            value := value
        } Else If (controlName = "KB") {
            If (std = "SI")
                value := value*2**10
            Else 
                value := value*10**3
        } Else If (controlName = "MB") {
            If (std = "SI")
                value := value*2**20
            Else 
                value := value*10**6
        } Else If (controlName = "GB") {
            If (std = "SI")
                value := value*2**30
            Else 
                value := value*10**9
        } Else If (controlName = "TB") {
            If (std = "SI")
                value := value*2**40
            Else 
                value := value*10**12
        } Else If (controlName = "PB") {
            If (std = "SI")
                value := value*2**50
            Else 
                value := value*10*15
        } Else If (controlName = "BitByte") {
            GuiControlGet, value,, B
            If (byte)
                value := value/8
            Else
                value := value*8
        } Else If (controlName = "standard") {
            GuiControlGet, value,, B
        }
        
        If !IsGuiControlFocused("B")
            GuiControl,, B, % value
        If !IsGuiControlFocused("KB") {
            If (std = "SI")
                GuiControl,, KB, % RemoveTrailingZeroes(value/2**10)
            Else
                GuiControl,, KB, % RemoveTrailingZeroes(value/10**3)
        }
        If !IsGuiControlFocused("MB") {
            If (std = "SI")
                GuiControl,, MB, % RemoveTrailingZeroes(value/2**20)
            Else
                GuiControl,, MB, % RemoveTrailingZeroes(value/10**6)
        }
        If !IsGuiControlFocused("GB") {
            If (std = "SI")
                GuiControl,, GB, % RemoveTrailingZeroes(value/2**30)
            Else
                GuiControl,, GB, % RemoveTrailingZeroes(value/10**9)
        }
        If !IsGuiControlFocused("TB") {
            If (std = "SI")
                GuiControl,, TB, % RemoveTrailingZeroes(value/2**40)
            Else
                GuiControl,, TB, % RemoveTrailingZeroes(value/10**12)
        }
        If !IsGuiControlFocused("PB") {
            If (std = "SI")
                GuiControl,, PB, % RemoveTrailingZeroes(value/2**50)
            Else
                GuiControl,, PB, % RemoveTrailingZeroes(value/10**15)
        }
    }
}
IsGuiControlFocused(controlName) {
    GuiControlGet, focused, FocusV
    Return focused = controlName
}
GuiClose(hwnd:=0) {
    ExitApp
}


RemoveTrailingZeroes(number) {
    local a, l, o, z
    a := &number
    l := StrLen(number)
    o := l - 1
    z := Asc("0")	; Just to be explicit...
    Loop {
        If (*(a + o) != z || o = 0)
            Break
        o--
    }
    StringTrimRight number, number, % l - o - 1
    Return number
}