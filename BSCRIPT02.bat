@echo off

:menu
echo.
echo 1. Circle
echo 2. Triangle
echo 3. Quadrilateral
echo 4. Exit
choice /c 1234 /m "Choose an option:"

if errorlevel 4 exit
if errorlevel 3 goto quad
if errorlevel 2 goto triangle
if errorlevel 1 goto circle

:circle
set /p radius="Enter radius: "
set /a area=(314159*radius*radius)/100000
echo Area: %area%
pause
goto menu

:triangle
set /p a="Enter length A: "
set /p b="Enter length B: "
set /p c="Enter length C: "
set /a s=(a+b+c)/2
set /a number=s*(s-a)*(s-b)*(s-c)
call :SquareRoot %number%
echo Area: %area%

if %a%==%b% (
    if %a%==%c% (
        echo Equilateral Triangle
    ) else if not %a%==%c% (
    echo Isosceles
    )
)
if not %a%==%b% (
    if %a%==%c% (
        echo Isosceles Triangle
    ) else if %b%==%c% (
        echo Isosceles Triangle
    ) else if not %b%==%c% (
        echo Scalene Triangle
    )
)
pause
goto menu

:quad
set /p length="Enter length: "
set /p width="Enter width: "

set /a area=%length%*%width%
echo Area: %area%

if %length%==%width% echo Square
if not %length%==%width% echo Rectangle
pause
goto menu

:SquareRoot
    SETLOCAL EnableDelayedExpansion
    set root=1
    set /a sqr=%root%*%root%
    :Loop
    if %sqr% LSS %number% (
        set /a root=!root!+1
        set /a sqr=!root!*!root!
        goto Loop
    )
(EndLocal && set area=%root% && exit /B)