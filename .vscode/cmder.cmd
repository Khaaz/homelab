@echo off
setlocal
if not defined CMDER_ROOT set "CMDER_ROOT=D:\dev\cmder"

set "RUN=%*" 

%SystemRoot%\System32\cmd.exe /K "%CMDER_ROOT%\vendor\bin\vscode_init.cmd" & %RUN%"
