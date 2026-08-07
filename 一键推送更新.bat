@echo off
chcp 65001 >nul
cd /d "%~dp0"

set GIT=C:\Users\Administrator\.trae-cn\work\6a69a3d1222c67d95ca3f50d\MinGit\cmd\git.exe

echo ========================================
echo   食堂采购系统 - 一键推送至 GitHub
echo ========================================
echo.

echo [1/3] 正在检查文件变更...
"%GIT%" status --short
if %errorlevel% neq 0 (
    echo 错误：无法检查文件状态，请确认 Git 是否正常
    pause
    exit /b 1
)

echo.
echo [2/3] 正在提交变更...
"%GIT%" add .
"%GIT%" commit -m "更新 - %date% %time%"
if %errorlevel% neq 0 (
    echo 没有文件变更或提交失败，跳过推送
    echo.
    pause
    exit /b 0
)

echo.
echo [3/3] 正在推送至 GitHub...
"%GIT%" push github master
if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   推送成功！GitHub Pages 将在 1 分钟内更新
    echo   访问地址：
    echo   PC端：https://belingzhong.github.io/canteen-procurement/canteen-procurement.html
    echo   App端：https://belingzhong.github.io/canteen-procurement/canteen-procurement-app.html
    echo ========================================
) else (
    echo.
    echo 推送失败，请检查网络连接
)

echo.
pause