@echo off

set "source_dir=C:"
set "archive_dir=D:\archive"
set "days_old=30"

echo Creating archive folder...
md "%archive_dir%"

echo.
echo Sorting text files on %source_dir% by date modified...
dir /s /od /b /a-d "%source_dir%\*.txt" > "%archive_dir%\date_files.txt"
for /f %%A in ('type "%archive_dir%\date_files.txt"') do (
    echo %%~tnxA
)
del %archive_dir%\date_files.txt

echo.
echo Moving text files on %source_dir% older than %days_old% days to %archive_dir%...
forfiles /p %source_dir% /m *.txt /d -%days_old% /c "cmd /c move @path \"%archive_dir%""

echo.
echo The following are the archived files sorted by size:
dir /s /o-s /b /a-d "%archive_dir%\*.docx" > "%archive_dir%\size_files.txt"
for /f %%A in ('type "%archive_dir%\size_files.txt"') do (
    echo %%~zA bytes %%~nxA
)

echo.
set /p delete="Do you want to delete these files? (Y/N): "
if /i "%delete%"=="Y" (
    for /f %%A in ('type "%archive_dir%\size_files.txt"') do (
        del %%A
        echo Deleted: %%A
    )
    rd %archive_dir%
) else (
    echo No files were deleted.
)