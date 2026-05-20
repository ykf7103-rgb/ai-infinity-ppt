@echo off
chcp 65001 >nul
set "ROOT=%~dp0"
set "HTML=%ROOT%AI_INFINITY_v6.html"

if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --new-window "%HTML%"
) else if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --new-window "%HTML%"
) else (
  start "" "%HTML%"
)
