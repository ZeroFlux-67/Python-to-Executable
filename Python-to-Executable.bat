@echo off
color a

title Python to Executable - by @sahik
setlocal EnableDelayedExpansion

:: Step 1: Ask for script name
echo Enter the name of your Python script (with .py extension):
set /p script_name=

:: Check if the file exists
if not exist "%script_name%" (
    echo.
    echo ❌ ERROR: "%script_name%" not found in this folder.
    pause
    exit /b
)

:: Step 2: Ask for EXE name
echo.
echo Enter the desired name for the .exe (no extension):
set /p exe_name=

:: Step 3: Ask for output folder
echo.
echo Enter the FULL PATH to save the .exe (e.g. C:\MyApps\user):
set /p output_path=

:: Make sure output path exists, if not create it
if not exist "%output_path%" (
    echo Creating folder...
    mkdir "%output_path%"
)

:: Step 4: Check if PyInstaller is installed
echo.
echo Checking PyInstaller...
pyinstaller --version >nul 2>&1
if errorlevel 1 (
    echo Installing PyInstaller...
    pip install pyinstaller
)

:: Step 5: Build the EXE
echo.
echo 🔨 Building "%exe_name%.exe" from "%script_name%"...

pyinstaller --onefile --noconsole --name "%exe_name%" "%script_name%"

:: Step 6: Move the EXE to desired location
if exist "dist\%exe_name%.exe" (
    move /Y "dist\%exe_name%.exe" "%output_path%\%exe_name%.exe" >nul
    echo ✅ Build complete! EXE moved to: %output_path%\%exe_name%.exe
) else (
    echo ❌ Build failed. EXE not found.
)

:: Step 7: Clean up
echo.
echo Cleaning up...
rmdir /s /q build >nul
rmdir /s /q __pycache__ >nul
del /f /q *.spec >nul

echo.
echo 🎉 All done, boss. Enjoy your masterpiece.
pause
