#SingleInstance, Force

Gui, Launch:Font, Bold s14
Gui, Launch:Add, Text, Section , Proxy setter

Gui, Launch:Font, norm s8
Gui, Launch:Add, Tab,x10 y40 w320 h100,&Proxy || &About

Gui, Launch:Add, Text, Section
Gui, Launch:Add, Text, Section y+5, Proxy :
Gui, Launch:Add, Edit, ys r1 w120 vProx,
Gui, Launch:Add, Text, ys r1, Port :
Gui, Launch:Add, Edit, ys r1 w40 vPort,

Gui, Launch:Tab, 2
Gui, Launch:Add, Text, Section r1, How to use :`n`nPress CTRL+Q to quit.`nPress ESC to stop.

Gui, Launch:Tab
Gui, Launch:Add, Text, xm, 
Gui, Launch:Add, Button, xm w90 gStart, Start
Gui, Launch:Add, Button, x+m w90 gStop, Stop
Gui, Launch:Add, Button, x+m w90 gExit, Exit

Gui, Launch:Show, , Proxy Setter

Start:
    Gui, Launch:Submit, NoHide
    Status := 0

    if (Port="") or (Prox="")
    {
        if runner=1
        {
            MsgBox, 64, Error, Please fill the differents fields
            Status := 3
            return
        }
    }
    if runner=1
    {
        proxch(Status,Prox,Port)
        return
    }
    runner := 1
    return

proxch(Status,Prox,Port)
{
    if (Status=0)
    {
        regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,1
        regwrite,REG_SZ,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyServer,%Prox%:%Port%
    }
    if (Status=1)
    {
        regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,0
    }
    return
}

Stop:
    ESC::
	Status := 1
    proxch(Status,Prox,Port)
	return

Exit:
    ^q::
    ExitApp
