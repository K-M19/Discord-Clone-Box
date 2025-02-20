@echo off
title Discord Clone Box
setlocal

set "nodejs_path="

echo Trying to find Node.js
timeout /nobreak /t 1 >nul

:loading
echo.
echo Loading.
timeout /nobreak /t 1 >nul
cls

echo.
echo Loading..
timeout /nobreak /t 1 >nul
cls

echo.
echo Loading...
timeout /nobreak /t 1 >nul
cls

for /f "tokens=*" %%i in ('where node') do (
    set "nodejs_path=%%i"
)

if not defined nodejs_path (
    echo Node.js not found, will attempt to install using scoop, will probably fail
    where scoop >nul 2>nul
    if %errorlevel% neq 0 (
        echo Instalando Scoop...
        echo.
        pause
        exit /b 1
    )

    echo Installing Node.js using Scoop...
    call scoop install nodejs

    where node >nul 2>nul
    if %errorlevel% neq 0 (
        Unable to install nodejs, please install manually - https://nodejs.org/en
        pause
        exit /b 1
    )

    for /f "tokens=*" %%i in ('where node') do (
        set "nodejs_path=%%i"
    )
)

echo Node.js found in: %nodejs_path%
node --version

if not exist "node_modules" (
    echo Installing...
    call npm i
)

where tsx >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing tsx..
    call npm i -g tsx
)
tsx .

endlocal
