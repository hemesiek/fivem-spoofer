@echo off
setlocal EnableDelayedExpansion

:: Ustawienie nazwy okna i kodowania na UTF-8
title FiveM Spoof by Hemesiek
chcp 65001 >nul

:: Sprawdzanie uprawnień administratorskich
net session >nul 2>&1
if %errorlevel%==0 (
    goto disclaimer
) else (
    cls
    color 0c
    echo ┌──────────────────────────────────────┐
    echo │          BRAK UPRAWNIEŃ!            │
    echo └──────────────────────────────────────┘
    echo.
    echo Ten skrypt wymaga uprawnień administratora.
    echo Uruchom ponownie skrypt, akceptując UAC jako administrator.
    echo.
    pause >nul

    :: Próba ponownego uruchomienia skryptu z UAC
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:disclaimer
cls
color 0a
echo ┌──────────────────────────────────────────────┐
echo │     INFORMACJA PRAWNA - Hemesiek [v1.0]     │
echo └──────────────────────────────────────────────┘
echo.
echo ~~~ Używanie tego skryptu na własne ryzyko! ~~~
echo Autor (Hemesiek) nie odpowiada za szkody ani utratę danych.
echo.
echo ┌──────────────────────────────────────────────┐
echo │                  WAŻNE!                     │
echo └──────────────────────────────────────────────┘
echo *** PRZED SPOOFEM ODINSTALUJ FIVEM ***
echo *** ZA POMOCĄ REVO UNINSTALLERA!  ***
echo *** BEZ TEGO SPOOF NIE ZADZIAŁA!  ***
echo *** !!! WAŻNE !!!                 ***
echo.
echo Wpisz 'TAK' (wielkie litery), by kontynuować.
echo Wpisz 'NIE', by anulować.
echo.
set /p consent="Wpisz zgodę (TAK/NIE): "

if /i "%consent%"=="TAK" (
    goto start_script
) else if /i "%consent%"=="NIE" (
    cls
    color 0c
    echo ┌──────────────────────────────────────┐
    echo │              BŁĄD!                   │
    echo └──────────────────────────────────────┘
    echo.
    echo Nie zaakceptowano warunków użytkowania.
    echo Skrypt zostanie zamknięty.
    echo.
    pause >nul
    exit
) else (
    cls
    color 0e
    echo ┌──────────────────────────────────────┐
    echo │      NIEPRAWIDŁOWA ODPOWIEDŹ!        │
    echo └──────────────────────────────────────┘
    echo Wpisz dokładnie 'TAK' lub 'NIE'.
    echo.
    pause >nul
    goto disclaimer
)

:start_script
cls

:: Menu powitalne z animacją
:menu
cls
color 0b
echo ┌──────────────────────────────────────────────┐
echo │       FiveM Spoofer by Hemesiek [v1.0]       │
echo └──────────────────────────────────────────────┘
echo.
echo ~~~ Witaj w FiveM Spoofer! Wybierz opcję: ~~~
echo ┌──────────────────────────────────────────────┐
echo │ 1. Rozpocznij Spoof                         │
echo │ 2. Pobierz Revo Uninstaller                 │
echo │ 3. Wyjście                                  │
echo └──────────────────────────────────────────────┘
echo.
set /p choice="Wprowadź numer opcji (1-3): "

if "%choice%"=="1" goto start_spoof
if "%choice%"=="2" goto download_revo
if "%choice%"=="3" exit
echo ┌──────────────────────────────────────┐
echo │      NIEPRAWIDŁOWA OPcja!            │
echo └──────────────────────────────────────┘
echo Spróbuj ponownie.
pause >nul
goto menu

:download_revo
cls
color 0d
echo ┌──────────────────────────────────────────────┐
echo │       Pobieranie Revo Uninstaller - Hemesiek │
echo └──────────────────────────────────────────────┘
echo.
echo Sprawdzanie połączenia internetowego...
ping -n 1 google.com >nul 2>&1
if %errorlevel% neq 0 (
    echo ┌──────────────────────────────────────┐
    echo │      BRAK POŁĄCZENIA INTERNETOWEGO!  │
    echo └──────────────────────────────────────┘
    echo Podłącz się i spróbuj ponownie.
    echo.
    pause >nul
    goto menu
)

echo Rozpoczynanie pobierania Revo Uninstaller...
powershell -Command "try { Invoke-WebRequest -Uri 'https://f3b1cfc5d488c0384dc3-056ccca39cd416ca6db85fa26f78b9ef.ssl.cf1.rackcdn.com/revosetup.exe' -OutFile '%userprofile%\Desktop\RevoUninstaller.exe'; Write-Host 'Pobieranie zakończone! Plik zapisano na pulpicie: %userprofile%\Desktop\RevoUninstaller.exe'; } catch { Start-Sleep -Seconds 2; try { Invoke-WebRequest -Uri 'https://f3b1cfc5d488c0384dc3-056ccca39cd416ca6db85fa26f78b9ef.ssl.cf1.rackcdn.com/revosetup.exe' -OutFile '%userprofile%\Desktop\RevoUninstaller.exe'; Write-Host 'Pobieranie zakończone! Plik zapisano na pulpicie: %userprofile%\Desktop\RevoUninstaller.exe'; } catch { Write-Host 'Błąd pobierania! Sprawdź zaporę, antywirus lub połączenie.'; } }"
if exist "%userprofile%\Desktop\RevoUninstaller.exe" (
    echo ┌──────────────────────────────────────┐
    echo │        INSTALACJA GOTOWA!            │
    echo └──────────────────────────────────────┘
    echo Otwieranie folderu z pobranym plikiem...
    explorer /select,"%userprofile%\Desktop\RevoUninstaller.exe"
    echo Uruchamianie instalatora...
    start "" "%userprofile%\Desktop\RevoUninstaller.exe"
)
echo.
echo ┌──────────────────────────────────────┐
echo │ Naciśnij dowolny klawisz, by wrócić. │
echo └──────────────────────────────────────┘
pause >nul
goto menu

:start_spoof
cls
color 0e
echo ┌──────────────────────────────────────────────┐
echo │       Rozpoczynanie spoofowania - Hemesiek   │
echo └──────────────────────────────────────────────┘
echo.
:: Zapisanie czasu rozpoczęcia
set start_time=%time%

:: Usuwanie folderów i plików związanych z FiveM, CITIZEN, DigitalEntitlements na całym dysku
echo Usuwanie folderów i plików FiveM, CITIZEN, DigitalEntitlements...
for /f "delims=" %%i in ('dir "C:\*FiveM*" /s /b /ad 2^>nul') do (
    rd /s /q "%%i" 2>nul
)
for /f "delims=" %%i in ('dir "C:\*CITIZEN*" /s /b /ad 2^>nul') do (
    rd /s /q "%%i" 2>nul
)
for /f "delims=" %%i in ('dir "C:\*DigitalEntitlements*" /s /b /ad 2^>nul') do (
    rd /s /q "%%i" 2>nul
)
for /f "delims=" %%i in ('dir "C:\*FiveM*" /s /b /a-d 2^>nul') do (
    del /q "%%i" 2>nul
)
for /f "delims=" %%i in ('dir "C:\*CITIZEN*" /s /b /a-d 2^>nul') do (
    del /q "%%i" 2>nul
)
for /f "delims=" %%i in ('dir "C:\*DigitalEntitlements*" /s /b /a-d 2^>nul') do (
    del /q "%%i" 2>nul
)

:: Usuwanie zawartości folderu Rockstar Games w dokumentach, z wyjątkiem pliku i folderu LAUNCHER
set "rockstarPath=C:\Users\%username%\Documents\Rockstar Games"
if exist "%rockstarPath%" (
    echo Czyszczenie folderu Rockstar Games...
    for /d %%i in ("%rockstarPath%\*") do (
        if /i not "%%~nxi"=="LAUNCHER" if /i not "%%~nxi"=="launcher" (
            rd /s /q "%%i" 2>nul
        )
    )
    for %%i in ("%rockstarPath%\*") do (
        if /i not "%%~nxi"=="LAUNCHER" if /i not "%%~nxi"=="launcher" (
            del /q "%%i" 2>nul
        )
    )
)

:: Czyszczenie folderów Prefetch, Temp i %temp%
echo Czyszczenie folderów systemowych (Prefetch, Temp, %temp%)...
if exist "C:\Windows\Prefetch" (
    del /q /s "C:\Windows\Prefetch\*.*" 2>nul
    rd /s /q "C:\Windows\Prefetch" 2>nul
)
if exist "C:\Windows\Temp" (
    del /q /s "C:\Windows\Temp\*.*" 2>nul
    rd /s /q "C:\Windows\Temp" 2>nul
)
if exist "%temp%" (
    del /q /s "%temp%\*.*" 2>nul
    rd /s /q "%temp%" 2>nul
)

:: Zapisanie czasu zakończenia
set end_time=%time%

:: Obliczenie czasu spoofowania
set "start=!start_time: =0!"
set "end=!end_time: =0!"
set /a start_ms=(1!start:~0,2!*360000) + (1!start:~3,2!*6000) + (1!start:~6,2!*100) + 1!start:~9,2!
set /a end_ms=(1!end:~0,2!*360000) + (1!end:~3,2!*6000) + (1!end:~6,2!*100) + 1!end:~9,2!
if !end_ms! lss !start_ms! set /a end_ms+=8640000
set /a diff_ms=end_ms-start_ms
set /a seconds=diff_ms/100
set /a milliseconds=diff_ms%%100

:: Wyświetlenie informacji o zakończeniu
cls
color 0a
echo ┌──────────────────────────────────────────────┐
echo │      Spoofowanie zakończone! - Hemesiek     │
echo └──────────────────────────────────────────────┘
echo.
echo ~~~ Czas spoofowania: %seconds%.%milliseconds% sekundy ~~~
echo Skrypt by Hemesiek
echo.
echo ┌──────────────────────────────────────┐
echo │ Naciśnij Enter, by wyjść.            │
echo └──────────────────────────────────────┘
pause >nul
exit
endlocal