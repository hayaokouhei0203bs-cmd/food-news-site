@echo off
chcp 65001 > nul
title 食品業界ニュース収集システム

echo.
echo  ==========================================
echo   食品業界ニュース自動収集システム
echo  ==========================================
echo.
echo  初回収集が完了するとブラウザが自動で開きます。
echo  このウィンドウを閉じると収集が停止します。
echo.

cd /d "%~dp0food_news"

:loop
echo [%date% %time%] ニュースを収集中...
powershell -NoProfile -ExecutionPolicy Bypass -File collector.ps1

if exist index.html (
    REM 初回のみブラウザを開く
    if not defined BROWSER_OPENED (
        set BROWSER_OPENED=1
        echo.
        echo  ブラウザでニュースサイトを開きます...
        start "" "%~dp0food_news\index.html"
        echo.
    )
    echo [%date% %time%] 収集完了。次回は15分後に更新します。
) else (
    echo [%date% %time%] 警告: index.html が生成されませんでした。
)

echo.
echo  次の更新まで15分待機します...（Ctrl+C で停止）
echo  ----------------------------------------
timeout /t 900 /nobreak > nul

goto loop
