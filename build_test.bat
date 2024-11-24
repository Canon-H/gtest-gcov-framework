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
cmake .. -G "MinGW Makefiles" -D ENABLE_COVERAGE=OFF
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
if %errorlevel% neq 0 (
    echo Error: %EXE_NAME%.exe execution failed.
    pause
    exit /b %errorlevel%
)

echo Build completed successfully!
pause