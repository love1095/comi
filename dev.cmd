@echo off
rem Double-click to start comi locally (or: dev.cmd -Apps restaurant / dev.cmd -Reset / dev.cmd -Stop).
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0dev.ps1" %*
if errorlevel 1 pause
