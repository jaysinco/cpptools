Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c start /B ipfs daemon", 0, False
