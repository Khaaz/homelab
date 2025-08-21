@echo off
setlocal

set "CDOPT=--cd %CD%"
set "DISTROOPT="

wsl.exe %DISTROOPT% %CDOPT%
