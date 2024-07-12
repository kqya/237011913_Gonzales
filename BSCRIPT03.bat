@echo off

:menu
echo.
echo 1. IP Configuration
echo 2. Tasklist
echo 3. Taskkill
echo 4. Check Disk
echo 5. Format
echo 6. Defrag
echo 7. Find
echo 8. Attributes
echo 9. Exit

choice /c 123456789 /m "Choose an option:"

if errorlevel 9 exit
if errorlevel 8 goto attrib
if errorlevel 7 goto find
if errorlevel 6 goto defrag
if errorlevel 5 goto format
if errorlevel 4 goto chkdsk
if errorlevel 3 goto taskkill
if errorlevel 2 goto tasklist
if errorlevel 1 goto ipconfig

:ipconfig
cls
ipconfig
pause
goto menu

:tasklist
cls
Tasklist
pause
goto menu

:taskkill
cls
set /p pid="Enter the PID of the task to kill: "
taskkill /PID %pid%
if %errorlevel% NEQ 0 (echo Failed to kill task. Please check the PID and try again. &goto menu)
echo Task killed successfully.
pause
goto menu

:chkdsk
cls
set /p drive="Enter drive to check (e.g., C:): "
chkdsk %drive%
if %errorlevel% NEQ 0 (echo Failed to check disk. Please check the drive letter and try again. &goto menu)
echo Disk check completed successfully.
pause
goto menu

:format
cls
set /p drive="Enter the drive to format (e.g., C:): "
echo WARNING: This will erase all data on the drive!
set /p confirm="Are you sure you want to format %drive%? (Y/N): "
if /i "%confirm%" NEQ "Y" goto menu
format %drive%
if %errorlevel% NEQ 0 (echo Failed to format drive. Please check the drive letter and try again. &goto menu)
pause
goto menu

:defrag
cls
set /p drive="Enter drive to defrag (e.g., C:): "
defrag.exe %drive% -f
if %errorlevel% NEQ 0 (echo Failed to defrag drive. Please check the drive letter and try again. &goto menu)
pause
goto menu

:find
set /p text="Enter the text to find: "
set /p filename="Enter the filename to search within: "
find "%text%" %filename%
if %errorlevel% NEQ 0 (echo Text not found or error occurred. Please check the inputs and try again. &goto menu)
echo Search completed successfully.
pause
goto menu

:attrib
set /p filename="Enter the filename to change attributes for: "
echo Options for attributes:
echo + or - followed by A, R, S, or H (e.g., +A or -R)

set /p attributes="Enter the attribute(s) to set: "
attrib %attributes% %filename%
if %errorlevel% NEQ 0 (echo Failed to change attributes. Please check the inputs and try again. &goto menu)
echo Attributes changed successfully.
pause
goto menu