@echo off

:: 设置项目根目录为当前脚本所在的目录
set "PROJECT_DIR=%~dp0"

:: 设置文件名
set "EXE_NAME=RES"

echo Starting the build process...

:: 判断是否存在 build 文件夹，若有则清空，若没有则创建
if exist "%PROJECT_DIR%build" (
    echo Build folder exists. Cleaning up...
    rmdir /s /q "%PROJECT_DIR%build"
    if %errorlevel% neq 0 (
        echo Error: Failed to clean the build directory.
        pause
        exit /b %errorlevel%
    )
)

echo Build folder does not exist. Creating build folder...
mkdir "%PROJECT_DIR%build"
if %errorlevel% neq 0 (
    echo Error: Failed to create build folder.
    pause
    exit /b %errorlevel%
)

:: 进入 build 文件夹
cd "%PROJECT_DIR%build"
if %errorlevel% neq 0 (
    echo Error: Failed to change directory to build.
    pause
    exit /b %errorlevel%
)

:: 运行 cmake 命令
cmake .. -G "MinGW Makefiles" -D ENABLE_COVERAGE=ON
if %errorlevel% neq 0 (
    echo Error: cmake command failed.
    pause
    exit /b %errorlevel%
)

:: 运行 mingw32-make.exe
mingw32-make.exe
if %errorlevel% neq 0 (
    echo Error: mingw32-make.exe command failed.
    pause
    exit /b %errorlevel%
)

:: 进入 bin 目录
cd "%PROJECT_DIR%build\bin"
if %errorlevel% neq 0 (
    echo Error: Failed to change directory to bin.
    pause
    exit /b %errorlevel%
)

echo Testing result generation in progress

:: 运行 %EXE_NAME%.exe  检测报告生成
.\%EXE_NAME%.exe  > test_reports.txt

setlocal enabledelayedexpansion

:: 设置源路径
set source_dir=%~dp0build\src\main\CMakeFiles\%EXE_NAME%.dir\__\funcs

echo Processing .gcda files...
:: 遍历所有 .gcda 文件并重命名
for %%f in (%source_dir%\*.gcda) do (
    set "filename=%%~nxf"    
    :: 删除文件名中的 .cpp 部分
    set "filename=!filename:.cpp=!"
    ren "%%f" "!filename!"
)

echo Processing of .gcda files completed

echo Processing .gcno files...
:: 遍历所有 .gcno 文件并重命名
for %%f in (%source_dir%\*.gcno) do (
    set "filename=%%~nxf"
    
    set "filename=!filename:.cpp=!"

    ren "%%f" "!filename!"
)

echo Processing of .gcno files completed



:: 移动 funcs 文件夹中所有的 .gcda 和 .gcno 文件到 src\funcs 目录
echo Moving .gcda and .gcno files to src\funcs directory...
for %%f in ("%PROJECT_DIR%build\src\main\CMakeFiles\RES.dir\__\funcs\*.gcda") do (
    move "%%f" "%PROJECT_DIR%src\funcs\"
    if %errorlevel% neq 0 (
        echo Error: Failed to move %%f to %PROJECT_DIR%src\funcs.
        pause
        exit /b %errorlevel%
    )
)

for %%f in ("%PROJECT_DIR%build\src\main\CMakeFiles\RES.dir\__\funcs\*.gcno") do (
    move "%%f" "%PROJECT_DIR%src\funcs\"
    if %errorlevel% neq 0 (
        echo Error: Failed to move %%f to %PROJECT_DIR%src\funcs.
        pause
        exit /b %errorlevel%
    )
)

:: 运行 gcov 对文件夹下所有 .c 文件进行覆盖率分析
echo Running gcov on all .c files in src\tests...
cd "%PROJECT_DIR%src\funcs"
if %errorlevel% neq 0 (
    echo Error: Failed to change directory to src\funcs.
    pause
    exit /b %errorlevel%
)

:: 对所有 .cpp 文件运行 gcov
for %%f in (*.c) do (
    gcov "%%f"
    if %errorlevel% neq 0 (
        echo Error: gcov command failed for %%f.
        pause
        exit /b %errorlevel%
    )
)

:: 运行 gcovr 生成覆盖率报告
gcovr -r . --html --html-details -o %PROJECT_DIR%/coverage/coverage.html
if %errorlevel% neq 0 (
    echo Error: gcovr command failed.
    pause
    exit /b %errorlevel%
)

:: 打开 coverage.html 文件
start %PROJECT_DIR%/coverage/coverage.html
if %errorlevel% neq 0 (
    echo Error: Failed to open coverage.html.
    pause
    exit /b %errorlevel%
)

echo Build, file renaming, moving, and gcov analysis completed successfully!
pause