@echo off
chcp 65001
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64 &&^
C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -use-full-path
