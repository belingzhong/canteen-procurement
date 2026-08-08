@echo off
chcp 65001 >nul

set SKILLS=C:\Users\Administrator\.trae-cn\skills\04-交互原型生成器\原型\食堂采购
set PRD=C:\Users\Administrator\.trae-cn\skills\03-PRD生成器\食堂采购-PRD
set PROJECT=C:\Users\Administrator\AppData\Roaming\TRAE SOLO CN\ModularData\ai-agent\work-mode-projects\6a69a3d1222c67d95ca3f50a\canteen-procurement
set GIT=C:\Users\Administrator\.trae-cn\work\6a69a3d1222c67d95ca3f50d\MinGit\cmd\git.exe

echo ========================================
echo   食堂采购系统 - 一键推送至 GitHub
echo ========================================
echo.

echo [1/5] 正在同步文件到Git仓库...
copy /y "%SKILLS%\食堂采购.html" "%PROJECT%\canteen-procurement.html" >nul
echo 已同步：食堂采购.html (PC端)
copy /y "%SKILLS%\食堂采购-app.html" "%PROJECT%\canteen-procurement-app.html" >nul
echo 已同步：食堂采购-app.html (App端)
copy /y "%PRD%\食堂采购系统-迭代PRD-v2.1.docx" "%PROJECT%\食堂采购系统-迭代PRD-v2.1.docx" >nul
echo 已同步：食堂采购系统-迭代PRD-v2.1.docx (PRD)

echo.
echo [2/5] 正在检查文件变更...
cd /d "%PROJECT%"
"%GIT%" status --short
if %errorlevel% neq 0 (
    echo 错误：无法检查文件状态
    pause
    exit /b 1
)

echo.
echo [3/5] 正在提交变更...
"%GIT%" add .
"%GIT%" commit -m "更新 - %date% %time%"
if %errorlevel% neq 0 (
    echo 没有文件变更或提交失败
)

echo.
echo [4/5] 正在推送至 GitHub...
"%GIT%" push github master
if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   推送成功！GitHub Pages 将在 1 分钟内更新
    echo   访问地址：
    echo   PC端：https://belingzhong.github.io/canteen-procurement/canteen-procurement.html
    echo   App端：https://belingzhong.github.io/canteen-procurement/canteen-procurement-app.html
    echo   PRD：https://belingzhong.github.io/canteen-procurement/食堂采购系统-迭代PRD-v2.1.docx
    echo ========================================
) else (
    echo.
    echo 推送失败，请检查网络连接
)

echo.
pause